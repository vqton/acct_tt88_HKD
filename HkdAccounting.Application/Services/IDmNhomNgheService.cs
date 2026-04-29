using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Application.Dtos;

namespace HkdAccounting.Application.Services
{
    /// <summary>
    /// Interface cho dịch vụ xử lý danh mục nhóm nghề - MD-03
    /// </summary>
    public interface IDmNhomNgheService
    {
        Task<DmNhomNgheDto> GetByIdAsync(long id);
        Task<IEnumerable<DmNhomNgheDto>> GetAllAsync();
        Task<long> CreateAsync(DmNhomNgheDto dto);
        Task UpdateAsync(DmNhomNgheDto dto);
        Task DeleteAsync(long id);
    }
}
