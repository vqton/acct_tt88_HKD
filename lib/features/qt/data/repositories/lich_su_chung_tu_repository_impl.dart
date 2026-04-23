import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/qt/data/datasources/lich_su_chung_tu_local_datasource.dart';
import 'package:hkd_accounting/features/qt/domain/entities/lich_su_chung_tu.dart';
import 'package:hkd_accounting/features/qt/domain/repositories/lich_su_chung_tu_repository.dart';

class LichSuChungTuRepositoryImpl implements LichSuChungTuRepository {
  final LichSuChungTuLocalDatasource _datasource;

  LichSuChungTuRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, List<LichSuChungTu>>> search({
    String? query,
    LoaiChungTu? loaiChungTu,
    DateTime? tuNgay,
    DateTime? denNgay,
    String? trangThai,
  }) async {
    try {
      final results = await _datasource.search(
        query: query,
        loaiChungTu: loaiChungTu,
        tuNgay: tuNgay,
        denNgay: denNgay,
        trangThai: trangThai,
      );

      if (loaiChungTu != null) {
        return Right(results.where((item) => item.loaiChungTu == loaiChungTu).toList());
      }

      return Right(results);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LichSuChungTu>> getById(String id) async {
    try {
      final results = await _datasource.search(query: id);
      final found = results.where((item) => item.id == id).firstOrNull;
      if (found != null) {
        return Right(found);
      }
      return Left(NotFoundFailure('Không tìm thấy chứng từ'));
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}