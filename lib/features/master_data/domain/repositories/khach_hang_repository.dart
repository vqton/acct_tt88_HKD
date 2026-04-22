// ============================================================================
// Domain Layer - Repository Interface
// Based on UC_HKD_TT88_2021 - MD-05: Quản lý danh mục khách hàng
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/khach_hang.dart';

abstract class KhachHangRepository {
  Future<Either<Failure, List<KhachHang>>> getKhachHangList();
  Future<Either<Failure, KhachHang?>> getKhachHangById(String id);
  Future<Either<Failure, String>> saveKhachHang(KhachHang khachHang);
  Future<Either<Failure, void>> updateKhachHang(KhachHang khachHang);
  Future<Either<Failure, void>> deleteKhachHang(String id);
  Future<Either<Failure, List<KhachHang>>> searchKhachHang(String query);
}
