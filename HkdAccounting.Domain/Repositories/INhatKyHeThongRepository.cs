using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;

namespace HkdAccounting.Domain.Repositories
{
    public interface INhatKyHeThongRepository
    {
        Task<NhatKyHeThong> GetByIdAsync(long id);
        Task<IEnumerable<NhatKyHeThong>> GetAllAsync();
        Task AddAsync(NhatKyHeThong entity);
        Task UpdateAsync(NhatKyHeThong entity);
        Task DeleteAsync(long id);
    }
}
