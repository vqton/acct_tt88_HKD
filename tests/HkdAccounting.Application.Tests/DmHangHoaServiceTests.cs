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
    /// Test cases cho DmHangHoaService - MD-02
    /// </summary>
    public class DmHangHoaServiceTests
    {
        private readonly Mock<IDmHangHoaRepository> _repositoryMock;
        private readonly DmHangHoaService _service;

        public DmHangHoaServiceTests()
        {
            _repositoryMock = new Mock<IDmHangHoaRepository>();
            _service = new DmHangHoaService(_repositoryMock.Object);
        }

        [Fact]
        public async Task GetByIdAsync_ExistingId_ReturnsDto()
        {
            // Arrange
            var entity = new DmHangHoa
            {
                Id = 1,
                MaHang = "MH001",
                TenHang = "Gao nep",
                DonViTinh = "Kg",
                LoaiHang = "HANG_HOA"
            };
            _repositoryMock.Setup(r => r.GetByIdAsync(1)).ReturnsAsync(entity);

            // Act
            var result = await _service.GetByIdAsync(1);

            // Assert
            Assert.NotNull(result);
            Assert.Equal("MH001", result.MaHang);
            Assert.Equal("Gao nep", result.TenHang);
        }

        [Fact]
        public async Task GetByIdAsync_NonExistingId_ReturnsNull()
        {
            // Arrange
            _repositoryMock.Setup(r => r.GetByIdAsync(999)).ReturnsAsync((DmHangHoa)null);

            // Act
            var result = await _service.GetByIdAsync(999);

            // Assert
            Assert.Null(result);
        }

        [Fact]
        public async Task GetAllAsync_ReturnsAllDtos()
        {
            // Arrange
            var entities = new List<DmHangHoa>
            {
                new DmHangHoa { Id = 1, MaHang = "MH001", TenHang = "Hang 1", DonViTinh = "Kg", LoaiHang = "HANG_HOA" },
                new DmHangHoa { Id = 2, MaHang = "MH002", TenHang = "Hang 2", DonViTinh = "Cai", LoaiHang = "DICH_VU" }
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
            var dto = new DmHangHoaDto
            {
                MaHang = "MH001",
                TenHang = "Gao nep",
                DonViTinh = "Kg",
                LoaiHang = "HANG_HOA"
            };
            _repositoryMock.Setup(r => r.AddAsync(It.IsAny<DmHangHoa>()))
                .Callback<DmHangHoa>(e => e.Id = 1)
                .Returns(Task.CompletedTask);

            // Act
            var result = await _service.CreateAsync(dto);

            // Assert
            Assert.Equal(1, result);
            _repositoryMock.Verify(r => r.AddAsync(It.IsAny<DmHangHoa>()), Times.Once);
        }

        [Fact]
        public async Task UpdateAsync_ExistingDto_UpdatesEntity()
        {
            // Arrange
            var entity = new DmHangHoa
            {
                Id = 1,
                MaHang = "MH001",
                TenHang = "Old Name",
                DonViTinh = "Kg",
                LoaiHang = "HANG_HOA"
            };
            var dto = new DmHangHoaDto
            {
                Id = 1,
                MaHang = "MH001",
                TenHang = "Updated Name",
                DonViTinh = "Kg",
                LoaiHang = "HANG_HOA"
            };
            _repositoryMock.Setup(r => r.GetByIdAsync(1)).ReturnsAsync(entity);

            // Act
            await _service.UpdateAsync(dto);

            // Assert
            Assert.Equal("Updated Name", entity.TenHang);
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
