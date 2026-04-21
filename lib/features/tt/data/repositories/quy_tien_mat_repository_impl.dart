// ============================================================================
// Data Layer - Repository Implementation
// Based on UC_HKD_TT88_2021 - TT-01: Quản lý quỹ tiền mặt
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/tt/data/datasources/quy_tien_mat_local_datasource.dart';
import 'package:hkd_accounting/features/tt/data/models/quy_tien_mat_model.dart';
import 'package:hkd_accounting/features/tt/domain/entities/quy_tien_mat.dart';
import 'package:hkd_accounting/features/tt/domain/repositories/quy_tien_mat_repository.dart';

class QuyTienMatRepositoryImpl implements QuyTienMatRepository {
  final QuyTienMatLocalDatasource localDatasource;

  QuyTienMatRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, QuyTienMat>> createQuyTienMat(QuyTienMat quyTienMat) async {
    try {
      final id = await localDatasource.saveQuyTienMat(
        QuyTienMatModel.fromEntity(quyTienMat),
      );
      final createdQuyTienMat = await localDatasource.getQuyTienMatById(id);
      return Right(createdQuyTienMat!.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, QuyTienMat?>> getQuyTienMatById(String id) async {
    try {
      final quyTienMat = await localDatasource.getQuyTienMatById(id);
      return Right(quyTienMat?.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<QuyTienMat>>> getQuyTienMatList() async {
    try {
      final quyTienMatList = await localDatasource.getQuyTienMatList();
      return Right(quyTienMatList.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateQuyTienMat(QuyTienMat quyTienMat) async {
    try {
      await localDatasource.updateQuyTienMat(
        QuyTienMatModel.fromEntity(quyTienMat),
      );
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteQuyTienMat(String id) async {
    try {
      await localDatasource.deleteQuyTienMat(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}