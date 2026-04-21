// ============================================================================
// Domain Layer - Repository Interface
// Based on UC_HKD_TT88_2021 - MD-07: Quản lý danh mục tài khoản ngân hàng
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/tai_khoan_ngan_hang.dart';

abstract class TaiKhoanNganHangRepository {
  Future<Either<Failure, List<TaiKhoanNganHang>>> getTaiKhoanNganHangList();
  Future<Either<Failure, TaiKhoanNganHang?>> getTaiKhoanNganHangById(String id);
  Future<Either<Failure, String>> saveTaiKhoanNganHang(TaiKhoanNganHang taiKhoanNganHang);
  Future<Either<Failure, void>> updateTaiKhoanNganHang(TaiKhoanNganHang taiKhoanNganHang);
  Future<Either<Failure, void>> deleteTaiKhoanNganHang(String id);
  Future<Either<Failure, List<TaiKhoanNganHang>>> searchTaiKhoanNganHang(String query);
}