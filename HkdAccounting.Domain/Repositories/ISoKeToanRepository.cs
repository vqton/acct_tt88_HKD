using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;

namespace HkdAccounting.Domain.Repositories
{
    public interface ISoKeToanRepository
    {
        Task<SoKeToan> GetByIdAsync(long id);
        Task<IEnumerable<SoKeToan>> GetAllAsync();
        Task AddAsync(SoKeToan entity);
        Task UpdateAsync(SoKeToan entity);
        Task DeleteAsync(long id);
    }
}
