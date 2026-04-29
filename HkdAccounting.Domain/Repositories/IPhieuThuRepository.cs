using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;

namespace HkdAccounting.Domain.Repositories
{
    public interface IPhieuThuRepository
    {
        Task<PhieuThu> GetByIdAsync(long id);
        Task<IEnumerable<PhieuThu>> GetAllAsync();
        Task AddAsync(PhieuThu entity);
        Task UpdateAsync(PhieuThu entity);
        Task DeleteAsync(long id);
    }
}
