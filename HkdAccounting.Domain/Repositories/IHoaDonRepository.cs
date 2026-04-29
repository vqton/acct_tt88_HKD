using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;

namespace HkdAccounting.Domain.Repositories
{
    public interface IHoaDonRepository
    {
        Task<HoaDon> GetByIdAsync(long id);
        Task<IEnumerable<HoaDon>> GetAllAsync();
        Task AddAsync(HoaDon entity);
        Task UpdateAsync(HoaDon entity);
        Task DeleteAsync(long id);
    }
}
