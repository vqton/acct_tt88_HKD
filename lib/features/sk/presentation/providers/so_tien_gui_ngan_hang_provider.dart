// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - SK-08: Ghi sổ tiền gửi ngân hàng (S7-HKD)
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/sk/domain/entities/so_tien_gui_ngan_hang.dart';
import 'package:hkd_accounting/features/sk/domain/repositories/so_tien_gui_ngan_hang_repository.dart';

class SoTienGuiNganHangFormState {
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final String? errorMessage;
  final String? successMessage;
  final SoTienGuiNganHang? soTienGuiNganHang;

  const SoTienGuiNganHangFormState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isError = false,
    this.errorMessage,
    this.successMessage,
    this.soTienGuiNganHang,
  });

  SoTienGuiNganHangFormState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    String? errorMessage,
    String? successMessage,
    SoTienGuiNganHang? soTienGuiNganHang,
  }) {
    return SoTienGuiNganHangFormState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      soTienGuiNganHang: soTienGuiNganHang ?? this.soTienGuiNganHang,
    );
  }
}

class SoTienGuiNganHangNotifier extends StateNotifier<SoTienGuiNganHangFormState> {
  final SoTienGuiNganHangRepository repository;

  SoTienGuiNganHangNotifier()
      : repository = GetIt.instance.get<SoTienGuiNganHangRepository>(),
        super(const SoTienGuiNganHangFormState());

  Future<void> createSoTienGuiNganHang(SoTienGuiNganHang soTienGuiNganHang) async {
    state = state.copyWith(isLoading: true, isError: false, isSuccess: false);
    final result = await repository.createSoTienGuiNganHang(soTienGuiNganHang);
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: _mapFailureToMessage(failure),
      ),
      (created) => state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        successMessage: 'Đã ghi sổ tiền gửi ngân hàng thành công',
        soTienGuiNganHang: created,
      ),
    );
  }

  Future<List<SoTienGuiNganHang>> getSoTienGuiNganHangList() async {
    final result = await repository.getSoTienGuiNganHangList();
    return result.fold(
      (failure) => [],
      (list) => list,
    );
  }

  Future<List<SoTienGuiNganHang>> getSoTienGuiNganHangByTaiKhoanNganHangId(String taiKhoanNganHangId) async {
    final result = await repository.getSoTienGuiNganHangByTaiKhoanNganHangId(taiKhoanNganHangId);
    return result.fold(
      (failure) => [],
      (list) => list,
    );
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.toString();
  }
}

final soTienGuiNganHangProvider = StateNotifierProvider<SoTienGuiNganHangNotifier, SoTienGuiNganHangFormState>((ref) {
  return SoTienGuiNganHangNotifier();
});

final soTienGuiNganHangListProvider = FutureProvider<List<SoTienGuiNganHang>>((ref) async {
  final notifier = ref.read(soTienGuiNganHangProvider.notifier);
  return notifier.getSoTienGuiNganHangList();
});