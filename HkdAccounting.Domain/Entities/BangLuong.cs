using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HkdAccounting.Domain.Entities
{
    /// <summary>
    /// Bảng thanh toán lương (Payroll) - CT-05
    /// </summary>
    public class BangLuong
    {
        public long Id { get; set; }

        [Required, MaxLength(20)]
        public string SoBangLuong { get; set; }

        [Required]
        public DateTime ThangLuong { get; set; }

        public long HkdInfoId { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal TongLuong { get; set; }

        [MaxLength(20)]
        public string TrangThai { get; set; } = "CHO_DUYET";

        [MaxLength(100)]
        public string NguoiLap { get; set; }

        [MaxLength(100)]
        public string NguoiDuyet { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;

        public virtual HkdInfo HkdInfo { get; set; }
        public virtual ICollection<BangLuongChiTiet> ChiTiet { get; set; }
    }
}
