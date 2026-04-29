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
    /// Test cases cho HkdInfoRepository - MD-01
    /// </summary>
    public class HkdInfoRepositoryTests
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
            var repository = new HkdInfoRepository(context);
            var entity = new HkdInfo
            {
                TenHkd = "Test HKD",
                MaSoThue = "0101234567",
                DiaChiTruSo = "123 Test St",
                HoTenNguoiDaiDien = "Nguyen Van A",
                SoCccdNguoiDaiDien = "012345678901",
                PhuongPhapTinhGiaXuatKho = "BINH_QUAN"
            };

            // Act
            await repository.AddAsync(entity);

            // Assert
            Assert.Equal(1, context.HkdInfos.Count());
            Assert.Equal("Test HKD", context.HkdInfos.First().TenHkd);
        }

        [Fact]
        public async Task GetByIdAsync_ExistingId_ReturnsEntity()
        {
            // Arrange
            using var context = CreateContext();
            var repository = new HkdInfoRepository(context);
            var entity = new HkdInfo
            {
                TenHkd = "Test HKD",
                MaSoThue = "0101234567",
                DiaChiTruSo = "123 Test St",
                HoTenNguoiDaiDien = "Nguyen Van A",
                SoCccdNguoiDaiDien = "012345678901",
                PhuongPhapTinhGiaXuatKho = "BINH_QUAN"
            };
            context.HkdInfos.Add(entity);
            await context.SaveChangesAsync();

            // Act
            var result = await repository.GetByIdAsync(entity.Id);

            // Assert
            Assert.NotNull(result);
            Assert.Equal("Test HKD", result.TenHkd);
        }

        [Fact]
        public async Task GetByIdAsync_NonExistingId_ReturnsNull()
        {
            // Arrange
            using var context = CreateContext();
            var repository = new HkdInfoRepository(context);

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
            var repository = new HkdInfoRepository(context);
            context.HkdInfos.Add(new HkdInfo { TenHkd = "HKD 1", MaSoThue = "0101", DiaChiTruSo = "Addr1", HoTenNguoiDaiDien = "A", SoCccdNguoiDaiDien = "1", PhuongPhapTinhGiaXuatKho = "BINH_QUAN" });
            context.HkdInfos.Add(new HkdInfo { TenHkd = "HKD 2", MaSoThue = "0102", DiaChiTruSo = "Addr2", HoTenNguoiDaiDien = "B", SoCccdNguoiDaiDien = "2", PhuongPhapTinhGiaXuatKho = "BINH_QUAN" });
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
            var repository = new HkdInfoRepository(context);
            var entity = new HkdInfo { TenHkd = "Old Name", MaSoThue = "0101", DiaChiTruSo = "Addr", HoTenNguoiDaiDien = "A", SoCccdNguoiDaiDien = "1", PhuongPhapTinhGiaXuatKho = "BINH_QUAN" };
            context.HkdInfos.Add(entity);
            await context.SaveChangesAsync();

            // Act
            entity.TenHkd = "Updated Name";
            await repository.UpdateAsync(entity);

            // Assert
            var updated = await context.HkdInfos.FindAsync(entity.Id);
            Assert.Equal("Updated Name", updated.TenHkd);
        }

        [Fact]
        public async Task DeleteAsync_ExistingId_RemovesFromDatabase()
        {
            // Arrange
            using var context = CreateContext();
            var repository = new HkdInfoRepository(context);
            var entity = new HkdInfo { TenHkd = "Test HKD", MaSoThue = "0101", DiaChiTruSo = "Addr", HoTenNguoiDaiDien = "A", SoCccdNguoiDaiDien = "1", PhuongPhapTinhGiaXuatKho = "BINH_QUAN" };
            context.HkdInfos.Add(entity);
            await context.SaveChangesAsync();

            // Act
            await repository.DeleteAsync(entity.Id);

            // Assert
            Assert.Empty(context.HkdInfos.ToList());
        }
    }
}
