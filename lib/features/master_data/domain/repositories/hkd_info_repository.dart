// ============================================================================
// Domain Layer - Repository Interface
// Based on UC_HKD_TT88_2021 - MD-01
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/hkd_info.dart';

abstract class HkdInfoRepository {
  Future<Either<Failure, HkdInfo?>> getHkdInfo();
  Future<Either<Failure, String>> saveHkdInfo(HkdInfo hkdInfo);
  Future<Either<Failure, void>> updateHkdInfo(HkdInfo hkdInfo);
  Future<Either<Failure, void>> deleteHkdInfo(String id);
}
