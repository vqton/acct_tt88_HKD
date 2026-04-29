using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Application.Dtos;

namespace HkdAccounting.Application.Services
{
    /// <summary>
    /// Interface cho dịch vụ xử lý khách hàng - MD-05
    /// </summary>
    public interface IKhachHangService
    {
        Task<KhachHangDto> GetByIdAsync(long id);
        Task<IEnumerable<KhachHangDto>> GetAllAsync();
        Task<long> CreateAsync(KhachHangDto dto);
        Task UpdateAsync(KhachHangDto dto);
        Task DeleteAsync(long id);
    }
}