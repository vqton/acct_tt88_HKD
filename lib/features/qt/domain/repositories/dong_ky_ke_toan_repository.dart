// ============================================================================
// Domain Layer - Repository Interface
// Based on UC_HKD_TT88_2021 - QT-03: Đóng kỳ kế toán và khóa sổ
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/qt/domain/entities/dong_ky_ke_toan.dart';

abstract class DongKyKeToanRepository {
  Future<Either<Failure, String>> create(DongKyKeToan entity);
  Future<Either<Failure, DongKyKeToan?>> getCurrent();
  Future<Either<Failure, List<DongKyKeToan>>> getList();
  Future<Either<Failure, void>> update(DongKyKeToan entity);
  Future<Either<Failure, void>> delete(String id);
}