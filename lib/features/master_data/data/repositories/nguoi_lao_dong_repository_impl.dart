// ============================================================================
// Data Layer - Repository Implementation
// Based on UC_HKD_TT88_2021 - MD-06
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/master_data/data/datasources/nguoi_lao_dong_local_datasource.dart';
import 'package:hkd_accounting/features/master_data/data/models/nguoi_lao_dong_model.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/nguoi_lao_dong.dart';
import 'package:hkd_accounting/features/master_data/domain/repositories/nguoi_lao_dong_repository.dart';

class NguoiLaoDongRepositoryImpl implements NguoiLaoDongRepository {
  final NguoiLaoDongLocalDatasource localDatasource;

  NguoiLaoDongRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, List<NguoiLaoDong>>> getNguoiLaoDongList() async {
    try {
      final nguoiLaoDongModels = await localDatasource.getNguoiLaoDongList();
      final nguoiLaoDongList = nguoiLaoDongModels.map((model) => model.toEntity()).toList();
      return Right(nguoiLaoDongList);
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, NguoiLaoDong?>> getNguoiLaoDongById(String id) async {
    try {
      final nguoiLaoDongModel = await localDatasource.getNguoiLaoDongById(id);
      if (nguoiLaoDongModel != null) {
        return Right(nguoiLaoDongModel.toEntity());
      } else {
        return Right(null);
      }
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, String>> saveNguoiLaoDong(NguoiLaoDong nguoiLaoDong) async {
    try {
      final nguoiLaoDongModel = NguoiLaoDongModel.fromEntity(nguoiLaoDong);
      final id = await localDatasource.saveNguoiLaoDong(nguoiLaoDongModel);
      return Right(id);
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateNguoiLaoDong(NguoiLaoDong nguoiLaoDong) async {
    try {
      final nguoiLaoDongModel = NguoiLaoDongModel.fromEntity(nguoiLaoDong);
      await localDatasource.updateNguoiLaoDong(nguoiLaoDongModel);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteNguoiLaoDong(String id) async {
    try {
      await localDatasource.deleteNguoiLaoDong(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<NguoiLaoDong>>> searchNguoiLaoDong(String query) async {
    try {
      final nguoiLaoDongModels = await localDatasource.searchNguoiLaoDong(query);
      final nguoiLaoDongList = nguoiLaoDongModels.map((model) => model.toEntity()).toList();
      return Right(nguoiLaoDongList);
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }
}