// ============================================================================
// Domain Layer - Use Cases
// Based on UC_HKD_TT88_2021 - CT-08: Phê duyệt chứng từ (cho Phiếu chi)
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/core/usecases/usecase.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_chi.dart';
import 'package:hkd_accounting/features/ct/domain/repositories/phieu_chi_repository.dart';

class ApprovePhieuChi extends UseCase<PhieuChi, String> {
  final PhieuChiRepository repository;

  ApprovePhieuChi(this.repository);

  @override
  Future<Either<Failure, PhieuChi>> call(String id) async {
    final result = await repository.getPhieuChiById(id);
    
    return result.fold(
      (failure) => Left(failure),
      (phieuChi) async {
        if (phieuChi == null) {
          return Left(EmptyFailure('Phiếu chi không tồn tại'));
        }
        
        if (phieuChi.trangThai == 'DA_DUYET') {
          return const Left(Failure('Phiếu chi đã được duyệt rồi'));
        }
        
        final approvedPhieuChi = phieuChi.copyWith(trangThai: 'DA_DUYET');
        final updateResult = await repository.updatePhieuChi(approvedPhieuChi);
        
        return updateResult.fold(
          (failure) => Left(failure),
          (_) => Right(approvedPhieuChi),
        );
      },
    );
  }
}