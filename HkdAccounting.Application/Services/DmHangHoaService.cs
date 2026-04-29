using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using HkdAccounting.Application.Dtos;
using HkdAccounting.Domain.Entities;
using HkdAccounting.Domain.Repositories;

namespace HkdAccounting.Application.Services
{
    /// <summary>
    /// Dịch vụ xử lý danh mục hàng hóa - MD-02
    /// </summary>
    public class DmHangHoaService : IDmHangHoaService
    {
        private readonly IDmHangHoaRepository _repository;

        /// <summary>
        /// Khởi tạo dịch vụ với repository được inject qua DI
        /// </summary>
        public DmHangHoaService(IDmHangHoaRepository repository)
        {
            _repository = repository;
        }

        /// <summary>
        /// Lấy danh mục hàng hóa theo ID
        /// </summary>
        public async Task<DmHangHoaDto> GetByIdAsync(long id)
        {
            var entity = await _repository.GetByIdAsync(id);
            if (entity == null) return null;

            return new DmHangHoaDto
            {
                Id = entity.Id,
                MaHang = entity.MaHang,
                TenHang = entity.TenHang,
                NhanHieuQuyCach = entity.NhanHieuQuyCach,
                DonViTinh = entity.DonViTinh,
                NhomNgheId = entity.NhomNgheId,
                LoaiHang = entity.LoaiHang,
                DonGiaMuaChuan = entity.DonGiaMuaChuan,
                TrangThai = entity.TrangThai,
                CreatedAt = entity.CreatedAt,
                UpdatedAt = entity.UpdatedAt
            };
        }

        /// <summary>
        /// Lấy danh sách tất cả danh mục hàng hóa
        /// </summary>
        public async Task<IEnumerable<DmHangHoaDto>> GetAllAsync()
        {
            var entities = await _repository.GetAllAsync();
            return entities.Select(e => new DmHangHoaDto
            {
                Id = e.Id,
                MaHang = e.MaHang,
                TenHang = e.TenHang,
                NhanHieuQuyCach = e.NhanHieuQuyCach,
                DonViTinh = e.DonViTinh,
                NhomNgheId = e.NhomNgheId,
                LoaiHang = e.LoaiHang,
                DonGiaMuaChuan = e.DonGiaMuaChuan,
                TrangThai = e.TrangThai,
                CreatedAt = e.CreatedAt,
                UpdatedAt = e.UpdatedAt
            });
        }

        /// <summary>
        /// Tạo mới danh mục hàng hóa
        /// </summary>
        public async Task<long> CreateAsync(DmHangHoaDto dto)
        {
            var entity = new DmHangHoa
            {
                MaHang = dto.MaHang,
                TenHang = dto.TenHang,
                NhanHieuQuyCach = dto.NhanHieuQuyCach,
                DonViTinh = dto.DonViTinh,
                NhomNgheId = dto.NhomNgheId,
                LoaiHang = dto.LoaiHang,
                DonGiaMuaChuan = dto.DonGiaMuaChuan,
                TrangThai = dto.TrangThai
            };

            await _repository.AddAsync(entity);
            return entity.Id;
        }

        /// <summary>
        /// Cập nhật danh mục hàng hóa
        /// </summary>
        public async Task UpdateAsync(DmHangHoaDto dto)
        {
            var entity = await _repository.GetByIdAsync(dto.Id);
            if (entity == null) return;

            entity.MaHang = dto.MaHang;
            entity.TenHang = dto.TenHang;
            entity.NhanHieuQuyCach = dto.NhanHieuQuyCach;
            entity.DonViTinh = dto.DonViTinh;
            entity.NhomNgheId = dto.NhomNgheId;
            entity.LoaiHang = dto.LoaiHang;
            entity.DonGiaMuaChuan = dto.DonGiaMuaChuan;
            entity.TrangThai = dto.TrangThai;
            entity.UpdatedAt = DateTime.UtcNow;

            await _repository.UpdateAsync(entity);
        }

        /// <summary>
        /// Xóa danh mực hàng hóa
        /// </summary>
        public async Task DeleteAsync(long id)
        {
            await _repository.DeleteAsync(id);
        }
    }
}
