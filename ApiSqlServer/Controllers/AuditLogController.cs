using ApiSqlServer.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ApiSqlServer.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuditLogController : ControllerBase
    {
        private readonly IDbContextFactory<ApiCuentasContablesContext> _contextFactory;
        private readonly ILogger<AuditLogController> _logger;

        public AuditLogController(IDbContextFactory<ApiCuentasContablesContext> contextFactory, ILogger<AuditLogController> logger)
        {
            _contextFactory = contextFactory;
            _logger = logger;
        }

        [HttpGet("Lista")]
        public async Task<IActionResult> GetListaAsync()
        {
            try
            {
                using var context = _contextFactory.CreateDbContext();
                List<AuditLog> lista = await context.AuditLogs.ToListAsync();

                return Ok(new { success = true, message = "Ok", data = lista });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while fetching EstadoCuenta list");
                return StatusCode(StatusCodes.Status500InternalServerError, new { success = false, message = ex.Message });
            }
        }
    }
}
