// ============================================================================
// Domain Layer - Repository Interface
// Based on UC_HKD_TT88_2021 - CT-04: Lập phiếu xuất kho
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_xuat_kho.dart';

abstract class PhieuXuatKhoRepository {
  Future<Either<Failure, PhieuXuatKho>> createPhieuXuatKho(
      PhieuXuatKho phieuXuatKho);
  Future<Either<Failure, PhieuXuatKho?>> getPhieuXuatKhoById(String id);
  Future<Either<Failure, List<PhieuXuatKho>>> getPhieuXuatKhoList();
  Future<Either<Failure, void>> updatePhieuXuatKho(PhieuXuatKho phieuXuatKho);
  Future<Either<Failure, void>> deletePhieuXuatKho(String id);
  Future<Either<Failure, List<PhieuXuatKho>>> searchPhieuXuatKho(String query);
  Future<Either<Failure, void>> approvePhieuXuatKho(String id);
}
