// ============================================================================
// Domain Layer - Repository Interface
// Based on UC_HKD_TT88_2021 - MD-03
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/nghe_nghiep.dart';

abstract class NgheNghiepRepository {
  Future<Either<Failure, List<NgheNghiep>>> getNgheNghiepList();
  Future<Either<Failure, NgheNghiep?>> getNgheNghiepById(String id);
  Future<Either<Failure, String>> saveNgheNghiep(NgheNghiep ngheNghieu);
  Future<Either<Failure, void>> updateNgheNghiep(NgheNghiep ngheNghieu);
  Future<Either<Failure, void>> deleteNgheNghiep(String id);
  Future<Either<Failure, NgheNghiep?>> getApplicableNgheNghiep(DateTime date);
}