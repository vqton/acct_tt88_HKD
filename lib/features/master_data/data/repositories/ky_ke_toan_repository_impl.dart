// ============================================================================
// Data Layer - Repository Implementation
// Based on UC_HKD_TT88_2021 - MD-08: Cấu hình kỳ kế toán
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/master_data/data/datasources/ky_ke_toan_local_datasource.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/ky_ke_toan.dart';
import 'package:hkd_accounting/features/master_data/domain/repositories/ky_ke_toan_repository.dart';
import 'package:hkd_accounting/features/master_data/data/models/ky_ke_toan_model.dart';

class KyKeToanRepositoryImpl implements KyKeToanRepository {
  final KyKeToanLocalDatasource localDatasource;

  KyKeToanRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, KyKeToan?>> getKyKeToan() async {
    try {
      final kyKeToan = await localDatasource.getKyKeToan();
      return Right(kyKeToan?.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> saveKyKeToan(KyKeToan kyKeToan) async {
    try {
      final id = await localDatasource.saveKyKeToan(
        KyKeToanModel.fromEntity(kyKeToan),
      );
      return Right(id);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateKyKeToan(KyKeToan kyKeToan) async {
    try {
      await localDatasource.updateKyKeToan(
        KyKeToanModel.fromEntity(kyKeToan),
      );
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteKyKeToan(String id) async {
    try {
      await localDatasource.deleteKyKeToan(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}

// Extension to convert model to entity
extension KyKeToanModelExtension on KyKeToanModel {
  KyKeToan toEntity() {
    return KyKeToan(
      id: this.id,
      namTaiChinh: this.namTaiChinh,
      ngayBatDauKy: this.ngayBatDauKy,
      ngayKetThucKy: this.ngayKetThucKy,
      trangThaiKy: this.trangThaiKy,
      ngayKhoaSoThucTe: this.ngayKhoaSoThucTe,
    );
  }
}

// Extension to convert entity to model
extension KyKeToanEntityExtension on KyKeToan {
  KyKeToanModel toModel() {
    return KyKeToanModel(
      id: this.id,
      namTaiChinh: this.namTaiChinh,
      ngayBatDauKy: this.ngayBatDauKy,
      ngayKetThucKy: this.ngayKetThucKy,
      trangThaiKy: this.trangThaiKy,
      ngayKhoaSoThucTe: this.ngayKhoaSoThucTe,
    );
  }
}