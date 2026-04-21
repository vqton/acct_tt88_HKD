// ============================================================================
// Domain Layer - Repository Interface
// Based on UC_HKD_TT88_2021 - CT-06: Quản lý hóa đơn
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/ct/domain/entities/hoa_don.dart';

abstract class HoaDonRepository {
  Future<Either<Failure, HoaDon>> createHoaDon(HoaDon hoaDon);
  Future<Either<Failure, HoaDon?>> getHoaDonById(String id);
  Future<Either<Failure, List<HoaDon>>> getHoaDonList();
  Future<Either<Failure, List<HoaDon>>> getHoaDonByLoai(String loaiHoaDon);
  Future<Either<Failure, void>> updateHoaDon(HoaDon hoaDon);
  Future<Either<Failure, void>> deleteHoaDon(String id);
  Future<Either<Failure, List<HoaDon>>> searchHoaDon(String query);
  Future<Either<Failure, void>> approveHoaDon(String id);
}
