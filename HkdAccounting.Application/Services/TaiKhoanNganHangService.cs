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
    /// Dịch vụ xử lý thông tin tài khoản ngân hàng
    /// </summary>
    public class TaiKhoanNganHangService : ITaiKhoanNganHangService
    {
        private readonly ITaiKhoanNganHangRepository _repository;

        /// <summary>
        /// Khởi tạo dịch vụ với repository được inject qua DI
        /// </summary>
        /// <param name="repository">Repository xử lý dữ liệu TaiKhoanNganHang</param>
        public TaiKhoanNganHangService(ITaiKhoanNganHangRepository repository)
        {
            _repository = repository;
        }

        /// <summary>
        /// Lấy thông tin tài khoản ngân hàng theo ID
        /// </summary>
        /// <param name="id">ID của tài khoản ngân hàng</param>
        /// <returns>Thông tin tài khoản ngân hàng</returns>
        public async Task<TaiKhoanNganHangDto> GetByIdAsync(long id)
        {
            var entity = await _repository.GetByIdAsync(id);
            if (entity == null) return null;

            return new TaiKhoanNganHangDto
            {
                Id = entity.Id,
                MaTaiKhoan = entity.MaTaiKhoan,
                SoTaiKhoan = entity.SoTaiKhoan,
                TenNganHang = entity.TenNganHang,
                ChiNhanh = entity.ChiNhanh,
                SoDuHienTai = entity.SoDuHienTai,
                HkdInfoId = entity.HkdInfoId,
                TrangThai = entity.TrangThai,
                CreatedAt = entity.CreatedAt,
                UpdatedAt = entity.UpdatedAt
            };
        }

        /// <summary>
        /// Lấy danh sách tất cả tài khoản ngân hàng
        /// </summary>
        /// <returns>Danh sách tài khoản ngân hàng</returns>
        public async Task<IEnumerable<TaiKhoanNganHangDto>> GetAllAsync()
        {
            var entities = await _repository.GetAllAsync();
            return entities.Select(e => new TaiKhoanNganHangDto
            {
                Id = e.Id,
                MaTaiKhoan = e.MaTaiKhoan,
                SoTaiKhoan = e.SoTaiKhoan,
                TenNganHang = e.TenNganHang,
                ChiNhanh = e.ChiNhanh,
                SoDuHienTai = e.SoDuHienTai,
                HkdInfoId = e.HkdInfoId,
                TrangThai = e.TrangThai,
                CreatedAt = e.CreatedAt,
                UpdatedAt = e.UpdatedAt
            });
        }

        /// <summary>
        /// Tạo mới tài khoản ngân hàng
        /// </summary>
        /// <param name="dto">Thông tin tài khoản ngân hàng cần tạo</param>
        /// <returns>ID của tài khoản ngân hàng vừa tạo</returns>
        public async Task<long> CreateAsync(TaiKhoanNganHangDto dto)
        {
            var entity = new TaiKhoanNganHang
            {
                MaTaiKhoan = dto.MaTaiKhoan,
                SoTaiKhoan = dto.SoTaiKhoan,
                TenNganHang = dto.TenNganHang,
                ChiNhanh = dto.ChiNhanh,
                SoDuHienTai = dto.SoDuHienTai,
                HkdInfoId = dto.HkdInfoId,
                TrangThai = dto.TrangThai ?? "DANG_SU_DUNG"
            };

            await _repository.AddAsync(entity);
            return entity.Id;
        }

        /// <summary>
        /// Cập nhật thông tin tài khoản ngân hàng
        /// </summary>
        /// <param name="dto">Thông tin tài khoản ngân hàng cần cập nhật</param>
        public async Task UpdateAsync(TaiKhoanNganHangDto dto)
        {
            var entity = await _repository.GetByIdAsync(dto.Id);
            if (entity == null) return;

            entity.MaTaiKhoan = dto.MaTaiKhoan;
            entity.SoTaiKhoan = dto.SoTaiKhoan;
            entity.TenNganHang = dto.TenNganHang;
            entity.ChiNhanh = dto.ChiNhanh;
            entity.SoDuHienTai = dto.SoDuHienTai;
            entity.HkdInfoId = dto.HkdInfoId;
            entity.TrangThai = dto.TrangThai;
            entity.UpdatedAt = DateTime.UtcNow;

            await _repository.UpdateAsync(entity);
        }

        /// <summary>
        /// Xóa tài khoản ngân hàng
        /// </summary>
        /// <param name="id">ID của tài khoản ngân hàng cần xóa</param>
        public async Task DeleteAsync(long id)
        {
            await _repository.DeleteAsync(id);
        }
    }
}