// ============================================================================
// Data Layer - Repository Implementation
// Based on UC_HKD_TT88_2021 - CT-01: Lập phiếu thu
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/ct/data/datasources/phieu_thu_local_datasource.dart';
import 'package:hkd_accounting/features/ct/data/models/phieu_thu_model.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_thu.dart';
import 'package:hkd_accounting/features/ct/domain/repositories/phieu_thu_repository.dart';

class PhieuThuRepositoryImpl implements PhieuThuRepository {
  final PhieuThuLocalDatasource localDatasource;

  PhieuThuRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, PhieuThu>> createPhieuThu(PhieuThu phieuThu) async {
    try {
      await localDatasource.createPhieuThu(
        PhieuThuModel.fromEntity(phieuThu),
      );
      return Right(phieuThu);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PhieuThu?>> getPhieuThuById(String id) async {
    try {
      final phieuThu = await localDatasource.getPhieuThuById(id);
      return Right(phieuThu?.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PhieuThu>>> getPhieuThuList() async {
    try {
      final phieuThus = await localDatasource.getPhieuThuList();
      return Right(phieuThus.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updatePhieuThu(PhieuThu phieuThu) async {
    try {
      await localDatasource.updatePhieuThu(
        PhieuThuModel.fromEntity(phieuThu),
      );
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePhieuThu(String id) async {
    try {
      await localDatasource.deletePhieuThu(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}