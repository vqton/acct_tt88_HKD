using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HkdAccounting.Domain.Entities
{
    /// <summary>
    /// Hóa đơn (Invoice) - CT-06
    /// </summary>
    public class HoaDon
    {
        public long Id { get; set; }

        [Required, MaxLength(20)]
        public string SoHoaDon { get; set; }

        [Required]
        public DateTime NgayHoaDon { get; set; }

        public long KhachHangId { get; set; }

        public long? DoiTacId { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal TongTienHang { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal ThueGtgt { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal TongThanhToan { get; set; }

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
        public virtual DoiTac DoiTac { get; set; }
        public virtual HkdInfo HkdInfo { get; set; }
        public virtual ICollection<HoaDonChiTiet> ChiTiet { get; set; }
    }
}
