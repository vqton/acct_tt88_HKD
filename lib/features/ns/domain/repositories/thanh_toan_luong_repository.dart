// ============================================================================
// Domain Layer - Repository Interface
// Based on UC_HKD_TT88_2021 - NS-03: Theo dõi và thanh toán lương
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/ns/domain/entities/thanh_toan_luong.dart';

abstract class ThanhToanLuongRepository {
  Future<Either<Failure, String>> create(ThanhToanLuong entity);
  Future<Either<Failure, ThanhToanLuong?>> getById(String id);
  Future<Either<Failure, List<ThanhToanLuong>>> getList();
  Future<Either<Failure, List<ThanhToanLuong>>> getByBangLuongId(String bangLuongId);
  Future<Either<Failure, void>> update(ThanhToanLuong entity);
  Future<Either<Failure, void>> delete(String id);
  Future<Either<Failure, void>> updateThanhToan(String id, double soTienChuyenKhoan, double soTienMat);
}