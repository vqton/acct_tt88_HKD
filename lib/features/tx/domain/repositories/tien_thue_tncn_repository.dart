// ============================================================================
// Domain Layer - Repository Interface
// Based on UC_HKD_TT88_2021 - TX-04 Tiền thuế TNCN
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/tx/domain/entities/tien_thue_tncn.dart';

abstract class TienThueTncnRepository {
  Future<Either<Failure, List<TienThueTncn>>> getByKyKeToan(String kyKeToanId);
  Future<Either<Failure, List<TienThueTncn>>> getAll();
  Future<Either<Failure, TienThueTncn>> calculateTncn(String kyKeToanId);
  Future<Either<Failure, void>> saveTncn(TienThueTncn entity);
  Future<Either<Failure, void>> updateTncnDaNop(String id, int soTien);
}