using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Xunit;
using Moq;
using HkdAccounting.Application.Dtos;
using HkdAccounting.Application.Services;
using HkdAccounting.Domain.Entities;
using HkdAccounting.Domain.Repositories;

namespace HkdAccounting.Application.Tests
{
    /// <summary>
    /// Test cases cho DmNhomNgheService - MD-03 (Tax Rates)
    /// </summary>
    public class DmNhomNgheServiceTests
    {
        private readonly Mock<IDmNhomNgheRepository> _repositoryMock;
        private readonly DmNhomNgheService _service;

        public DmNhomNgheServiceTests()
        {
            _repositoryMock = new Mock<IDmNhomNgheRepository>();
            _service = new DmNhomNgheService(_repositoryMock.Object);
        }

        [Fact]
        public async Task GetByIdAsync_ExistingId_ReturnsDto()
        {
            var entity = new DmNhomNghe
            {
                Id = 1,
                MaNhomNghe = "Ngh001",
                TenNhomNghe = "Kinh doanh tổng hợp",
                TyLeThueGtgt = 5.0m,
                TyLeThueTncn = 2.0m,
                NgayHieuLuc = new DateTime(2024, 1, 1),
                NgayHetHieuLuc = null,
                TrangThai = "HOAT_DONG"
            };
            _repositoryMock.Setup(r => r.GetByIdAsync(1)).ReturnsAsync(entity);

            var result = await _service.GetByIdAsync(1);

            Assert.NotNull(result);
            Assert.Equal("Ngh001", result.MaNhomNghe);
            Assert.Equal(5.0m, result.TyLeThueGtgt);
            Assert.Equal(2.0m, result.TyLeThueTncn);
        }

        [Fact]
        public async Task GetByIdAsync_NonExistingId_ReturnsNull()
        {
            _repositoryMock.Setup(r => r.GetByIdAsync(999)).ReturnsAsync((DmNhomNghe)null);

            var result = await _service.GetByIdAsync(999);

            Assert.Null(result);
        }

        [Fact]
        public async Task GetAllAsync_ReturnsAllDtos()
        {
            var entities = new List<DmNhomNghe>
            {
                new DmNhomNghe { Id = 1, MaNhomNghe = "Ngh001", TenNhomNghe = "Kinh doanh tổng hợp", TyLeThueGtgt = 5.0m, TyLeThueTncn = 2.0m, NgayHieuLuc = DateTime.UtcNow },
                new DmNhomNghe { Id = 2, MaNhomNghe = "Ngh002", TenNhomNghe = "Bán lẻ hàng hóa", TyLeThueGtgt = 10.0m, TyLeThueTncn = 2.0m, NgayHieuLuc = DateTime.UtcNow }
            };
            _repositoryMock.Setup(r => r.GetAllAsync()).ReturnsAsync(entities);

            var result = await _service.GetAllAsync();

            Assert.Equal(2, result.Count());
        }

        [Fact]
        public async Task CreateAsync_ValidDto_ReturnsId()
        {
            var dto = new DmNhomNgheDto
            {
                MaNhomNghe = "Ngh003",
                TenNhomNghe = "Dịch vụ ăn uống",
                TyLeThueGtgt = 10.0m,
                TyLeThueTncn = 2.0m,
                NgayHieuLuc = new DateTime(2024, 1, 1),
                NgayHetHieuLuc = null,
                TrangThai = "HOAT_DONG"
            };
            _repositoryMock.Setup(r => r.AddAsync(It.IsAny<DmNhomNghe>()))
                .Callback<DmNhomNghe>(e => e.Id = 1)
                .Returns(Task.CompletedTask);

            var result = await _service.CreateAsync(dto);

            Assert.Equal(1, result);
            _repositoryMock.Verify(r => r.AddAsync(It.IsAny<DmNhomNghe>()), Times.Once);
        }

