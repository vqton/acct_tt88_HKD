// ============================================================================
// Data Layer - Repository Implementation
// Based on UC_HKD_TT88_2021 - TT-02: Quản lý tiền gửi ngân hàng
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/tt/data/datasources/tien_gui_ngan_hang_local_datasource.dart';
import 'package:hkd_accounting/features/tt/data/models/tien_gui_ngan_hang_model.dart';
import 'package:hkd_accounting/features/tt/domain/entities/tien_gui_ngan_hang.dart';
import 'package:hkd_accounting/features/tt/domain/repositories/tien_gui_ngan_hang_repository.dart';

class TienGuiNganHangRepositoryImpl implements TienGuiNganHangRepository {
  final TienGuiNganHangLocalDatasource localDatasource;

  TienGuiNganHangRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, TienGuiNganHang>> createTienGuiNganHang(TienGuiNganHang tienGuiNganHang) async {
    try {
      final id = await localDatasource.saveTienGuiNganHang(
        TienGuiNganHangModel.fromEntity(tienGuiNganHang),
      );
      final createdTienGuiNganHang = await localDatasource.getTienGuiNganHangById(id);
      return Right(createdTienGuiNganHang!.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TienGuiNganHang?>> getTienGuiNganHangById(String id) async {
    try {
      final tienGuiNganHang = await localDatasource.getTienGuiNganHangById(id);
      return Right(tienGuiNganHang?.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TienGuiNganHang>>> getTienGuiNganHangList() async {
    try {
      final tienGuiNganHangList = await localDatasource.getTienGuiNganHangList();
      return Right(tienGuiNganHangList.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateTienGuiNganHang(TienGuiNganHang tienGuiNganHang) async {
    try {
      await localDatasource.updateTienGuiNganHang(
        TienGuiNganHangModel.fromEntity(tienGuiNganHang),
      );
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTienGuiNganHang(String id) async {
    try {
      await localDatasource.deleteTienGuiNganHang(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}