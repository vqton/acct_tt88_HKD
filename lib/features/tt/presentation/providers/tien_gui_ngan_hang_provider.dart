// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - TT-02: Quản lý tiền gửi ngân hàng
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/tt/domain/entities/tien_gui_ngan_hang.dart';
import 'package:hkd_accounting/features/tt/domain/repositories/tien_gui_ngan_hang_repository.dart';

// StateNotifier to manage the state of tien gui ngan hang list
class TienGuiNganHangNotifier extends StateNotifier<AsyncValue<List<TienGuiNganHang>>> {
  final TienGuiNganHangRepository repository;

  TienGuiNganHangNotifier()
      : repository = GetIt.instance.get<TienGuiNganHangRepository>(),
        super(const AsyncValue.loading()) {
    loadTienGuiNganHangList();
  }

  Future<void> loadTienGuiNganHangList() async {
    state = const AsyncValue.loading();
    final result = await repository.getTienGuiNganHangList();
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (tienGuiNganHangList) => AsyncValue.data(tienGuiNganHangList),
    );
  }

  Future<void> saveTienGuiNganHang(TienGuiNganHang tienGuiNganHang) async {
    await repository.createTienGuiNganHang(tienGuiNganHang);
    await loadTienGuiNganHangList();
  }

  Future<void> updateTienGuiNganHang(TienGuiNganHang tienGuiNganHang) async {
    await repository.updateTienGuiNganHang(tienGuiNganHang);
    await loadTienGuiNganHangList();
  }

  Future<void> deleteTienGuiNganHang(String id) async {
    await repository.deleteTienGuiNganHang(id);
    await loadTienGuiNganHangList();
  }

  Future<List<TienGuiNganHang>> searchTienGuiNganHang(String query) async {
    // TODO: Implement search in repository if needed
    final result = await repository.getTienGuiNganHangList();
    return result.fold(
      (failure) => [],
      (tienGuiNganHangList) => tienGuiNganHangList
          .where((tienGuiNganHang) =>
              tienGuiNganHang.maTaiKhoan.contains(query) ||
              tienGuiNganHang.tenTaiKhoan.contains(query))
          .toList(),
    );
  }
}

// Provider for TienGuiNganHangNotifier
final tienGuiNganHangProvider = StateNotifierProvider<TienGuiNganHangNotifier, AsyncValue<List<TienGuiNganHang>>>((ref) {
  return TienGuiNganHangNotifier();
});

// Provider for selected tien gui ngan hang (for editing/detail view)
final selectedTienGuiNganHangProvider = StateProvider<TienGuiNganHang?>((ref) => null);