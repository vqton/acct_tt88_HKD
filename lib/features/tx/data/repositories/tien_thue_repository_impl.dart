import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/sk/data/models/so_doanh_thu_model.dart';
import 'package:hkd_accounting/features/tx/data/datasources/tien_thue_local_datasource.dart';
import 'package:hkd_accounting/features/tx/domain/entities/doanh_thu_chiu_thue.dart';
import 'package:hkd_accounting/features/tx/domain/entities/tien_thue_gtgt.dart';
import 'package:hkd_accounting/features/tx/domain/repositories/tien_thue_repository.dart';
import 'package:uuid/uuid.dart';

class TienThueRepositoryImpl implements TienThueRepository {
  final TienThueLocalDatasource _ds;
  final _uuid = const Uuid();

  TienThueRepositoryImpl(this._ds);

  @override
  Future<Either<Failure, List<TienThueGtgt>>> getByKyKeToan(String kyKeToanId) async {
    try {
      final rows = await _ds.getTienThueGtgtByKy(kyKeToanId);
      if (rows.isEmpty) return const Right([]);
      return Right(rows.map(_mapRowToGtgt).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TienThueGtgt>>> getAll() async {
    try {
      final rows = await _ds.getTienThueGtgtByKy('');
      return Right(rows.map(_mapRowToGtgt).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TienThueGtgt>> calculateGtgt(String kyKeToanId) async {
    try {
      final doanhThuList = await _ds.getDoanhThuByKyKeToan(kyKeToanId);
      if (doanhThuList.isEmpty) {
        return Left(const DatabaseFailure('Không có dữ liệu doanh thu trong kỳ'));
      }

      final Map<String, Map<String, dynamic>> grouped = {};
      for (final s1 in doanhThuList) {
        final ngheId = s1.nhomNgheId;
        if (!grouped.containsKey(ngheId)) {
          final nghe = await _ds.getNgheNgheById(ngheId);
          grouped[ngheId] = {
            'ten_nhom_nghe': nghe['ten_nhom_nghe'] ?? '',
            'ty_le_thue_gtgt': nghe['ty_le_thue_gtgt'] ?? 0.0,
            'tong_doanh_thu': 0,
          };
        }
        grouped[ngheId]!['tong_doanh_thu'] =
            (grouped[ngheId]!['tong_doanh_thu'] as int) + s1.doanhThu;
      }

      final List<TienThueGtgt> results = [];
      for (final entry in grouped.entries) {
        final ngheId = entry.key;
        final data = entry.value;
        final doanhThu = data['tong_doanh_thu'] as int;
        final tyLe = data['ty_le_thue_gtgt'] as double;
        final thueGtgtPhaiNop = (doanhThu * tyLe).round();

        final row = {
          'id': _uuid.v4(),
          'ky_ke_toan_id': kyKeToanId,
          'nhom_nghe_id': ngheId,
          'ten_nhom_nghe': data['ten_nhom_nghe'],
          'ty_le_thue_gtgt': tyLe,
          'doanh_thu': doanhThu,
          'thue_gtgt_phai_nop': thueGtgtPhaiNop,
          'thue_gtgt_da_nop': 0,
          'trang_thai': 'DA_TINH',
          'created_at': DateTime.now().toIso8601String(),
        };

        await _ds.saveTienThueGtgt(row);
        results.add(TienThueGtgt(
          id: row['id'] as String,
          kyKeToanId: kyKeToanId,
          nhomNgheId: ngheId,
          tenNhomNghe: data['ten_nhom_nghe'] as String,
          tyLeThueGtgt: tyLe,
          doanhThu: doanhThu,
          thueGtgtPhaiNop: thueGtgtPhaiNop,
        ));
      }

      return Right(results.first);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveGtgt(TienThueGtgt entity) async {
    try {
      await _ds.saveTienThueGtgt({
        'id': entity.id,
        'ky_ke_toan_id': entity.kyKeToanId,
        'nhom_nghe_id': entity.nhomNgheId,
        'ten_nhom_nghe': entity.tenNhomNghe,
        'ty_le_thue_gtgt': entity.tyLeThueGtgt,
        'doanh_thu': entity.doanhThu,
        'thue_gtgt_phai_nop': entity.thueGtgtPhaiNop,
        'thue_gtgt_da_nop': entity.thueGtgtDaNop,
        'trang_thai': entity.trangThai,
        'created_at': DateTime.now().toIso8601String(),
      });
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateGtgtDaNop(String id, int soTien) async {
    try {
      await _ds.updateTienThueGtgtDaNop(id, soTien);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DoanhThuChiuThue>>> getDoanhThuChiuThue(String kyKeToanId) async {
    try {
      final doanhThuList = await _ds.getDoanhThuByKyKeToan(kyKeToanId);
      final Map<String, DoanhThuChiuThue> grouped = {};

      for (final s1 in doanhThuList) {
        final ngheId = s1.nhomNgheId;
        if (!grouped.containsKey(ngheId)) {
          final nghe = await _ds.getNgheNgheById(ngheId);
          grouped[ngheId] = DoanhThuChiuThue(
            id: _uuid.v4(),
            kyKeToanId: kyKeToanId,
            nhomNgheId: ngheId,
            tenNhomNghe: nghe['ten_nhom_nghe'] ?? '',
            tongDoanhThu: 0,
          );
        }
        grouped[ngheId] = grouped[ngheId]!.copyWith(
          tongDoanhThu: grouped[ngheId]!.tongDoanhThu + s1.doanhThu,
        );
      }

      return Right(grouped.values.toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  TienThueGtgt _mapRowToGtgt(Map<String, dynamic> row) {
    return TienThueGtgt(
      id: row['id'] as String,
      kyKeToanId: row['ky_ke_toan_id'] as String,
      nhomNgheId: row['nhom_nghe_id'] as String,
      tenNhomNghe: row['ten_nhom_nghe'] as String,
      tyLeThueGtgt: (row['ty_le_thue_gtgt'] as num).toDouble(),
      doanhThu: row['doanh_thu'] as int,
      thueGtgtPhaiNop: row['thue_gtgt_phai_nop'] as int,
      thueGtgtDaNop: row['thue_gtgt_da_nop'] as int? ?? 0,
      trangThai: row['trang_thai'] as String? ?? 'MOI',
    );
  }
}