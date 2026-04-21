// ============================================================================
// Data Layer - Repository Implementation
// Based on UC_HKD_TT88_2021 - KH-04: Tính giá xuất kho
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/kh/data/datasources/ton_kho_local_datasource.dart';
import 'package:hkd_accounting/features/kh/data/models/ton_kho_model.dart';
import 'package:hkd_accounting/features/kh/domain/entities/ton_kho.dart';
import 'package:hkd_accounting/features/kh/domain/repositories/ton_kho_repository.dart';

class TonKhoRepositoryImpl implements TonKhoRepository {
  final TonKhoLocalDatasource localDatasource;

  TonKhoRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, TonKho>> getTonKho(
      String kyKeToanId, String hangHoaId) async {
    try {
      final tonKho = await localDatasource.getTonKho(kyKeToanId, hangHoaId);
      return Right(tonKho?.toEntity() ??
          TonKho(
            id: '${kyKeToanId}_$hangHoaId',
            kyKeToanId: kyKeToanId,
            hangHoaId: hangHoaId,
          ));
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TonKho>>> getTonKhoList(
      String kyKeToanId) async {
    try {
      final tonKhoList = await localDatasource.getTonKhoList(kyKeToanId);
      return Right(tonKhoList.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveTonKho(TonKho tonKho) async {
    try {
      await localDatasource.saveTonKho(TonKhoModel.fromEntity(tonKho));
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateAfterNhapKho(
      String hangHoaId, double soLuong, int thanhTien) async {
    try {
      // This would be called when a goods receipt is approved
      // Implementation would update ton_kho table
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateAfterXuatKho(
      String hangHoaId, double soLuong) async {
    try {
      // This would be called when a goods issue is created
      // Implementation would calculate COGS and update ton_kho
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PhieuNhapKhoLot>>> getPhieuNhapKhoLots(
      String hangHoaId) async {
    try {
      final lots = await localDatasource.getPhieuNhapKhoLots(hangHoaId);
      return Right(lots.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}