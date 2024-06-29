using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ApiSqlServer.Models;

namespace ApiSqlServer.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TipoDeTransaccionsController : ControllerBase
    {
        private readonly ApiCuentasContablesContext _context;

        public TipoDeTransaccionsController(ApiCuentasContablesContext context)
        {
            _context = context;
        }

        // GET: api/TipoDeTransaccions
        [HttpGet]
        public async Task<ActionResult<IEnumerable<TipoDeTransaccion>>> GetTipoDeTransaccions()
        {
            return await _context.TipoDeTransaccions.ToListAsync();
        }

        // GET: api/TipoDeTransaccions/5
        [HttpGet("{id}")]
        public async Task<ActionResult<TipoDeTransaccion>> GetTipoDeTransaccion(int id)
        {
            var tipoDeTransaccion = await _context.TipoDeTransaccions.FindAsync(id);

            if (tipoDeTransaccion == null)
            {
                return NotFound();
            }

            return tipoDeTransaccion;
        }

        // PUT: api/TipoDeTransaccions/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutTipoDeTransaccion(int id, TipoDeTransaccion tipoDeTransaccion)
        {
            if (id != tipoDeTransaccion.Id)
            {
                return BadRequest();
            }

            _context.Entry(tipoDeTransaccion).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!TipoDeTransaccionExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/TipoDeTransaccions
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<TipoDeTransaccion>> PostTipoDeTransaccion(TipoDeTransaccion tipoDeTransaccion)
        {
            _context.TipoDeTransaccions.Add(tipoDeTransaccion);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetTipoDeTransaccion", new { id = tipoDeTransaccion.Id }, tipoDeTransaccion);
        }

        private bool TipoDeTransaccionExists(int id)
        {
            return _context.TipoDeTransaccions.Any(e => e.Id == id);
        }
    }
}
