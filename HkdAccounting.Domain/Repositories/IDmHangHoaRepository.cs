using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;

namespace HkdAccounting.Domain.Repositories
{
    /// <summary>
    /// Interface Repository cho DmHangHoa
    /// </summary>
    public interface IDmHangHoaRepository
    {
        /// <summary>
        /// Lấy danh mục hàng hóa theo ID
        /// </summary>
        /// <param name="id">ID của danh mục hàng hóa</param>
        /// <returns>Danh mục hàng hóa</returns>
        Task<DmHangHoa> GetByIdAsync(long id);

        /// <summary>
        /// Lấy danh sách tất cả danh mục hàng hóa
        /// </summary>
        /// <returns>Danh sách danh mục hàng hóa</returns>
        Task<IEnumerable<DmHangHoa>> GetAllAsync();

        /// <summary>
        /// Tạo mới danh mục hàng hóa
        /// </summary>
        /// <param name="entity">Danh mục hàng hóa cần tạo</param>
        Task AddAsync(DmHangHoa entity);

        /// <summary>
        /// Cập nhật danh mục hàng hóa
        /// </summary>
        /// <param name="entity">Danh mục hàng hóa cần cập nhật</param>
        Task UpdateAsync(DmHangHoa entity);

        /// <summary>
        /// Xóa danh mục hàng hóa
        /// </summary>
        /// <param name="id">ID của danh mục hàng hóa cần xóa</param>
        Task DeleteAsync(long id);
    }
}