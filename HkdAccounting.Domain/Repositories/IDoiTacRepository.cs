using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;

namespace HkdAccounting.Domain.Repositories
{
    /// <summary>
    /// Interface Repository cho DoiTac
    /// </summary>
    public interface IDoiTacRepository
    {
        /// <summary>
        /// Lấy đối tác theo ID
        /// </summary>
        Task<DoiTac> GetByIdAsync(long id);

        /// <summary>
        /// Lấy danh sách tất cả đối tác
        /// </summary>
        Task<IEnumerable<DoiTac>> GetAllAsync();

        /// <summary>
        /// Tạo mới đối tác
        /// </summary>
        Task AddAsync(DoiTac entity);

        /// <summary>
        /// Cập nhật thông tin đối tác
        /// </summary>
        Task UpdateAsync(DoiTac entity);

        /// <summary>
        /// Xóa đối tác
        /// </summary>
        Task DeleteAsync(long id);
    }
}
