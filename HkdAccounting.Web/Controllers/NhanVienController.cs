using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using HkdAccounting.Application.Dtos;
using HkdAccounting.Application.Services;

namespace HkdAccounting.Web.Controllers
{
    /// <summary>
    /// API controller for NhanVien management - MD-06
    /// </summary>
    [Route("api/[controller]")]
    [ApiController]
    public class NhanVienController : ControllerBase
    {
        private readonly INhanVienService _service;

        /// <summary>
        /// Constructor with service injected via DI
        /// </summary>
        public NhanVienController(INhanVienService service)
        {
            _service = service;
        }

        /// <summary>
        /// Get all NhanVien records
        /// </summary>
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var result = await _service.GetAllAsync();
            return Ok(result);
        }

        /// <summary>
        /// Get NhanVien by ID
        /// </summary>
        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(long id)
        {
            var result = await _service.GetByIdAsync(id);
            if (result == null) return NotFound();
            return Ok(result);
        }

        /// <summary>
        /// Create new NhanVien
        /// </summary>
        [HttpPost]
        public async Task<IActionResult> Create(NhanVienDto dto)
        {
            var id = await _service.CreateAsync(dto);
            return CreatedAtAction(nameof(GetById), new { id }, null);
        }

        /// <summary>
        /// Update existing NhanVien
        /// </summary>
        [HttpPut("{id}")]
        public async Task<IActionResult> Update(long id, NhanVienDto dto)
        {
            if (id != dto.Id) return BadRequest();
            await _service.UpdateAsync(dto);
            return NoContent();
        }

        /// <summary>
        /// Delete NhanVien
        /// </summary>
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(long id)
        {
            await _service.DeleteAsync(id);
            return NoContent();
        }
    }
}