        [Fact]
        public async Task CreateAsync_SetsDefaultTimestamps()
        {
            DmNhomNghe? capturedEntity = null;
            var dto = new DmNhomNgheDto
            {
                MaNhomNghe = "Ngh003",
                TenNhomNghe = "Dịch vụ ăn uống",
                TyLeThueGtgt = 10.0m,
                TyLeThueTncn = 2.0m,
                NgayHieuLuc = DateTime.UtcNow,
                TrangThai = "HOAT_DONG"
            };
            _repositoryMock.Setup(r => r.AddAsync(It.IsAny<DmNhomNghe>()))
                .Callback<DmNhomNghe>(e =>
                {
                    e.Id = 1;
                    capturedEntity = e;
                })
                .Returns(Task.CompletedTask);

            await _service.CreateAsync(dto);

            Assert.NotNull(capturedEntity);
            Assert.True(capturedEntity.CreatedAt <= DateTime.UtcNow);
            Assert.True(capturedEntity.UpdatedAt <= DateTime.UtcNow);
        }

        [Fact]
        public async Task UpdateAsync_ExistingDto_UpdatesEntity()
        {
            var entity = new DmNhomNghe
            {
                Id = 1,
                MaNhomNghe = "Ngh001",
                TenNhomNghe = "Kinh doanh tổng hợp",
                TyLeThueGtgt = 5.0m,
                TyLeThueTncn = 2.0m
            };
            var dto = new DmNhomNgheDto
            {
                Id = 1,
                MaNhomNghe = "Ngh001",
                TenNhomNghe = "Kinh doanh tổng hợp - Updated",
                TyLeThueGtgt = 8.0m,
                TyLeThueTncn = 3.0m
            };
            _repositoryMock.Setup(r => r.GetByIdAsync(1)).ReturnsAsync(entity);

            await _service.UpdateAsync(dto);

            Assert.Equal("Kinh doanh tổng hợp - Updated", entity.TenNhomNghe);
            Assert.Equal(8.0m, entity.TyLeThueGtgt);
            Assert.Equal(3.0m, entity.TyLeThueTncn);
            _repositoryMock.Verify(r => r.UpdateAsync(entity), Times.Once);
        }

        [Fact]
        public async Task UpdateAsync_NonExistingId_DoesNotUpdate()
        {
            _repositoryMock.Setup(r => r.GetByIdAsync(999)).ReturnsAsync((DmNhomNghe)null);
            var dto = new DmNhomNgheDto
            {
                Id = 999,
                MaNhomNghe = "Ngh999",
                TenNhomNghe = "Non-existent"
            };

            await _service.UpdateAsync(dto);

            _repositoryMock.Verify(r => r.UpdateAsync(It.IsAny<DmNhomNghe>()), Times.Never);
        }

        [Fact]
        public async Task DeleteAsync_ExistingId_CallsRepository()
        {
            _repositoryMock.Setup(r => r.DeleteAsync(1)).Returns(Task.CompletedTask);

            await _service.DeleteAsync(1);

            _repositoryMock.Verify(r => r.DeleteAsync(1), Times.Once);
        }

        [Fact]
        public async Task UpdateAsync_SetsUpdatedAtTimestamp()
        {
            var entity = new DmNhomNghe
            {
                Id = 1,
                MaNhomNghe = "Ngh001",
                TenNhomNghe = "Old Name",
                TyLeThueGtgt = 5.0m,
                TyLeThueTncn = 2.0m,
                UpdatedAt = DateTime.UtcNow.AddDays(-1)
            };
            var dto = new DmNhomNgheDto
            {
                Id = 1,
                MaNhomNghe = "Ngh001",
                TenNhomNghe = "New Name",
                TyLeThueGtgt = 5.0m,
                TyLeThueTncn = 2.0m
            };
            _repositoryMock.Setup(r => r.GetByIdAsync(1)).ReturnsAsync(entity);

            await _service.UpdateAsync(dto);

            Assert.True(entity.UpdatedAt >= DateTime.UtcNow.AddSeconds(-1));
        }
    }
}