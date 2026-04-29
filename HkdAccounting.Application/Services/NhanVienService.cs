using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using HkdAccounting.Application.Dtos;
using HkdAccounting.Domain.Entities;
using HkdAccounting.Domain.Repositories;

namespace HkdAccounting.Application.Services
{
    /// <summary>
    /// Dịch vụ xử lý thông tin nhân viên
    /// </summary>
    public class NhanVienService : INhanVienService
    {
        private readonly INhanVienRepository _nhanVienRepository;

        /// <summary>
        /// Khởi tạo dịch vụ với repository được inject qua DI
        /// </summary>
        /// <param name="nhanVienRepository">Repository xử lý dữ liệu NhanVien</param>
        public NhanVienService(INhanVienRepository nhanVienRepository)
        {
            _nhanVienRepository = nhanVienRepository;
        }

        /// <summary>
        /// Lấy thông tin nhân viên theo ID
        /// </summary>
        /// <param name="id">ID của nhân viên</param>
        /// <returns>Thông tin nhân viên</returns>
        public async Task<NhanVienDto> GetByIdAsync(long id)
        {
            var entity = await _nhanVienRepository.GetByIdAsync(id);
            if (entity == null) return null;

            return new NhanVienDto
            {
                Id = entity.Id,
                MaNhanVien = entity.MaNhanVien,
                HoTen = entity.HoTen,
                SoCccd = entity.SoCccd,
                DiaChi = entity.DiaChi,
                SoDienThoai = entity.SoDienThoai,
                Email = entity.Email,
                ChucVu = entity.ChucVu,
                LoaiNhanVien = entity.LoaiNhanVien,
                LuongCoBan = entity.LuongCoBan,
                DonGiaLuanSanPham = entity.DonGiaLuanSanPham,
                DonGiaLuanThoiGian = entity.DonGiaLuanThoiGian,
                HkdInfoId = entity.HkdInfoId,
                TrangThai = entity.TrangThai,
                CreatedAt = entity.CreatedAt,
                UpdatedAt = entity.UpdatedAt
            };
        }

        /// <summary>
        /// Lấy danh sách tất cả nhân viên
        /// </summary>
        /// <returns>Danh sách nhân viên</returns>
        public async Task<IEnumerable<NhanVienDto>> GetAllAsync()
        {
            var entities = await _nhanVienRepository.GetAllAsync();
            return entities.Select(e => new NhanVienDto
            {
                Id = e.Id,
                MaNhanVien = e.MaNhanVien,
                HoTen = e.HoTen,
                SoCccd = e.SoCccd,
                DiaChi = e.DiaChi,
                SoDienThoai = e.SoDienThoai,
                Email = e.Email,
                ChucVu = e.ChucVu,
                LoaiNhanVien = e.LoaiNhanVien,
                LuongCoBan = e.LuongCoBan,
                DonGiaLuanSanPham = e.DonGiaLuanSanPham,
                DonGiaLuanThoiGian = e.DonGiaLuanThoiGian,
                HkdInfoId = e.HkdInfoId,
                TrangThai = e.TrangThai,
                CreatedAt = e.CreatedAt,
                UpdatedAt = e.UpdatedAt
            });
        }

        /// <summary>
        /// Tạo mới nhân viên
        /// </summary>
        /// <param name="dto">Thông tin nhân viên cần tạo</param>
        /// <returns>ID của nhân viên vừa tạo</returns>
        public async Task<long> CreateAsync(NhanVienDto dto)
        {
            var entity = new NhanVien
            {
                MaNhanVien = dto.MaNhanVien,
                HoTen = dto.HoTen,
                SoCccd = dto.SoCccd,
                DiaChi = dto.DiaChi,
                SoDienThoai = dto.SoDienThoai,
                Email = dto.Email,
                ChucVu = dto.ChucVu,
                LoaiNhanVien = dto.LoaiNhanVien ?? "CHINH_THUC",
                LuongCoBan = dto.LuongCoBan,
                DonGiaLuanSanPham = dto.DonGiaLuanSanPham,
                DonGiaLuanThoiGian = dto.DonGiaLuanThoiGian,
                HkdInfoId = dto.HkdInfoId,
                TrangThai = dto.TrangThai ?? "DANG_LAM_VIEC"
            };

            await _nhanVienRepository.AddAsync(entity);
            return entity.Id;
        }

        /// <summary>
        /// Cập nhật thông tin nhân viên
        /// </summary>
        /// <param name="dto">Thông tin nhân viên cần cập nhật</param>
        public async Task UpdateAsync(NhanVienDto dto)
        {
            var entity = await _nhanVienRepository.GetByIdAsync(dto.Id);
            if (entity == null) return;

            entity.MaNhanVien = dto.MaNhanVien;
            entity.HoTen = dto.HoTen;
            entity.SoCccd = dto.SoCccd;
            entity.DiaChi = dto.DiaChi;
            entity.SoDienThoai = dto.SoDienThoai;
            entity.Email = dto.Email;
            entity.ChucVu = dto.ChucVu;
            entity.LoaiNhanVien = dto.LoaiNhanVien;
            entity.LuongCoBan = dto.LuongCoBan;
            entity.DonGiaLuanSanPham = dto.DonGiaLuanSanPham;
            entity.DonGiaLuanThoiGian = dto.DonGiaLuanThoiGian;
            entity.HkdInfoId = dto.HkdInfoId;
            entity.TrangThai = dto.TrangThai;
            entity.UpdatedAt = DateTime.UtcNow;

            await _nhanVienRepository.UpdateAsync(entity);
        }

        /// <summary>
        /// Xóa nhân viên
        /// </summary>
        /// <param name="id">ID của nhân viên cần xóa</param>
        public async Task DeleteAsync(long id)
        {
            await _nhanVienRepository.DeleteAsync(id);
        }
    }
}