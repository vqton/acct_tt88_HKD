using System;

namespace HkdAccounting.Application.Dtos
{
    /// <summary>
    /// DTO cho khách hàng - MD-05
    /// </summary>
    public class KhachHangDto
    {
        public long Id { get; set; }

        public string MaKhachHang { get; set; }

        public string TenKhachHang { get; set; }

        public string MaSoThue { get; set; }

        public string DiaChi { get; set; }

        public string SoDienThoai { get; set; }

        public string Email { get; set; }

        public long HkdInfoId { get; set; }

        public string TrangThai { get; set; }

        public DateTime CreatedAt { get; set; }

        public DateTime UpdatedAt { get; set; }
    }
}