using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Application.Dtos;

namespace HkdAccounting.Application.Services
{
    /// <summary>
    /// Interface cho dịch vụ xử lý thông tin tài khoản ngân hàng
    /// </summary>
    public interface ITaiKhoanNganHangService
    {
        /// <summary>
        /// Lấy thông tin tài khoản ngân hàng theo ID
        /// </summary>
        /// <param name="id">ID của tài khoản ngân hàng</param>
        /// <returns>Thông tin tài khoản ngân hàng</returns>
        Task<TaiKhoanNganHangDto> GetByIdAsync(long id);

        /// <summary>
        /// Lấy danh sách tất cả tài khoản ngân hàng
        /// </summary>
        /// <returns>Danh sách tài khoản ngân hàng</returns>
        Task<IEnumerable<TaiKhoanNganHangDto>> GetAllAsync();

        /// <summary>
        /// Tạo mới tài khoản ngân hàng
        /// </summary>
        /// <param name="dto">Thông tin tài khoản ngân hàng cần tạo</param>
        /// <returns>ID của tài khoản ngân hàng vừa tạo</returns>
        Task<long> CreateAsync(TaiKhoanNganHangDto dto);

        /// <summary>
        /// Cập nhật thông tin tài khoản ngân hàng
        /// </summary>
        /// <param name="dto">Thông tin tài khoản ngân hàng cần cập nhật</param>
        Task UpdateAsync(TaiKhoanNganHangDto dto);

        /// <summary>
        /// Xóa tài khoản ngân hàng
        /// </summary>
        /// <param name="id">ID của tài khoản ngân hàng cần xóa</param>
        Task DeleteAsync(long id);
    }
}