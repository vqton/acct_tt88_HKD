using System;

namespace HkdAccounting.Application.Dtos
{
    /// <summary>
    /// DTO để truyền dữ liệu nhân viên giữa các lớp
    /// </summary>
    public class NhanVienDto
    {
        /// <summary>
        /// Khóa chính
        /// </summary>
        public long Id { get; set; }
        
        /// <summary>
        /// Mã nhân viên
        /// </summary>
        public string MaNhanVien { get; set; }
        
        /// <summary>
        /// Họ tên nhân viên
        /// </summary>
        public string HoTen { get; set; }
        
        /// <summary>
        /// Số CCCD
        /// </summary>
        public string SoCccd { get; set; }
        
        /// <summary>
        /// Địa chỉ
        /// </summary>
        public string DiaChi { get; set; }
        
        /// <summary>
        /// Số điện thoại
        /// </summary>
        public string SoDienThoai { get; set; }
        
        /// <summary>
        /// Email
        /// </summary>
        public string Email { get; set; }
        
        /// <summary>
        /// Chức vụ
        /// </summary>
        public string ChucVu { get; set; }
        
        /// <summary>
        /// Loại nhân viên (CHINH_THUC, THU_VIEC, CONG_TAC_VIEN)
        /// </summary>
        public string LoaiNhanVien { get; set; }
        
        /// <summary>
        /// Lương cơ bản
        /// </summary>
        public decimal? LuongCoBan { get; set; }
        
        /// <summary>
        /// Đơn giá lương sản phẩm
        /// </summary>
        public decimal? DonGiaLuanSanPham { get; set; }
        
        /// <summary>
        /// Đơn giá lương thời gian
        /// </summary>
        public decimal? DonGiaLuanThoiGian { get; set; }
        
        /// <summary>
        /// Khóa ngoại tới HkdInfo
        /// </summary>
        public long HkdInfoId { get; set; }
        
        /// <summary>
        /// Trạng thái (DANG_LAM_VIEC, NGHI_VIEC)
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