// ============================================================================
// Data Layer - Repository Implementation
// Based on UC_HKD_TT88_2021 - SK-07: Ghi sổ quỹ tiền mặt (S6-HKD)
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/sk/data/datasources/so_quy_tien_mat_local_datasource.dart';
import 'package:hkd_accounting/features/sk/data/models/so_quy_tien_mat_model.dart';
import 'package:hkd_accounting/features/sk/domain/entities/so_quy_tien_mat.dart';
import 'package:hkd_accounting/features/sk/domain/repositories/so_quy_tien_mat_repository.dart';

/// Implementation của SoQuyTienMatRepository sử dụng local data source.
/// 
/// Class này xử lý việc lưu trữ dữ liệu sổ quỹ tiền mặt (S6-HKD)
/// theo UC_HKD_TT88_2021 - SK-07: Ghi sổ quỹ tiền mặt (S6-HKD).
/// 
/// Nó chuyển đổi giữa domain entities và data models, và xử lý
/// các trường hợp lỗi bằng cách bọc exceptions trong Failure objects.
class SoQuyTienMatRepositoryImpl implements SoQuyTienMatRepository {
  /// Local data source chịu trách nhiệm lưu trữ dữ liệu thực tế
  final SoQuyTienMatLocalDatasource localDatasource;

  /// Tạo một repository implementation với data source đã cho
  /// 
  /// [localDatasource] Data source dùng cho các thao tác lưu trữ
  SoQuyTienMatRepositoryImpl(this.localDatasource);

  /// Tạo một dòng mới trong sổ quỹ tiền mặt
  /// 
  /// [soQuyTienMat] Dòng sổ cần tạo
  /// @return Future chứa Failure hoặc ID của dòng sổ đã tạo
  @override
  Future<Either<Failure, SoQuyTienMat>> createSoQuyTienMat(SoQuyTienMat soQuyTienMat) async {
    try {
      final id = await localDatasource.createSoQuyTienMat(
        SoQuyTienMatModel.fromEntity(soQuyTienMat),
      );
      return Right(soQuyTienMat.copyWith(id: id));
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  /// Lấy một dòng sổ theo ID
  /// 
  /// [id] ID duy nhất của dòng sổ cần lấy
  /// @return Future chứa Failure hoặc SoQuyTienMat nếu tìm thấy (null nếu không tìm thấy)
  @override
  Future<Either<Failure, SoQuyTienMat?>> getSoQuyTienMatById(String id) async {
    try {
      final soQuy = await localDatasource.getSoQuyTienMatById(id);
      return Right(soQuy?.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  /// Lấy tất cả các dòng sổ quỹ tiền mặt
  /// @return Future chứa Failure hoặc List các SoQuyTienMat
  @override
  Future<Either<Failure, List<SoQuyTienMat>>> getSoQuyTienMatList() async {
    try {
      final soQuyList = await localDatasource.getSoQuyTienMatList();
      return Right(soQuyList.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  /// Lấy các dòng sổ theo ID quỹ tiền mặt
  /// 
  /// [quyTienMatId] ID của quỹ tiền mặt
  /// @return Future chứa Failure hoặc List các SoQuyTienMat thuộc quỹ đó
  @override
  Future<Either<Failure, List<SoQuyTienMat>>> getSoQuyTienMatByQuyTienMatId(String quyTienMatId) async {
    try {
      final soQuyList = await localDatasource.getSoQuyTienMatByQuyTienMatId(quyTienMatId);
      return Right(soQuyList.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  /// Lấy các dòng sổ theo ID kỳ kế toán
  /// 
  /// [kyKeToanId] ID của kỳ kế toán
  /// @return Future chứa Failure hoặc List các SoQuyTienMat thuộc kỳ đó
  @override
  Future<Either<Failure, List<SoQuyTienMat>>> getSoQuyTienMatByKyKeToanId(String kyKeToanId) async {
    try {
      final soQuyList = await localDatasource.getSoQuyTienMatByKyKeToanId(kyKeToanId);
      return Right(soQuyList.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  /// Cập nhật một dòng sổ đã tồn tại
  /// 
  /// [soQuyTienMat] Dòng sổ với thông tin đã cập nhật
  /// @return Future chứa Failure hoặc void nếu thành công
  @override
  Future<Either<Failure, void>> updateSoQuyTienMat(SoQuyTienMat soQuyTienMat) async {
    try {
      await localDatasource.updateSoQuyTienMat(
        SoQuyTienMatModel.fromEntity(soQuyTienMat),
      );
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  /// Xóa một dòng sổ theo ID
  /// 
  /// [id] ID duy nhất của dòng sổ cần xóa
  /// @return Future chứa Failure hoặc void nếu thành công
  @override
  Future<Either<Failure, void>> deleteSoQuyTienMat(String id) async {
    try {
      await localDatasource.deleteSoQuyTienMat(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}