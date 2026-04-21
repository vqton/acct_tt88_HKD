// ============================================================================
// Data Layer - Repository Implementation
// Based on UC_HKD_TT88_2021 - MD-03
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/master_data/data/datasources/nghe_nghiep_local_datasource.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/nghe_nghiep.dart';
import 'package:hkd_accounting/features/master_data/domain/repositories/nghe_nghiep_repository.dart';
import 'package:hkd_accounting/features/master_data/data/models/nghe_nghiep_model.dart';

class NgheNghiepRepositoryImpl implements NgheNghiepRepository {
  final NgheNghiepLocalDatasource localDatasource;

  NgheNghiepRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, List<NgheNghiep>>> getNgheNghiepList() async {
    try {
      final ngheNghieuList = await localDatasource.getNgheNghiepList();
      return Right(ngheNghieuList.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, NgheNghiep?>> getNgheNghiepById(String id) async {
    try {
      final ngheNghieu = await localDatasource.getNgheNghiepById(id);
      return Right(ngheNghieu?.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> saveNgheNghiep(NgheNghiep ngheNghieu) async {
    try {
      final id = await localDatasource.saveNgheNghiep(
        NgheNghiepModel.fromEntity(ngheNghieu),
      );
      return Right(id);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateNgheNghiep(NgheNghiep ngheNghieu) async {
    try {
      await localDatasource.updateNgheNghiep(
        NgheNghiepModel.fromEntity(ngheNghieu),
      );
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNgheNghiep(String id) async {
    try {
      await localDatasource.deleteNgheNghiep(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, NgheNghiep?>> getApplicableNgheNghiep(DateTime date) async {
    try {
      final ngheNghieu = await localDatasource.getApplicableNgheNghiep(date);
      return Right(ngheNghieu?.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}

// Extension to convert model to entity
extension NgheNghiepModelExtension on NgheNghiepModel {
  NgheNghiep toEntity() {
    return NgheNghiep(
      id: id,
      maNhomNgheNghe: maNhomNgheNghe,
      tenNhomNgheNghe: tenNhomNgheNghe,
      tyLeThueGTGT: tyLeThueGTGT,
      tyLeThueTNCN: tyLeThueTNCN,
      ngayHieuLuc: ngayHieuLuc,
      ngayHetHieuLuc: ngayHetHieuLuc,
    );
  }
}

// Extension to convert entity to model
extension NgheNghiepEntityExtension on NgheNghiep {
  NgheNghiepModel toModel() {
    return NgheNghiepModel(
      id: id,
      maNhomNgheNghe: maNhomNgheNghe,
      tenNhomNgheNghe: tenNhomNgheNghe,
      tyLeThueGTGT: tyLeThueGTGT,
      tyLeThueTNCN: tyLeThueTNCN,
      ngayHieuLuc: ngayHieuLuc,
      ngayHetHieuLuc: ngayHetHieuLuc,
    );
  }
}