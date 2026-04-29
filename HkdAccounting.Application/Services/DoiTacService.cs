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
    /// Dịch vụ xử lý đối tác (nhà cung cấp) - MD-04
    /// </summary>
    public class DoiTacService : IDoiTacService
    {
        private readonly IDoiTacRepository _repository;

        public DoiTacService(IDoiTacRepository repository)
        {
            _repository = repository;
        }

        public async Task<DoiTacDto> GetByIdAsync(long id)
        {
            var entity = await _repository.GetByIdAsync(id);
            if (entity == null) return null;

            return new DoiTacDto
            {
                Id = entity.Id,
                MaDoiTac = entity.MaDoiTac,
                TenDoiTac = entity.TenDoiTac,
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

        public async Task<IEnumerable<DoiTacDto>> GetAllAsync()
        {
            var entities = await _repository.GetAllAsync();
            return entities.Select(e => new DoiTacDto
            {
                Id = e.Id,
                MaDoiTac = e.MaDoiTac,
                TenDoiTac = e.TenDoiTac,
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

        public async Task<long> CreateAsync(DoiTacDto dto)
        {
            var entity = new DoiTac
            {
                MaDoiTac = dto.MaDoiTac,
                TenDoiTac = dto.TenDoiTac,
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

        public async Task UpdateAsync(DoiTacDto dto)
        {
            var entity = await _repository.GetByIdAsync(dto.Id);
            if (entity == null) return;

            entity.MaDoiTac = dto.MaDoiTac;
            entity.TenDoiTac = dto.TenDoiTac;
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