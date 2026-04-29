using System;

namespace HkdAccounting.Application.Dtos
{
    /// <summary>
    /// DTO cho đối tác (nhà cung cấp) - MD-04
    /// </summary>
    public class DoiTacDto
    {
        public long Id { get; set; }

        public string MaDoiTac { get; set; }

        public string TenDoiTac { get; set; }

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