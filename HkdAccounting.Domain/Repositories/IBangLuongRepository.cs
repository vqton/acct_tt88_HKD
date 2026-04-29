using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;

namespace HkdAccounting.Domain.Repositories
{
    public interface IBangLuongRepository
    {
        Task<BangLuong> GetByIdAsync(long id);
        Task<IEnumerable<BangLuong>> GetAllAsync();
        Task AddAsync(BangLuong entity);
        Task UpdateAsync(BangLuong entity);
        Task DeleteAsync(long id);
    }
}
