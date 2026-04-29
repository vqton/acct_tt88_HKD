using System;

namespace HkdAccounting.Application.Dtos
{
    /// <summary>
    /// DTO để truyền dữ liệu thông tin hộ kinh doanh giữa các lớp
    /// </summary>
    public class HkdInfoDto
    {
        /// <summary>
        /// Khóa chính
        /// </summary>
        public long Id { get; set; }
        
        /// <summary>
        /// Tên hộ kinh doanh
        /// </summary>
        public string TenHkd { get; set; }
        
        /// <summary>
        /// Địa chỉ trú sở
        /// </summary>
        public string DiaChiTruSo { get; set; }
        
        /// <summary>
        /// Mã số thuế
        /// </summary>
        public string MaSoThue { get; set; }
        
        /// <summary>
        /// Số CCCD người đại diện
        /// </summary>
        public string SoCccdNguoiDaiDien { get; set; }
        
        /// <summary>
        /// Họ tên người đại diện
        /// </summary>
        public string HoTenNguoiDaiDien { get; set; }
        
        /// <summary>
        /// Phương pháp tính giá xuất kho (BINH_QUAN: Bình quân, FIFO: First In First Out)
        /// </summary>
        public string PhuongPhapTinhGiaXuatKho { get; set; }
        
        /// <summary>
        /// Trạng thái hoạt động
        /// </summary>
        public string TrangThai { get; set; }
        
        /// <summary>
        /// Ngày tạo bản ghi
        /// </summary>
        public DateTime CreatedAt { get; set; }
        
        /// <summary>
        /// Ngày cập nhật bản ghi
        /// </summary>
        public DateTime UpdatedAt { get; set; }
    }
}