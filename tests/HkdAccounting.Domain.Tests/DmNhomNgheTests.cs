using System;
using Xunit;
using HkdAccounting.Domain.Entities;

namespace HkdAccounting.Domain.Tests
{
    /// <summary>
    /// Test cases cho entity DmNhomNghe - MD-03
    /// </summary>
    public class DmNhomNgheTests
    {
        [Fact]
        public void Create_ValidDmNhomNghe_SetsPropertiesCorrectly()
        {
            // Arrange & Act
            var entity = new DmNhomNghe
            {
                MaNhomNghe = "NG001",
                TenNhomNghe = "May mac",
                TyLeThueGtgt = 5.0m,
                TyLeThueTncn = 2.0m,
                NgayHieuLuc = new DateTime(2026, 1, 1),
                NgayHetHieuLuc = new DateTime(2026, 12, 31),
                TrangThai = "HOAT_DONG"
            };

            // Assert
            Assert.Equal("NG001", entity.MaNhomNghe);
            Assert.Equal("May mac", entity.TenNhomNghe);
            Assert.Equal(5.0m, entity.TyLeThueGtgt);
            Assert.Equal(2.0m, entity.TyLeThueTncn);
            Assert.Equal(new DateTime(2026, 1, 1), entity.NgayHieuLuc);
            Assert.Equal(new DateTime(2026, 12, 31), entity.NgayHetHieuLuc);
        }

        [Fact]
        public void Create_DmNhomNghe_WithDefaultValues_HasCorrectDefaults()
        {
            // Arrange & Act
            var entity = new DmNhomNghe
            {
                MaNhomNghe = "NG001",
                TenNhomNghe = "May mac",
                TyLeThueGtgt = 5.0m,
                TyLeThueTncn = 2.0m,
                NgayHieuLuc = DateTime.UtcNow
            };

            // Assert
            Assert.Equal("HOAT_DONG", entity.TrangThai);
            Assert.NotEqual(default, entity.CreatedAt);
            Assert.NotEqual(default, entity.UpdatedAt);
        }
    }
}
