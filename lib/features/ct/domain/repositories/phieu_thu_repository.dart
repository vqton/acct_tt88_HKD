// ============================================================================
// Domain Layer - Repository Interfaces
// Based on UC_HKD_TT88_2021 - CT-01: Lập phiếu thu
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_thu.dart';

abstract class PhieuThuRepository {
  Future<Either<Failure, PhieuThu>> createPhieuThu(PhieuThu phieuThu);
  Future<Either<Failure, PhieuThu?>> getPhieuThuById(String id);
  Future<Either<Failure, List<PhieuThu>>> getPhieuThuList();
  Future<Either<Failure, void>> updatePhieuThu(PhieuThu phieuThu);
  Future<Either<Failure, void>> deletePhieuThu(String id);
}