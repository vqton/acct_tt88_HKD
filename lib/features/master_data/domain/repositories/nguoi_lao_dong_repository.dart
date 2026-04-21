// ============================================================================
// Domain Layer - Repository Interface
// Based on UC_HKD_TT88_2021 - MD-06: Quản lý danh mục người lao động
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/nguoi_lao_dong.dart';

abstract class NguoiLaoDongRepository {
  Future<Either<Failure, List<NguoiLaoDong>>> getNguoiLaoDongList();
  Future<Either<Failure, NguoiLaoDong?>> getNguoiLaoDongById(String id);
  Future<Either<Failure, String>> saveNguoiLaoDong(NguoiLaoDong nguoiLaoDong);
  Future<Either<Failure, void>> updateNguoiLaoDong(NguoiLaoDong nguoiLaoDong);
  Future<Either<Failure, void>> deleteNguoiLaoDong(String id);
  Future<Either<Failure, List<NguoiLaoDong>>> searchNguoiLaoDong(String query);
}