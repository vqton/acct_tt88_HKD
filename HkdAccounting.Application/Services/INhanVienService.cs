using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Application.Dtos;

namespace HkdAccounting.Application.Services
{
    /// <summary>
    /// Interface cho dịch vụ xử lý thông tin nhân viên
    /// </summary>
    public interface INhanVienService
    {
        /// <summary>
        /// Lấy thông tin nhân viên theo ID
        /// </summary>
        /// <param name="id">ID của nhân viên</param>
        /// <returns>Thông tin nhân viên</returns>
        Task<NhanVienDto> GetByIdAsync(long id);

        /// <summary>
        /// Lấy danh sách tất cả nhân viên
        /// </summary>
        /// <returns>Danh sách nhân viên</returns>
        Task<IEnumerable<NhanVienDto>> GetAllAsync();

        /// <summary>
        /// Tạo mới nhân viên
        /// </summary>
        /// <param name="dto">Thông tin nhân viên cần tạo</param>
        /// <returns>ID của nhân viên vừa tạo</returns>
        Task<long> CreateAsync(NhanVienDto dto);

        /// <summary>
        /// Cập nhật thông tin nhân viên
        /// </summary>
        /// <param name="dto">Thông tin nhân viên cần cập nhật</param>
        Task UpdateAsync(NhanVienDto dto);

        /// <summary>
        /// Xóa nhân viên
        /// </summary>
        /// <param name="id">ID của nhân viên cần xóa</param>
        Task DeleteAsync(long id);
    }
}