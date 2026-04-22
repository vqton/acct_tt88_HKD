import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/tx/data/datasources/so_thue_local_datasource.dart';
import 'package:hkd_accounting/features/tx/domain/entities/so_thue.dart';
import 'package:hkd_accounting/features/tx/domain/repositories/so_thue_repository.dart';

class SoThueRepositoryImpl implements SoThueRepository {
  final SoThueLocalDatasource _ds;

  SoThueRepositoryImpl(this._ds);

  @override
  Future<Either<Failure, List<SoThue>>> getByKyKeToan(String kyKeToanId) async {
    try {
      final rows = await _ds.getByKyKeToan(kyKeToanId);
      if (rows.isEmpty) return const Right([]);
      return Right(rows.map(_mapRow).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SoThue>>> getAll() async {
    try {
      final rows = await _ds.getAll();
      return Right(rows.map(_mapRow).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SoThue>> create(SoThue entity) async {
    try {
      await _ds.save(_mapToRow(entity));
      return Right(entity);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> update(SoThue entity) async {
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

  @override
  Future<Either<Failure, SoThue>> getTongHop(String kyKeToanId) async {
    try {
      final rows = await _ds.getByKyKeToan(kyKeToanId);
      if (rows.isEmpty) {
        return Right(SoThue(
          id: '',
          kyKeToanId: kyKeToanId,
          ngayChungTu: DateTime.now(),
          dienGiai: 'Tổng hợp thuế kỳ kế toán',
        ));
      }

      int thueGtgtPhaiNop = 0;
      int thueGtgtDaNop = 0;
      int thueTncnPhaiNop = 0;
      int thueTncnDaNop = 0;

      for (final row in rows) {
        thueGtgtPhaiNop += row['thue_gtgt_phai_nop'] as int? ?? 0;
        thueGtgtDaNop += row['thue_gtgt_da_nop'] as int? ?? 0;
        thueTncnPhaiNop += row['thue_tncn_phai_nop'] as int? ?? 0;
        thueTncnDaNop += row['thue_tncn_da_nop'] as int? ?? 0;
      }

      return Right(SoThue(
        id: rows.first['id'] as String,
        kyKeToanId: kyKeToanId,
        soHieuChungTu: rows.first['so_hieu_chung_tu'] as String?,
        ngayChungTu: DateTime.parse(rows.first['ngay_chung_tu'] as String),
        dienGiai: rows.first['dien_giai'] as String? ?? '',
        thueGtgtPhaiNop: thueGtgtPhaiNop,
        thueGtgtDaNop: thueGtgtDaNop,
        thueTncnPhaiNop: thueTncnPhaiNop,
        thueTncnDaNop: thueTncnDaNop,
        thueGtgtConPhaiNop: thueGtgtPhaiNop - thueGtgtDaNop,
        thueTncnConPhaiNop: thueTncnPhaiNop - thueTncnDaNop,
        trangThai: rows.first['trang_thai'] as String? ?? 'MOI',
      ));
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  Map<String, dynamic> _mapToRow(SoThue entity) {
    return {
      'id': entity.id,
      'ky_ke_toan_id': entity.kyKeToanId,
      'so_hieu_chung_tu': entity.soHieuChungTu,
      'ngay_chung_tu': entity.ngayChungTu.toIso8601String(),
      'dien_giai': entity.dienGiai,
      'thue_gtgt_phai_nop': entity.thueGtgtPhaiNop,
      'thue_gtgt_da_nop': entity.thueGtgtDaNop,
      'thue_tncn_phai_nop': entity.thueTncnPhaiNop,
      'thue_tncn_da_nop': entity.thueTncnDaNop,
      'thue_gtgt_con_phai_nop': entity.thueGtgtConPhaiNop,
      'thue_tncn_con_phai_nop': entity.thueTncnConPhaiNop,
      'trang_thai': entity.trangThai,
      'created_at': DateTime.now().toIso8601String(),
    };
  }

  SoThue _mapRow(Map<String, dynamic> row) {
    return SoThue(
      id: row['id'] as String,
      kyKeToanId: row['ky_ke_toan_id'] as String,
      soHieuChungTu: row['so_hieu_chung_tu'] as String?,
      ngayChungTu: DateTime.parse(row['ngay_chung_tu'] as String),
      dienGiai: row['dien_giai'] as String? ?? '',
      thueGtgtPhaiNop: row['thue_gtgt_phai_nop'] as int? ?? 0,
      thueGtgtDaNop: row['thue_gtgt_da_nop'] as int? ?? 0,
      thueTncnPhaiNop: row['thue_tncn_phai_nop'] as int? ?? 0,
      thueTncnDaNop: row['thue_tncn_da_nop'] as int? ?? 0,
      thueGtgtConPhaiNop: row['thue_gtgt_con_phai_nop'] as int? ?? 0,
      thueTncnConPhaiNop: row['thue_tncn_con_phai_nop'] as int? ?? 0,
      trangThai: row['trang_thai'] as String? ?? 'MOI',
    );
  }
}