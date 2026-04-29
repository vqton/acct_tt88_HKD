using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;

namespace HkdAccounting.Domain.Repositories
{
    public interface IPhieuXuatKhoRepository
    {
        Task<PhieuXuatKho> GetByIdAsync(long id);
        Task<IEnumerable<PhieuXuatKho>> GetAllAsync();
        Task AddAsync(PhieuXuatKho entity);
        Task UpdateAsync(PhieuXuatKho entity);
        Task DeleteAsync(long id);
    }
}
