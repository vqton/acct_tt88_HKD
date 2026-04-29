using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HkdAccounting.Domain.Entities
{
    /// <summary>
    /// Phiếu nhập kho (Goods Receipt Voucher) - CT-03
    /// </summary>
    public class PhieuNhapKho
    {
        public long Id { get; set; }

        [Required, MaxLength(20)]
        public string SoPhieu { get; set; }

        [Required]
        public DateTime NgayNhap { get; set; }

        [MaxLength(500)]
        public string LyDo { get; set; }

        public long DoiTacId { get; set; }

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

        public virtual DoiTac DoiTac { get; set; }
        public virtual HkdInfo HkdInfo { get; set; }
        public virtual ICollection<PhieuNhapKhoChiTiet> ChiTiet { get; set; }
    }
}
