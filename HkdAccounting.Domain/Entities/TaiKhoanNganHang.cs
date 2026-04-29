using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HkdAccounting.Domain.Entities
{
    /// <summary>
    /// Tài khoản ngân hàng
    /// </summary>
    public class TaiKhoanNganHang
    {
        /// <summary>
        /// Khóa chính
        /// </summary>
        public long Id { get; set; }

        /// <summary>
        /// Mã tài khoản
        /// </summary>
        [Required(ErrorMessage = "Mã tài khoản là bắt buộc")]
        [MaxLength(20, ErrorMessage = "Mã tài khoản không được vượt quá 20 ký tự")]
        public string MaTaiKhoan { get; set; }

        /// <summary>
        /// Số tài khoản
        /// </summary>
        [Required(ErrorMessage = "Số tài khoản là bắt buộc")]
        [MaxLength(50, ErrorMessage = "Số tài khoản không được vượt quá 50 ký tự")]
        public string SoTaiKhoan { get; set; }

        /// <summary>
        /// Tên ngân hàng
        /// </summary>
        [Required(ErrorMessage = "Tên ngân hàng là bắt buộc")]
        [MaxLength(255, ErrorMessage = "Tên ngân hàng không được vượt quá 255 ký tự")]
        public string TenNganHang { get; set; }

        /// <summary>
        /// Chi nhánh
        /// </summary>
        [MaxLength(255, ErrorMessage = "Chi nhánh không được vượt quá 255 ký tự")]
        public string ChiNhanh { get; set; }

        /// <summary>
        /// Số dư hiện tại
        /// </summary>
        [Column(TypeName = "decimal(18,2)")]
        public decimal SoDuHienTai { get; set; } = 0;

        /// <summary>
        /// Khóa ngoại tới HkdInfo
        /// </summary>
        public long HkdInfoId { get; set; }

        /// <summary>
        /// Trạng thái
        /// </summary>
        [MaxLength(20, ErrorMessage = "Trạng thái không được vượt quá 20 ký tự")]
        public string TrangThai { get; set; } = "DANG_SU_DUNG";

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
