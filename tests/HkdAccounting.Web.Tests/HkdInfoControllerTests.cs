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
    /// Test cases cho HkdInfoController - MD-01
    /// </summary>
    public class HkdInfoControllerTests
    {
        private readonly Mock<IHkdInfoService> _serviceMock;
        private readonly HkdInfoController _controller;

        public HkdInfoControllerTests()
        {
            _serviceMock = new Mock<IHkdInfoService>();
            _controller = new HkdInfoController(_serviceMock.Object);
        }

        [Fact]
        public async Task GetAll_ReturnsOkWithData()
        {
            // Arrange
            var dtos = new List<HkdInfoDto>
            {
                new HkdInfoDto { Id = 1, TenHkd = "HKD 1", MaSoThue = "0101" },
                new HkdInfoDto { Id = 2, TenHkd = "HKD 2", MaSoThue = "0102" }
            };
            _serviceMock.Setup(s => s.GetAllAsync()).ReturnsAsync(dtos);

            // Act
            var result = await _controller.GetAll();

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var returnValue = Assert.IsAssignableFrom<IEnumerable<HkdInfoDto>>(okResult.Value);
            Assert.Equal(2, returnValue.Count());
        }

        [Fact]
        public async Task GetById_ExistingId_ReturnsOk()
        {
            // Arrange
            var dto = new HkdInfoDto { Id = 1, TenHkd = "Test HKD", MaSoThue = "0101" };
            _serviceMock.Setup(s => s.GetByIdAsync(1)).ReturnsAsync(dto);

            // Act
            var result = await _controller.GetById(1);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var returnValue = Assert.IsType<HkdInfoDto>(okResult.Value);
            Assert.Equal("Test HKD", returnValue.TenHkd);
        }

        [Fact]
        public async Task GetById_NonExistingId_ReturnsNotFound()
        {
            // Arrange
            _serviceMock.Setup(s => s.GetByIdAsync(999)).ReturnsAsync((HkdInfoDto)null);

            // Act
            var result = await _controller.GetById(999);

            // Assert
            Assert.IsType<NotFoundResult>(result);
        }

        [Fact]
        public async Task Create_ValidDto_ReturnsCreatedAt()
        {
            // Arrange
            var dto = new HkdInfoDto { TenHkd = "New HKD", MaSoThue = "0101" };
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
            var dto = new HkdInfoDto { Id = 1, TenHkd = "Updated HKD", MaSoThue = "0101" };
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
            var dto = new HkdInfoDto { Id = 2, TenHkd = "Updated HKD", MaSoThue = "0101" };

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
