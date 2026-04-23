// ============================================================================
// Presentation Layer - Providers
// Based on UC_HKD_TT88_2021 - CT-01: Lập phiếu thu
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_thu.dart';
import 'package:hkd_accounting/features/ct/domain/usecases/create_phieu_thu.dart';
import 'package:hkd_accounting/features/ct/domain/usecases/approve_phieu_thu.dart';

class PhieuThuFormState {
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final String? errorMessage;
  final String? successMessage;
  final PhieuThu? phieuThu;

  const PhieuThuFormState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isError = false,
    this.errorMessage,
    this.successMessage,
    this.phieuThu,
  });

  PhieuThuFormState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    String? errorMessage,
    String? successMessage,
    PhieuThu? phieuThu,
  }) {
    return PhieuThuFormState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      phieuThu: phieuThu ?? this.phieuThu,
    );
  }
}

class PhieuThuNotifier extends StateNotifier<PhieuThuFormState> {
  final CreatePhieuThu createPhieuThuUseCase;
  final ApprovePhieuThu approvePhieuThuUseCase;

  PhieuThuNotifier()
      : createPhieuThuUseCase = GetIt.instance.get<CreatePhieuThu>(),
        approvePhieuThuUseCase = GetIt.instance.get<ApprovePhieuThu>(),
        super(const PhieuThuFormState());

  Future<void> createPhieuThu(PhieuThu phieuThu) async {
    state = state.copyWith(isLoading: true, isError: false, isSuccess: false);
    final result = await createPhieuThuUseCase(phieuThu);
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: _mapFailureToMessage(failure),
      ),
      (success) => state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        successMessage: 'Phiếu thu đã được tạo thành công',
        phieuThu: success,
      ),
    );
  }

  Future<void> approvePhieuThu(String id) async {
    state = state.copyWith(isLoading: true, isError: false, isSuccess: false);
    final result = await approvePhieuThuUseCase(id);
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: _mapFailureToMessage(failure),
      ),
      (success) => state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        successMessage: 'Phiếu thu đã được duyệt thành công',
        phieuThu: success,
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.toString();
  }
}

final phieuThuProvider = StateNotifierProvider<PhieuThuNotifier, PhieuThuFormState>((ref) {
  return PhieuThuNotifier();
});