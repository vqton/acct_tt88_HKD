// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - CT-02: Lập phiếu chi
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_chi.dart';
import 'package:hkd_accounting/features/ct/domain/repositories/phieu_chi_repository.dart';
import 'package:hkd_accounting/features/ct/domain/usecases/create_phieu_chi.dart';
import 'package:hkd_accounting/features/ct/domain/usecases/approve_phieu_chi.dart';

class PhieuChiState {
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final String? errorMessage;
  final String? successMessage;
  final PhieuChi? phieuChi;

  const PhieuChiState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isError = false,
    this.errorMessage,
    this.successMessage,
    this.phieuChi,
  });

  PhieuChiState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    String? errorMessage,
    String? successMessage,
    PhieuChi? phieuChi,
  }) {
    return PhieuChiState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      phieuChi: phieuChi ?? this.phieuChi,
    );
  }
}

class PhieuChiNotifier extends StateNotifier<PhieuChiState> {
  final CreatePhieuChi createPhieuChiUseCase;
  final ApprovePhieuChi approvePhieuChiUseCase;
  final PhieuChiRepository repository;

  PhieuChiNotifier()
      : createPhieuChiUseCase = GetIt.instance.get<CreatePhieuChi>(),
        approvePhieuChiUseCase = GetIt.instance.get<ApprovePhieuChi>(),
        repository = GetIt.instance.get<PhieuChiRepository>(),
        super(const PhieuChiState());

  Future<void> createPhieuChi(PhieuChi phieuChi) async {
    state = state.copyWith(isLoading: true, isError: false, isSuccess: false);
    final result = await createPhieuChiUseCase(phieuChi);
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: failure.message,
      ),
      (created) => state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        successMessage: 'Phiếu chi đã được tạo thành công',
        phieuChi: created,
      ),
    );
  }

  Future<void> approvePhieuChi(String id) async {
    state = state.copyWith(isLoading: true, isError: false, isSuccess: false);
    final result = await approvePhieuChiUseCase(id);
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: failure.message,
      ),
      (approved) => state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        successMessage: 'Phiếu chi đã được duyệt thành công',
        phieuChi: approved,
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message;
  }
}

final phieuChiProvider = StateNotifierProvider<PhieuChiNotifier, PhieuChiState>((ref) {
  return PhieuChiNotifier();
});

final phieuChiListProvider = StateNotifierProvider<PhieuChiListNotifier, AsyncValue<List<PhieuChi>>>((ref) {
  return PhieuChiListNotifier();
});

class PhieuChiListNotifier extends StateNotifier<AsyncValue<List<PhieuChi>>> {
  final PhieuChiRepository repository;

  PhieuChiListNotifier()
      : repository = GetIt.instance.get<PhieuChiRepository>(),
        super(const AsyncValue.loading()) {
    loadPhieuChiList();
  }

  Future<void> loadPhieuChiList() async {
    state = const AsyncValue.loading();
    final result = await repository.getPhieuChiList();
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (phieuChiList) => state = AsyncValue.data(phieuChiList),
    );
  }

  Future<void> savePhieuChi(PhieuChi phieuChi) async {
    await repository.createPhieuChi(phieuChi);
    await loadPhieuChiList();
  }

  Future<void> updatePhieuChi(PhieuChi phieuChi) async {
    await repository.updatePhieuChi(phieuChi);
    await loadPhieuChiList();
  }

  Future<void> deletePhieuChi(String id) async {
    await repository.deletePhieuChi(id);
    await loadPhieuChiList();
  }
}

final selectedPhieuChiProvider = StateProvider<PhieuChi?>((ref) => null);