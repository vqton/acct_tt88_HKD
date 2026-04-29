using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;

namespace HkdAccounting.Domain.Repositories
{
    public interface INghiaVuThueRepository
    {
        Task<NghiaVuThue> GetByIdAsync(long id);
        Task<IEnumerable<NghiaVuThue>> GetAllAsync();
        Task AddAsync(NghiaVuThue entity);
        Task UpdateAsync(NghiaVuThue entity);
        Task DeleteAsync(long id);
    }
}
