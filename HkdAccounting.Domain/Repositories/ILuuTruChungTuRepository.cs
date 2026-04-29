using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;

namespace HkdAccounting.Domain.Repositories
{
    public interface ILuuTruChungTuRepository
    {
        Task<LuuTruChungTu> GetByIdAsync(long id);
        Task<IEnumerable<LuuTruChungTu>> GetAllAsync();
        Task AddAsync(LuuTruChungTu entity);
        Task UpdateAsync(LuuTruChungTu entity);
        Task DeleteAsync(long id);
    }
}
