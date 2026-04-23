// ============================================================================
// Domain Layer - Use Cases
// Based on UC_HKD_TT88_2021 - CT-01: Lập phiếu thu
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/core/usecases/usecase.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_thu.dart';
import 'package:hkd_accounting/features/ct/domain/repositories/phieu_thu_repository.dart';

class CreatePhieuThu extends UseCase<PhieuThu, PhieuThu> {
  /// Repository responsible for persisting receipt voucher data
  final PhieuThuRepository repository;

  /// Creates a new instance of the CreatePhieuThu use case
  /// 
  /// [repository] The repository used to persist receipt voucher data
  CreatePhieuThu(this.repository);

  /// Executes the use case to create a receipt voucher
  /// 
  /// [params] The receipt voucher to create
  /// @return A Future containing either a Failure or the created PhieuThu with its ID
  @override
  Future<Either<Failure, PhieuThu>> call(PhieuThu params) async {
    return await repository.createPhieuThu(params);
  }
}