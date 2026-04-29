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
    /// Dịch vụ xử lý khách hàng - MD-05
    /// </summary>
    public class KhachHangService : IKhachHangService
    {
        private readonly IKhachHangRepository _repository;

        public KhachHangService(IKhachHangRepository repository)
        {
            _repository = repository;
        }

        public async Task<KhachHangDto> GetByIdAsync(long id)
        {
            var entity = await _repository.GetByIdAsync(id);
            if (entity == null) return null;

            return new KhachHangDto
            {
                Id = entity.Id,
                MaKhachHang = entity.MaKhachHang,
                TenKhachHang = entity.TenKhachHang,
                MaSoThue = entity.MaSoThue,
                DiaChi = entity.DiaChi,
                SoDienThoai = entity.SoDienThoai,
                Email = entity.Email,
                HkdInfoId = entity.HkdInfoId,
                TrangThai = entity.TrangThai,
                CreatedAt = entity.CreatedAt,
                UpdatedAt = entity.UpdatedAt
            };
        }

        public async Task<IEnumerable<KhachHangDto>> GetAllAsync()
        {
            var entities = await _repository.GetAllAsync();
            return entities.Select(e => new KhachHangDto
            {
                Id = e.Id,
                MaKhachHang = e.MaKhachHang,
                TenKhachHang = e.TenKhachHang,
                MaSoThue = e.MaSoThue,
                DiaChi = e.DiaChi,
                SoDienThoai = e.SoDienThoai,
                Email = e.Email,
                HkdInfoId = e.HkdInfoId,
                TrangThai = e.TrangThai,
                CreatedAt = e.CreatedAt,
                UpdatedAt = e.UpdatedAt
            });
        }

        public async Task<long> CreateAsync(KhachHangDto dto)
        {
            var entity = new KhachHang
            {
                MaKhachHang = dto.MaKhachHang,
                TenKhachHang = dto.TenKhachHang,
                MaSoThue = dto.MaSoThue,
                DiaChi = dto.DiaChi,
                SoDienThoai = dto.SoDienThoai,
                Email = dto.Email,
                HkdInfoId = dto.HkdInfoId,
                TrangThai = dto.TrangThai ?? "DANG_HOP_TAC"
            };

            await _repository.AddAsync(entity);
            return entity.Id;
        }

        public async Task UpdateAsync(KhachHangDto dto)
        {
            var entity = await _repository.GetByIdAsync(dto.Id);
            if (entity == null) return;

            entity.MaKhachHang = dto.MaKhachHang;
            entity.TenKhachHang = dto.TenKhachHang;
            entity.MaSoThue = dto.MaSoThue;
            entity.DiaChi = dto.DiaChi;
            entity.SoDienThoai = dto.SoDienThoai;
            entity.Email = dto.Email;
            entity.HkdInfoId = dto.HkdInfoId;
            entity.TrangThai = dto.TrangThai;
            entity.UpdatedAt = DateTime.UtcNow;

            await _repository.UpdateAsync(entity);
        }

        public async Task DeleteAsync(long id)
        {
            await _repository.DeleteAsync(id);
        }
    }
}