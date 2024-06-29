using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ApiSqlServer.Models;
using Microsoft.Data.SqlClient;

namespace ApiSqlServer.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TransaccionesController : ControllerBase
    {
        private readonly ApiCuentasContablesContext _context;

        public TransaccionesController(ApiCuentasContablesContext context)
        {
            _context = context;
        }

        // GET: api/Transacciones
        [HttpGet]
        public async Task<ActionResult<IEnumerable<object>>> GetTransacciones()
        {
            var transactions = await _context.Transacciones
                .Include(t => t.CuentaDestino)
                .Include(t => t.CuentaOrigen)
                .Include(t => t.TipoNavigation)
                .ToListAsync();

            var result = transactions.Select(t => new
            {
                Id = t.Id,
                Monto = t.Monto,
                FechaTransaccion = t.FechaTransaccion,
                CuentaOrigen = t.CuentaOrigen.NumeroCuenta,
                CuentaDestino = t.CuentaDestino?.NumeroCuenta,
                TipoNavigation = t.TipoNavigation.TipoTrasaccion,
            });

            return Ok(result);
        }

        [HttpGet("tipoTrasaccionFilter")]
        public async Task<ActionResult<IEnumerable<object>>> GetTransaccionesT(string tipoTrasaccionFilter)
        {
            var transactionsQuery = _context.Transacciones
                .Include(t => t.CuentaDestino)
                .Include(t => t.CuentaOrigen)
                .Include(t => t.TipoNavigation)
                .AsQueryable(); // Create a queryable object for further filtering

            // Apply the TipoNavigation.TipoTrasaccion filter if provided
            if (!string.IsNullOrEmpty(tipoTrasaccionFilter))
            {
                transactionsQuery = transactionsQuery
                    .Where(t => t.TipoNavigation.TipoTrasaccion == tipoTrasaccionFilter);
            }

            var transactions = await transactionsQuery.ToListAsync();

            var result = transactions.Select(t => new
            {
                Id = t.Id,
                Monto = t.Monto,
                FechaTransaccion = t.FechaTransaccion,
                CuentaOrigen = t.CuentaOrigen.NumeroCuenta,
                CuentaDestino = t.CuentaDestino?.NumeroCuenta,
                TipoNavigation = t.TipoNavigation.TipoTrasaccion,
                // Include other properties you need from Transacciones
            });

            return Ok(result);
        }

        // GET: api/Transacciones/5
        [HttpGet("NumeroCuenta")]
        public async Task<ActionResult<IEnumerable<object>>> GetTransaccionesCuenta(string NumeroCuenta)
        {
            var transactionsQuery = _context.Transacciones
                .Include(t => t.CuentaDestino)
                .Include(t => t.CuentaOrigen)
                .Include(t => t.TipoNavigation)
                .AsQueryable(); // Create a queryable object for further filtering

            // Apply the TipoNavigation.TipoTrasaccion filter if provided
            if (!string.IsNullOrWhiteSpace(NumeroCuenta))
            {
                transactionsQuery = transactionsQuery
                    .Where(t => t.CuentaDestino.NumeroCuenta == NumeroCuenta ||
                        t.CuentaOrigen.NumeroCuenta == (NumeroCuenta));
            }

            var transactions = await transactionsQuery.ToListAsync();

            var result = transactions.Select(t => new
            {
                Id = t.Id,
                Monto = t.Monto,
                FechaTransaccion = t.FechaTransaccion,
                CuentaOrigen = t.CuentaOrigen.NumeroCuenta,
                CuentaDestino = t.CuentaDestino?.NumeroCuenta,
                TipoNavigation = t.TipoNavigation.TipoTrasaccion,
                // Include other properties you need from Transacciones
            });

            return Ok(result);
        }
        [HttpPost("Transferencia/{tipo}/{monto}/{cuentaOrigenId}/{cuentaDestinoId}")]

        public IActionResult Transferencia(int tipo, decimal monto, int cuentaOrigenId, int cuentaDestinoId)
        {
            try
            {
                // Map URI parameters to INSERT statement parameters
                var fechaTransaccion = DateTime.Now;

                // Execute raw SQL INSERT statement
                _context.Database.ExecuteSqlRaw("INSERT INTO Transacciones (tipo, monto, fecha_transaccion, cuenta_origen_id, cuenta_destino_id) VALUES (@Tipo, @Monto, @FechaTransaccion, @CuentaOrigenId, @CuentaDestinoId)",
                    new SqlParameter("@Tipo", tipo),
                    new SqlParameter("@Monto", monto),
                    new SqlParameter("@FechaTransaccion", fechaTransaccion),
                    new SqlParameter("@CuentaOrigenId", cuentaOrigenId),
                    new SqlParameter("@CuentaDestinoId", cuentaDestinoId)); // Set DBNull.Value for null values

                return Ok("Transaction created successfully");
            }
            catch (Exception ex)
            {
                // Handle exceptions as needed
                return BadRequest($"Error creating transaction: {ex.Message}");
            }
        }

        [HttpPost("RetiroYDeposito/{tipo}/{monto}/{cuentaOrigenId}")]
        public IActionResult RetiroYDeposito(int tipo, decimal monto, int cuentaOrigenId)
        {
            using (var transaction = _context.Database.BeginTransaction())
            {
                try
                {
                    // Map URI parameters to INSERT statement parameters
                    var fechaTransaccion = DateTime.Now;

                    // Execute raw SQL INSERT statement
                    _context.Database.ExecuteSqlRaw("INSERT INTO Transacciones (tipo, monto, fecha_transaccion, cuenta_origen_id) VALUES (@Tipo, @Monto, @FechaTransaccion, @CuentaOrigenId)",
                        new SqlParameter("@Tipo", tipo),
                        new SqlParameter("@Monto", monto),
                        new SqlParameter("@FechaTransaccion", fechaTransaccion),
                        new SqlParameter("@CuentaOrigenId", cuentaOrigenId));

                    transaction.Commit(); // Commit the transaction

                    return Ok("Transaction created successfully");
                }
                catch (Exception ex)
                {
                    // Handle exceptions as needed
                    transaction.Rollback(); // Rollback the transaction in case of an exception
                    return BadRequest($"Error creating transaction: {ex.Message}");
                }
            }
        }
    }
}
