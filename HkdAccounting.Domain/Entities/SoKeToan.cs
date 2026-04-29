using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HkdAccounting.Domain.Entities
{
    /// <summary>
    /// Sổ kế toán (Accounting Book) - SK-01 to SK-08
    /// </summary>
    public class SoKeToan
    {
        public long Id { get; set; }

        [Required, MaxLength(20)]
        public string MaSo { get; set; }

        [Required, MaxLength(100)]
        public string TenSo { get; set; }

        [Required, MaxLength(20)]
        public string LoaiSo { get; set; }

        [Required]
        public DateTime NgayMoSo { get; set; }

        public long KyKeToanId { get; set; }

        public long HkdInfoId { get; set; }

        [MaxLength(255)]
        public string DiaDiemKinhDoanh { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal SoDuDauKy { get; set; } = 0;

        [Column(TypeName = "decimal(18,2)")]
        public decimal TongPhatSinhNo { get; set; } = 0;

        [Column(TypeName = "decimal(18,2)")]
        public decimal TongPhatSinhCo { get; set; } = 0;

        [Column(TypeName = "decimal(18,2)")]
        public decimal SoDuCuoiKy { get; set; } = 0;

        [MaxLength(20)]
        public string TrangThai { get; set; } = "MO_SO";

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;

        public virtual KyKeToan KyKeToan { get; set; }
        public virtual HkdInfo HkdInfo { get; set; }
        public virtual ICollection<SoKeToanChiTiet> ChiTiet { get; set; }
    }
}
