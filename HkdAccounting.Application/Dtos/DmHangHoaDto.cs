using System;

namespace HkdAccounting.Application.Dtos
{
    /// <summary>
    /// DTO để truyền dữ liệu danh mục hàng hóa giữa các lớp - MD-02
    /// </summary>
    public class DmHangHoaDto
    {
        /// <summary>
        /// Khóa chính
        /// </summary>
        public long Id { get; set; }

        /// <summary>
        /// Mã hàng
        /// </summary>
        public string MaHang { get; set; }

        /// <summary>
        /// Tên hàng
        /// </summary>
        public string TenHang { get; set; }

        /// <summary>
        /// Thương hiệu / Quy cách
        /// </summary>
        public string NhanHieuQuyCach { get; set; }

        /// <summary>
        /// Đơn vị tính
        /// </summary>
        public string DonViTinh { get; set; }

        /// <summary>
        /// ID nhóm nghề
        /// </summary>
        public long? NhomNgheId { get; set; }

        /// <summary>
        /// Loại hàng (HANG_HOA, DICH_VU, TAI_SAN)
        /// </summary>
        public string LoaiHang { get; set; }

        /// <summary>
        /// Đơn giá mua chuẩn
        /// </summary>
        public decimal? DonGiaMuaChuan { get; set; }

        /// <summary>
        /// Trạng thái (DANG_KINH_DOANH, NGUNG_KINH_DOANH)
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
