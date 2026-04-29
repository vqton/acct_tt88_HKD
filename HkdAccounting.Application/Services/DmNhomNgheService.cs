using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using HkdAccounting.Application.Dtos;
using HkdAccounting.Domain.Entities;
using HkdAccounting.Domain.Repositories;

namespace HkdAccounting.Application.Services
{
    /// <summary>
    /// Dịch vụ xử lý danh mục nhóm nghề - MD-03
    /// </summary>
    public class DmNhomNgheService : IDmNhomNgheService
    {
        private readonly IDmNhomNgheRepository _repository;

        public DmNhomNgheService(IDmNhomNgheRepository repository)
        {
            _repository = repository;
        }

        public async Task<DmNhomNgheDto> GetByIdAsync(long id)
        {
            var entity = await _repository.GetByIdAsync(id);
            if (entity == null) return null;

            return new DmNhomNgheDto
            {
                Id = entity.Id,
                MaNhomNghe = entity.MaNhomNghe,
                TenNhomNghe = entity.TenNhomNghe,
                TyLeThueGtgt = entity.TyLeThueGtgt,
                TyLeThueTncn = entity.TyLeThueTncn,
                NgayHieuLuc = entity.NgayHieuLuc,
                NgayHetHieuLuc = entity.NgayHetHieuLuc,
                TrangThai = entity.TrangThai,
                CreatedAt = entity.CreatedAt,
                UpdatedAt = entity.UpdatedAt
            };
        }

        public async Task<IEnumerable<DmNhomNgheDto>> GetAllAsync()
        {
            var entities = await _repository.GetAllAsync();
            return entities.Select(e => new DmNhomNgheDto
            {
                Id = e.Id,
                MaNhomNghe = e.MaNhomNghe,
                TenNhomNghe = e.TenNhomNghe,
                TyLeThueGtgt = e.TyLeThueGtgt,
                TyLeThueTncn = e.TyLeThueTncn,
                NgayHieuLuc = e.NgayHieuLuc,
                NgayHetHieuLuc = e.NgayHetHieuLuc,
                TrangThai = e.TrangThai,
                CreatedAt = e.CreatedAt,
                UpdatedAt = e.UpdatedAt
            });
        }

        public async Task<long> CreateAsync(DmNhomNgheDto dto)
        {
            var entity = new DmNhomNghe
            {
                MaNhomNghe = dto.MaNhomNghe,
                TenNhomNghe = dto.TenNhomNghe,
                TyLeThueGtgt = dto.TyLeThueGtgt,
                TyLeThueTncn = dto.TyLeThueTncn,
                NgayHieuLuc = dto.NgayHieuLuc,
                NgayHetHieuLuc = dto.NgayHetHieuLuc,
                TrangThai = dto.TrangThai
            };

            await _repository.AddAsync(entity);
            return entity.Id;
        }

        public async Task UpdateAsync(DmNhomNgheDto dto)
        {
            var entity = await _repository.GetByIdAsync(dto.Id);
            if (entity == null) return;

            entity.MaNhomNghe = dto.MaNhomNghe;
            entity.TenNhomNghe = dto.TenNhomNghe;
            entity.TyLeThueGtgt = dto.TyLeThueGtgt;
            entity.TyLeThueTncn = dto.TyLeThueTncn;
            entity.NgayHieuLuc = dto.NgayHieuLuc;
            entity.NgayHetHieuLuc = dto.NgayHetHieuLuc;
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
