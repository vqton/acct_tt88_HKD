using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;

namespace HkdAccounting.Domain.Repositories
{
    /// <summary>
    /// Interface Repository cho KyKeToan
    /// </summary>
    public interface IKyKeToanRepository
    {
        /// <summary>
        /// Lấy kỳ kế toán theo ID
        /// </summary>
        Task<KyKeToan> GetByIdAsync(long id);

        /// <summary>
        /// Lấy danh sách tất cả kỳ kế toán
        /// </summary>
        Task<IEnumerable<KyKeToan>> GetAllAsync();

        /// <summary>
        /// Tạo mới kỳ kế toán
        /// </summary>
        Task AddAsync(KyKeToan entity);

        /// <summary>
        /// Cập nhật thông tin kỳ kế toán
        /// </summary>
        Task UpdateAsync(KyKeToan entity);

        /// <summary>
        /// Xóa kỳ kế toán
        /// </summary>
        Task DeleteAsync(long id);
    }
}
