using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HkdAccounting.Domain.Entities
{
    /// <summary>
    /// Phê duyệt chứng từ (Approve Voucher) - CT-08
    /// </summary>
    public class PheDuyetChungTu
    {
        public long Id { get; set; }

        [Required, MaxLength(20)]
        public string SoPheDuyet { get; set; }

        [Required]
        public DateTime NgayPheDuyet { get; set; }

        [Required, MaxLength(20)]
        public string LoaiChungTu { get; set; }

        public long ChungTuId { get; set; }

        [MaxLength(20)]
        public string KetQua { get; set; } = "DAT";

        [MaxLength(500)]
        public string LyDo { get; set; }

        [MaxLength(100)]
        public string NguoiPheDuyet { get; set; }

        public long HkdInfoId { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;

        public virtual HkdInfo HkdInfo { get; set; }
    }
}
