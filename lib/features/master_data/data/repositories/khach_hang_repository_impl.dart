// ============================================================================
// Data Layer - Repository Implementation
// Based on UC_HKD_TT88_2021 - MD-05: Quản lý danh mục khách hàng
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/master_data/data/datasources/khach_hang_local_datasource.dart';
import 'package:hkd_accounting/features/master_data/data/models/khach_hang_model.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/khach_hang.dart';
import 'package:hkd_accounting/features/master_data/domain/repositories/khach_hang_repository.dart';

class KhachHangRepositoryImpl implements KhachHangRepository {
  final KhachHangLocalDatasource localDatasource;

  KhachHangRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, List<KhachHang>>> getKhachHangList() async {
    try {
      final khachHangModels = await localDatasource.getKhachHangList();
      final khachHangList = khachHangModels.map((model) => model.toEntity()).toList();
      return Right(khachHangList);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, KhachHang?>> getKhachHangById(String id) async {
    try {
      final khachHangModel = await localDatasource.getKhachHangById(id);
      if (khachHangModel != null) {
        return Right(khachHangModel.toEntity());
      } else {
        return Right(null);
      }
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> saveKhachHang(KhachHang khachHang) async {
    try {
      final khachHangModel = KhachHangModel.fromEntity(khachHang);
      final id = await localDatasource.saveKhachHang(khachHangModel);
      return Right(id);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateKhachHang(KhachHang khachHang) async {
    try {
      final khachHangModel = KhachHangModel.fromEntity(khachHang);
      await localDatasource.updateKhachHang(khachHangModel);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteKhachHang(String id) async {
    try {
      await localDatasource.deleteKhachHang(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<KhachHang>>> searchKhachHang(String query) async {
    try {
      final khachHangModels = await localDatasource.searchKhachHang(query);
      final khachHangList = khachHangModels.map((model) => model.toEntity()).toList();
      return Right(khachHangList);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
