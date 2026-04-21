// ============================================================================
// Data Layer - Repository Implementation
// Based on UC_HKD_TT88_2021 - CT-03: Lập phiếu nhập kho
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/ct/data/datasources/phieu_nhap_kho_local_datasource.dart';
import 'package:hkd_accounting/features/ct/data/models/phieu_nhap_kho_model.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_nhap_kho.dart';
import 'package:hkd_accounting/features/ct/domain/repositories/phieu_nhap_kho_repository.dart';

class PhieuNhapKhoRepositoryImpl implements PhieuNhapKhoRepository {
  final PhieuNhapKhoLocalDatasource localDatasource;

  PhieuNhapKhoRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, PhieuNhapKho>> createPhieuNhapKho(
      PhieuNhapKho phieuNhapKho) async {
    try {
      final id = await localDatasource.savePhieuNhapKho(
        PhieuNhapKhoModel.fromEntity(phieuNhapKho),
      );
      final createdPhieuNhapKho = await localDatasource.getPhieuNhapKhoById(id);
      return Right(createdPhieuNhapKho!.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PhieuNhapKho?>> getPhieuNhapKhoById(String id) async {
    try {
      final phieuNhapKho = await localDatasource.getPhieuNhapKhoById(id);
      return Right(phieuNhapKho?.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PhieuNhapKho>>> getPhieuNhapKhoList() async {
    try {
      final phieuNhapKhoList = await localDatasource.getPhieuNhapKhoList();
      return Right(phieuNhapKhoList.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updatePhieuNhapKho(
      PhieuNhapKho phieuNhapKho) async {
    try {
      await localDatasource.updatePhieuNhapKho(
        PhieuNhapKhoModel.fromEntity(phieuNhapKho),
      );
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePhieuNhapKho(String id) async {
    try {
      await localDatasource.deletePhieuNhapKho(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PhieuNhapKho>>> searchPhieuNhapKho(
      String query) async {
    try {
      final phieuNhapKhoList = await localDatasource.searchPhieuNhapKho(query);
      return Right(phieuNhapKhoList.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> approvePhieuNhapKho(String id) async {
    try {
      await localDatasource.approvePhieuNhapKho(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}