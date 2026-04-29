using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HkdAccounting.Domain.Entities
{
    /// <summary>
    /// Tài khoản người dùng (User Account) - QT-01
    /// </summary>
    public class TaiKhoanNguoiDung
    {
        public long Id { get; set; }

        [Required, MaxLength(50)]
        public string TenDangNhap { get; set; }

        [Required]
        public string MatKhauHash { get; set; }

        [MaxLength(100)]
        public string HoTen { get; set; }

        [MaxLength(20)]
        public string Role { get; set; } = "KE_TOAN_VIEN";

        [MaxLength(20)]
        public string TrangThai { get; set; } = "HOAT_DONG";

        public long HkdInfoId { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;

        public virtual HkdInfo HkdInfo { get; set; }
    }
}
