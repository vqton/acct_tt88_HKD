using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HkdAccounting.Domain.Entities
{
    /// <summary>
    /// Chi tiết hóa đơn
    /// </summary>
    public class HoaDonChiTiet
    {
        public long Id { get; set; }

        public long HoaDonId { get; set; }

        public long HangHoaId { get; set; }

        public int SoLuong { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal DonGia { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal ThanhTien { get; set; }

        public long? NhomNgheId { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        public virtual HoaDon HoaDon { get; set; }
        public virtual DmHangHoa HangHoa { get; set; }
        public virtual DmNhomNghe NhomNghe { get; set; }
    }
}
