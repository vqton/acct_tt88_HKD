using System;
using Xunit;
using HkdAccounting.Domain.Entities;

namespace HkdAccounting.Domain.Tests
{
    /// <summary>
    /// Test cases cho entity DmHangHoa - MD-02
    /// </summary>
    public class DmHangHoaTests
    {
        [Fact]
        public void Create_ValidDmHangHoa_SetsPropertiesCorrectly()
        {
            // Arrange & Act
            var entity = new DmHangHoa
            {
                MaHang = "MH001",
                TenHang = "Gao nep",
                NhanHieuQuyCach = "Thom ngon",
                DonViTinh = "Kg",
                LoaiHang = "HANG_HOA",
                DonGiaMuaChuan = 50000,
                TrangThai = "DANG_KINH_DOANH"
            };

            // Assert
            Assert.Equal("MH001", entity.MaHang);
            Assert.Equal("Gao nep", entity.TenHang);
            Assert.Equal("Thom ngon", entity.NhanHieuQuyCach);
            Assert.Equal("Kg", entity.DonViTinh);
            Assert.Equal("HANG_HOA", entity.LoaiHang);
            Assert.Equal(50000, entity.DonGiaMuaChuan);
            Assert.Equal("DANG_KINH_DOANH", entity.TrangThai);
        }

        [Fact]
        public void Create_DmHangHoa_WithDefaultValues_HasCorrectDefaults()
        {
            // Arrange & Act
            var entity = new DmHangHoa
            {
                MaHang = "MH001",
                TenHang = "Gao nep",
                DonViTinh = "Kg",
                LoaiHang = "HANG_HOA"
            };

            // Assert
            Assert.Equal("DANG_KINH_DOANH", entity.TrangThai);
            Assert.NotEqual(default, entity.CreatedAt);
            Assert.NotEqual(default, entity.UpdatedAt);
        }

        [Fact]
        public void SetNullableProperties_ValidValues_WorksCorrectly()
        {
            // Arrange
            var entity = new DmHangHoa();

            // Act
            entity.NhanHieuQuyCach = "Chat luong cao";
            entity.NhomNgheId = 1;
            entity.DonGiaMuaChuan = 100000;

            // Assert
            Assert.Equal("Chat luong cao", entity.NhanHieuQuyCach);
            Assert.Equal(1, entity.NhomNgheId);
            Assert.Equal(100000, entity.DonGiaMuaChuan);
        }
    }
}
