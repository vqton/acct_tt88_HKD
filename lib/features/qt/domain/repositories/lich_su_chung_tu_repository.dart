import 'package:hkd_accounting/core/failures/failures.dart';
import 'package:hkd_accounting/features/qt/domain/entities/lich_su_chung_tu.dart';

abstract class LichSuChungTuRepository {
  Future<Either<Failure, List<LichSuChungTu>>> search({
    String? query,
    LoaiChungTu? loaiChungTu,
    DateTime? tuNgay,
    DateTime? denNgay,
    String? trangThai,
  });

  Future<Either<Failure, LichSuChungTu>> getById(String id);
}