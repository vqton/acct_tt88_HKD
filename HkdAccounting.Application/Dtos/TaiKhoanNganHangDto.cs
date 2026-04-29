using System;

namespace HkdAccounting.Application.Dtos
{
    /// <summary>
    /// DTO để truyền dữ liệu tài khoản ngân hàng giữa các lớp
    /// </summary>
    public class TaiKhoanNganHangDto
    {
        /// <summary>
        /// Khóa chính
        /// </summary>
        public long Id { get; set; }
        
        /// <summary>
        /// Mã tài khoản
        /// </summary>
        public string MaTaiKhoan { get; set; }
        
        /// <summary>
        /// Số tài khoản
        /// </summary>
        public string SoTaiKhoan { get; set; }
        
        /// <summary>
        /// Tên ngân hàng
        /// </summary>
        public string TenNganHang { get; set; }
        
        /// <summary>
        /// Chi nhánh
        /// </summary>
        public string ChiNhanh { get; set; }
        
        /// <summary>
        /// Số dư hiện tại
        /// </summary>
        public decimal SoDuHienTai { get; set; }
        
        /// <summary>
        /// Khóa ngoại tới HkdInfo
        /// </summary>
        public long HkdInfoId { get; set; }
        
        /// <summary>
        /// Trạng thái (DANG_SU_DUNG, NGUNG_SU_DUNG)
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