using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HkdAccounting.Domain.Entities
{
    /// <summary>
    /// Chi tiết sổ kế toán
    /// </summary>
    public class SoKeToanChiTiet
    {
        public long Id { get; set; }

        public long SoKeToanId { get; set; }

        public DateTime NgayChungTu { get; set; }

        [MaxLength(20)]
        public string SoChungTu { get; set; }

        [MaxLength(500)]
        public string DienGiai { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal PhatSinhNo { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal PhatSinhCo { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal SoDu { get; set; }

        public long? NhomNgheId { get; set; }

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        public virtual SoKeToan SoKeToan { get; set; }
        public virtual DmNhomNghe NhomNghe { get; set; }
    }
}
