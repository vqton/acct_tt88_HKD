// ============================================================================
// Data Layer - Repository Implementation
// Based on UC_HKD_TT88_2021 - CT-06: Quản lý hóa đơn
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/ct/data/datasources/hoa_don_local_datasource.dart';
import 'package:hkd_accounting/features/ct/data/models/hoa_don_model.dart';
import 'package:hkd_accounting/features/ct/domain/entities/hoa_don.dart';
import 'package:hkd_accounting/features/ct/domain/repositories/hoa_don_repository.dart';

class HoaDonRepositoryImpl implements HoaDonRepository {
  final HoaDonLocalDatasource localDatasource;

  HoaDonRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, HoaDon>> createHoaDon(HoaDon hoaDon) async {
    try {
      final id = await localDatasource.saveHoaDon(
        HoaDonModel.fromEntity(hoaDon),
      );
      final created = await localDatasource.getHoaDonById(id);
      return Right(created!.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, HoaDon?>> getHoaDonById(String id) async {
    try {
      final hoaDon = await localDatasource.getHoaDonById(id);
      return Right(hoaDon?.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HoaDon>>> getHoaDonList() async {
    try {
      final hoaDonList = await localDatasource.getHoaDonList();
      return Right(hoaDonList.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HoaDon>>> getHoaDonByLoai(String loaiHoaDon) async {
    try {
      final hoaDonList = await localDatasource.getHoaDonByLoai(loaiHoaDon);
      return Right(hoaDonList.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateHoaDon(HoaDon hoaDon) async {
    try {
      await localDatasource.updateHoaDon(HoaDonModel.fromEntity(hoaDon));
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteHoaDon(String id) async {
    try {
      await localDatasource.deleteHoaDon(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HoaDon>>> searchHoaDon(String query) async {
    try {
      final hoaDonList = await localDatasource.searchHoaDon(query);
      return Right(hoaDonList.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> approveHoaDon(String id) async {
    try {
      final hoaDon = await localDatasource.getHoaDonById(id);
      if (hoaDon != null) {
        await localDatasource.updateHoaDon(
          HoaDonModel.fromEntity(hoaDon.toEntity().copyWith(trangThai: 'DA_DUYET')),
        );
      }
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}