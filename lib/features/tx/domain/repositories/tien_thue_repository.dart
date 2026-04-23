// ============================================================================
// Domain Layer - Repository Interface
// Based on UC_HKD_TT88_2021 - TX-03 Tiền thuế GTGT
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/tx/domain/entities/doanh_thu_chiu_thue.dart';
import 'package:hkd_accounting/features/tx/domain/entities/tien_thue_gtgt.dart';

abstract class TienThueRepository {
  Future<Either<Failure, List<TienThueGtgt>>> getByKyKeToan(String kyKeToanId);
  Future<Either<Failure, List<TienThueGtgt>>> getAll();
  Future<Either<Failure, TienThueGtgt>> calculateGtgt(String kyKeToanId);
  Future<Either<Failure, void>> saveGtgt(TienThueGtgt entity);
  Future<Either<Failure, void>> updateGtgtDaNop(String id, int soTien);
  Future<Either<Failure, List<DoanhThuChiuThue>>> getDoanhThuChiuThue(String kyKeToanId);
}