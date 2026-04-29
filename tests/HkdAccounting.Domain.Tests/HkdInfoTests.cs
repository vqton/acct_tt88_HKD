using System;
using Xunit;
using HkdAccounting.Domain.Entities;

namespace HkdAccounting.Domain.Tests
{
    /// <summary>
    /// Test cases cho entity HkdInfo - MD-01
    /// </summary>
    public class HkdInfoTests
    {
        [Fact]
        public void Create_ValidHkdInfo_SetsPropertiesCorrectly()
        {
            // Arrange & Act
            var hkdInfo = new HkdInfo
            {
                TenHkd = "Test HKD",
                MaSoThue = "0101234567",
                DiaChiTruSo = "123 Test St",
                HoTenNguoiDaiDien = "Nguyen Van A",
                SoCccdNguoiDaiDien = "012345678901",
                PhuongPhapTinhGiaXuatKho = "BINH_QUAN",
                TrangThai = "HOAT_DONG"
            };

            // Assert
            Assert.Equal("Test HKD", hkdInfo.TenHkd);
            Assert.Equal("0101234567", hkdInfo.MaSoThue);
            Assert.Equal("123 Test St", hkdInfo.DiaChiTruSo);
            Assert.Equal("Nguyen Van A", hkdInfo.HoTenNguoiDaiDien);
            Assert.Equal("012345678901", hkdInfo.SoCccdNguoiDaiDien);
            Assert.Equal("BINH_QUAN", hkdInfo.PhuongPhapTinhGiaXuatKho);
            Assert.Equal("HOAT_DONG", hkdInfo.TrangThai);
        }

        [Fact]
        public void Create_HkdInfo_WithDefaultValues_HasCorrectDefaults()
        {
            // Arrange & Act
            var hkdInfo = new HkdInfo
            {
                TenHkd = "Test HKD",
                MaSoThue = "0101234567"
            };

            // Assert
            Assert.Equal("BINH_QUAN", hkdInfo.PhuongPhapTinhGiaXuatKho);
            Assert.Equal("HOAT_DONG", hkdInfo.TrangThai);
            Assert.NotEqual(default, hkdInfo.CreatedAt);
            Assert.NotEqual(default, hkdInfo.UpdatedAt);
        }

        [Fact]
        public void SetInvalidTaxCode_EmptyString_ThrowsNothing()
        {
            // Arrange
            var hkdInfo = new HkdInfo();

            // Act & Assert - Domain entity doesn't validate, that's Application layer's job
            hkdInfo.MaSoThue = "";
            Assert.Equal("", hkdInfo.MaSoThue);
        }
    }
}
