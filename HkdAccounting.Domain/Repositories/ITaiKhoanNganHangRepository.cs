using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;

namespace HkdAccounting.Domain.Repositories
{
    /// <summary>
    /// Interface Repository cho TaiKhoanNganHang
    /// </summary>
    public interface ITaiKhoanNganHangRepository
    {
        /// <summary>
        /// Lấy tài khoản ngân hàng theo ID
        /// </summary>
        Task<TaiKhoanNganHang> GetByIdAsync(long id);

        /// <summary>
        /// Lấy danh sách tất cả tài khoản ngân hàng
        /// </summary>
        Task<IEnumerable<TaiKhoanNganHang>> GetAllAsync();

        /// <summary>
        /// Tạo mới tài khoản ngân hàng
        /// </summary>
        Task AddAsync(TaiKhoanNganHang entity);

        /// <summary>
        /// Cập nhật thông tin tài khoản ngân hàng
        /// </summary>
        Task UpdateAsync(TaiKhoanNganHang entity);

        /// <summary>
        /// Xóa tài khoản ngân hàng
        /// </summary>
        Task DeleteAsync(long id);
    }
}
