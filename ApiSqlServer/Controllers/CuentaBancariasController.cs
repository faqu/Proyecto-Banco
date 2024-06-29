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
    public class CuentaBancariasController : ControllerBase
    {
        private readonly ApiCuentasContablesContext _context;

        public CuentaBancariasController(ApiCuentasContablesContext context)
        {
            _context = context;
        }

        // GET: api/CuentaBancarias
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CuentaBancaria>>> GetCuentaBancaria()
        {
            return await _context.CuentaBancaria.ToListAsync();
        }
        [HttpGet("CuentasActivas")]
        public async Task<ActionResult<IEnumerable<CuentaBancaria>>> GetCuentaActivasBancaria()
        {
            var cuentasActivas = await _context.CuentaBancaria
                .Where(c => c.Estadocuenta == 1)
                .Select(c => new CuentaBancaria {Id=c.Id, NumeroCuenta = c.NumeroCuenta, Saldo = c.Saldo })
                .ToListAsync();

            return cuentasActivas;
        }


        // GET: api/CuentaBancarias/5
        [HttpGet("{id}")]
        public async Task<ActionResult<CuentaBancaria>> GetCuentaBancaria(int id)
        {
            var cuentaBancaria = await _context.CuentaBancaria.FindAsync(id);

            if (cuentaBancaria == null)
            {
                return NotFound();
            }

            return cuentaBancaria;
        }

        // POST: api/CuentaBancarias
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost("CrearCuenta/{numero_cuenta}/{tipo_cuenta}/{saldo}/{propietario_nombre}/{estadocuenta}")]
        public IActionResult RetiroYDeposito(string numero_cuenta, int tipo_cuenta, decimal saldo, string propietario_nombre, int estadocuenta)
        {
            using (var transaction = _context.Database.BeginTransaction())
            {
                try
                {
                    // Map URI parameters to INSERT statement parameters
                    var fechaTransaccion = DateTime.Now;

                    // Execute raw SQL INSERT statement
                    _context.Database.ExecuteSqlRaw("INSERT INTO CuentaBancaria (numero_cuenta, tipo_cuenta, saldo, fecha_apertura, propietario_nombre,estadocuenta) VALUES (@numero_cuenta, @tipo_cuenta, @saldo,@fecha_apertura, @propietario_nombre,@estadocuenta)",
                        new SqlParameter("@numero_cuenta", numero_cuenta),
                        new SqlParameter("@tipo_cuenta", tipo_cuenta),
                        new SqlParameter("@saldo", saldo),
                        new SqlParameter("@fecha_apertura", fechaTransaccion),
                        new SqlParameter("@propietario_nombre", propietario_nombre),
                        new SqlParameter("@estadocuenta", estadocuenta));

                    transaction.Commit(); // Commit the transaction

                    return Ok("Cuenta Bancaria created successfully");
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
