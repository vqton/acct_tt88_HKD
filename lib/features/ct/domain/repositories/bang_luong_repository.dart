// ============================================================================
// Domain Layer - Repository Interface
// Based on UC_HKD_TT88_2021 - CT-05: Lập bảng thanh toán tiền lương & thu nhập NLĐ
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/ct/domain/entities/bang_luong.dart';

abstract class BangLuongRepository {
  Future<Either<Failure, BangLuong>> create(BangLuong bangLuong);
  Future<Either<Failure, BangLuong?>> getById(String id);
  Future<Either<Failure, List<BangLuong>>> getList();
  Future<Either<Failure, List<BangLuong>>> getByKyKeToan(String kyKeToanId);
  Future<Either<Failure, void>> update(BangLuong bangLuong);
  Future<Either<Failure, void>> delete(String id);
  Future<Either<Failure, BangLuong>> approve(String id, String nguoiDuyet);
  Future<Either<Failure, ChiTietBangLuong>> addChiTiet(ChiTietBangLuong chiTiet);
  Future<Either<Failure, void>> deleteChiTiet(String chiTietId);
}