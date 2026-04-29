using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Application.Dtos;

namespace HkdAccounting.Application.Services
{
    /// <summary>
    /// Interface cho dịch vụ xử lý đối tác - MD-04
    /// </summary>
    public interface IDoiTacService
    {
        Task<DoiTacDto> GetByIdAsync(long id);
        Task<IEnumerable<DoiTacDto>> GetAllAsync();
        Task<long> CreateAsync(DoiTacDto dto);
        Task UpdateAsync(DoiTacDto dto);
        Task DeleteAsync(long id);
    }
}