using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HkdAccounting.Domain.Entities
{
    /// <summary>
    /// Tiền gửi ngân hàng (Bank Deposit) - TT-02
    /// </summary>
    public class TienGuiNganHang
    {
        public long Id { get; set; }

        public long TaiKhoanNganHangId { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal SoDuDauKy { get; set; } = 0;

        [Column(TypeName = "decimal(18,2)")]
        public decimal PhatSinhTang { get; set; } = 0;

        [Column(TypeName = "decimal(18,2)")]
        public decimal PhatSinhGiam { get; set; } = 0;

        [Column(TypeName = "decimal(18,2)")]
        public decimal SoDuCuoiKy { get; set; } = 0;

        public long KyKeToanId { get; set; }

        public long HkdInfoId { get; set; }

        [MaxLength(20)]
        public string TrangThai { get; set; } = "HOAT_DONG";

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;

        public virtual TaiKhoanNganHang TaiKhoanNganHang { get; set; }
        public virtual KyKeToan KyKeToan { get; set; }
        public virtual HkdInfo HkdInfo { get; set; }
    }
}
