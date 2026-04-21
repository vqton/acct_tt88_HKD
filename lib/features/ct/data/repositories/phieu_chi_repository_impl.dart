// ============================================================================
// Data Layer - Repository Implementation
// Based on UC_HKD_TT88_2021 - CT-02: Lập phiếu chi
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/ct/data/datasources/phieu_chi_local_datasource.dart';
import 'package:hkd_accounting/features/ct/data/models/phieu_chi_model.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_chi.dart';
import 'package:hkd_accounting/features/ct/domain/repositories/phieu_chi_repository.dart';

class PhieuChiRepositoryImpl implements PhieuChiRepository {
  final PhieuChiLocalDatasource localDatasource;

  PhieuChiRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, PhieuChi>> createPhieuChi(PhieuChi phieuChi) async {
    try {
      final id = await localDatasource.savePhieuChi(
        PhieuChiModel.fromEntity(phieuChi),
      );
      final createdPhieuChi = await localDatasource.getPhieuChiById(id);
      return Right(createdPhieuChi!.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PhieuChi?>> getPhieuChiById(String id) async {
    try {
      final phieuChi = await localDatasource.getPhieuChiById(id);
      return Right(phieuChi?.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PhieuChi>>> getPhieuChiList() async {
    try {
      final phieuChiList = await localDatasource.getPhieuChiList();
      return Right(phieuChiList.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updatePhieuChi(PhieuChi phieuChi) async {
    try {
      await localDatasource.updatePhieuChi(
        PhieuChiModel.fromEntity(phieuChi),
      );
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePhieuChi(String id) async {
    try {
      await localDatasource.deletePhieuChi(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}