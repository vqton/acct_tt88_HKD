using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HkdAccounting.Domain.Entities
{
    /// <summary>
    /// Khách hàng
    /// </summary>
    public class KhachHang
    {
        /// <summary>
        /// Khóa chính
        /// </summary>
        public long Id { get; set; }

        /// <summary>
        /// Mã khách hàng
        /// </summary>
        [Required(ErrorMessage = "Mã khách hàng là bắt buộc")]
        [MaxLength(20, ErrorMessage = "Mã khách hàng không được vượt quá 20 ký tự")]
        public string MaKhachHang { get; set; }

        /// <summary>
        /// Tên khách hàng
        /// </summary>
        [Required(ErrorMessage = "Tên khách hàng là bắt buộc")]
        [MaxLength(255, ErrorMessage = "Tên khách hàng không được vượt quá 255 ký tự")]
        public string TenKhachHang { get; set; }

        /// <summary>
        /// Mã số thuế
        /// </summary>
        [MaxLength(20, ErrorMessage = "Mã số thuế không được vượt quá 20 ký tự")]
        public string MaSoThue { get; set; }

        /// <summary>
        /// Địa chỉ
        /// </summary>
        [MaxLength(500, ErrorMessage = "Địa chỉ không được vượt quá 500 ký tự")]
        public string DiaChi { get; set; }

        /// <summary>
        /// Số điện thoại
        /// </summary>
        [MaxLength(20, ErrorMessage = "Số điện thoại không được vượt quá 20 ký tự")]
        public string SoDienThoai { get; set; }

        /// <summary>
        /// Email
        /// </summary>
        [MaxLength(100, ErrorMessage = "Email không được vượt quá 100 ký tự")]
        public string Email { get; set; }

        /// <summary>
        /// Khóa ngoại tới HkdInfo
        /// </summary>
        public long HkdInfoId { get; set; }

        /// <summary>
        /// Trạng thái
        /// </summary>
        [MaxLength(20, ErrorMessage = "Trạng thái không được vượt quá 20 ký tự")]
        public string TrangThai { get; set; } = "DANG_HOP_TAC";

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
