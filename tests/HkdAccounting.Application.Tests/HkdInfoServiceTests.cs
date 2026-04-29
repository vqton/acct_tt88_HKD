using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Xunit;
using Moq;
using FluentValidation;
using HkdAccounting.Application.Dtos;
using HkdAccounting.Application.Services;
using HkdAccounting.Domain.Entities;
using HkdAccounting.Domain.Repositories;

namespace HkdAccounting.Application.Tests
{
    /// <summary>
    /// Test cases cho HkdInfoService - MD-01
    /// </summary>
    public class HkdInfoServiceTests
    {
        private readonly Mock<IHkdInfoRepository> _repositoryMock;
        private readonly HkdInfoService _service;

        public HkdInfoServiceTests()
        {
            _repositoryMock = new Mock<IHkdInfoRepository>();
            _service = new HkdInfoService(_repositoryMock.Object);
        }

        [Fact]
        public async Task GetByIdAsync_ExistingId_ReturnsDto()
        {
            // Arrange
            var entity = new HkdInfo
            {
                Id = 1,
                TenHkd = "Test HKD",
                MaSoThue = "0101234567",
                DiaChiTruSo = "123 Test St",
                HoTenNguoiDaiDien = "Nguyen Van A",
                SoCccdNguoiDaiDien = "012345678901",
                PhuongPhapTinhGiaXuatKho = "BINH_QUAN",
                TrangThai = "HOAT_DONG"
            };
            _repositoryMock.Setup(r => r.GetByIdAsync(1)).ReturnsAsync(entity);

            // Act
            var result = await _service.GetByIdAsync(1);

            // Assert
            Assert.NotNull(result);
            Assert.Equal("Test HKD", result.TenHkd);
            Assert.Equal("0101234567", result.MaSoThue);
        }

        [Fact]
        public async Task GetByIdAsync_NonExistingId_ReturnsNull()
        {
            // Arrange
            _repositoryMock.Setup(r => r.GetByIdAsync(999)).ReturnsAsync((HkdInfo)null);

            // Act
            var result = await _service.GetByIdAsync(999);

            // Assert
            Assert.Null(result);
        }

        [Fact]
        public async Task GetAllAsync_ReturnsAllDtos()
        {
            // Arrange
            var entities = new List<HkdInfo>
            {
                new HkdInfo { Id = 1, TenHkd = "HKD 1", MaSoThue = "0101" },
                new HkdInfo { Id = 2, TenHkd = "HKD 2", MaSoThue = "0102" }
            };
            _repositoryMock.Setup(r => r.GetAllAsync()).ReturnsAsync(entities);

            // Act
            var result = await _service.GetAllAsync();

            // Assert
            Assert.Equal(2, result.Count());
        }

        [Fact]
        public async Task CreateAsync_ValidDto_ReturnsId()
        {
            // Arrange
            var dto = new HkdInfoDto
            {
                TenHkd = "New HKD",
                MaSoThue = "0101234567",
                DiaChiTruSo = "123 St",
                HoTenNguoiDaiDien = "Nguyen Van A",
                SoCccdNguoiDaiDien = "012345678901",
                PhuongPhapTinhGiaXuatKho = "BINH_QUAN"
            };
            _repositoryMock.Setup(r => r.AddAsync(It.IsAny<HkdInfo>()))
                .Callback<HkdInfo>(e => e.Id = 1)
                .Returns(Task.CompletedTask);

            // Act
            var result = await _service.CreateAsync(dto);

            // Assert
            Assert.Equal(1, result);
            _repositoryMock.Verify(r => r.AddAsync(It.IsAny<HkdInfo>()), Times.Once);
        }

        [Fact]
        public async Task UpdateAsync_ExistingDto_UpdatesEntity()
        {
            // Arrange
            var entity = new HkdInfo
            {
                Id = 1,
                TenHkd = "Old Name",
                MaSoThue = "0101"
            };
            var dto = new HkdInfoDto
            {
                Id = 1,
                TenHkd = "Updated Name",
                MaSoThue = "0101"
            };
            _repositoryMock.Setup(r => r.GetByIdAsync(1)).ReturnsAsync(entity);

            // Act
            await _service.UpdateAsync(dto);

            // Assert
            Assert.Equal("Updated Name", entity.TenHkd);
            _repositoryMock.Verify(r => r.UpdateAsync(entity), Times.Once);
        }

        [Fact]
        public async Task DeleteAsync_ExistingId_CallsRepository()
        {
            // Arrange
            _repositoryMock.Setup(r => r.DeleteAsync(1)).Returns(Task.CompletedTask);

            // Act
            await _service.DeleteAsync(1);

            // Assert
            _repositoryMock.Verify(r => r.DeleteAsync(1), Times.Once);
        }
    }
}
