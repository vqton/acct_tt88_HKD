using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;

namespace HkdAccounting.Domain.Repositories
{
    public interface IPhieuChiRepository
    {
        Task<PhieuChi> GetByIdAsync(long id);
        Task<IEnumerable<PhieuChi>> GetAllAsync();
        Task AddAsync(PhieuChi entity);
        Task UpdateAsync(PhieuChi entity);
        Task DeleteAsync(long id);
    }
}
