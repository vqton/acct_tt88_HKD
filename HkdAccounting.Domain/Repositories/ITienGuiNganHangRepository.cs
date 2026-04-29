using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;

namespace HkdAccounting.Domain.Repositories
{
    public interface ITienGuiNganHangRepository
    {
        Task<TienGuiNganHang> GetByIdAsync(long id);
        Task<IEnumerable<TienGuiNganHang>> GetAllAsync();
        Task AddAsync(TienGuiNganHang entity);
        Task UpdateAsync(TienGuiNganHang entity);
        Task DeleteAsync(long id);
    }
}
