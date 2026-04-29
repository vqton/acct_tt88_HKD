using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;
using HkdAccounting.Domain.Repositories;
using HkdAccounting.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace HkdAccounting.Infrastructure.Repositories
{
    /// <summary>
    /// Repository implementation for TaiKhoanNganHang
    /// </summary>
    public class TaiKhoanNganHangRepository : ITaiKhoanNganHangRepository
    {
        private readonly AppDbContext _context;

        /// <summary>
        /// Constructor with database context injected via DI
        /// </summary>
        /// <param name="context">Database context</param>
        public TaiKhoanNganHangRepository(AppDbContext context)
        {
            _context = context;
        }

        /// <summary>
        /// Lấy thông tin tài khoản ngân hàng theo ID
        /// </summary>
        /// <param name="id">ID của tài khoản ngân hàng</param>
        /// <returns>Thông tin tài khoản ngân hàng</returns>
        public async Task<TaiKhoanNganHang> GetByIdAsync(long id)
        {
            return await _context.TaiKhoanNganHangs.FindAsync(id);
        }

        /// <summary>
        /// Lấy danh sách tất cả tài khoản ngân hàng
        /// </summary>
        /// <returns>Danh sách tài khoản ngân hàng</returns>
        public async Task<IEnumerable<TaiKhoanNganHang>> GetAllAsync()
        {
            return await _context.TaiKhoanNganHangs.ToListAsync();
        }

        /// <summary>
        /// Tạo mới tài khoản ngân hàng
        /// </summary>
        /// <param name="entity">Thông tin tài khoản ngân hàng cần tạo</param>
        public async Task AddAsync(TaiKhoanNganHang entity)
        {
            await _context.TaiKhoanNganHangs.AddAsync(entity);
            await _context.SaveChangesAsync();
        }

        /// <summary>
        /// Cập nhật thông tin tài khoản ngân hàng
        /// </summary>
        /// <param name="entity">Thông tin tài khoản ngân hàng cần cập nhật</param>
        public async Task UpdateAsync(TaiKhoanNganHang entity)
        {
            _context.TaiKhoanNganHangs.Update(entity);
            await _context.SaveChangesAsync();
        }

        /// <summary>
        /// Xóa tài khoản ngân hàng
        /// </summary>
        /// <param name="id">ID của tài khoản ngân hàng cần xóa</param>
        public async Task DeleteAsync(long id)
        {
            var entity = await GetByIdAsync(id);
            if (entity != null)
            {
                _context.TaiKhoanNganHangs.Remove(entity);
                await _context.SaveChangesAsync();
            }
        }
    }
}