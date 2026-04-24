// ============================================================================
// Data Layer - Repository Implementation
// Based on UC_HKD_TT88_2021 - QT-06: Nhật ký hệ thống và Audit Trail
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/qt/data/datasources/nhat_ky_he_thong_local_datasource.dart';
import 'package:hkd_accounting/features/qt/data/models/nhat_ky_he_thong_model.dart';
import 'package:hkd_accounting/features/qt/domain/entities/nhat_ky_he_thong.dart';
import 'package:hkd_accounting/features/qt/domain/repositories/nhat_ky_he_thong_repository.dart';

class NhatKyHeThongRepositoryImpl implements NhatKyHeThongRepository {
  final NhatKyHeThongLocalDatasource datasource;

  NhatKyHeThongRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, String>> create(NhatKyHeThong entity) async {
    try {
      final model = NhatKyHeThongModel.fromEntity(entity);
      final id = await datasource.save(model);
      return Right(id);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NhatKyHeThong>>> getList({int? limit, int? offset}) async {
    try {
      final result = await datasource.getList(limit: limit, offset: offset);
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NhatKyHeThong>>> getByUserId(String userId) async {
    try {
      final result = await datasource.getByUserId(userId);
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NhatKyHeThong>>> getByDoiTuong(String doiTuongLoai, String doiTuongId) async {
    try {
      final result = await datasource.getByDoiTuong(doiTuongLoai, doiTuongId);
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NhatKyHeThong>>> getByDateRange(DateTime from, DateTime to) async {
    try {
      final result = await datasource.getByDateRange(from, to);
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NhatKyHeThong>>> getByHanhDong(HanhDong hanhDong) async {
    try {
      final result = await datasource.getByHanhDong(hanhDong.name);
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, NhatKyHeThong?>> getById(String id) async {
    try {
      final result = await datasource.getById(id);
      return Right(result?.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getCount() async {
    try {
      final count = await datasource.getCount();
      return Right(count);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}