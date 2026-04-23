// ============================================================================
// Data Layer - Repository Implementation
// Based on UC_HKD_TT88_2021 - MD-02
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/master_data/data/datasources/hang_hoa_local_datasource.dart';
import 'package:hkd_accounting/features/master_data/data/models/hang_hoa_model.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/hang_hoa.dart';
import 'package:hkd_accounting/features/master_data/domain/repositories/hang_hoa_repository.dart';

class HangHoaRepositoryImpl implements HangHoaRepository {
  final HangHoaLocalDatasource localDatasource;

  HangHoaRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, List<HangHoa>>> getHangHoaList() async {
    try {
      final hangHoaModels = await localDatasource.getHangHoaList();
      final hangHoaList = hangHoaModels.map((model) => model.toEntity()).toList();
      return Right(hangHoaList);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, HangHoa?>> getHangHoaById(String id) async {
    try {
      final hangHoaModel = await localDatasource.getHangHoaById(id);
      if (hangHoaModel != null) {
        return Right(hangHoaModel.toEntity());
      } else {
        return Right(null);
      }
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> saveHangHoa(HangHoa hangHoa) async {
    try {
      final hangHoaModel = HangHoaModel.fromEntity(hangHoa);
      final id = await localDatasource.saveHangHoa(hangHoaModel);
      return Right(id);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateHangHoa(HangHoa hangHoa) async {
    try {
      final hangHoaModel = HangHoaModel.fromEntity(hangHoa);
      await localDatasource.updateHangHoa(hangHoaModel);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteHangHoa(String id) async {
    try {
      await localDatasource.deleteHangHoa(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HangHoa>>> searchHangHoa(String query) async {
    try {
      final hangHoaModels = await localDatasource.searchHangHoa(query);
      final hangHoaList = hangHoaModels.map((model) => model.toEntity()).toList();
      return Right(hangHoaList);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}