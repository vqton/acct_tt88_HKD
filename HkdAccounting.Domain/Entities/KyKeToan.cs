using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HkdAccounting.Domain.Entities
{
    /// <summary>
    /// Kỳ kế toán
    /// </summary>
    public class KyKeToan
    {
        /// <summary>
        /// Khóa chính
        /// </summary>
        public long Id { get; set; }

        /// <summary>
        /// Mã kỳ kế toán
        /// </summary>
        [Required(ErrorMessage = "Mã kỳ kế toán là bắt buộc")]
        [MaxLength(20, ErrorMessage = "Mã kỳ kế toán không được vượt quá 20 ký tự")]
        public string MaKy { get; set; }

        /// <summary>
        /// Tên kỳ kế toán
        /// </summary>
        [Required(ErrorMessage = "Tên kỳ kế toán là bắt buộc")]
        [MaxLength(100, ErrorMessage = "Tên kỳ kế toán không được vượt quá 100 ký tự")]
        public string TenKy { get; set; }

        /// <summary>
        /// Ngày bắt đầu kỳ
        /// </summary>
        [Required(ErrorMessage = "Ngày bắt đầu kỳ là bắt buộc")]
        public DateTime NgayBatDau { get; set; }

        /// <summary>
        /// Ngày kết thúc kỳ
        /// </summary>
        [Required(ErrorMessage = "Ngày kết thúc kỳ là bắt buộc")]
        public DateTime NgayKetThuc { get; set; }

        /// <summary>
        /// Trạng thái kỳ kế toán (MO_SO: Mở sổ, DANG_HOAT_DONG: Đang hoạt động, KHOA_SO: Khóa sổ)
        /// </summary>
        [MaxLength(20, ErrorMessage = "Trạng thái không được vượt quá 20 ký tự")]
        public string TrangThai { get; set; } = "MO_SO";

        /// <summary>
        /// Khóa ngoại tới HkdInfo
        /// </summary>
        public long HkdInfoId { get; set; }

        /// <summary>
        /// Ngày tạo bản ghi
        /// </summary>
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        /// <summary>
        /// Ngày cập nhật bản ghi
        /// </summary>
        public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;

        // Navigation property
        public virtual HkdInfo HkdInfo { get; set; }
    }
}
