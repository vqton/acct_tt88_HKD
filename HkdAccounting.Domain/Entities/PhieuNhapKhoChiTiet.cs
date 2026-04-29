using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HkdAccounting.Domain.Entities
{
    /// <summary>
    /// Chi tiết phiếu nhập kho
    /// </summary>
    public class PhieuNhapKhoChiTiet
    {
        public long Id { get; set; }

        public long PhieuNhapKhoId { get; set; }

        public long HangHoaId { get; set; }

        public int SoLuong { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal DonGia { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal ThanhTien { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        public virtual PhieuNhapKho PhieuNhapKho { get; set; }
        public virtual DmHangHoa HangHoa { get; set; }
    }
}
