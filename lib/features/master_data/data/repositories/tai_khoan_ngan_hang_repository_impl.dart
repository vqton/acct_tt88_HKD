// ============================================================================
// Data Layer - Repository Implementation
// Based on UC_HKD_TT88_2021 - MD-07
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/master_data/data/datasources/tai_khoan_ngan_hang_local_datasource.dart';
import 'package:hkd_accounting/features/master_data/data/models/tai_khoan_ngan_hang_model.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/tai_khoan_ngan_hang.dart';
import 'package:hkd_accounting/features/master_data/domain/repositories/tai_khoan_ngan_hang_repository.dart';

class TaiKhoanNganHangRepositoryImpl implements TaiKhoanNganHangRepository {
  final TaiKhoanNganHangLocalDatasource localDatasource;

  TaiKhoanNganHangRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, List<TaiKhoanNganHang>>> getTaiKhoanNganHangList() async {
    try {
      final taiKhoanNganHangModels = await localDatasource.getTaiKhoanNganHangList();
      final taiKhoanNganHangList = taiKhoanNganHangModels.map((model) => model.toEntity()).toList();
      return Right(taiKhoanNganHangList);
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, TaiKhoanNganHang?>> getTaiKhoanNganHangById(String id) async {
    try {
      final taiKhoanNganHangModel = await localDatasource.getTaiKhoanNganHangById(id);
      if (taiKhoanNganHangModel != null) {
        return Right(taiKhoanNganHangModel.toEntity());
      } else {
        return Right(null);
      }
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, String>> saveTaiKhoanNganHang(TaiKhoanNganHang taiKhoanNganHang) async {
    try {
      final taiKhoanNganHangModel = TaiKhoanNganHangModel.fromEntity(taiKhoanNganHang);
      final id = await localDatasource.saveTaiKhoanNganHang(taiKhoanNganHangModel);
      return Right(id);
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateTaiKhoanNganHang(TaiKhoanNganHang taiKhoanNganHang) async {
    try {
      final taiKhoanNganHangModel = TaiKhoanNganHangModel.fromEntity(taiKhoanNganHang);
      await localDatasource.updateTaiKhoanNganHang(taiKhoanNganHangModel);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteTaiKhoanNganHang(String id) async {
    try {
      await localDatasource.deleteTaiKhoanNganHang(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<TaiKhoanNganHang>>> searchTaiKhoanNganHang(String query) async {
    try {
      final taiKhoanNganHangModels = await localDatasource.searchTaiKhoanNganHang(query);
      final taiKhoanNganHangList = taiKhoanNganHangModels.map((model) => model.toEntity()).toList();
      return Right(taiKhoanNganHangList);
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }
}