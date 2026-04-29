using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Application.Dtos;

namespace HkdAccounting.Application.Services
{
    /// <summary>
    /// Interface cho dịch vụ xử lý danh mục hàng hóa - MD-02
    /// </summary>
    public interface IDmHangHoaService
    {
        /// <summary>
        /// Lấy danh mục hàng hóa theo ID
        /// </summary>
        Task<DmHangHoaDto> GetByIdAsync(long id);

        /// <summary>
        /// Lấy danh sách tất cả danh mục hàng hóa
        /// </summary>
        Task<IEnumerable<DmHangHoaDto>> GetAllAsync();

        /// <summary>
        /// Tạo mới danh mục hàng hóa
        /// </summary>
        Task<long> CreateAsync(DmHangHoaDto dto);

        /// <summary>
        /// Cập nhật danh mục hàng hóa
        /// </summary>
        Task UpdateAsync(DmHangHoaDto dto);

        /// <summary>
        /// Xóa danh mực hàng hóa
        /// </summary>
        Task DeleteAsync(long id);
    }
}
