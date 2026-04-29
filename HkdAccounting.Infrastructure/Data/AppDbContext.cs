using Microsoft.EntityFrameworkCore;
using HkdAccounting.Domain.Entities;
using HkdAccounting.Domain.Entities;

namespace HkdAccounting.Infrastructure.Data
{
    /// <summary>
    /// Database context for HKD Accounting System
    /// </summary>
    public class AppDbContext : DbContext
    {
        /// <summary>
        /// Constructor with options
        /// </summary>
        /// <param name="options">Database context options</param>
        public AppDbContext(DbContextOptions<AppDbContext> options)
            : base(options)
        {
        }

        /// <summary>
        /// HkdInfo table
        /// </summary>
        public DbSet<HkdInfo> HkdInfos { get; set; }

        /// <summary>
        /// DmNhomNghe table
        /// </summary>
        public DbSet<DmNhomNghe> DmNhomNghes { get; set; }

        /// <summary>
        /// DmHangHoa table
        /// </summary>
        public DbSet<DmHangHoa> DmHangHoas { get; set; }

        /// <summary>
        /// DoiTac table
        /// </summary>
        public DbSet<DoiTac> DoiTacs { get; set; }

        /// <summary>
        /// KhachHang table
        /// </summary>
        public DbSet<KhachHang> KhachHangs { get; set; }

        /// <summary>
        /// NhanVien table
        /// </summary>
        public DbSet<NhanVien> NhanViens { get; set; }

        /// <summary>
        /// Configure database schema and relationships
        /// </summary>
        /// <param name="modelBuilder">Model builder</param>
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // Configure HkdInfo
            modelBuilder.Entity<HkdInfo>(entity =>
            {
                entity.ToTable("hkd_info");
                entity.HasKey(e => e.Id);
                entity.Property(e => e.TenHkd)
                    .IsRequired()
                    .HasMaxLength(255);
                entity.Property(e => e.DiaChiTruSo)
                    .HasMaxLength(500);
                entity.Property(e => e.MaSoThue)
                    .IsRequired()
                    .HasMaxLength(20)
                    .IsUnicode(false);
                entity.Property(e => e.SoCccdNguoiDaiDien)
                    .HasMaxLength(20);
                entity.Property(e => e.HoTenNguoiDaiDien)
                    .HasMaxLength(100);
                entity.Property(e => e.PhuongPhapTinhGiaXuatKho)
                    .IsRequired()
                    .HasMaxLength(20)
                    .HasDefaultValue("BINH_QUAN");
                entity.Property(e => e.TrangThai)
                    .HasMaxLength(20)
                    .HasDefaultValue("HOAT_DONG");
                entity.Property(e => e.CreatedAt)
                     .HasDefaultValue(DateTime.UtcNow);
                 entity.Property(e => e.UpdatedAt)
                     .HasDefaultValue(DateTime.UtcNow);
             });
 
             // Configure DmNhomNghe
            modelBuilder.Entity<DmNhomNghe>(entity =>
            {
                entity.ToTable("dm_nhom_nghe");
                entity.HasKey(e => e.Id);
                entity.Property(e => e.MaNhomNghe)
                    .IsRequired()
                    .HasMaxLength(20);
                entity.Property(e => e.TenNhomNghe)
                    .IsRequired()
                    .HasMaxLength(255);
                entity.Property(e => e.TyLeThueGtgt)
                    .IsRequired();
                entity.Property(e => e.TyLeThueTncn)
                    .IsRequired();
                entity.Property(e => e.NgayHieuLuc)
                    .IsRequired();
                entity.Property(e => e.NgayHetHieuLuc);
                entity.Property(e => e.TrangThai)
                    .HasMaxLength(20)
                    .HasDefaultValue("HOAT_DONG");
                entity.Property(e => e.CreatedAt)
                     .HasDefaultValue(DateTime.UtcNow);
                 entity.Property(e => e.UpdatedAt)
                     .HasDefaultValue(DateTime.UtcNow);
                 
                 // Unique constraint for MaNhomNghe + NgayHieuLuc
                entity.HasIndex(e => new { e.MaNhomNghe, e.NgayHieuLuc })
                    .IsUnique();
            });

            // Configure DmHangHoa
            modelBuilder.Entity<DmHangHoa>(entity =>
            {
                entity.ToTable("dm_hang_hoa");
                entity.HasKey(e => e.Id);
                entity.Property(e => e.MaHang)
                    .IsRequired()
                    .HasMaxLength(20);
                entity.Property(e => e.TenHang)
                    .IsRequired()
                    .HasMaxLength(255);
                entity.Property(e => e.NhanHieuQuyCach)
                    .HasMaxLength(255);
                entity.Property(e => e.DonViTinh)
                    .IsRequired()
                    .HasMaxLength(20);
                entity.Property(e => e.NhomNgheId);
                entity.Property(e => e.LoaiHang)
                    .IsRequired()
                    .HasMaxLength(20);
                entity.Property(e => e.DonGiaMuaChuan)
                    .HasColumnType("decimal(18,2)");
                entity.Property(e => e.TrangThai)
                    .HasMaxLength(20)
                    .HasDefaultValue("DANG_KINH_DOANH");
                entity.Property(e => e.CreatedAt)
                     .HasDefaultValue(DateTime.UtcNow);
                 entity.Property(e => e.UpdatedAt)
                     .HasDefaultValue(DateTime.UtcNow);
                 
                 // Unique constraint for MaHang
                entity.HasIndex(e => e.MaHang)
                    .IsUnique();
                
                // Foreign key to DmNhomNghe
                entity.HasOne(e => e.NhomNghe)
                    .WithMany()
                    .HasForeignKey(e => e.NhomNgheId)
                    .OnDelete(DeleteBehavior.SetNull);
            });

