// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - MD-04: Quản lý danh mục nhà cung cấp
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/nha_cung_cap.dart';
import 'package:hkd_accounting/features/master_data/domain/repositories/nha_cung_cap_repository.dart';

// StateNotifier to manage the state of nha cung cap list
class NhaCungCapNotifier extends StateNotifier<AsyncValue<List<NhaCungCap>>> {
  final NhaCungCapRepository repository;

  NhaCungCapNotifier()
      : repository = GetIt.instance.get<NhaCungCapRepository>(),
        super(const AsyncValue.loading()) {
    loadNhaCungCapList();
  }

  Future<void> loadNhaCungCapList() async {
    state = const AsyncValue.loading();
    final result = await repository.getNhaCungCapList();
    state = result.when(
      success: (nhaCungCapList) => AsyncValue.data(nhaCungCapList),
      failure: (failure) => AsyncValue.error(failure, StackTrace.current),
    );
  }

  Future<void> saveNhaCungCap(NhaCungCap nhaCungCap) async {
    await repository.saveNhaCungCap(nhaCungCap);
    await loadNhaCungCapList();
  }

  Future<void> updateNhaCungCap(NhaCungCap nhaCungCap) async {
    await repository.updateNhaCungCap(nhaCungCap);
    await loadNhaCungCapList();
  }

  Future<void> deleteNhaCungCap(String id) async {
    await repository.deleteNhaCungCap(id);
    await loadNhaCungCapList();
  }

  Future<List<NhaCungCap>> searchNhaCungCap(String query) async {
    final result = await repository.searchNhaCungCap(query);
    return result.fold(
      (failure) => [],
      (nhaCungCapList) => nhaCungCapList,
    );
  }
}

// Provider for NhaCungCapNotifier
final nhaCungCapProvider = StateNotifierProvider<NhaCungCapNotifier, AsyncValue<List<NhaCungCap>>>((ref) {
  return NhaCungCapNotifier();
});

// Provider for selected nha cung cap (for editing/detail view)
final selectedNhaCungCapProvider = StateProvider<NhaCungCap?>((ref) => null);