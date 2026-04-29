using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HkdAccounting.Domain.Entities
{
    /// <summary>
    /// Danh mục hàng hóa / Dịch vụ
    /// </summary>
    public class DmHangHoa
    {
        /// <summary>
        /// Khóa chính
        /// </summary>
        public long Id { get; set; }
        
        /// <summary>
        /// Mã hàng
        /// </summary>
        [Required(ErrorMessage = "Mã hàng là bắt buộc")]
        [MaxLength(20, ErrorMessage = "Mã hàng không được vượt quá 20 ký tự")]
        public string MaHang { get; set; }
        
        /// <summary>
        /// Tên hàng
        /// </summary>
        [Required(ErrorMessage = "Tên hàng là bắt buộc")]
        [MaxLength(255, ErrorMessage = "Tên hàng không được vượt quá 255 ký tự")]
        public string TenHang { get; set; }
        
        /// <summary>
        /// Thương hiệu / Quy cách
        /// </summary>
        [MaxLength(255, ErrorMessage = "Thương hiệu / Quy cách không được vượt quá 255 ký tự")]
        public string NhanHieuQuyCach { get; set; }
        
        /// <summary>
        /// Đơn vị tính
        /// </summary>
        [Required(ErrorMessage = "Đơn vị tính là bắt buộc")]
        [MaxLength(20, ErrorMessage = "Đơn vị tính không được vượt quá 20 ký tự")]
        public string DonViTinh { get; set; }
        
        /// <summary>
        /// Khóa ngoại tới Nhóm nghề
        /// </summary>
        public long? NhomNgheId { get; set; }
        
        /// <summary>
        /// Loại hàng (Hàng hoá, Dịch vụ, Tài sản)
        /// </summary>
        [Required(ErrorMessage = "Loại hàng là bắt buộc")]
        [MaxLength(20, ErrorMessage = "Loại hàng không được vượt quá 20 ký tự")]
        public string LoaiHang { get; set; }
        
        /// <summary>
        /// Đơn giá mua chuẩn
        /// </summary>
        [Column(TypeName = "decimal(18,2)")]
        public decimal? DonGiaMuaChuan { get; set; }
        
        /// <summary>
        /// Trạng thái
        /// </summary>
        [MaxLength(20, ErrorMessage = "Trạng thái không được vượt quá 20 ký tự")]
        public string TrangThai { get; set; } = "DANG_KINH_DOANH";
        
        /// <summary>
        /// Ngày tạo bản ghi
        /// </summary>
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        
        /// <summary>
        /// Ngày cập nhật bản ghi
        /// </summary>
        public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;
        
        // Navigation property (optional, for EF Core)
        public virtual DmNhomNghe NhomNghe { get; set; }
    }
}