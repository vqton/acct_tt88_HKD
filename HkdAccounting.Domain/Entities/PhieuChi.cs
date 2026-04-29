using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HkdAccounting.Domain.Entities
{
    /// <summary>
    /// Phiếu chi (Payment Voucher) - CT-02
    /// </summary>
    public class PhieuChi
    {
        public long Id { get; set; }

        [Required, MaxLength(20)]
        public string SoPhieu { get; set; }

        [Required]
        public DateTime NgayChi { get; set; }

        [Required, MaxLength(255)]
        public string NguoiNhan { get; set; }

        [MaxLength(500)]
        public string DiaChi { get; set; }

        [MaxLength(500)]
        public string LyDo { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal SoTien { get; set; }

        [MaxLength(255)]
        public string BangChu { get; set; }

        [Required, MaxLength(20)]
        public string PhuongThucThanhToan { get; set; } = "TIEN_MAT";

        public long? DoiTacId { get; set; }
        public long HkdInfoId { get; set; }

        [MaxLength(20)]
        public string TrangThai { get; set; } = "CHO_DUYET";

        [MaxLength(100)]
        public string NguoiLap { get; set; }

        [MaxLength(100)]
        public string NguoiDuyet { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;

        public virtual DoiTac DoiTac { get; set; }
        public virtual HkdInfo HkdInfo { get; set; }
    }
}
