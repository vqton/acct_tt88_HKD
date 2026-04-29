using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;

namespace HkdAccounting.Domain.Repositories
{
    public interface IPhieuNhapKhoRepository
    {
        Task<PhieuNhapKho> GetByIdAsync(long id);
        Task<IEnumerable<PhieuNhapKho>> GetAllAsync();
        Task AddAsync(PhieuNhapKho entity);
        Task UpdateAsync(PhieuNhapKho entity);
        Task DeleteAsync(long id);
    }
}
