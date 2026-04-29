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
    /// Test cases cho KhachHangService - MD-05 (Khách hàng)
    /// </summary>
    public class KhachHangServiceTests
    {
        private readonly Mock<IKhachHangRepository> _repositoryMock;
        private readonly KhachHangService _service;

        public KhachHangServiceTests()
        {
            _repositoryMock = new Mock<IKhachHangRepository>();
            _service = new KhachHangService(_repositoryMock.Object);
        }

        [Fact]
        public async Task GetByIdAsync_ExistingId_ReturnsDto()
        {
            var entity = new KhachHang
            {
                Id = 1,
                MaKhachHang = "KH001",
                TenKhachHang = "Công ty TNHH ABC",
                MaSoThue = "0101234567",
                DiaChi = "123 Đường ABC, TP HCM",
                SoDienThoai = "0912345678",
                Email = "abc@company.com",
                HkdInfoId = 1,
                TrangThai = "DANG_HOP_TAC"
            };
            _repositoryMock.Setup(r => r.GetByIdAsync(1)).ReturnsAsync(entity);

            var result = await _service.GetByIdAsync(1);

            Assert.NotNull(result);
            Assert.Equal("KH001", result.MaKhachHang);
            Assert.Equal("Công ty TNHH ABC", result.TenKhachHang);
            Assert.Equal("0101234567", result.MaSoThue);
        }

        [Fact]
        public async Task GetByIdAsync_NonExistingId_ReturnsNull()
        {
            _repositoryMock.Setup(r => r.GetByIdAsync(999)).ReturnsAsync((KhachHang)null);

            var result = await _service.GetByIdAsync(999);

            Assert.Null(result);
        }

        [Fact]
        public async Task GetAllAsync_ReturnsAllDtos()
        {
            var entities = new List<KhachHang>
            {
                new KhachHang { Id = 1, MaKhachHang = "KH001", TenKhachHang = "Công ty ABC", HkdInfoId = 1 },
                new KhachHang { Id = 2, MaKhachHang = "KH002", TenKhachHang = "Công ty XYZ", HkdInfoId = 1 }
            };
            _repositoryMock.Setup(r => r.GetAllAsync()).ReturnsAsync(entities);

            var result = await _service.GetAllAsync();

            Assert.Equal(2, result.Count());
        }

        [Fact]
        public async Task CreateAsync_ValidDto_ReturnsId()
        {
            var dto = new KhachHangDto
            {
                MaKhachHang = "KH003",
                TenKhachHang = "Công ty MNP",
                MaSoThue = "0109999999",
                DiaChi = "456 Đường XYZ",
                SoDienThoai = "0987654321",
                Email = "mnp@company.com",
                HkdInfoId = 1,
                TrangThai = "DANG_HOP_TAC"
            };
            _repositoryMock.Setup(r => r.AddAsync(It.IsAny<KhachHang>()))
                .Callback<KhachHang>(e => e.Id = 1)
                .Returns(Task.CompletedTask);

            var result = await _service.CreateAsync(dto);

            Assert.Equal(1, result);
            _repositoryMock.Verify(r => r.AddAsync(It.IsAny<KhachHang>()), Times.Once);
        }

        [Fact]
        public async Task CreateAsync_NullTrangThai_SetsDefault()
        {
            KhachHang? capturedEntity = null;
            var dto = new KhachHangDto
            {
                MaKhachHang = "KH003",
                TenKhachHang = "Công ty MNP",
                HkdInfoId = 1,
                TrangThai = null
            };
            _repositoryMock.Setup(r => r.AddAsync(It.IsAny<KhachHang>()))
                .Callback<KhachHang>(e =>
                {
                    e.Id = 1;
                    capturedEntity = e;
                })
                .Returns(Task.CompletedTask);

            await _service.CreateAsync(dto);

            Assert.NotNull(capturedEntity);
            Assert.Equal("DANG_HOP_TAC", capturedEntity.TrangThai);
        }

        [Fact]
        public async Task UpdateAsync_ExistingDto_UpdatesEntity()
        {
            var entity = new KhachHang
            {
                Id = 1,
                MaKhachHang = "KH001",
                TenKhachHang = "Công ty ABC",
                MaSoThue = "0101234567",
                HkdInfoId = 1
            };
            var dto = new KhachHangDto
            {
                Id = 1,
                MaKhachHang = "KH001",
                TenKhachHang = "Công ty ABC - Updated",
                MaSoThue = "0109999999",
                HkdInfoId = 1
            };
            _repositoryMock.Setup(r => r.GetByIdAsync(1)).ReturnsAsync(entity);

            await _service.UpdateAsync(dto);

            Assert.Equal("Công ty ABC - Updated", entity.TenKhachHang);
            Assert.Equal("0109999999", entity.MaSoThue);
            _repositoryMock.Verify(r => r.UpdateAsync(entity), Times.Once);
        }

        [Fact]
        public async Task UpdateAsync_NonExistingId_DoesNotUpdate()
        {
            _repositoryMock.Setup(r => r.GetByIdAsync(999)).ReturnsAsync((KhachHang)null);
            var dto = new KhachHangDto
            {
                Id = 999,
                MaKhachHang = "KH999",
                TenKhachHang = "Non-existent"
            };

            await _service.UpdateAsync(dto);

            _repositoryMock.Verify(r => r.UpdateAsync(It.IsAny<KhachHang>()), Times.Never);
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
            var entity = new KhachHang
            {
                Id = 1,
                MaKhachHang = "KH001",
                TenKhachHang = "Old Name",
                HkdInfoId = 1,
                UpdatedAt = DateTime.UtcNow.AddDays(-1)
            };
            var dto = new KhachHangDto
            {
                Id = 1,
                MaKhachHang = "KH001",
                TenKhachHang = "New Name",
                HkdInfoId = 1
            };
            _repositoryMock.Setup(r => r.GetByIdAsync(1)).ReturnsAsync(entity);

            await _service.UpdateAsync(dto);

            Assert.True(entity.UpdatedAt >= DateTime.UtcNow.AddSeconds(-1));
        }

        [Fact]
        public async Task CreateAsync_SetsDefaultTimestamps()
        {
            KhachHang? capturedEntity = null;
            var dto = new KhachHangDto
            {
                MaKhachHang = "KH003",
                TenKhachHang = "Công ty MNP",
                HkdInfoId = 1
            };
            _repositoryMock.Setup(r => r.AddAsync(It.IsAny<KhachHang>()))
                .Callback<KhachHang>(e =>
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
    }
}