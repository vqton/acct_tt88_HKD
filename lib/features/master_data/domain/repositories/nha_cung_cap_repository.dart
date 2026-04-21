// ============================================================================
// Domain Layer - Repository Interface
// Based on UC_HKD_TT88_2021 - MD-04: Quản lý danh mục nhà cung cấp
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/nha_cung_cap.dart';

abstract class NhaCungCapRepository {
  Future<Either<Failure, List<NhaCungCap>>> getNhaCungCapList();
  Future<Either<Failure, NhaCungCap?>> getNhaCungCapById(String id);
  Future<Either<Failure, String>> saveNhaCungCap(NhaCungCap nhaCungCap);
  Future<Either<Failure, void>> updateNhaCungCap(NhaCungCap nhaCungCap);
  Future<Either<Failure, void>> deleteNhaCungCap(String id);
  Future<Either<Failure, List<NhaCungCap>>> searchNhaCungCap(String query);
}