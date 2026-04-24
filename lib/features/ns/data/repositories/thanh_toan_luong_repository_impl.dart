// ============================================================================
// Data Layer - Repository Implementation
// Based on UC_HKD_TT88_2021 - NS-03: Theo dõi và thanh toán lương
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/ns/data/datasources/thanh_toan_luong_local_datasource.dart';
import 'package:hkd_accounting/features/ns/data/models/thanh_toan_luong_model.dart';
import 'package:hkd_accounting/features/ns/domain/entities/thanh_toan_luong.dart';
import 'package:hkd_accounting/features/ns/domain/repositories/thanh_toan_luong_repository.dart';

class ThanhToanLuongRepositoryImpl implements ThanhToanLuongRepository {
  final ThanhToanLuongLocalDatasource datasource;

  ThanhToanLuongRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, String>> create(ThanhToanLuong entity) async {
    try {
      final model = ThanhToanLuongModel.fromEntity(entity);
      final id = await datasource.save(model);
      return Right(id);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ThanhToanLuong?>> getById(String id) async {
    try {
      final result = await datasource.getById(id);
      return Right(result?.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ThanhToanLuong>>> getList() async {
    try {
      final result = await datasource.getList();
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ThanhToanLuong>>> getByBangLuongId(String bangLuongId) async {
    try {
      final result = await datasource.getByBangLuongId(bangLuongId);
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> update(ThanhToanLuong entity) async {
    try {
      await datasource.update(ThanhToanLuongModel.fromEntity(entity));
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> delete(String id) async {
    try {
      await datasource.delete(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateThanhToan(String id, double soTienChuyenKhoan, double soTienMat) async {
    try {
      await datasource.updateThanhToan(id, soTienChuyenKhoan, soTienMat);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}