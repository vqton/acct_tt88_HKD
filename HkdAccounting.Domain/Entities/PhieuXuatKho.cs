using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HkdAccounting.Domain.Entities
{
    /// <summary>
    /// Phiếu xuất kho (Goods Issue Voucher) - CT-04
    /// </summary>
    public class PhieuXuatKho
    {
        public long Id { get; set; }

        [Required, MaxLength(20)]
        public string SoPhieu { get; set; }

        [Required]
        public DateTime NgayXuat { get; set; }

        [MaxLength(500)]
        public string LyDo { get; set; }

        public long? KhachHangId { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal TongTien { get; set; }

        public long HkdInfoId { get; set; }

        [MaxLength(20)]
        public string TrangThai { get; set; } = "CHO_DUYET";

        [MaxLength(100)]
        public string NguoiLap { get; set; }

        [MaxLength(100)]
        public string NguoiDuyet { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;

        public virtual KhachHang KhachHang { get; set; }
        public virtual HkdInfo HkdInfo { get; set; }
        public virtual ICollection<PhieuXuatKhoChiTiet> ChiTiet { get; set; }
    }
}
