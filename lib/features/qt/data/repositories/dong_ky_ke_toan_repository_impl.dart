// ============================================================================
// Data Layer - Repository Implementation
// Based on UC_HKD_TT88_2021 - QT-03: Đóng kỳ kế toán và khóa sổ
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/qt/data/datasources/dong_ky_ke_toan_local_datasource.dart';
import 'package:hkd_accounting/features/qt/data/models/dong_ky_ke_toan_model.dart';
import 'package:hkd_accounting/features/qt/domain/entities/dong_ky_ke_toan.dart';
import 'package:hkd_accounting/features/qt/domain/repositories/dong_ky_ke_toan_repository.dart';

class DongKyKeToanRepositoryImpl implements DongKyKeToanRepository {
  final DongKyKeToanLocalDatasource datasource;

  DongKyKeToanRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, String>> create(DongKyKeToan entity) async {
    try {
      final model = DongKyKeToanModel.fromEntity(entity);
      final id = await datasource.save(model);
      return Right(id);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DongKyKeToan?>> getCurrent() async {
    try {
      final result = await datasource.getCurrent();
      return Right(result?.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DongKyKeToan>>> getList() async {
    try {
      final result = await datasource.getList();
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> update(DongKyKeToan entity) async {
    try {
      await datasource.update(DongKyKeToanModel.fromEntity(entity));
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