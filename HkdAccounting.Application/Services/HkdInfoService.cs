using System.Collections.Generic;
using System.Threading.Tasks;
using HkdAccounting.Application.Dtos;
using HkdAccounting.Domain.Entities;
using HkdAccounting.Domain.Repositories;

namespace HkdAccounting.Application.Services
{
    /// <summary>
    /// Dịch vụ xử lý thông tin hộ kinh doanh
    /// </summary>
    public class HkdInfoService : IHkdInfoService
    {
        private readonly IHkdInfoRepository _hkdInfoRepository;

        /// <summary>
        /// Khởi tạo dịch vụ với repository được inject qua DI
        /// </summary>
        /// <param name="hkdInfoRepository">Repository xử lý dữ liệu HkdInfo</param>
        public HkdInfoService(IHkdInfoRepository hkdInfoRepository)
        {
            _hkdInfoRepository = hkdInfoRepository;
        }

        /// <summary>
        /// Lấy thông tin hộ kinh doanh theo ID
        /// </summary>
        /// <param name="id">ID của hộ kinh doanh</param>
        /// <returns>Thông tin hộ kinh doanh</returns>
        public async Task<HkdInfoDto> GetByIdAsync(long id)
        {
            var entity = await _hkdInfoRepository.GetByIdAsync(id);
            if (entity == null) return null;

            return new HkdInfoDto
            {
                Id = entity.Id,
                TenHkd = entity.TenHkd,
                DiaChiTruSo = entity.DiaChiTruSo,
                MaSoThue = entity.MaSoThue,
                SoCccdNguoiDaiDien = entity.SoCccdNguoiDaiDien,
                HoTenNguoiDaiDien = entity.HoTenNguoiDaiDien,
                PhuongPhapTinhGiaXuatKho = entity.PhuongPhapTinhGiaXuatKho,
                TrangThai = entity.TrangThai,
                CreatedAt = entity.CreatedAt,
                UpdatedAt = entity.UpdatedAt
            };
        }

        /// <summary>
        /// Lấy danh sách tất cả hộ kinh doanh
        /// </summary>
        /// <returns>Danh sách hộ kinh doanh</returns>
        public async Task<IEnumerable<HkdInfoDto>> GetAllAsync()
        {
            var entities = await _hkdInfoRepository.GetAllAsync();
            return entities.Select(e => new HkdInfoDto
            {
                Id = e.Id,
                TenHkd = e.TenHkd,
                DiaChiTruSo = e.DiaChiTruSo,
                MaSoThue = e.MaSoThue,
                SoCccdNguoiDaiDien = e.SoCccdNguoiDaiDien,
                HoTenNguoiDaiDien = e.HoTenNguoiDaiDien,
                PhuongPhapTinhGiaXuatKho = e.PhuongPhapTinhGiaXuatKho,
                TrangThai = e.TrangThai,
                CreatedAt = e.CreatedAt,
                UpdatedAt = e.UpdatedAt
            });
        }

        /// <summary>
        /// Tạo mới hộ kinh doanh
        /// </summary>
        /// <param name="dto">Thông tin hộ kinh doanh cần tạo</param>
        /// <returns>ID của hộ kinh doanh vừa tạo</returns>
        public async Task<long> CreateAsync(HkdInfoDto dto)
        {
            var entity = new HkdInfo
            {
                TenHkd = dto.TenHkd,
                DiaChiTruSo = dto.DiaChiTruSo,
                MaSoThue = dto.MaSoThue,
                SoCccdNguoiDaiDien = dto.SoCccdNguoiDaiDien,
                HoTenNguoiDaiDien = dto.HoTenNguoiDaiDien,
                PhuongPhapTinhGiaXuatKho = dto.PhuongPhapTinhGiaXuatKho,
                TrangThai = dto.TrangThai
            };

            await _hkdInfoRepository.AddAsync(entity);
            return entity.Id;
        }

        /// <summary>
        /// Cập nhật thông tin hộ kinh doanh
        /// </summary>
        /// <param name="dto">Thông tin hộ kinh doanh cần cập nhật</param>
        public async Task UpdateAsync(HkdInfoDto dto)
        {
            var entity = await _hkdInfoRepository.GetByIdAsync(dto.Id);
            if (entity == null) return;

            entity.TenHkd = dto.TenHkd;
            entity.DiaChiTruSo = dto.DiaChiTruSo;
            entity.MaSoThue = dto.MaSoThue;
            entity.SoCccdNguoiDaiDien = dto.SoCccdNguoiDaiDien;
            entity.HoTenNguoiDaiDien = dto.HoTenNguoiDaiDien;
            entity.PhuongPhapTinhGiaXuatKho = dto.PhuongPhapTinhGiaXuatKho;
            entity.TrangThai = dto.TrangThai;
            entity.UpdatedAt = DateTime.UtcNow;

            await _hkdInfoRepository.UpdateAsync(entity);
        }

        /// <summary>
        /// Xóa hộ kinh doanh
        /// </summary>
        /// <param name="id">ID của hộ kinh doanh cần xóa</param>
        public async Task DeleteAsync(long id)
        {
            await _hkdInfoRepository.DeleteAsync(id);
        }
    }
}