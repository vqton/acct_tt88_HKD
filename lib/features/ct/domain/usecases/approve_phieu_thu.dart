// ============================================================================
// Domain Layer - Use Cases
// Based on UC_HKD_TT88_2021 - CT-08: Phê duyệt chứng từ
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/core/usecases/usecase.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_thu.dart';
import 'package:hkd_accounting/features/ct/domain/repositories/phieu_thu_repository.dart';

class ApprovePhieuThu extends UseCase<PhieuThu, String> {
  final PhieuThuRepository repository;

  ApprovePhieuThu(this.repository);

  @override
  Future<Either<Failure, PhieuThu>> call(String id) async {
    final result = await repository.getPhieuThuById(id);
    
    return result.fold(
      (failure) => Left(failure),
      (phieuThu) async {
        if (phieuThu == null) {
          return Left(EmptyFailure());
        }
        
        if (phieuThu.trangThai == 'DA_DUYET') {
          return Left(ValidationFailure('Phiếu thu đã được duyệt rồi'));
        }
        
        final approvedPhieuThu = phieuThu.copyWith(trangThai: 'DA_DUYET');
        final updateResult = await repository.updatePhieuThu(approvedPhieuThu);
        
        return updateResult.fold(
          (failure) => Left(failure),
          (_) => Right(approvedPhieuThu),
        );
      },
    );
  }
}