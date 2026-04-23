// ============================================================================
// Data Layer - Repository Implementation
// Based on UC_HKD_TT88_2021 - KH-03: Kiểm kê hàng tồn kho
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/kh/data/datasources/phieu_kiem_ke_local_datasource.dart';
import 'package:hkd_accounting/features/kh/data/models/phieu_kiem_ke_model.dart';
import 'package:hkd_accounting/features/kh/domain/entities/phieu_kiem_ke.dart';
import 'package:hkd_accounting/features/kh/domain/repositories/phieu_kiem_ke_repository.dart';

class PhieuKiemKeRepositoryImpl implements PhieuKiemKeRepository {
  final PhieuKiemKeLocalDatasource localDatasource;

  PhieuKiemKeRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, List<PhieuKiemKe>>> getPhieuKiemKeList() async {
    try {
      final phieuKiemKeModels = await localDatasource.getPhieuKiemKeList();
      final phieuKiemKeList = phieuKiemKeModels.map((model) => model.toEntity()).toList();
      return Right(phieuKiemKeList);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PhieuKiemKe?>> getPhieuKiemKeById(String id) async {
    try {
      final phieuKiemKeModel = await localDatasource.getPhieuKiemKeById(id);
      if (phieuKiemKeModel != null) {
        return Right(phieuKiemKeModel.toEntity());
      } else {
        return Right(null);
      }
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> savePhieuKiemKe(PhieuKiemKe phieuKiemKe) async {
    try {
      final phieuKiemKeModel = PhieuKiemKeModel.fromEntity(phieuKiemKe);
      final id = await localDatasource.savePhieuKiemKe(phieuKiemKeModel);
      return Right(id);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updatePhieuKiemKe(PhieuKiemKe phieuKiemKe) async {
    try {
      final phieuKiemKeModel = PhieuKiemKeModel.fromEntity(phieuKiemKe);
      await localDatasource.updatePhieuKiemKe(phieuKiemKeModel);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePhieuKiemKe(String id) async {
    try {
      await localDatasource.deletePhieuKiemKe(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ChiTietKiemKe>>> getChiTietByPhieuId(String phieuId) async {
    try {
      final chiTietModels = await localDatasource.getChiTietByPhieuId(phieuId);
      final chiTietList = chiTietModels.map((model) => model.toEntity()).toList();
      return Right(chiTietList);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveChiTietKiemKe(ChiTietKiemKe chiTietKiemKe) async {
    try {
      final chiTietModel = ChiTietKiemKeModel.fromEntity(chiTietKiemKe);
      await localDatasource.saveChiTietKiemKe(chiTietModel);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateChiTietKiemKe(ChiTietKiemKe chiTietKiemKe) async {
    try {
      final chiTietModel = ChiTietKiemKeModel.fromEntity(chiTietKiemKe);
      await localDatasource.updateChiTietKiemKe(chiTietModel);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}