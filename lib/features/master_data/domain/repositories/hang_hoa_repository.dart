// ============================================================================
// Domain Layer - Repository Interface
// Based on UC_HKD_TT88_2021 - MD-02: Quản lý danh mục hàng hóa/dịch vụ
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/hang_hoa.dart';

abstract class HangHoaRepository {
  Future<Either<Failure, List<HangHoa>>> getHangHoaList();
  Future<Either<Failure, HangHoa?>> getHangHoaById(String id);
  Future<Either<Failure, String>> saveHangHoa(HangHoa hangHoa);
  Future<Either<Failure, void>> updateHangHoa(HangHoa hangHoa);
  Future<Either<Failure, void>> deleteHangHoa(String id);
  Future<Either<Failure, List<HangHoa>>> searchHangHoa(String query);
}