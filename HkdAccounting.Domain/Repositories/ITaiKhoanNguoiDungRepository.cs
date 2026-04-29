using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;

namespace HkdAccounting.Domain.Repositories
{
    public interface ITaiKhoanNguoiDungRepository
    {
        Task<TaiKhoanNguoiDung> GetByIdAsync(long id);
        Task<IEnumerable<TaiKhoanNguoiDung>> GetAllAsync();
        Task AddAsync(TaiKhoanNguoiDung entity);
        Task UpdateAsync(TaiKhoanNguoiDung entity);
        Task DeleteAsync(long id);
    }
}
