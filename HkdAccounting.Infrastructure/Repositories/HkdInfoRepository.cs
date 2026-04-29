using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;
using HkdAccounting.Domain.Repositories;
using Microsoft.EntityFrameworkCore;

namespace HkdAccounting.Infrastructure.Repositories
{
    /// <summary>
    /// Repository implementation for HkdInfo
    /// </summary>
    public class HkdInfoRepository : IHkdInfoRepository
    {
        private readonly AppDbContext _context;

        /// <summary>
        /// Constructor with database context injected via DI
        /// </summary>
        /// <param name="context">Database context</param>
        public HkdInfoRepository(AppDbContext context)
        {
            _context = context;
        }

        /// <summary>
        /// Lấy thông tin hộ kinh doanh theo ID
        /// </summary>
        /// <param name="id">ID của hộ kinh doanh</param>
        /// <returns>Thông tin hộ kinh doanh</returns>
        public async Task<HkdInfo> GetByIdAsync(long id)
        {
            return await _context.HkdInfos.FindAsync(id);
        }

        /// <summary>
        /// Lấy danh sách tất cả hộ kinh doanh
        /// </summary>
        /// <returns>Danh sách hộ kinh doanh</returns>
        public async Task<IEnumerable<HkdInfo>> GetAllAsync()
        {
            return await _context.HkdInfos.ToListAsync();
        }

        /// <summary>
        /// Tạo mới hộ kinh doanh
        /// </summary>
        /// <param name="entity">Thông tin hộ kinh doanh cần tạo</param>
        public async Task AddAsync(HkdInfo entity)
        {
            await _context.HkdInfos.AddAsync(entity);
            await _context.SaveChangesAsync();
        }

        /// <summary>
        /// Cập nhật thông tin hộ kinh doanh
        /// </summary>
        /// <param name="entity">Thông tin hộ kinh doanh cần cập nhật</param>
        public async Task UpdateAsync(HkdInfo entity)
        {
            _context.HkdInfos.Update(entity);
            await _context.SaveChangesAsync();
        }

        /// <summary>
        /// Xóa hộ kinh doanh
        /// </summary>
        /// <param name="id">ID của hộ kinh doanh cần xóa</param>
        public async Task DeleteAsync(long id)
        {
            var entity = await GetByIdAsync(id);
            if (entity != null)
            {
                _context.HkdInfos.Remove(entity);
                await _context.SaveChangesAsync();
            }
        }
    }
}