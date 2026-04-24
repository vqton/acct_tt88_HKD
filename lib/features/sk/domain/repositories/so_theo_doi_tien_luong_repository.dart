// ============================================================================
// Domain Layer - Repository Interface
// Based on UC_HKD_TT88_2021 - SK-06: Ghi sổ theo dõi thanh toán tiền lương (S5-HKD)
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/sk/domain/entities/so_theo_doi_tien_luong.dart';

abstract class SoTheoDoiTienLuongRepository {
  Future<Either<Failure, String>> create(SoTheoDoiTienLuong entity);
  Future<Either<Failure, SoTheoDoiTienLuong?>> getById(String id);
  Future<Either<Failure, List<SoTheoDoiTienLuong>>> getList();
  Future<Either<Failure, List<SoTheoDoiTienLuong>>> getByKyKeToanId(String kyKeToanId);
  Future<Either<Failure, List<SoTheoDoiTienLuong>>> getByBangLuongId(String bangLuongId);
  Future<Either<Failure, void>> update(SoTheoDoiTienLuong entity);
  Future<Either<Failure, void>> delete(String id);
  Future<Either<Failure, void>> updateThanhToan(String id, double soTien);
  Future<Either<Failure, void>> updateBhxhNop(String id, double bhxhDaNop, double bhytDaNop, double bhtnDaNop);
}