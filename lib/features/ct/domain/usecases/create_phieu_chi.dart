// ============================================================================
// Domain Layer - Use Cases
// Based on UC_HKD_TT88_2021 - CT-02: Lập phiếu chi
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/core/usecases/usecase.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_chi.dart';
import 'package:hkd_accounting/features/ct/domain/repositories/phieu_chi_repository.dart';

class CreatePhieuChi extends UseCase<PhieuChi, PhieuChi> {
  final PhieuChiRepository repository;

  CreatePhieuChi(this.repository);

  @override
  Future<Either<Failure, PhieuChi>> call(PhieuChi params) async {
    return await repository.createPhieuChi(params);
  }
}