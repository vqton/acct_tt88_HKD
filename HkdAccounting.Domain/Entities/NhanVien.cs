using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HkdAccounting.Domain.Entities
{
    /// <summary>
    /// Nhân viên
    /// </summary>
    public class NhanVien
    {
        /// <summary>
        /// Khóa chính
        /// </summary>
        public long Id { get; set; }

        /// <summary>
        /// Mã nhân viên
        /// </summary>
        [Required(ErrorMessage = "Mã nhân viên là bắt buộc")]
        [MaxLength(20, ErrorMessage = "Mã nhân viên không được vượt quá 20 ký tự")]
        public string MaNhanVien { get; set; }

        /// <summary>
        /// Họ tên nhân viên
        /// </summary>
        [Required(ErrorMessage = "Họ tên nhân viên là bắt buộc")]
        [MaxLength(100, ErrorMessage = "Họ tên nhân viên không được vượt quá 100 ký tự")]
        public string HoTen { get; set; }

        /// <summary>
        /// Số CCCD
        /// </summary>
        [MaxLength(20, ErrorMessage = "Số CCCD không được vượt quá 20 ký tự")]
        public string SoCccd { get; set; }

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
        /// Chức vụ
        /// </summary>
        [MaxLength(50, ErrorMessage = "Chức vụ không được vượt quá 50 ký tự")]
        public string ChucVu { get; set; }

        /// <summary>
        /// Loại nhân viên (Chính thức, Thử việc, Cộng tác viên)
        /// </summary>
        [MaxLength(20, ErrorMessage = "Loại nhân viên không được vượt quá 20 ký tự")]
        public string LoaiNhanVien { get; set; } = "CHINH_THUC";

        /// <summary>
        /// Lương cơ bản
        /// </summary>
        [Column(TypeName = "decimal(18,2)")]
        public decimal? LuongCoBan { get; set; }

        /// <summary>
        /// Đơn giá lương sản phẩm
        /// </summary>
        [Column(TypeName = "decimal(18,2)")]
        public decimal? DonGiaLuanSanPham { get; set; }

        /// <summary>
        /// Đơn giá lương thời gian
        /// </summary>
        [Column(TypeName = "decimal(18,2)")]
        public decimal? DonGiaLuanThoiGian { get; set; }

        /// <summary>
        /// Khóa ngoại tới HkdInfo
        /// </summary>
        public long HkdInfoId { get; set; }

        /// <summary>
        /// Trạng thái
        /// </summary>
        [MaxLength(20, ErrorMessage = "Trạng thái không được vượt quá 20 ký tự")]
        public string TrangThai { get; set; } = "DANG_LAM_VIEC";

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
