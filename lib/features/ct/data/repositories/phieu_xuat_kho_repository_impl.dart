// ============================================================================
// Data Layer - Repository Implementation
// Based on UC_HKD_TT88_2021 - CT-04: Lập phiếu xuất kho
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/ct/data/datasources/phieu_xuat_kho_local_datasource.dart';
import 'package:hkd_accounting/features/ct/data/models/phieu_xuat_kho_model.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_xuat_kho.dart';
import 'package:hkd_accounting/features/ct/domain/repositories/phieu_xuat_kho_repository.dart';

class PhieuXuatKhoRepositoryImpl implements PhieuXuatKhoRepository {
  final PhieuXuatKhoLocalDatasource localDatasource;

  PhieuXuatKhoRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, PhieuXuatKho>> createPhieuXuatKho(
      PhieuXuatKho phieuXuatKho) async {
    try {
      final id = await localDatasource.savePhieuXuatKho(
        PhieuXuatKhoModel.fromEntity(phieuXuatKho),
      );
      final createdPhieuXuatKho = await localDatasource.getPhieuXuatKhoById(id);
      return Right(createdPhieuXuatKho!.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PhieuXuatKho?>> getPhieuXuatKhoById(String id) async {
    try {
      final phieuXuatKho = await localDatasource.getPhieuXuatKhoById(id);
      return Right(phieuXuatKho?.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PhieuXuatKho>>> getPhieuXuatKhoList() async {
    try {
      final phieuXuatKhoList = await localDatasource.getPhieuXuatKhoList();
      return Right(phieuXuatKhoList.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updatePhieuXuatKho(
      PhieuXuatKho phieuXuatKho) async {
    try {
      await localDatasource.updatePhieuXuatKho(
        PhieuXuatKhoModel.fromEntity(phieuXuatKho),
      );
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePhieuXuatKho(String id) async {
    try {
      await localDatasource.deletePhieuXuatKho(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PhieuXuatKho>>> searchPhieuXuatKho(
      String query) async {
    try {
      final phieuXuatKhoList = await localDatasource.searchPhieuXuatKho(query);
      return Right(phieuXuatKhoList.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> approvePhieuXuatKho(String id) async {
    try {
      await localDatasource.approvePhieuXuatKho(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
