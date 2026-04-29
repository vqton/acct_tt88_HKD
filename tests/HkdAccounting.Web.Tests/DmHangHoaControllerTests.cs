using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Xunit;
using Moq;
using Microsoft.AspNetCore.Mvc;
using HkdAccounting.Application.Dtos;
using HkdAccounting.Application.Services;
using HkdAccounting.Web.Controllers;

namespace HkdAccounting.Web.Tests
{
    /// <summary>
    /// Test cases cho DmHangHoaController - MD-02
    /// </summary>
    public class DmHangHoaControllerTests
    {
        private readonly Mock<IDmHangHoaService> _serviceMock;
        private readonly DmHangHoaController _controller;

        public DmHangHoaControllerTests()
        {
            _serviceMock = new Mock<IDmHangHoaService>();
            _controller = new DmHangHoaController(_serviceMock.Object);
        }

        [Fact]
        public async Task GetAll_ReturnsOkWithData()
        {
            // Arrange
            var dtos = new List<DmHangHoaDto>
            {
                new DmHangHoaDto { Id = 1, MaHang = "MH001", TenHang = "Hang 1" },
                new DmHangHoaDto { Id = 2, MaHang = "MH002", TenHang = "Hang 2" }
            };
            _serviceMock.Setup(s => s.GetAllAsync()).ReturnsAsync(dtos);

            // Act
            var result = await _controller.GetAll();

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var returnValue = Assert.IsAssignableFrom<IEnumerable<DmHangHoaDto>>(okResult.Value);
            Assert.Equal(2, returnValue.Count());
        }

        [Fact]
        public async Task GetById_ExistingId_ReturnsOk()
        {
            // Arrange
            var dto = new DmHangHoaDto { Id = 1, MaHang = "MH001", TenHang = "Gao nep" };
            _serviceMock.Setup(s => s.GetByIdAsync(1)).ReturnsAsync(dto);

            // Act
            var result = await _controller.GetById(1);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var returnValue = Assert.IsType<DmHangHoaDto>(okResult.Value);
            Assert.Equal("MH001", returnValue.MaHang);
        }

        [Fact]
        public async Task GetById_NonExistingId_ReturnsNotFound()
        {
            // Arrange
            _serviceMock.Setup(s => s.GetByIdAsync(999)).ReturnsAsync((DmHangHoaDto)null);

            // Act
            var result = await _controller.GetById(999);

            // Assert
            Assert.IsType<NotFoundResult>(result);
        }

        [Fact]
        public async Task Create_ValidDto_ReturnsCreatedAt()
        {
            // Arrange
            var dto = new DmHangHoaDto { MaHang = "MH001", TenHang = "Gao nep", DonViTinh = "Kg", LoaiHang = "HANG_HOA" };
            _serviceMock.Setup(s => s.CreateAsync(dto)).ReturnsAsync(1);

            // Act
            var result = await _controller.Create(dto);

            // Assert
            var createdResult = Assert.IsType<CreatedAtActionResult>(result);
            Assert.Equal("GetById", createdResult.ActionName);
        }

        [Fact]
        public async Task Update_ExistingDto_ReturnsNoContent()
        {
            // Arrange
            var dto = new DmHangHoaDto { Id = 1, MaHang = "MH001", TenHang = "Updated", DonViTinh = "Kg", LoaiHang = "HANG_HOA" };
            _serviceMock.Setup(s => s.UpdateAsync(dto)).Returns(Task.CompletedTask);

            // Act
            var result = await _controller.Update(1, dto);

            // Assert
            Assert.IsType<NoContentResult>(result);
        }

        [Fact]
        public async Task Update_IdMismatch_ReturnsBadRequest()
        {
            // Arrange
            var dto = new DmHangHoaDto { Id = 2, MaHang = "MH001", TenHang = "Updated", DonViTinh = "Kg", LoaiHang = "HANG_HOA" };

            // Act
            var result = await _controller.Update(1, dto);

            // Assert
            Assert.IsType<BadRequestResult>(result);
        }

        [Fact]
        public async Task Delete_ExistingId_ReturnsNoContent()
        {
            // Arrange
            _serviceMock.Setup(s => s.DeleteAsync(1)).Returns(Task.CompletedTask);

            // Act
            var result = await _controller.Delete(1);

            // Assert
            Assert.IsType<NoContentResult>(result);
        }
    }
}
