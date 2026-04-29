using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HkdAccounting.Domain.Entities
{
    /// <summary>
    /// Lưu trữ chứng từ (Archive Voucher) - CT-07
    /// </summary>
    public class LuuTruChungTu
    {
        public long Id { get; set; }

        [Required, MaxLength(20)]
        public string SoLuuTru { get; set; }

        [Required]
        public DateTime NgayLuuTru { get; set; }

        [Required, MaxLength(20)]
        public string LoaiChungTu { get; set; }

        public long ChungTuId { get; set; }

        [MaxLength(500)]
        public string MoTa { get; set; }

        [MaxLength(255)]
        public string LinkFile { get; set; }

        public long KyKeToanId { get; set; }

        public long HkdInfoId { get; set; }

        [MaxLength(20)]
        public string TrangThai { get; set; } = "DA_LUU";

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;

        public virtual KyKeToan KyKeToan { get; set; }
        public virtual HkdInfo HkdInfo { get; set; }
    }
}