            // Configure DoiTac
            modelBuilder.Entity<DoiTac>(entity =>
            {
                entity.ToTable("doi_tac");
                entity.HasKey(e => e.Id);
                entity.Property(e => e.MaDoiTac)
                    .IsRequired()
                    .HasMaxLength(20);
                entity.Property(e => e.TenDoiTac)
                    .IsRequired()
                    .HasMaxLength(255);
                entity.Property(e => e.MaSoThue)
                    .HasMaxLength(20);
                entity.Property(e => e.DiaChi)
                    .HasMaxLength(500);
                entity.Property(e => e.SoDienThoai)
                    .HasMaxLength(20);
                entity.Property(e => e.Email)
                    .HasMaxLength(100);
                entity.Property(e => e.HkdInfoId)
                    .IsRequired();
                entity.Property(e => e.TrangThai)
                    .HasMaxLength(20)
                    .HasDefaultValue("DANG_HOP_TAC");
                entity.Property(e => e.CreatedAt)
                    .HasDefaultValue(DateTime.UtcNow);
                entity.Property(e => e.UpdatedAt)
                    .HasDefaultValue(DateTime.UtcNow);

                entity.HasIndex(e => e.MaDoiTac)
                    .IsUnique();

                entity.HasOne(e => e.HkdInfo)
                    .WithMany()
                    .HasForeignKey(e => e.HkdInfoId)
                    .OnDelete(DeleteBehavior.Cascade);
            });

            // Configure KhachHang
            modelBuilder.Entity<KhachHang>(entity =>
            {
                entity.ToTable("khach_hang");
                entity.HasKey(e => e.Id);
                entity.Property(e => e.MaKhachHang)
                    .IsRequired()
                    .HasMaxLength(20);
                entity.Property(e => e.TenKhachHang)
                    .IsRequired()
                    .HasMaxLength(255);
                entity.Property(e => e.MaSoThue)
                    .HasMaxLength(20);
                entity.Property(e => e.DiaChi)
                    .HasMaxLength(500);
                entity.Property(e => e.SoDienThoai)
                    .HasMaxLength(20);
                entity.Property(e => e.Email)
                    .HasMaxLength(100);
                entity.Property(e => e.HkdInfoId)
                    .IsRequired();
                entity.Property(e => e.TrangThai)
                    .HasMaxLength(20)
                    .HasDefaultValue("DANG_HOP_TAC");
                entity.Property(e => e.CreatedAt)
                    .HasDefaultValue(DateTime.UtcNow);
                entity.Property(e => e.UpdatedAt)
                    .HasDefaultValue(DateTime.UtcNow);

                entity.HasIndex(e => e.MaKhachHang)
                    .IsUnique();

                entity.HasOne(e => e.HkdInfo)
                    .WithMany()
                    .HasForeignKey(e => e.HkdInfoId)
                    .OnDelete(DeleteBehavior.Cascade);
            });

            // Configure NhanVien
            modelBuilder.Entity<NhanVien>(entity =>
            {
                entity.ToTable("nhan_vien");
                entity.HasKey(e => e.Id);
                entity.Property(e => e.MaNhanVien)
                    .IsRequired()
                    .HasMaxLength(20);
                entity.Property(e => e.HoTen)
                    .IsRequired()
                    .HasMaxLength(100);
                entity.Property(e => e.SoCccd)
                    .HasMaxLength(20);
                entity.Property(e => e.DiaChi)
                    .HasMaxLength(500);
                entity.Property(e => e.SoDienThoai)
                    .HasMaxLength(20);
                entity.Property(e => e.Email)
                    .HasMaxLength(100);
                entity.Property(e => e.ChucVu)
                    .HasMaxLength(50);
                entity.Property(e => e.LoaiNhanVien)
                    .HasMaxLength(20)
                    .HasDefaultValue("CHINH_THUC");
                entity.Property(e => e.LuongCoBan)
                    .HasColumnType("decimal(18,2)");
                entity.Property(e => e.DonGiaLuanSanPham)
                    .HasColumnType("decimal(18,2)");
                entity.Property(e => e.DonGiaLuanThoiGian)
                    .HasColumnType("decimal(18,2)");
                entity.Property(e => e.HkdInfoId)
                    .IsRequired();
                entity.Property(e => e.TrangThai)
                    .HasMaxLength(20)
                    .HasDefaultValue("DANG_LAM_VIEC");
                entity.Property(e => e.CreatedAt)
                    .HasDefaultValue(DateTime.UtcNow);
                entity.Property(e => e.UpdatedAt)
                    .HasDefaultValue(DateTime.UtcNow);

                entity.HasIndex(e => e.MaNhanVien)
                    .IsUnique();

                entity.HasOne(e => e.HkdInfo)
                    .WithMany()
                    .HasForeignKey(e => e.HkdInfoId)
                    .OnDelete(DeleteBehavior.Cascade);
            });
        }
    }
}