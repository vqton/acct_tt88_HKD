// ============================================================================
// Data Layer - Repository Implementation
// Based on UC_HKD_TT88_2021 - QT-01: Quản lý tài khoản người dùng & phân quyền
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/qt/data/datasources/nguoi_dung_local_datasource.dart';
import 'package:hkd_accounting/features/qt/data/models/nguoi_dung_model.dart';
import 'package:hkd_accounting/features/qt/domain/entities/nguoi_dung.dart';
import 'package:hkd_accounting/features/qt/domain/repositories/nguoi_dung_repository.dart';

class NguoiDungRepositoryImpl implements NguoiDungRepository {
  final NguoiDungLocalDatasource localDatasource;

  NguoiDungRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, List<NguoiDung>>> getNguoiDungList() async {
    try {
      final nguoiDungModels = await localDatasource.getNguoiDungList();
      final nguoiDungList = nguoiDungModels.map((model) => model.toEntity()).toList();
      return Right(nguoiDungList);
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, NguoiDung?>> getNguoiDungById(String id) async {
    try {
      final nguoiDungModel = await localDatasource.getNguoiDungById(id);
      if (nguoiDungModel != null) {
        return Right(nguoiDungModel.toEntity());
      } else {
        return Right(null);
      }
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, NguoiDung?>> getNguoiDungByEmail(String email) async {
    try {
      final nguoiDungModel = await localDatasource.getNguoiDungByEmail(email);
      if (nguoiDungModel != null) {
        return Right(nguoiDungModel.toEntity());
      } else {
        return Right(null);
      }
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, String>> saveNguoiDung(NguoiDung nguoiDung) async {
    try {
      final nguoiDungModel = NguoiDungModel.fromEntity(nguoiDung);
      final id = await localDatasource.saveNguoiDung(nguoiDungModel);
      return Right(id);
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateNguoiDung(NguoiDung nguoiDung) async {
    try {
      final nguoiDungModel = NguoiDungModel.fromEntity(nguoiDung);
      await localDatasource.updateNguoiDung(nguoiDungModel);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteNguoiDung(String id) async {
    try {
      await localDatasource.deleteNguoiDung(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<NguoiDung>>> searchNguoiDung(String query) async {
    try {
      final nguoiDungModels = await localDatasource.searchNguoiDung(query);
      final nguoiDungList = nguoiDungModels.map((model) => model.toEntity()).toList();
      return Right(nguoiDungList);
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, NguoiDung?>> login(String email, String password) async {
    try {
      final nguoiDungModel = await localDatasource.login(email, password);
      if (nguoiDungModel != null) {
        return Right(nguoiDungModel.toEntity());
      } else {
        return Right(null);
      }
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }
}