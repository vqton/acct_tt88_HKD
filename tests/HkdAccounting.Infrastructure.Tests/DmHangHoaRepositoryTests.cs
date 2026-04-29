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
    /// Test cases cho DmHangHoaRepository - MD-02
    /// </summary>
    public class DmHangHoaRepositoryTests
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
            // Arrange
            using var context = CreateContext();
            var repository = new DmHangHoaRepository(context);
            var entity = new DmHangHoa
            {
                MaHang = "MH001",
                TenHang = "Gao nep",
                DonViTinh = "Kg",
                LoaiHang = "HANG_HOA",
                NhanHieuQuyCach = "Chat luong cao",
                DonGiaMuaChuan = 50000,
                TrangThai = "DANG_KINH_DOANH"
            };

            // Act
            await repository.AddAsync(entity);

            // Assert
            Assert.Equal(1, context.DmHangHoas.Count());
            Assert.Equal("MH001", context.DmHangHoas.First().MaHang);
        }

        [Fact]
        public async Task GetByIdAsync_ExistingId_ReturnsEntity()
        {
            // Arrange
            using var context = CreateContext();
            var repository = new DmHangHoaRepository(context);
            var entity = new DmHangHoa
            {
                MaHang = "MH001",
                TenHang = "Gao nep",
                DonViTinh = "Kg",
                LoaiHang = "HANG_HOA",
                NhanHieuQuyCach = "Chat luong cao",
                DonGiaMuaChuan = 50000,
                TrangThai = "DANG_KINH_DOANH"
            };
            context.DmHangHoas.Add(entity);
            await context.SaveChangesAsync();

            // Act
            var result = await repository.GetByIdAsync(entity.Id);

            // Assert
            Assert.NotNull(result);
            Assert.Equal("MH001", result.MaHang);
        }

        [Fact]
        public async Task GetByIdAsync_NonExistingId_ReturnsNull()
        {
            // Arrange
            using var context = CreateContext();
            var repository = new DmHangHoaRepository(context);

            // Act
            var result = await repository.GetByIdAsync(999);

            // Assert
            Assert.Null(result);
        }

        [Fact]
        public async Task GetAllAsync_ReturnsAllEntities()
        {
            // Arrange
            using var context = CreateContext();
            var repository = new DmHangHoaRepository(context);
            context.DmHangHoas.Add(new DmHangHoa { MaHang = "MH001", TenHang = "Hang 1", DonViTinh = "Kg", LoaiHang = "HANG_HOA", NhanHieuQuyCach = "A", TrangThai = "DANG_KINH_DOANH" });
            context.DmHangHoas.Add(new DmHangHoa { MaHang = "MH002", TenHang = "Hang 2", DonViTinh = "Cai", LoaiHang = "DICH_VU", NhanHieuQuyCach = "B", TrangThai = "DANG_KINH_DOANH" });
            await context.SaveChangesAsync();

            // Act
            var result = await repository.GetAllAsync();

            // Assert
            Assert.Equal(2, result.Count());
        }

        [Fact]
        public async Task UpdateAsync_ExistingEntity_UpdatesDatabase()
        {
            // Arrange
            using var context = CreateContext();
            var repository = new DmHangHoaRepository(context);
            var entity = new DmHangHoa { MaHang = "MH001", TenHang = "Old Name", DonViTinh = "Kg", LoaiHang = "HANG_HOA", NhanHieuQuyCach = "A", TrangThai = "DANG_KINH_DOANH" };
            context.DmHangHoas.Add(entity);
            await context.SaveChangesAsync();

            // Act
            entity.TenHang = "Updated Name";
            await repository.UpdateAsync(entity);

            // Assert
            var updated = await context.DmHangHoas.FindAsync(entity.Id);
            Assert.Equal("Updated Name", updated.TenHang);
        }

        [Fact]
        public async Task DeleteAsync_ExistingId_RemovesFromDatabase()
        {
            // Arrange
            using var context = CreateContext();
            var repository = new DmHangHoaRepository(context);
            var entity = new DmHangHoa { MaHang = "MH001", TenHang = "Gao nep", DonViTinh = "Kg", LoaiHang = "HANG_HOA", NhanHieuQuyCach = "A", TrangThai = "DANG_KINH_DOANH" };
            context.DmHangHoas.Add(entity);
            await context.SaveChangesAsync();

            // Act
            await repository.DeleteAsync(entity.Id);

            // Assert
            Assert.Empty(context.DmHangHoas.ToList());
        }
    }
}
