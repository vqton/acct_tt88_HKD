using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using HkdAccounting.Application.Dtos;
using HkdAccounting.Application.Services;

namespace HkdAccounting.Web.Controllers
{
    /// <summary>
    /// API controller for DmHangHoa management - MD-02
    /// </summary>
    [Route("api/[controller]")]
    [ApiController]
    public class DmHangHoaController : ControllerBase
    {
        private readonly IDmHangHoaService _service;

        /// <summary>
        /// Constructor with service injected via DI
        /// </summary>
        public DmHangHoaController(IDmHangHoaService service)
        {
            _service = service;
        }

        /// <summary>
        /// Get all DmHangHoa records
        /// </summary>
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var result = await _service.GetAllAsync();
            return Ok(result);
        }

        /// <summary>
        /// Get DmHangHoa by ID
        /// </summary>
        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(long id)
        {
            var result = await _service.GetByIdAsync(id);
            if (result == null) return NotFound();
            return Ok(result);
        }

        /// <summary>
        /// Create new DmHangHoa
        /// </summary>
        [HttpPost]
        public async Task<IActionResult> Create(DmHangHoaDto dto)
        {
            var id = await _service.CreateAsync(dto);
            return CreatedAtAction(nameof(GetById), new { id }, null);
        }

        /// <summary>
        /// Update existing DmHangHoa
        /// </summary>
        [HttpPut("{id}")]
        public async Task<IActionResult> Update(long id, DmHangHoaDto dto)
        {
            if (id != dto.Id) return BadRequest();
            await _service.UpdateAsync(dto);
            return NoContent();
        }

        /// <summary>
        /// Delete DmHangHoa
        /// </summary>
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(long id)
        {
            await _service.DeleteAsync(id);
            return NoContent();
        }
    }
}
