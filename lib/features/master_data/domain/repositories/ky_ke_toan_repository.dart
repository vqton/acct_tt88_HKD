// ============================================================================
// Domain Layer - Repository Interface
// Based on UC_HKD_TT88_2021 - MD-08: Cấu hình kỳ kế toán
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/ky_ke_toan.dart';

abstract class KyKeToanRepository {
  Future<Either<Failure, KyKeToan?>> getKyKeToan();
  Future<Either<Failure, String>> saveKyKeToan(KyKeToan kyKeToan);
  Future<Either<Failure, void>> updateKyKeToan(KyKeToan kyKeToan);
  Future<Either<Failure, void>> deleteKyKeToan(String id);
}