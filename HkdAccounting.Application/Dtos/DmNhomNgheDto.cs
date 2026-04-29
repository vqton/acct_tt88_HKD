using System;

namespace HkdAccounting.Application.Dtos
{
    /// <summary>
    /// DTO để truyền dữ liệu danh mục nhóm nghề - MD-03
    /// </summary>
    public class DmNhomNgheDto
    {
        /// <summary>
        /// Khóa chính
        /// </summary>
        public long Id { get; set; }

        /// <summary>
        /// Mã nhóm nghề
        /// </summary>
        public string MaNhomNghe { get; set; }

        /// <summary>
        /// Tên nhóm nghề
        /// </summary>
        public string TenNhomNghe { get; set; }

        /// <summary>
        /// Tỷ lệ thuế GTGT (%)
        /// </summary>
        public decimal TyLeThueGtgt { get; set; }

        /// <summary>
        /// Tỷ lệ thuế TNCN (%)
        /// </summary>
        public decimal TyLeThueTncn { get; set; }

        /// <summary>
        /// Ngày hiệu lực
        /// </summary>
        public DateTime NgayHieuLuc { get; set; }

        /// <summary>
        /// Ngày hết hiệu lực
        /// </summary>
        public DateTime? NgayHetHieuLuc { get; set; }

        /// <summary>
        /// Trạng thái
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
