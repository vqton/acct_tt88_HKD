// ============================================================================
// Domain Layer - SK-02: Sổ doanh thu (S1-HKD) - Repository
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/sk/domain/entities/so_doanh_thu.dart';

abstract class SoDoanhThuRepository {
  Future<Either<Failure, SoDoanhThu>> create(SoDoanhThu entity);
  Future<Either<Failure, List<SoDoanhThu>>> getByKyKeToan(String kyKeToanId);
  Future<Either<Failure, List<SoDoanhThu>>> getAll();
  Future<Either<Failure, void>> update(SoDoanhThu entity);
  Future<Either<Failure, void>> delete(String id);
}