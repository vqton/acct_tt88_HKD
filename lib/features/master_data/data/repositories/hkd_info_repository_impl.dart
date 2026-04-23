// ============================================================================
// Data Layer - Repository Implementation
// Based on UC_HKD_TT88_2021 - MD-01
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/master_data/data/datasources/hkd_info_local_datasource.dart';
import 'package:hkd_accounting/features/master_data/data/models/hkd_info_model.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/hkd_info.dart';
import 'package:hkd_accounting/features/master_data/domain/repositories/hkd_info_repository.dart';

class HkdInfoRepositoryImpl implements HkdInfoRepository {
  final HkdInfoLocalDatasource localDatasource;

  HkdInfoRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, HkdInfo?>> getHkdInfo() async {
    try {
      final hkdInfoModel = await localDatasource.getHkdInfo();
      if (hkdInfoModel != null) {
        return Right(hkdInfoModel.toEntity());
      } else {
        return Right(null);
      }
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> saveHkdInfo(HkdInfo hkdInfo) async {
    try {
      final hkdInfoModel = HkdInfoModel.fromEntity(hkdInfo);
      final id = await localDatasource.saveHkdInfo(hkdInfoModel);
      return Right(id);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateHkdInfo(HkdInfo hkdInfo) async {
    try {
      final hkdInfoModel = HkdInfoModel.fromEntity(hkdInfo);
      await localDatasource.updateHkdInfo(hkdInfoModel);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteHkdInfo(String id) async {
    try {
      await localDatasource.deleteHkdInfo(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
