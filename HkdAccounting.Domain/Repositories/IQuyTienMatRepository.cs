using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;

namespace HkdAccounting.Domain.Repositories
{
    public interface IQuyTienMatRepository
    {
        Task<QuyTienMat> GetByIdAsync(long id);
        Task<IEnumerable<QuyTienMat>> GetAllAsync();
        Task AddAsync(QuyTienMat entity);
        Task UpdateAsync(QuyTienMat entity);
        Task DeleteAsync(long id);
    }
}
