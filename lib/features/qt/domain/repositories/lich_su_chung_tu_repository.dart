// ============================================================================
// Domain Layer - Repository Interface
// Based on UC_HKD_TT88_2021 - QT-05: Lưu trữ và tra cứu lịch sử chứng từ
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
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