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
    /// Test cases cho NhanVienController - MD-06
    /// </summary>
    public class NhanVienControllerTests
    {
        private readonly Mock<INhanVienService> _serviceMock;
        private readonly NhanVienController _controller;

        public NhanVienControllerTests()
        {
            _serviceMock = new Mock<INhanVienService>();
            _controller = new NhanVienController(_serviceMock.Object);
        }

        [Fact]
        public async Task GetAll_ReturnsOkWithData()
        {
            // Arrange
            var dtos = new List<NhanVienDto>
            {
                new NhanVienDto { Id = 1, MaNhanVien = "NV001", HoTen = "Nguyen Van A" },
                new NhanVienDto { Id = 2, MaNhanVien = "NV002", HoTen = "Tran Van B" }
            };
            _serviceMock.Setup(s => s.GetAllAsync()).ReturnsAsync(dtos);

            // Act
            var result = await _controller.GetAll();

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var returnValue = Assert.IsAssignableFrom<IEnumerable<NhanVienDto>>(okResult.Value);
            Assert.Equal(2, returnValue.Count());
        }

        [Fact]
        public async Task GetById_ExistingId_ReturnsOk()
        {
            // Arrange
            var dto = new NhanVienDto { Id = 1, MaNhanVien = "NV001", HoTen = "Nguyen Van A" };
            _serviceMock.Setup(s => s.GetByIdAsync(1)).ReturnsAsync(dto);

            // Act
            var result = await _controller.GetById(1);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var returnValue = Assert.IsType<NhanVienDto>(okResult.Value);
            Assert.Equal("NV001", returnValue.MaNhanVien);
        }

        [Fact]
        public async Task GetById_NonExistingId_ReturnsNotFound()
        {
            // Arrange
            _serviceMock.Setup(s => s.GetByIdAsync(999)).ReturnsAsync((NhanVienDto)null);

            // Act
            var result = await _controller.GetById(999);

            // Assert
            Assert.IsType<NotFoundResult>(result);
        }

        [Fact]
        public async Task Create_ValidDto_ReturnsCreatedAt()
        {
            // Arrange
            var dto = new NhanVienDto { MaNhanVien = "NV001", HoTen = "Nguyen Van A", ChucVu = "Nhan Vien" };
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
            var dto = new NhanVienDto { Id = 1, MaNhanVien = "NV001", HoTen = "Updated", ChucVu = "Truong Phong" };
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
            var dto = new NhanVienDto { Id = 2, MaNhanVien = "NV001", HoTen = "Updated", ChucVu = "Truong Phong" };

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