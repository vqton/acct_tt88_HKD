using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HkdAccounting.Domain.Entities
{
    /// <summary>
    /// Nghĩa vụ thuế (Tax Obligation) - TX-01 to TX-04
    /// </summary>
    public class NghiaVuThue
    {
        public long Id { get; set; }

        [Required, MaxLength(20)]
        public string MaNghiaVu { get; set; }

        [Required]
        public DateTime KyThue { get; set; }

        [MaxLength(20)]
        public string LoaiThue { get; set; } = "GTGT";

        [Column(TypeName = "decimal(18,2)")]
        public decimal DoanhThuChiuThue { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal TyLeThue { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal SoThuePhaiNop { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal SoThueDaNop { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal SoThueConNo { get; set; }

        public long NhomNgheId { get; set; }

        public long KyKeToanId { get; set; }

        public long HkdInfoId { get; set; }

        [MaxLength(20)]
        public string TrangThai { get; set; } = "CHUA_NOP";

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;

        public virtual DmNhomNghe NhomNghe { get; set; }
        public virtual KyKeToan KyKeToan { get; set; }
        public virtual HkdInfo HkdInfo { get; set; }
    }
}
