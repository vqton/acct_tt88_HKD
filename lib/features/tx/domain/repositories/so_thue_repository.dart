import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/tx/domain/entities/so_thue.dart';

abstract class SoThueRepository {
  Future<Either<Failure, List<SoThue>>> getByKyKeToan(String kyKeToanId);
  Future<Either<Failure, List<SoThue>>> getAll();
  Future<Either<Failure, SoThue>> create(SoThue entity);
  Future<Either<Failure, void>> update(SoThue entity);
  Future<Either<Failure, void>> delete(String id);
  Future<Either<Failure, SoThue>> getTongHop(String kyKeToanId);
}