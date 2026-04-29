using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;
using HkdAccounting.Domain.Repositories;
using HkdAccounting.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace HkdAccounting.Infrastructure.Repositories
{
    /// <summary>
    /// Repository implementation for NhanVien
    /// </summary>
    public class NhanVienRepository : INhanVienRepository
    {
        private readonly AppDbContext _context;

        /// <summary>
        /// Constructor with database context injected via DI
        /// </summary>
        /// <param name="context">Database context</param>
        public NhanVienRepository(AppDbContext context)
        {
            _context = context;
        }

        /// <summary>
        /// Lấy thông tin nhân viên theo ID
        /// </summary>
        /// <param name="id">ID của nhân viên</param>
        /// <returns>Thông tin nhân viên</returns>
        public async Task<NhanVien> GetByIdAsync(long id)
        {
            return await _context.NhanViens.FindAsync(id);
        }

        /// <summary>
        /// Lấy danh sách tất cả nhân viên
        /// </summary>
        /// <returns>Danh sách nhân viên</returns>
        public async Task<IEnumerable<NhanVien>> GetAllAsync()
        {
            return await _context.NhanViens.ToListAsync();
        }

        /// <summary>
        /// Tạo mới nhân viên
        /// </summary>
        /// <param name="entity">Thông tin nhân viên cần tạo</param>
        public async Task AddAsync(NhanVien entity)
        {
            await _context.NhanViens.AddAsync(entity);
            await _context.SaveChangesAsync();
        }

        /// <summary>
        /// Cập nhật thông tin nhân viên
        /// </summary>
        /// <param name="entity">Thông tin nhân viên cần cập nhật</param>
        public async Task UpdateAsync(NhanVien entity)
        {
            _context.NhanViens.Update(entity);
            await _context.SaveChangesAsync();
        }

        /// <summary>
        /// Xóa nhân viên
        /// </summary>
        /// <param name="id">ID của nhân viên cần xóa</param>
        public async Task DeleteAsync(long id)
        {
            var entity = await GetByIdAsync(id);
            if (entity != null)
            {
                _context.NhanViens.Remove(entity);
                await _context.SaveChangesAsync();
            }
        }
    }
}