using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using HkdAccounting.Application.Dtos;
using HkdAccounting.Application.Services;

namespace HkdAccounting.Web.Controllers
{
    /// <summary>
    /// API controller for TaiKhoanNganHang management - MD-07
    /// </summary>
    [Route("api/[controller]")]
    [ApiController]
    public class TaiKhoanNganHangController : ControllerBase
    {
        private readonly ITaiKhoanNganHangService _service;

        /// <summary>
        /// Constructor with service injected via DI
        /// </summary>
        /// <param name="service">Application service</param>
        public TaiKhoanNganHangController(ITaiKhoanNganHangService service)
        {
            _service = service;
        }

        /// <summary>
        /// Get all TaiKhoanNganHang records
        /// </summary>
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var result = await _service.GetAllAsync();
            return Ok(result);
        }

        /// <summary>
        /// Get TaiKhoanNganHang by ID
        /// </summary>
        /// <param name="id">Record ID</param>
        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(long id)
        {
            var result = await _service.GetByIdAsync(id);
            if (result == null) return NotFound();
            return Ok(result);
        }

        /// <summary>
        /// Create new TaiKhoanNganHang
        /// </summary>
        /// <param name="dto">Data transfer object</param>
        [HttpPost]
        public async Task<IActionResult> Create(TaiKhoanNganHangDto dto)
        {
            var id = await _service.CreateAsync(dto);
            return CreatedAtAction(nameof(GetById), new { id }, null);
        }

        /// <summary>
        /// Update existing TaiKhoanNganHang
        /// </summary>
        /// <param name="id">Record ID</param>
        /// <param name="dto">Data transfer object</param>
        [HttpPut("{id}")]
        public async Task<IActionResult> Update(long id, TaiKhoanNganHangDto dto)
        {
            if (id != dto.Id) return BadRequest();
            await _service.UpdateAsync(dto);
            return NoContent();
        }

        /// <summary>
        /// Delete TaiKhoanNganHang
        /// </summary>
        /// <param name="id">Record ID</param>
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(long id)
        {
            await _service.DeleteAsync(id);
            return NoContent();
        }
    }
}