using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;
using HkdAccounting.Domain.Repositories;
using Microsoft.EntityFrameworkCore;

namespace HkdAccounting.Infrastructure.Repositories
{
    /// <summary>
    /// Repository implementation for DmNhomNghe
    /// </>
    public class DmNhomNgheRepository : IDmNhomNgheRepository
    {
        private readonly AppDbContext _context;

        /// <summary>
        /// Constructor with database context injected via DI
        /// </summary>
        /// <param name="context">Database context</param>
        public DmNhomNgheRepository(AppDbContext context)
        {
            _context = context;
        }

        /// <summary>
        /// Lấy danh mục ngành nghề theo ID
        /// </summary>
        /// <param name="id">ID của danh mục ngành nghề</param>
        /// <returns>Danh mục ngành nghề</returns>
        public async Task<DmNhomNghe> GetByIdAsync(long id)
        {
            return await _context.DmNhomNghes.FindAsync(id);
        }

        /// <summary>
        /// Lấy danh sách tất cả danh mục ngành nghề
        /// </summary>
        /// <returns>Danh sách danh mục ngành nghề</returns>
        public async Task<IEnumerable<DmNhomNghe>> GetAllAsync()
        {
            return await _context.DmNhomNghes.ToListAsync();
        }

        /// <summary>
        /// Tạo mới danh mục ngành nghề
        /// </summary>
        /// <param name="entity">Danh mục ngành nghề cần tạo</param>
        public async Task AddAsync(DmNhomNghe entity)
        {
            await _context.DmNhomNghes.AddAsync(entity);
            await _context.SaveChangesAsync();
        }

        /// <summary>
        /// Cập nhật danh mục ngành nghề
        /// </summary>
        /// <param name="entity">Danh mục ngành nghề cần cập nhật</param>
        public async Task UpdateAsync(DmNhomNghe entity)
        {
            _context.DmNhomNghes.Update(entity);
            await _context.SaveChangesAsync();
        }

        /// <summary>
        /// Xóa danh mục ngành nghề
        /// </summary>
        /// <param name="id">ID của danh mục ngành nghề cần xóa</param>
        public async Task DeleteAsync(long id)
        {
            var entity = await GetByIdAsync(id);
            if (entity != null)
            {
                _context.DmNhomNghes.Remove(entity);
                await _context.SaveChangesAsync();
            }
        }

        /// <summary>
        /// Lấy danh mục ngành nghề có hiệu lực tại một ngày nhất định
        /// </summary>
        /// <param name="maNhomNghe">Mã nhóm nghề</param>
        /// <param name="ngay">Ngày cần kiểm tra</param>
        /// <returns>Danh mục ngành nghề có hiệu lực</returns>
        public async Task<DmNhomNghe> GetEffectiveAsync(string maNhomNghe, DateTime ngay)
        {
            return await _context.DmNhomNghes
                .Where(e => e.MaNhomNghe == maNhomNghe 
                         && e.NgayHieuLuc <= ngay 
                         && (!e.NgayHetHieuLuc.HasValue || e.NgayHetHieuLuc.Value >= ngay))
                .OrderByDescending(e => e.NgayHieuLuc)
                .FirstOrDefaultAsync();
        }
    }
}