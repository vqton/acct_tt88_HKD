// ============================================================================
// Data Layer - SK-02: Sổ doanh thu (S1-HKD) - Repository Implementation
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/sk/data/datasources/so_doanh_thu_local_datasource.dart';
import 'package:hkd_accounting/features/sk/data/models/so_doanh_thu_model.dart';
import 'package:hkd_accounting/features/sk/domain/entities/so_doanh_thu.dart';
import 'package:hkd_accounting/features/sk/domain/repositories/so_doanh_thu_repository.dart';

class SoDoanhThuRepositoryImpl implements SoDoanhThuRepository {
  final SoDoanhThuLocalDatasource datasource;

  SoDoanhThuRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, SoDoanhThu>> create(SoDoanhThu entity) async {
    try {
      await datasource.save(SoDoanhThuModel.fromEntity(entity));
      return Right(entity);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SoDoanhThu>>> getByKyKeToan(String kyKeToanId) async {
    try {
      final list = await datasource.getByKyKeToan(kyKeToanId);
      return Right(list.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SoDoanhThu>>> getAll() async {
    try {
      final list = await datasource.getAll();
      return Right(list.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> update(SoDoanhThu entity) async {
    try {
      await datasource.update(SoDoanhThuModel.fromEntity(entity));
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
}