using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ApiSqlServer.Models;

namespace ApiSqlServer.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class EstadoCuentaController : ControllerBase
    {
        private readonly IDbContextFactory<ApiCuentasContablesContext> _contextFactory;
        private readonly ILogger<EstadoCuentaController> _logger;
        private readonly ApiCuentasContablesContext _context;
        public EstadoCuentaController(ApiCuentasContablesContext context, IDbContextFactory<ApiCuentasContablesContext> contextFactory, ILogger<EstadoCuentaController> logger)
        {
            _context = context;
            _contextFactory = contextFactory;
            _logger = logger;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<EstadoCuenta>>> GetTipoCuenta()
        {
            return await _context.EstadoCuenta.ToListAsync();
        }

        [HttpPost("Insertar")]
        public async Task<IActionResult> CrearEstado([FromBody] EstadoCuenta estadoCuenta)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(new { success = false, message = "El estado del modelo es invalido", errors = ModelState.Values.SelectMany(v => v.Errors) });
            }

            try
            {
                using var context = _contextFactory.CreateDbContext();

                context.EstadoCuenta.Add(estadoCuenta);
                await context.SaveChangesAsync();

                return CreatedAtAction("GetListaAsync", new { success = true, message = "EstadoCuenta creado exitosamente", data = estadoCuenta });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while creating EstadoCuenta");
                return StatusCode(StatusCodes.Status500InternalServerError, new { success = false, message = ex.Message });
            }
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> ActualizarEstado(int id,EstadoCuenta estadoActualizado)
        {
            try
            {
                if (estadoActualizado == null)
                {
                    return BadRequest(new { success = false, message = "La solicitud no contiene datos válidos." });
                }

                using var context = _contextFactory.CreateDbContext();
                EstadoCuenta? estadoExistente = await context.EstadoCuenta.FindAsync(id);

                if (estadoExistente == null)
                {
                    return NotFound(new { success = false, message = $"EstadoCuenta con ID {id} no encontrado." });
                }

                estadoExistente.TipoEstadoCuenta = estadoActualizado.TipoEstadoCuenta;
                await context.SaveChangesAsync();

                return Ok(new { success = true, message = $"EstadoCuenta con ID {id} actualizado exitosamente", data = estadoExistente });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"An error occurred while updating EstadoCuenta with ID {id}");
                return StatusCode(StatusCodes.Status500InternalServerError, new { success = false, message = ex.Message });
            }
        }

    }
}
