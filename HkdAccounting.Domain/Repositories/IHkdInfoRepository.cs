using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;

namespace HkdAccounting.Domain.Repositories
{
    /// <summary>
    /// Interface Repository cho HkdInfo
    /// </summary>
    public interface IHkdInfoRepository
    {
        /// <summary>
        /// Lấy thông tin hộ kinh doanh theo ID
        /// </summary>
        /// <param name="id">ID của hộ kinh doanh</param>
        /// <returns>Thông tin hộ kinh doanh</returns>
        Task<HkdInfo> GetByIdAsync(long id);

        /// <summary>
        /// Lấy danh sách tất cả hộ kinh doanh
        /// </summary>
        /// <returns>Danh sách hộ kinh doanh</returns>
        Task<IEnumerable<HkdInfo>> GetAllAsync();

        /// <summary>
        /// Tạo mới hộ kinh doanh
        /// </summary>
        /// <param name="entity">Thông tin hộ kinh doanh cần tạo</param>
        Task AddAsync(HkdInfo entity);

        /// <summary>
        /// Cập nhật thông tin hộ kinh doanh
        /// </summary>
        /// <param name="entity">Thông tin hộ kinh doanh cần cập nhật</param>
        Task UpdateAsync(HkdInfo entity);

        /// <summary>
        /// Xóa hộ kinh doanh
        /// </summary>
        /// <param name="id">ID của hộ kinh doanh cần xóa</param>
        Task DeleteAsync(long id);
    }
}