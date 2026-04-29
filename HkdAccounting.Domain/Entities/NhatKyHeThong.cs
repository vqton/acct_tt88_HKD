using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HkdAccounting.Domain.Entities
{
    /// <summary>
    /// Nhật ký hệ thống (System Log) - QT-06
    /// </summary>
    public class NhatKyHeThong
    {
        public long Id { get; set; }

        [MaxLength(100)]
        public string TaiKhoan { get; set; }

        [Required, MaxLength(50)]
        public string HanhDong { get; set; }

        [MaxLength(500)]
        public string MoTa { get; set; }

        public DateTime ThoiGian { get; set; } = DateTime.UtcNow;

        [MaxLength(50)]
        public string DiaChiIp { get; set; }

        public long HkdInfoId { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        public virtual HkdInfo HkdInfo { get; set; }
    }
}
