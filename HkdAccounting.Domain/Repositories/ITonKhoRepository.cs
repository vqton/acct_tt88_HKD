using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;

namespace HkdAccounting.Domain.Repositories
{
    public interface ITonKhoRepository
    {
        Task<TonKho> GetByIdAsync(long id);
        Task<IEnumerable<TonKho>> GetAllAsync();
        Task AddAsync(TonKho entity);
        Task UpdateAsync(TonKho entity);
        Task DeleteAsync(long id);
    }
}
