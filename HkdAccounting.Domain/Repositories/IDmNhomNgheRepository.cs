using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;

namespace HkdAccounting.Domain.Repositories
{
    /// <summary>
    /// Interface Repository cho DmNhomNghe
    /// </summary>
    public interface IDmNhomNgheRepository
    {
        /// <summary>
        /// Lấy danh mục ngành nghề theo ID
        /// </summary>
        /// <param name="id">ID của danh mục ngành nghề</param>
        /// <returns>Danh mục ngành nghề</returns>
        Task<DmNhomNghe> GetByIdAsync(long id);

        /// <summary>
        /// Lấy danh sách tất cả danh mục ngành nghề
        /// </summary>
        /// <returns>Danh sách danh mục ngành nghề</returns>
        Task<IEnumerable<DmNhomNghe>> GetAllAsync();

        /// <summary>
        /// Tạo mới danh mục ngành nghề
        /// </summary>
        /// <param name="entity">Danh mục ngành nghề cần tạo</param>
        Task AddAsync(DmNhomNghe entity);

        /// <summary>
        /// Cập nhật danh mục ngành nghề
        /// </summary>
        /// <param name="entity">Danh mục ngành nghề cần cập nhật</param>
        Task UpdateAsync(DmNhomNghe entity);

        /// <summary>
        /// Xóa danh mục ngành nghề
        /// </summary>
        /// <param name="id">ID của danh mục ngành nghề cần xóa</param>
        Task DeleteAsync(long id);

        /// <summary>
        /// Lấy danh mục ngành nghề có hiệu lực tại một ngày nhất định
        /// </summary>
        /// <param name="maNhomNghe">Mã nhóm nghề</param>
        /// <param name="ngay">Ngày cần kiểm tra</param>
        /// <returns>Danh mục ngành nghề có hiệu lực</returns>
        Task<DmNhomNghe> GetEffectiveAsync(string maNhomNghe, DateTime ngay);
    }
}