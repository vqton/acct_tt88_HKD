using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Domain.Entities;
using HkdAccounting.Domain.Repositories;
using HkdAccounting.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace HkdAccounting.Infrastructure.Repositories
{
    /// <summary>
    /// Repository implementation for DoiTac
    /// </summary>
    public class DoiTacRepository : IDoiTacRepository
    {
        private readonly AppDbContext _context;

        public DoiTacRepository(AppDbContext context)
        {
            _context = context;
        }

        public async Task<DoiTac> GetByIdAsync(long id)
        {
            return await _context.DoiTacs.FindAsync(id);
        }

        public async Task<IEnumerable<DoiTac>> GetAllAsync()
        {
            return await _context.DoiTacs.ToListAsync();
        }

        public async Task AddAsync(DoiTac entity)
        {
            await _context.DoiTacs.AddAsync(entity);
            await _context.SaveChangesAsync();
        }

        public async Task UpdateAsync(DoiTac entity)
        {
            _context.DoiTacs.Update(entity);
            await _context.SaveChangesAsync();
        }

        public async Task DeleteAsync(long id)
        {
            var entity = await GetByIdAsync(id);
            if (entity != null)
            {
                _context.DoiTacs.Remove(entity);
                await _context.SaveChangesAsync();
            }
        }
    }
}