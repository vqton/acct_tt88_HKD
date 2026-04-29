using System;
using System.ComponentModel.DataAnnotations;

namespace HkdAccounting.Domain.Entities
{
    /// <summary>
    /// Danh mục ngành nghề & Thuế suất (Industry Group and Tax Rates)
    /// </summary>
    public class DmNhomNghe
    {
        /// <summary>
        /// Khóa chính
        /// </summary>
        public long Id { get; set; }
        
        /// <summary>
        /// Mã nhóm nghề
        /// </summary>
        [Required(ErrorMessage = "Mã nhóm nghề là bắt buộc")]
        [MaxLength(20, ErrorMessage = "Mã nhóm nghề không được vượt quá 20 ký tự")]
        public string MaNhomNghe { get; set; }
        
        /// <summary>
        /// Tên nhóm nghề
        /// </summary>
        [Required(ErrorMessage = "Tên nhóm nghề là bắt buộc")]
        [MaxLength(255, ErrorMessage = "Tên nhóm nghề không được vượt quá 255 ký tự")]
        public string TenNhomNghe { get; set; }
        
        /// <summary>
        /// Tỷ lệ thuế GTGT (%)
        /// </summary>
        [Required(ErrorMessage = "Tỷ lệ thuế GTGT là bắt buộc")]
        [Range(0, 100, ErrorMessage = "Tỷ lệ thuế GTGT phải trong khoảng 0-100")]
        public decimal TyLeThueGtgt { get; set; }
        
        /// <summary>
        /// Tỷ lệ thuế TNCN (%)
        /// </summary>
        [Required(ErrorMessage = "Tỷ lệ thuế TNCN là bắt buộc")]
        [Range(0, 100, ErrorMessage = "Tỷ lệ thuế TNCN phải trong khoảng 0-100")]
        public decimal TyLeThueTncn { get; set; }
        
        /// <summary>
        /// Ngày hiệu lực
        /// </summary>
        [Required(ErrorMessage = "Ngày hiệu lực là bắt buộc")]
        public DateTime NgayHieuLuc { get; set; }
        
        /// <summary>
        /// Ngày hết hiệu lực (có thể null cho việc áp dụng vô thời hạn)
        /// </summary>
        public DateTime? NgayHetHieuLuc { get; set; }
        
        /// <summary>
        /// Trạng thái
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