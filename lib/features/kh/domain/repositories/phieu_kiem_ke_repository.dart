// ============================================================================
// Domain Layer - Repository Interface
// Based on UC_HKD_TT88_2021 - KH-03: Kiểm kê hàng tồn kho
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/kh/domain/entities/phieu_kiem_ke.dart';

abstract class PhieuKiemKeRepository {
  Future<Either<Failure, List<PhieuKiemKe>>> getPhieuKiemKeList();
  Future<Either<Failure, PhieuKiemKe?>> getPhieuKiemKeById(String id);
  Future<Either<Failure, String>> savePhieuKiemKe(PhieuKiemKe phieuKiemKe);
  Future<Either<Failure, void>> updatePhieuKiemKe(PhieuKiemKe phieuKiemKe);
  Future<Either<Failure, void>> deletePhieuKiemKe(String id);
  Future<Either<Failure, List<ChiTietKiemKe>>> getChiTietByPhieuId(String phieuId);
  Future<Either<Failure, void>> saveChiTietKiemKe(ChiTietKiemKe chiTietKiemKe);
  Future<Either<Failure, void>> updateChiTietKiemKe(ChiTietKiemKe chiTietKiemKe);
}