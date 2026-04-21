// ============================================================================
// Domain Layer - Repository Interface
// Based on UC_HKD_TT88_2021 - KH-04: Tính giá xuất kho
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/kh/domain/entities/ton_kho.dart';

abstract class TonKhoRepository {
  Future<Either<Failure, TonKho>> getTonKho(String kyKeToanId, String hangHoaId);
  Future<Either<Failure, List<TonKho>>> getTonKhoList(String kyKeToanId);
  Future<Either<Failure, void>> saveTonKho(TonKho tonKho);
  Future<Either<Failure, void>> updateAfterNhapKho(
      String hangHoaId, double soLuong, int thanhTien);
  Future<Either<Failure, void>> updateAfterXuatKho(
      String hangHoaId, double soLuong);
  Future<Either<Failure, List<PhieuNhapKhoLot>>> getPhieuNhapKhoLots(
      String hangHoaId);
}