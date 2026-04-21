import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/sk/data/datasources/so_tien_gui_ngan_hang_local_datasource.dart';
import 'package:hkd_accounting/features/sk/data/models/so_tien_gui_ngan_hang_model.dart';
import 'package:hkd_accounting/features/sk/domain/entities/so_tien_gui_ngan_hang.dart';
import 'package:hkd_accounting/features/sk/domain/repositories/so_tien_gui_ngan_hang_repository.dart';

/// Implementation của SoTienGuiNganHangRepository sử dụng local data source.
/// 
/// Class này xử lý việc lưu trữ dữ liệu sổ tiền gửi ngân hàng (S7-HKD)
/// theo UC_HKD_TT88_2021 - SK-08: Ghi sổ tiền gửi ngân hàng (S7-HKD).
class SoTienGuiNganHangRepositoryImpl implements SoTienGuiNganHangRepository {
  final SoTienGuiNganHangLocalDatasource localDatasource;

  SoTienGuiNganHangRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, SoTienGuiNganHang>> createSoTienGuiNganHang(SoTienGuiNganHang soTienGuiNganHang) async {
    try {
      final id = await localDatasource.createSoTienGuiNganHang(
        SoTienGuiNganHangModel.fromEntity(soTienGuiNganHang),
      );
      return Right(soTienGuiNganHang.copyWith(id: id));
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SoTienGuiNganHang?>> getSoTienGuiNganHangById(String id) async {
    try {
      final soTien = await localDatasource.getSoTienGuiNganHangById(id);
      return Right(soTien?.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SoTienGuiNganHang>>> getSoTienGuiNganHangList() async {
    try {
      final soTienList = await localDatasource.getSoTienGuiNganHangList();
      return Right(soTienList.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SoTienGuiNganHang>>> getSoTienGuiNganHangByTaiKhoanNganHangId(String taiKhoanNganHangId) async {
    try {
      final soTienList = await localDatasource.getSoTienGuiNganHangByTaiKhoanNganHangId(taiKhoanNganHangId);
      return Right(soTienList.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SoTienGuiNganHang>>> getSoTienGuiNganHangByKyKeToanId(String kyKeToanId) async {
    try {
      final soTienList = await localDatasource.getSoTienGuiNganHangByKyKeToanId(kyKeToanId);
      return Right(soTienList.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateSoTienGuiNganHang(SoTienGuiNganHang soTienGuiNganHang) async {
    try {
      await localDatasource.updateSoTienGuiNganHang(
        SoTienGuiNganHangModel.fromEntity(soTienGuiNganHang),
      );
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSoTienGuiNganHang(String id) async {
    try {
      await localDatasource.deleteSoTienGuiNganHang(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}