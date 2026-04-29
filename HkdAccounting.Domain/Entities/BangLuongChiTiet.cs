using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HkdAccounting.Domain.Entities
{
    /// <summary>
    /// Chi tiết bảng lương
    /// </summary>
    public class BangLuongChiTiet
    {
        public long Id { get; set; }

        public long BangLuongId { get; set; }

        public long NhanVienId { get; set; }

        public int SoCong { get; set; }

        public int SoSanPham { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal LuongSanPham { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal LuongThoiGian { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal PhuCap { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal Thuong { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal KhauTruBhxn { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal ThueTncn { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal ThucLinh { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        public virtual BangLuong BangLuong { get; set; }
        public virtual NhanVien NhanVien { get; set; }
    }
}
