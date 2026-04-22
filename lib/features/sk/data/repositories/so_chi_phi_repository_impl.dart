// ============================================================================
// Data Layer - SK-04: Sổ chi phí (S3-HKD) - Repository
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/sk/data/datasources/so_chi_phi_local_datasource.dart';
import 'package:hkd_accounting/features/sk/data/models/so_chi_phi_model.dart';
import 'package:hkd_accounting/features/sk/domain/entities/so_chi_phi.dart';

abstract class SoChiPhiRepository {
  Future<Either<Failure, List<SoChiPhi>>> getAll();
  Future<Either<Failure, List<SoChiPhi>>> getByKyKeToan(String kyKeToanId);
  Future<Either<Failure, void>> save(SoChiPhi entity);
}

class SoChiPhiRepositoryImpl implements SoChiPhiRepository {
  final SoChiPhiLocalDatasource ds;
  SoChiPhiRepositoryImpl(this.ds);

  @override
  Future<Either<Failure, List<SoChiPhi>>> getAll() async {
    try { return Right((await ds.getAll()).map((e) => e.toEntity()).toList()); }
    catch (e) { return Left(DatabaseFailure(e.toString())); }
  }

  @override
  Future<Either<Failure, List<SoChiPhi>>> getByKyKeToan(String kyKeToanId) async {
    try { return Right((await ds.getByKyKeToan(kyKeToanId)).map((e) => e.toEntity()).toList()); }
    catch (e) { return Left(DatabaseFailure(e.toString())); }
  }

  @override
  Future<Either<Failure, void>> save(SoChiPhi entity) async {
    try { await ds.save(SoChiPhiModel.fromEntity(entity)); return const Right(null); }
    catch (e) { return Left(DatabaseFailure(e.toString())); }
  }
}