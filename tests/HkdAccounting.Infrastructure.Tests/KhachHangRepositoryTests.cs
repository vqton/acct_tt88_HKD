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
    /// Test cases cho KhachHangRepository - MD-05 (Khách hàng)
    /// </summary>
    public class KhachHangRepositoryTests
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
            var repository = new KhachHangRepository(context);
            var entity = new KhachHang
            {
                MaKhachHang = "KH001",
                TenKhachHang = "Công ty TNHH ABC",
                MaSoThue = "0101234567",
                DiaChi = "123 Đường ABC",
                HkdInfoId = 1,
                TrangThai = "DANG_HOP_TAC"
            };

            await repository.AddAsync(entity);

            Assert.Equal(1, context.KhachHangs.Count());
            Assert.Equal("KH001", context.KhachHangs.First().MaKhachHang);
        }

        [Fact]
        public async Task GetByIdAsync_ExistingId_ReturnsEntity()
        {
            using var context = CreateContext();
            var repository = new KhachHangRepository(context);
            var entity = new KhachHang
            {
                MaKhachHang = "KH001",
                TenKhachHang = "Công ty TNHH ABC",
                MaSoThue = "0101234567",
                HkdInfoId = 1
            };
            context.KhachHangs.Add(entity);
            await context.SaveChangesAsync();

            var result = await repository.GetByIdAsync(entity.Id);

            Assert.NotNull(result);
            Assert.Equal("KH001", result.MaKhachHang);
            Assert.Equal("Công ty TNHH ABC", result.TenKhachHang);
        }

        [Fact]
        public async Task GetByIdAsync_NonExistingId_ReturnsNull()
        {
            using var context = CreateContext();
            var repository = new KhachHangRepository(context);

            var result = await repository.GetByIdAsync(999);

            Assert.Null(result);
        }

        [Fact]
        public async Task GetAllAsync_ReturnsAllEntities()
        {
            using var context = CreateContext();
            var repository = new KhachHangRepository(context);
            context.KhachHangs.Add(new KhachHang { MaKhachHang = "KH001", TenKhachHang = "Công ty ABC", HkdInfoId = 1 });
            context.KhachHangs.Add(new KhachHang { MaKhachHang = "KH002", TenKhachHang = "Công ty XYZ", HkdInfoId = 1 });
            await context.SaveChangesAsync();

            var result = await repository.GetAllAsync();

            Assert.Equal(2, result.Count());
        }

        [Fact]
        public async Task UpdateAsync_ExistingEntity_UpdatesDatabase()
        {
            using var context = CreateContext();
            var repository = new KhachHangRepository(context);
            var entity = new KhachHang { MaKhachHang = "KH001", TenKhachHang = "Old Name", HkdInfoId = 1 };
            context.KhachHangs.Add(entity);
            await context.SaveChangesAsync();

            entity.TenKhachHang = "Updated Name";
            await repository.UpdateAsync(entity);

            var updated = await context.KhachHangs.FindAsync(entity.Id);
            Assert.Equal("Updated Name", updated.TenKhachHang);
        }

        [Fact]
        public async Task DeleteAsync_ExistingId_RemovesFromDatabase()
        {
            using var context = CreateContext();
            var repository = new KhachHangRepository(context);
            var entity = new KhachHang { MaKhachHang = "KH001", TenKhachHang = "Công ty ABC", HkdInfoId = 1 };
            context.KhachHangs.Add(entity);
            await context.SaveChangesAsync();

            await repository.DeleteAsync(entity.Id);

            Assert.Empty(context.KhachHangs.ToList());
        }

        [Fact]
        public async Task DeleteAsync_NonExistingId_DoesNotThrow()
        {
            using var context = CreateContext();
            var repository = new KhachHangRepository(context);

            var exception = await Record.ExceptionAsync(() => repository.DeleteAsync(999));

            Assert.Null(exception);
        }

        [Fact]
        public async Task AddAsync_ValidEntity_SavesHkdInfoId()
        {
            using var context = CreateContext();
            var repository = new KhachHangRepository(context);
            var entity = new KhachHang
            {
                MaKhachHang = "KH001",
                TenKhachHang = "Công ty ABC",
                HkdInfoId = 5
            };

            await repository.AddAsync(entity);

            var result = await repository.GetByIdAsync(entity.Id);
            Assert.Equal(5, result.HkdInfoId);
        }

        [Fact]
        public async Task UpdateAsync_UpdatesAllFields()
        {
            using var context = CreateContext();
            var repository = new KhachHangRepository(context);
            var entity = new KhachHang
            {
                MaKhachHang = "KH001",
                TenKhachHang = "Công ty ABC",
                MaSoThue = "0101234567",
                DiaChi = "Old Address",
                HkdInfoId = 1
            };
            context.KhachHangs.Add(entity);
            await context.SaveChangesAsync();

            entity.MaSoThue = "0109999999";
            entity.DiaChi = "New Address";
            entity.TrangThai = "KHONG_HOP_TAC";
            await repository.UpdateAsync(entity);

            var updated = await context.KhachHangs.FindAsync(entity.Id);
            Assert.Equal("0109999999", updated.MaSoThue);
            Assert.Equal("New Address", updated.DiaChi);
            Assert.Equal("KHONG_HOP_TAC", updated.TrangThai);
        }
    }
}