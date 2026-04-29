using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;
using HkdAccounting.Domain.Repositories;
using HkdAccounting.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace HkdAccounting.Infrastructure.Repositories
{
    /// <summary>
    /// Repository implementation for KhachHang
    /// </summary>
    public class KhachHangRepository : IKhachHangRepository
    {
        private readonly AppDbContext _context;

        public KhachHangRepository(AppDbContext context)
        {
            _context = context;
        }

        public async Task<KhachHang> GetByIdAsync(long id)
        {
            return await _context.KhachHangs.FindAsync(id);
        }

        public async Task<IEnumerable<KhachHang>> GetAllAsync()
        {
            return await _context.KhachHangs.ToListAsync();
        }

        public async Task AddAsync(KhachHang entity)
        {
            await _context.KhachHangs.AddAsync(entity);
            await _context.SaveChangesAsync();
        }

        public async Task UpdateAsync(KhachHang entity)
        {
            _context.KhachHangs.Update(entity);
            await _context.SaveChangesAsync();
        }

        public async Task DeleteAsync(long id)
        {
            var entity = await GetByIdAsync(id);
            if (entity != null)
            {
                _context.KhachHangs.Remove(entity);
                await _context.SaveChangesAsync();
            }
        }
    }
}