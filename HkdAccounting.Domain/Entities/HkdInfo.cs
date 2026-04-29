using System;
using System.ComponentModel.DataAnnotations;

namespace HkdAccounting.Domain.Entities
{
    /// <summary>
    /// Thông tin hộ kinh doanh / Cá nhân kinh doanh
    /// </summary>
    public class HkdInfo
    {
        /// <summary>
        /// Khóa chính
        /// </summary>
        public long Id { get; set; }
        
        /// <summary>
        /// Tên hộ kinh doanh
        /// </summary>
        [Required(ErrorMessage = "Tên hộ kinh doanh là bắt buộc")]
        [MaxLength(255, ErrorMessage = "Tên hộ kinh doanh không được vượt quá 255 ký tự")]
        public string TenHkd { get; set; }
        
        /// <summary>
        /// Địa chỉ trú sở
        /// </summary>
        [MaxLength(500, ErrorMessage = "Địa chỉ trú sở không được vượt quá 500 ký tự")]
        public string DiaChiTruSo { get; set; }
        
        /// <summary>
        /// Mã số thuế
        /// </summary>
        [Required(ErrorMessage = "Mã số thuế là bắt buộc")]
        [MaxLength(20, ErrorMessage = "Mã số thuế không được vượt quá 20 ký tự")]
        public string MaSoThue { get; set; }
        
        /// <summary>
        /// Số CCCD người đại diện
        /// </summary>
        [MaxLength(20, ErrorMessage = "Số CCCD người đại diện không được vượt quá 20 ký tự")]
        public string SoCccdNguoiDaiDien { get; set; }
        
        /// <summary>
        /// Họ tên người đại diện
        /// </summary>
        [MaxLength(100, ErrorMessage = "Họ tên người đại diện không được vượt quá 100 ký tự")]
        public string HoTenNguoiDaiDien { get; set; }
        
        /// <summary>
        /// Phương pháp tính giá xuất kho (BINH_QUAN: Bình quân, FIFO: First In First Out)
        /// </summary>
        [Required(ErrorMessage = "Phương pháp tính giá xuất kho là bắt buộc")]
        [MaxLength(20, ErrorMessage = "Phương pháp tính giá xuất kho không được vượt quá 20 ký tự")]
        public string PhuongPhapTinhGiaXuatKho { get; set; } = "BINH_QUAN";
        
        /// <summary>
        /// Trạng thái hoạt động
        /// </summary>
        [MaxLength(20, ErrorMessage = "Trạng thái không được vượt quá 20 ký tự")]
        public string TrangThai { get; set; } = "HOAT_DONG";
        
        /// <summary>
        /// Ngày tạo bản ghi
        /// </summary>
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        
        /// <summary>
        /// Ngày cập nhật bản ghi
        /// </summary>
        public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;
    }
}