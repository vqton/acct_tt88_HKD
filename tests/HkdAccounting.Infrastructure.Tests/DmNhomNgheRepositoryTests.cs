using System;
using System.Linq;
using System.Threading.Tasks;
using Xunit;
using Microsoft.EntityFrameworkCore;
using HkdAccounting.Domain.Entities;
using HkdAccounting.Infrastructure.Data;
using HkdAccounting.Infrastructure.Repositories;

namespace HkdAccounting.Infrastructure.Tests
{
    /// <summary>
    /// Test cases cho DmNhomNgheRepository - MD-03 (Tax Rates)
    /// </summary>
    public class DmNhomNgheRepositoryTests
    {
        private AppDbContext CreateContext()
        {
            var options = new DbContextOptionsBuilder<AppDbContext>()
                .UseInMemoryDatabase(Guid.NewGuid().ToString())
                .Options;
            return new AppDbContext(options);
        }

        [Fact]
        public async Task AddAsync_ValidEntity_AddsToDatabase()
        {
            using var context = CreateContext();
            var repository = new DmNhomNgheRepository(context);
            var entity = new DmNhomNghe
            {
                MaNhomNghe = "Ngh001",
                TenNhomNghe = "Kinh doanh tổng hợp",
                TyLeThueGtgt = 5.0m,
                TyLeThueTncn = 2.0m,
                NgayHieuLuc = new DateTime(2024, 1, 1),
                TrangThai = "HOAT_DONG"
            };

            await repository.AddAsync(entity);

            Assert.Equal(1, context.DmNhomNghes.Count());
            Assert.Equal("Ngh001", context.DmNhomNghes.First().MaNhomNghe);
        }

        [Fact]
        public async Task GetByIdAsync_ExistingId_ReturnsEntity()
        {
            using var context = CreateContext();
            var repository = new DmNhomNgheRepository(context);
            var entity = new DmNhomNghe
            {
                MaNhomNghe = "Ngh001",
                TenNhomNghe = "Kinh doanh tổng hợp",
                TyLeThueGtgt = 5.0m,
                TyLeThueTncn = 2.0m,
                NgayHieuLuc = new DateTime(2024, 1, 1),
                TrangThai = "HOAT_DONG"
            };
            context.DmNhomNghes.Add(entity);
            await context.SaveChangesAsync();

            var result = await repository.GetByIdAsync(entity.Id);

            Assert.NotNull(result);
            Assert.Equal("Ngh001", result.MaNhomNghe);
            Assert.Equal(5.0m, result.TyLeThueGtgt);
        }

        [Fact]
        public async Task GetByIdAsync_NonExistingId_ReturnsNull()
        {
            using var context = CreateContext();
            var repository = new DmNhomNgheRepository(context);

            var result = await repository.GetByIdAsync(999);

            Assert.Null(result);
        }

        [Fact]
        public async Task GetAllAsync_ReturnsAllEntities()
        {
            using var context = CreateContext();
            var repository = new DmNhomNgheRepository(context);
            context.DmNhomNghes.Add(new DmNhomNghe { MaNhomNghe = "Ngh001", TenNhomNghe = "Kinh doanh tổng hợp", TyLeThueGtgt = 5.0m, TyLeThueTncn = 2.0m, NgayHieuLuc = DateTime.UtcNow });
            context.DmNhomNghes.Add(new DmNhomNghe { MaNhomNghe = "Ngh002", TenNhomNghe = "Bán lẻ hàng hóa", TyLeThueGtgt = 10.0m, TyLeThueTncn = 2.0m, NgayHieuLuc = DateTime.UtcNow });
            await context.SaveChangesAsync();

            var result = await repository.GetAllAsync();

            Assert.Equal(2, result.Count());
        }

        [Fact]
        public async Task UpdateAsync_ExistingEntity_UpdatesDatabase()
        {
            using var context = CreateContext();
            var repository = new DmNhomNgheRepository(context);
            var entity = new DmNhomNghe { MaNhomNghe = "Ngh001", TenNhomNghe = "Old Name", TyLeThueGtgt = 5.0m, TyLeThueTncn = 2.0m, NgayHieuLuc = DateTime.UtcNow };
            context.DmNhomNghes.Add(entity);
            await context.SaveChangesAsync();

            entity.TenNhomNghe = "Updated Name";
            entity.TyLeThueGtgt = 8.0m;
            await repository.UpdateAsync(entity);

            var updated = await context.DmNhomNghes.FindAsync(entity.Id);
            Assert.Equal("Updated Name", updated.TenNhomNghe);
            Assert.Equal(8.0m, updated.TyLeThueGtgt);
        }

