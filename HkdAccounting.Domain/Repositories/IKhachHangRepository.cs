using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;

namespace HkdAccounting.Domain.Repositories
{
    /// <summary>
    /// Interface Repository cho KhachHang
    /// </summary>
    public interface IKhachHangRepository
    {
        /// <summary>
        /// Lấy khách hàng theo ID
        /// </summary>
        Task<KhachHang> GetByIdAsync(long id);

        /// <summary>
        /// Lấy danh sách tất cả khách hàng
        /// </summary>
        Task<IEnumerable<KhachHang>> GetAllAsync();

        /// <summary>
        /// Tạo mới khách hàng
        /// </summary>
        Task AddAsync(KhachHang entity);

        /// <summary>
        /// Cập nhật thông tin khách hàng
        /// </summary>
        Task UpdateAsync(KhachHang entity);

        /// <summary>
        /// Xóa khách hàng
        /// </summary>
        Task DeleteAsync(long id);
    }
}
