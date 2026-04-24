// ============================================================================
// Data Layer - Repository Implementation
// Based on UC_HKD_TT88_2021 - SK-06: Ghi sổ theo dõi thanh toán tiền lương (S5-HKD)
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/sk/data/datasources/so_theo_doi_tien_luong_local_datasource.dart';
import 'package:hkd_accounting/features/sk/data/models/so_theo_doi_tien_luong_model.dart';
import 'package:hkd_accounting/features/sk/domain/entities/so_theo_doi_tien_luong.dart';
import 'package:hkd_accounting/features/sk/domain/repositories/so_theo_doi_tien_luong_repository.dart';

class SoTheoDoiTienLuongRepositoryImpl implements SoTheoDoiTienLuongRepository {
  final SoTheoDoiTienLuongLocalDatasource datasource;

  SoTheoDoiTienLuongRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, String>> create(SoTheoDoiTienLuong entity) async {
    try {
      final model = SoTheoDoiTienLuongModel.fromEntity(entity);
      final id = await datasource.save(model);
      return Right(id);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SoTheoDoiTienLuong?>> getById(String id) async {
    try {
      final result = await datasource.getById(id);
      return Right(result?.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SoTheoDoiTienLuong>>> getList() async {
    try {
      final result = await datasource.getList();
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SoTheoDoiTienLuong>>> getByKyKeToanId(String kyKeToanId) async {
    try {
      final result = await datasource.getByKyKeToanId(kyKeToanId);
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SoTheoDoiTienLuong>>> getByBangLuongId(String bangLuongId) async {
    try {
      final result = await datasource.getByBangLuongId(bangLuongId);
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> update(SoTheoDoiTienLuong entity) async {
    try {
      await datasource.update(SoTheoDoiTienLuongModel.fromEntity(entity));
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
  Future<Either<Failure, void>> updateThanhToan(String id, double soTien) async {
    try {
      await datasource.updateThanhToan(id, soTien);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateBhxhNop(String id, double bhxhDaNop, double bhytDaNop, double bhtnDaNop) async {
    try {
      await datasource.updateBhxhNop(id, bhxhDaNop, bhytDaNop, bhtnDaNop);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}