        [Fact]
        public async Task DeleteAsync_ExistingId_RemovesFromDatabase()
        {
            using var context = CreateContext();
            var repository = new DmNhomNgheRepository(context);
            var entity = new DmNhomNghe { MaNhomNghe = "Ngh001", TenNhomNghe = "Kinh doanh tổng hợp", TyLeThueGtgt = 5.0m, TyLeThueTncn = 2.0m, NgayHieuLuc = DateTime.UtcNow };
            context.DmNhomNghes.Add(entity);
            await context.SaveChangesAsync();

            await repository.DeleteAsync(entity.Id);

            Assert.Empty(context.DmNhomNghes.ToList());
        }

        [Fact]
        public async Task GetEffectiveAsync_ValidMaNhomNgheAndDate_ReturnsActiveEntity()
        {
            using var context = CreateContext();
            var repository = new DmNhomNgheRepository(context);
            var entity = new DmNhomNghe
            {
                MaNhomNghe = "Ngh001",
                TenNhomNghe = "Kinh doanh tổng hợp",
                TyLeThueGtgt = 5.0m,
                TyLeThueTncn = 2.0m,
                NgayHieuLuc = new DateTime(2024, 1, 1),
                NgayHetHieuLuc = null,
                TrangThai = "HOAT_DONG"
            };
            context.DmNhomNghes.Add(entity);
            await context.SaveChangesAsync();

            var result = await repository.GetEffectiveAsync("Ngh001", new DateTime(2024, 6, 15));

            Assert.NotNull(result);
            Assert.Equal("Ngh001", result.MaNhomNghe);
            Assert.Equal(5.0m, result.TyLeThueGtgt);
        }

        [Fact]
        public async Task GetEffectiveAsync_DateBeforeEffectiveDate_ReturnsNull()
        {
            using var context = CreateContext();
            var repository = new DmNhomNgheRepository(context);
            var entity = new DmNhomNghe
            {
                MaNhomNghe = "Ngh001",
                TenNhomNghe = "Kinh doanh tổng hợp",
                TyLeThueGtgt = 5.0m,
                TyLeThueTncn = 2.0m,
                NgayHieuLuc = new DateTime(2024, 7, 1),
                NgayHetHieuLuc = null,
                TrangThai = "HOAT_DONG"
            };
            context.DmNhomNghes.Add(entity);
            await context.SaveChangesAsync();

            var result = await repository.GetEffectiveAsync("Ngh001", new DateTime(2024, 6, 15));

            Assert.Null(result);
        }

        [Fact]
        public async Task GetEffectiveAsync_DateAfterExpiredDate_ReturnsNull()
        {
            using var context = CreateContext();
            var repository = new DmNhomNgheRepository(context);
            var entity = new DmNhomNghe
            {
                MaNhomNghe = "Ngh001",
                TenNhomNghe = "Kinh doanh tổng hợp",
                TyLeThueGtgt = 5.0m,
                TyLeThueTncn = 2.0m,
                NgayHieuLuc = new DateTime(2024, 1, 1),
                NgayHetHieuLuc = new DateTime(2024, 6, 30),
                TrangThai = "HOAT_DONG"
            };
            context.DmNhomNghes.Add(entity);
            await context.SaveChangesAsync();

            var result = await repository.GetEffectiveAsync("Ngh001", new DateTime(2024, 7, 15));

            Assert.Null(result);
        }

        [Fact]
        public async Task GetEffectiveAsync_MultipleVersions_ReturnsLatestEffective()
        {
            using var context = CreateContext();
            var repository = new DmNhomNgheRepository(context);
            context.DmNhomNghes.Add(new DmNhomNghe
            {
                MaNhomNghe = "Ngh001",
                TenNhomNghe = "Version 1",
                TyLeThueGtgt = 5.0m,
                TyLeThueTncn = 2.0m,
                NgayHieuLuc = new DateTime(2024, 1, 1),
                NgayHetHieuLuc = new DateTime(2024, 6, 30),
                TrangThai = "HOAT_DONG"
            });
            context.DmNhomNghes.Add(new DmNhomNghe
            {
                MaNhomNghe = "Ngh001",
                TenNhomNghe = "Version 2",
                TyLeThueGtgt = 8.0m,
                TyLeThueTncn = 3.0m,
                NgayHieuLuc = new DateTime(2024, 7, 1),
                NgayHetHieuLuc = null,
                TrangThai = "HOAT_DONG"
            });
            await context.SaveChangesAsync();

            var result = await repository.GetEffectiveAsync("Ngh001", new DateTime(2024, 8, 1));

            Assert.NotNull(result);
            Assert.Equal("Version 2", result.TenNhomNghe);
            Assert.Equal(8.0m, result.TyLeThueGtgt);
        }

        [Fact]
        public async Task DeleteAsync_NonExistingId_DoesNotThrow()
        {
            using var context = CreateContext();
            var repository = new DmNhomNgheRepository(context);

            var exception = await Record.ExceptionAsync(() => repository.DeleteAsync(999));

            Assert.Null(exception);
        }
    }
}