using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Application.Dtos;

namespace HkdAccounting.Application.Services
{
    /// <summary>
    /// Interface cho dịch vụ xử lý thông tin hộ kinh doanh
    /// </summary>
    public interface IHkdInfoService
    {
        /// <summary>
        /// Lấy thông tin hộ kinh doanh theo ID
        /// </summary>
        /// <param name="id">ID của hộ kinh doanh</param>
        /// <returns>Thông tin hộ kinh doanh</returns>
        Task<HkdInfoDto> GetByIdAsync(long id);

        /// <summary>
        /// Lấy danh sách tất cả hộ kinh doanh
        /// </summary>
        /// <returns>Danh sách hộ kinh doanh</returns>
        Task<IEnumerable<HkdInfoDto>> GetAllAsync();

        /// <summary>
        /// Tạo mới hộ kinh doanh
        /// </summary>
        /// <param name="dto">Thông tin hộ kinh doanh cần tạo</param>
        /// <returns>ID của hộ kinh doanh vừa tạo</returns>
        Task<long> CreateAsync(HkdInfoDto dto);

        /// <summary>
        /// Cập nhật thông tin hộ kinh doanh
        /// </summary>
        /// <param name="dto">Thông tin hộ kinh doanh cần cập nhật</param>
        Task UpdateAsync(HkdInfoDto dto);

        /// <summary>
        /// Xóa hộ kinh doanh
        /// </summary>
        /// <param name="id">ID của hộ kinh doanh cần xóa</param>
        Task DeleteAsync(long id);
    }
}