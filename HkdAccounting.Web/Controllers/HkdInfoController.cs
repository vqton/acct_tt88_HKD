using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using HkdAccounting.Application.Dtos;
using HkdAccounting.Application.Services;

namespace HkdAccounting.Web.Controllers
{
    /// <summary>
    /// API controller for HkdInfo management - MD-01
    /// </summary>
    [Route("api/[controller]")]
    [ApiController]
    public class HkdInfoController : ControllerBase
    {
        private readonly IHkdInfoService _service;

        /// <summary>
        /// Constructor with service injected via DI
        /// </summary>
        /// <param name="service">HkdInfo service</param>
        public HkdInfoController(IHkdInfoService service)
        {
            _service = service;
        }

        /// <summary>
        /// Get all HkdInfo records
        /// </summary>
        /// <returns>List of HkdInfo</returns>
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var result = await _service.GetAllAsync();
            return Ok(result);
        }

        /// <summary>
        /// Get HkdInfo by ID
        /// </summary>
        /// <param name="id">HkdInfo ID</param>
        /// <returns>HkdInfo details</returns>
        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(long id)
        {
            var result = await _service.GetByIdAsync(id);
            if (result == null) return NotFound();
            return Ok(result);
        }

        /// <summary>
        /// Create new HkdInfo
        /// </summary>
        /// <param name="dto">HkdInfo data</param>
        /// <returns>Created result</returns>
        [HttpPost]
        public async Task<IActionResult> Create(HkdInfoDto dto)
        {
            var id = await _service.CreateAsync(dto);
            return CreatedAtAction(nameof(GetById), new { id }, null);
        }

        /// <summary>
        /// Update existing HkdInfo
        /// </summary>
        /// <param name="id">HkdInfo ID</param>
        /// <param name="dto">Updated HkdInfo data</param>
        /// <returns>No content</returns>
        [HttpPut("{id}")]
        public async Task<IActionResult> Update(long id, HkdInfoDto dto)
        {
            if (id != dto.Id) return BadRequest();
            await _service.UpdateAsync(dto);
            return NoContent();
        }

        /// <summary>
        /// Delete HkdInfo
        /// </summary>
        /// <param name="id">HkdInfo ID</param>
        /// <returns>No content</returns>
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(long id)
        {
            await _service.DeleteAsync(id);
            return NoContent();
        }
    }
}
