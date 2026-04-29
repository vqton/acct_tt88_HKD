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
    /// Test cases cho DoiTacRepository - MD-04 (Đối tác/Nhà cung cấp)
    /// </summary>
    public class DoiTacRepositoryTests
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
            var repository = new DoiTacRepository(context);
            var entity = new DoiTac
            {
                MaDoiTac = "NCC001",
                TenDoiTac = "Công ty TNHH ABC",
                MaSoThue = "0101234567",
                DiaChi = "123 Đường ABC",
                HkdInfoId = 1,
                TrangThai = "DANG_HOP_TAC"
            };

            await repository.AddAsync(entity);

            Assert.Equal(1, context.DoiTacs.Count());
            Assert.Equal("NCC001", context.DoiTacs.First().MaDoiTac);
        }

        [Fact]
        public async Task GetByIdAsync_ExistingId_ReturnsEntity()
        {
            using var context = CreateContext();
            var repository = new DoiTacRepository(context);
            var entity = new DoiTac
            {
                MaDoiTac = "NCC001",
                TenDoiTac = "Công ty TNHH ABC",
                MaSoThue = "0101234567",
                HkdInfoId = 1
            };
            context.DoiTacs.Add(entity);
            await context.SaveChangesAsync();

            var result = await repository.GetByIdAsync(entity.Id);

            Assert.NotNull(result);
            Assert.Equal("NCC001", result.MaDoiTac);
            Assert.Equal("Công ty TNHH ABC", result.TenDoiTac);
        }

        [Fact]
        public async Task GetByIdAsync_NonExistingId_ReturnsNull()
        {
            using var context = CreateContext();
            var repository = new DoiTacRepository(context);

            var result = await repository.GetByIdAsync(999);

            Assert.Null(result);
        }

        [Fact]
        public async Task GetAllAsync_ReturnsAllEntities()
        {
            using var context = CreateContext();
            var repository = new DoiTacRepository(context);
            context.DoiTacs.Add(new DoiTac { MaDoiTac = "NCC001", TenDoiTac = "Công ty ABC", HkdInfoId = 1 });
            context.DoiTacs.Add(new DoiTac { MaDoiTac = "NCC002", TenDoiTac = "Công ty XYZ", HkdInfoId = 1 });
            await context.SaveChangesAsync();

            var result = await repository.GetAllAsync();

            Assert.Equal(2, result.Count());
        }

        [Fact]
        public async Task UpdateAsync_ExistingEntity_UpdatesDatabase()
        {
            using var context = CreateContext();
            var repository = new DoiTacRepository(context);
            var entity = new DoiTac { MaDoiTac = "NCC001", TenDoiTac = "Old Name", HkdInfoId = 1 };
            context.DoiTacs.Add(entity);
            await context.SaveChangesAsync();

            entity.TenDoiTac = "Updated Name";
            await repository.UpdateAsync(entity);

            var updated = await context.DoiTacs.FindAsync(entity.Id);
            Assert.Equal("Updated Name", updated.TenDoiTac);
        }

        [Fact]
        public async Task DeleteAsync_ExistingId_RemovesFromDatabase()
        {
            using var context = CreateContext();
            var repository = new DoiTacRepository(context);
            var entity = new DoiTac { MaDoiTac = "NCC001", TenDoiTac = "Công ty ABC", HkdInfoId = 1 };
            context.DoiTacs.Add(entity);
            await context.SaveChangesAsync();

            await repository.DeleteAsync(entity.Id);

            Assert.Empty(context.DoiTacs.ToList());
        }

        [Fact]
        public async Task DeleteAsync_NonExistingId_DoesNotThrow()
        {
            using var context = CreateContext();
            var repository = new DoiTacRepository(context);

            var exception = await Record.ExceptionAsync(() => repository.DeleteAsync(999));

            Assert.Null(exception);
        }

        [Fact]
        public async Task AddAsync_ValidEntity_SavesHkdInfoId()
        {
            using var context = CreateContext();
            var repository = new DoiTacRepository(context);
            var entity = new DoiTac
            {
                MaDoiTac = "NCC001",
                TenDoiTac = "Công ty ABC",
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
            var repository = new DoiTacRepository(context);
            var entity = new DoiTac
            {
                MaDoiTac = "NCC001",
                TenDoiTac = "Công ty ABC",
                MaSoThue = "0101234567",
                DiaChi = "Old Address",
                HkdInfoId = 1
            };
            context.DoiTacs.Add(entity);
            await context.SaveChangesAsync();

            entity.MaSoThue = "0109999999";
            entity.DiaChi = "New Address";
            entity.TrangThai = "KHONG_HOP_TAC";
            await repository.UpdateAsync(entity);

            var updated = await context.DoiTacs.FindAsync(entity.Id);
            Assert.Equal("0109999999", updated.MaSoThue);
            Assert.Equal("New Address", updated.DiaChi);
            Assert.Equal("KHONG_HOP_TAC", updated.TrangThai);
        }
    }
}