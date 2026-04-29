using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace HkdAccounting.Domain.Entities
{
    /// <summary>
    /// Tồn kho (Inventory) - KH-03
    /// </summary>
    public class TonKho
    {
        public long Id { get; set; }

        public long HangHoaId { get; set; }

        public long HkdInfoId { get; set; }

        public int SoLuongTon { get; set; } = 0;

        [Column(TypeName = "decimal(18,2)")]
        public decimal DonGiaBinhQuan { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal GiaTriTon { get; set; } = 0;

        [MaxLength(20)]
        public string PhuongPhapTinhGia { get; set; } = "BINH_QUAN";

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;

        public virtual DmHangHoa HangHoa { get; set; }
        public virtual HkdInfo HkdInfo { get; set; }
    }
}
