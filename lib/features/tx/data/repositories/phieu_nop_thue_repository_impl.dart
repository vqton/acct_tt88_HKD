// ============================================================================
// Data Layer - Repository Implementation
// Based on UC_HKD_TT88_2021 - TX-04: Theo dõi nộp thuế vào NSNN
// ============================================================================
import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/tx/data/datasources/phieu_nop_thue_local_datasource.dart';
import 'package:hkd_accounting/features/tx/domain/entities/phieu_nop_thue.dart';
import 'package:hkd_accounting/features/tx/domain/repositories/phieu_nop_thue_repository.dart';

class PhieuNopThueRepositoryImpl implements PhieuNopThueRepository {
  final PhieuNopThueLocalDatasource _ds;

  PhieuNopThueRepositoryImpl(this._ds);

  @override
  Future<Either<Failure, List<PhieuNopThue>>> getByKyKeToan(String kyKeToanId) async {
    try {
      final rows = await _ds.getByKyKeToan(kyKeToanId);
      if (rows.isEmpty) return const Right([]);
      return Right(rows.map(_mapRow).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PhieuNopThue>>> getAll() async {
    try {
      final rows = await _ds.getAll();
      return Right(rows.map(_mapRow).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PhieuNopThue>> create(PhieuNopThue entity) async {
    try {
      await _ds.save(_mapToRow(entity));
      return Right(entity);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> update(PhieuNopThue entity) async {
    try {
      await _ds.update(_mapToRow(entity));
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> delete(String id) async {
    try {
      await _ds.delete(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  Map<String, dynamic> _mapToRow(PhieuNopThue entity) {
    return {
      'id': entity.id,
      'ky_ke_toan_id': entity.kyKeToanId,
      'loai_thue': entity.loaiThue.name,
      'ngay_nop': entity.ngayNop.toIso8601String(),
      'so_tien_gtgt': entity.soTienGtgt,
      'so_tien_tncn': entity.soTienTncn,
      'tong_tien': entity.tongTien,
      'so_giay_nop_tien': entity.soGiayNopTien,
      'hinh_thuc_nop': entity.hinhThucNop,
      'ngan_hang_nop': entity.nganHangNop,
      'dien_giai': entity.dienGiai,
      'trang_thai': entity.trangThai,
      'created_at': DateTime.now().toIso8601String(),
    };
  }

  PhieuNopThue _mapRow(Map<String, dynamic> row) {
    return PhieuNopThue(
      id: row['id'] as String,
      kyKeToanId: row['ky_ke_toan_id'] as String,
      loaiThue: LoaiThue.values.firstWhere(
        (e) => e.name == row['loai_thue'],
        orElse: () => LoaiThue.gtgt,
      ),
      ngayNop: DateTime.parse(row['ngay_nop'] as String),
      soTienGtgt: row['so_tien_gtgt'] as int? ?? 0,
      soTienTncn: row['so_tien_tncn'] as int? ?? 0,
      tongTien: row['tong_tien'] as int,
      soGiayNopTien: row['so_giay_nop_tien'] as String? ?? '',
      hinhThucNop: row['hinh_thuc_nop'] as String? ?? 'CHUYEN_KHOAN',
      nganHangNop: row['ngan_hang_nop'] as String? ?? '',
      dienGiai: row['dien_giai'] as String? ?? '',
      trangThai: row['trang_thai'] as String? ?? 'DA_NOP',
    );
  }
}