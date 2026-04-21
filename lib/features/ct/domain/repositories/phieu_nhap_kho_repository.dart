// ============================================================================
// Domain Layer - Repository Interface
// Based on UC_HKD_TT88_2021 - CT-03: Lập phiếu nhập kho
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_nhap_kho.dart';

abstract class PhieuNhapKhoRepository {
  Future<Either<Failure, PhieuNhapKho>> createPhieuNhapKho(
      PhieuNhapKho phieuNhapKho);
  Future<Either<Failure, PhieuNhapKho?>> getPhieuNhapKhoById(String id);
  Future<Either<Failure, List<PhieuNhapKho>>> getPhieuNhapKhoList();
  Future<Either<Failure, void>> updatePhieuNhapKho(PhieuNhapKho phieuNhapKho);
  Future<Either<Failure, void>> deletePhieuNhapKho(String id);
  Future<Either<Failure, List<PhieuNhapKho>>> searchPhieuNhapKho(String query);
  Future<Either<Failure, void>> approvePhieuNhapKho(String id);
}
