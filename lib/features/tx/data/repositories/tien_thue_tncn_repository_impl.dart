// ============================================================================
// Data Layer - Repository Implementation
// Based on UC_HKD_TT88_2021 - TX-03: Tính thuế thu nhập cá nhân (TNCN)
// ============================================================================
import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/tx/data/datasources/tien_thue_local_datasource.dart';
import 'package:hkd_accounting/features/tx/domain/entities/tien_thue_tncn.dart';
import 'package:hkd_accounting/features/tx/domain/repositories/tien_thue_tncn_repository.dart';
import 'package:uuid/uuid.dart';

class TienThueTncnRepositoryImpl implements TienThueTncnRepository {
  final TienThueLocalDatasource _ds;
  final _uuid = const Uuid();

  TienThueTncnRepositoryImpl(this._ds);

  @override
  Future<Either<Failure, List<TienThueTncn>>> getByKyKeToan(String kyKeToanId) async {
    try {
      final rows = await _ds.getTienThueTncnByKy(kyKeToanId);
      if (rows.isEmpty) return const Right([]);
      return Right(rows.map(_mapRowToTncn).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TienThueTncn>>> getAll() async {
    try {
      final rows = await _ds.getTienThueTncnByKy('');
      return Right(rows.map(_mapRowToTncn).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TienThueTncn>> calculateTncn(String kyKeToanId) async {
    try {
      final doanhThuList = await _ds.getDoanhThuByKyKeToan(kyKeToanId);
      if (doanhThuList.isEmpty) {
        return Left(const DatabaseFailure('Không có dữ liệu doanh thu trong kỳ'));
      }

      int tongDoanhThu = 0;
      for (final s1 in doanhThuList) {
        tongDoanhThu += s1.doanhThu;
      }

      double tyLeTncn = 0.0;
      if (tongDoanhThu > 0) {
        final nghe = await _ds.getNgheNgheById(doanhThuList.first.nhomNgheId);
        tyLeTncn = (nghe['ty_le_thue_tncn'] as num?)?.toDouble() ?? 0.0;
      }
      final thueTncnPhaiNop = (tongDoanhThu * tyLeTncn).round();

      final row = {
        'id': _uuid.v4(),
        'ky_ke_toan_id': kyKeToanId,
        'loai_doi_tuong': 'CHU_HKD',
        'ten_nguoi_nop_thue': 'Chủ HKD',
        'tong_thu_nhap': tongDoanhThu,
        'thue_tncn_phai_nop': thueTncnPhaiNop,
        'thue_tncn_da_nop': 0,
        'trang_thai': 'DA_TINH',
        'created_at': DateTime.now().toIso8601String(),
      };

      await _ds.saveTienThueTncn(row);

      return Right(TienThueTncn(
        id: row['id'] as String,
        kyKeToanId: kyKeToanId,
        loaiDoiTuong: 'CHU_HKD',
        tenNguoiNopThue: 'Chủ HKD',
        tongThuNhap: tongDoanhThu,
        thueTncnPhaiNop: thueTncnPhaiNop,
      ));
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveTncn(TienThueTncn entity) async {
    try {
      await _ds.saveTienThueTncn({
        'id': entity.id,
        'ky_ke_toan_id': entity.kyKeToanId,
        'nguoi_dung_id': entity.nguoiDungId,
        'ten_nguoi_nop_thue': entity.tenNguoiNopThue,
        'loai_doi_tuong': entity.loaiDoiTuong,
        'tong_thu_nhap': entity.tongThuNhap,
        'thue_tncn_phai_nop': entity.thueTncnPhaiNop,
        'thue_tncn_da_nop': entity.thueTncnDaNop,
        'trang_thai': entity.trangThai,
        'created_at': DateTime.now().toIso8601String(),
      });
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateTncnDaNop(String id, int soTien) async {
    try {
      await _ds.updateTienThueTncnDaNop(id, soTien);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  TienThueTncn _mapRowToTncn(Map<String, dynamic> row) {
    return TienThueTncn(
      id: row['id'] as String,
      kyKeToanId: row['ky_ke_toan_id'] as String,
      nguoiDungId: row['nguoi_dung_id'] as String?,
      tenNguoiNopThue: row['ten_nguoi_nop_thue'] as String?,
      loaiDoiTuong: row['loai_doi_tuong'] as String? ?? 'CHU_HKD',
      tongThuNhap: row['tong_thu_nhap'] as int? ?? 0,
      thueTncnPhaiNop: row['thue_tncn_phai_nop'] as int,
      thueTncnDaNop: row['thue_tncn_da_nop'] as int? ?? 0,
      trangThai: row['trang_thai'] as String? ?? 'MOI',
    );
  }
}