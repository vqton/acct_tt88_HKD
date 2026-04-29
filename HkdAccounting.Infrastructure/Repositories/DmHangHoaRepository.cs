using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;
using HkdAccounting.Domain.Repositories;
using Microsoft.EntityFrameworkCore;

namespace HkdAccounting.Infrastructure.Repositories
{
    /// <summary>
    /// Repository implementation for DmHangHoa
    /// </summary>
    public class DmHangHoaRepository : IDmHangHoaRepository
    {
        private readonly AppDbContext _context;

        /// <summary>
        /// Constructor with database context injected via DI
        /// </summary>
        /// <param name="context">Database context</param>
        public DmHangHoaRepository(AppDbContext context)
        {
            _context = context;
        }

        /// <summary>
        /// Lấy danh mục hàng hóa theo ID
        /// </summary>
        /// <param name="id">ID của danh mục hàng hóa</param>
        /// <returns>Danh mục hàng hóa</returns>
        public async Task<DmHangHoa> GetByIdAsync(long id)
        {
            return await _context.DmHangHoas.FindAsync(id);
        }

        /// <summary>
        /// Lấy danh sách tất cả danh mục hàng hóa
        /// </summary>
        /// <returns>Danh sách danh mục hàng hóa</returns>
        public async Task<IEnumerable<DmHangHoa>> GetAllAsync()
        {
            return await _context.DmHangHoas.ToListAsync();
        }

        /// <summary>
        /// Tạo mới danh mục hàng hóa
        /// </summary>
        /// <param name="entity">Danh mục hàng hóa cần tạo</param>
        public async Task AddAsync(DmHangHoa entity)
        {
            await _context.DmHangHoas.AddAsync(entity);
            await _context.SaveChangesAsync();
        }

        /// <summary>
        /// Cập nhật danh mục hàng hóa
        /// </summary>
        /// <param name="entity">Danh mục hàng hóa cần cập nhật</param>
        public async Task UpdateAsync(DmHangHoa entity)
        {
            _context.DmHangHoas.Update(entity);
            await _context.SaveChangesAsync();
        }

        /// <summary>
        /// Xóa danh mục hàng hóa
        /// </summary>
        /// <param name="id">ID của danh mục hàng hóa cần xóa</param>
        public async Task DeleteAsync(long id)
        {
            var entity = await GetByIdAsync(id);
            if (entity != null)
            {
                _context.DmHangHoas.Remove(entity);
                await _context.SaveChangesAsync();
            }
        }
    }
}