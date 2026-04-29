using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;

namespace HkdAccounting.Domain.Repositories
{
    /// <summary>
    /// Interface Repository cho NhanVien
    /// </summary>
    public interface INhanVienRepository
    {
        /// <summary>
        /// Lấy nhân viên theo ID
        /// </summary>
        Task<NhanVien> GetByIdAsync(long id);

        /// <summary>
        /// Lấy danh sách tất cả nhân viên
        /// </summary>
        Task<IEnumerable<NhanVien>> GetAllAsync();

        /// <summary>
        /// Tạo mới nhân viên
        /// </summary>
        Task AddAsync(NhanVien entity);

        /// <summary>
        /// Cập nhật thông tin nhân viên
        /// </summary>
        Task UpdateAsync(NhanVien entity);

        /// <summary>
        /// Xóa nhân viên
        /// </summary>
        Task DeleteAsync(long id);
    }
}
