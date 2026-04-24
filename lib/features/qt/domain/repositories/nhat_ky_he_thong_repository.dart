// ============================================================================
// Domain Layer - Repository Interface
// Based on UC_HKD_TT88_2021 - QT-06: Nhật ký hệ thống và Audit Trail
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/qt/domain/entities/nhat_ky_he_thong.dart';

abstract class NhatKyHeThongRepository {
  Future<Either<Failure, String>> create(NhatKyHeThong entity);
  Future<Either<Failure, List<NhatKyHeThong>>> getList({int? limit, int? offset});
  Future<Either<Failure, List<NhatKyHeThong>>> getByUserId(String userId);
  Future<Either<Failure, List<NhatKyHeThong>>> getByDoiTuong(String doiTuongLoai, String doiTuongId);
  Future<Either<Failure, List<NhatKyHeThong>>> getByDateRange(DateTime from, DateTime to);
  Future<Either<Failure, List<NhatKyHeThong>>> getByHanhDong(HanhDong hanhDong);
  Future<Either<Failure, NhatKyHeThong?>> getById(String id);
  Future<Either<Failure, int>> getCount();
}