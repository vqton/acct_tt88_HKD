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
    /// Test cases cho TaiKhoanNganHangController - MD-07
    /// </summary>
    public class TaiKhoanNganHangControllerTests
    {
        private readonly Mock<ITaiKhoanNganHangService> _serviceMock;
        private readonly TaiKhoanNganHangController _controller;

        public TaiKhoanNganHangControllerTests()
        {
            _serviceMock = new Mock<ITaiKhoanNganHangService>();
            _controller = new TaiKhoanNganHangController(_serviceMock.Object);
        }

        [Fact]
        public async Task GetAll_ReturnsOkWithData()
        {
            // Arrange
            var dtos = new List<TaiKhoanNganHangDto>
            {
                new TaiKhoanNganHangDto { Id = 1, MaTaiKhoan = "TK001", SoTaiKhoan = "123456789", TenNganHang = "Vietcombank" },
                new TaiKhoanNganHangDto { Id = 2, MaTaiKhoan = "TK002", SoTaiKhoan = "987654321", TenNganHang = "Agribank" }
            };
            _serviceMock.Setup(s => s.GetAllAsync()).ReturnsAsync(dtos);

            // Act
            var result = await _controller.GetAll();

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var returnValue = Assert.IsAssignableFrom<IEnumerable<TaiKhoanNganHangDto>>(okResult.Value);
            Assert.Equal(2, returnValue.Count());
        }

        [Fact]
        public async Task GetById_ExistingId_ReturnsOk()
        {
            // Arrange
            var dto = new TaiKhoanNganHangDto { Id = 1, MaTaiKhoan = "TK001", SoTaiKhoan = "123456789", TenNganHang = "Vietcombank" };
            _serviceMock.Setup(s => s.GetByIdAsync(1)).ReturnsAsync(dto);

            // Act
            var result = await _controller.GetById(1);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var returnValue = Assert.IsType<TaiKhoanNganHangDto>(okResult.Value);
            Assert.Equal("TK001", returnValue.MaTaiKhoan);
        }

        [Fact]
        public async Task GetById_NonExistingId_ReturnsNotFound()
        {
            // Arrange
            _serviceMock.Setup(s => s.GetByIdAsync(999)).ReturnsAsync((TaiKhoanNganHangDto)null);

            // Act
            var result = await _controller.GetById(999);

            // Assert
            Assert.IsType<NotFoundResult>(result);
        }

        [Fact]
        public async Task Create_ValidDto_ReturnsCreatedAt()
        {
            // Arrange
            var dto = new TaiKhoanNganHangDto { MaTaiKhoan = "TK001", SoTaiKhoan = "123456789", TenNganHang = "Vietcombank" };
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
            var dto = new TaiKhoanNganHangDto { Id = 1, MaTaiKhoan = "TK001", SoTaiKhoan = "123456789", TenNganHang = "Updated" };
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
            var dto = new TaiKhoanNganHangDto { Id = 2, MaTaiKhoan = "TK001", SoTaiKhoan = "123456789", TenNganHang = "Updated" };

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