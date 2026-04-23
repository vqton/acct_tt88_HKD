// ============================================================================
// Domain Layer - Repository Interface
// Based on UC_HKD_TT88_2021 - TX-01 Phiếu nộp thuế
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/tx/domain/entities/phieu_nop_thue.dart';

abstract class PhieuNopThueRepository {
  Future<Either<Failure, List<PhieuNopThue>>> getByKyKeToan(String kyKeToanId);
  Future<Either<Failure, List<PhieuNopThue>>> getAll();
  Future<Either<Failure, PhieuNopThue>> create(PhieuNopThue entity);
  Future<Either<Failure, void>> update(PhieuNopThue entity);
  Future<Either<Failure, void>> delete(String id);
}