using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;

namespace HkdAccounting.Domain.Repositories
{
    public interface IPheDuyetChungTuRepository
    {
        Task<PheDuyetChungTu> GetByIdAsync(long id);
        Task<IEnumerable<PheDuyetChungTu>> GetAllAsync();
        Task AddAsync(PheDuyetChungTu entity);
        Task UpdateAsync(PheDuyetChungTu entity);
        Task DeleteAsync(long id);
    }
}
