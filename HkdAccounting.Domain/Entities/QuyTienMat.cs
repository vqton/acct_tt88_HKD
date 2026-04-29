using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HkdAccounting.Domain.Entities
{
    /// <summary>
    /// Quỹ tiền mặt (Cash Fund) - TT-01
    /// </summary>
    public class QuyTienMat
    {
        public long Id { get; set; }

        [Required, MaxLength(20)]
        public string MaQuy { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal SoDuHienTai { get; set; } = 0;

        [Column(TypeName = "decimal(18,2)")]
        public decimal TongThuKy { get; set; } = 0;

        [Column(TypeName = "decimal(18,2)")]
        public decimal TongChiKy { get; set; } = 0;

        public long KyKeToanId { get; set; }

        public long HkdInfoId { get; set; }

        [MaxLength(20)]
        public string TrangThai { get; set; } = "HOAT_DONG";

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;

        public virtual KyKeToan KyKeToan { get; set; }
        public virtual HkdInfo HkdInfo { get; set; }
    }
}
