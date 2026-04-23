// ============================================================================
// Data Layer - Repository Implementation
// Based on UC_HKD_TT88_2021 - MD-04
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/master_data/data/datasources/nha_cung_cap_local_datasource.dart';
import 'package:hkd_accounting/features/master_data/data/models/nha_cung_cap_model.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/nha_cung_cap.dart';
import 'package:hkd_accounting/features/master_data/domain/repositories/nha_cung_cap_repository.dart';

class NhaCungCapRepositoryImpl implements NhaCungCapRepository {
  final NhaCungCapLocalDatasource localDatasource;

  NhaCungCapRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, List<NhaCungCap>>> getNhaCungCapList() async {
    try {
      final nhaCungCapModels = await localDatasource.getNhaCungCapList();
      final nhaCungCapList = nhaCungCapModels.map((model) => model.toEntity()).toList();
      return Right(nhaCungCapList);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, NhaCungCap?>> getNhaCungCapById(String id) async {
    try {
      final nhaCungCapModel = await localDatasource.getNhaCungCapById(id);
      if (nhaCungCapModel != null) {
        return Right(nhaCungCapModel.toEntity());
      } else {
        return Right(null);
      }
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> saveNhaCungCap(NhaCungCap nhaCungCap) async {
    try {
      final nhaCungCapModel = NhaCungCapModel.fromEntity(nhaCungCap);
      final id = await localDatasource.saveNhaCungCap(nhaCungCapModel);
      return Right(id);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateNhaCungCap(NhaCungCap nhaCungCap) async {
    try {
      final nhaCungCapModel = NhaCungCapModel.fromEntity(nhaCungCap);
      await localDatasource.updateNhaCungCap(nhaCungCapModel);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNhaCungCap(String id) async {
    try {
      await localDatasource.deleteNhaCungCap(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NhaCungCap>>> searchNhaCungCap(String query) async {
    try {
      final nhaCungCapModels = await localDatasource.searchNhaCungCap(query);
      final nhaCungCapList = nhaCungCapModels.map((model) => model.toEntity()).toList();
      return Right(nhaCungCapList);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}