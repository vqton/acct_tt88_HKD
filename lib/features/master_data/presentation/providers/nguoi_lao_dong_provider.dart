// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - MD-06: Quản lý danh mục người lao động
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/nguoi_lao_dong.dart';
import 'package:hkd_accounting/features/master_data/domain/repositories/nguoi_lao_dong_repository.dart';

// StateNotifier to manage the state of nguoi lao dong list
class NguoiLaoDongNotifier extends StateNotifier<AsyncValue<List<NguoiLaoDong>>> {
  final NguoiLaoDongRepository repository;

  NguoiLaoDongNotifier()
      : repository = GetIt.instance.get<NguoiLaoDongRepository>(),
        super(const AsyncValue.loading()) {
    loadNguoiLaoDongList();
  }

  Future<void> loadNguoiLaoDongList() async {
    state = const AsyncValue.loading();
    final result = await repository.getNguoiLaoDongList();
    state = result.when(
      success: (nguoiLaoDongList) => AsyncValue.data(nguoiLaoDongList),
      failure: (failure) => AsyncValue.error(failure, StackTrace.current),
    );
  }

  Future<void> saveNguoiLaoDong(NguoiLaoDong nguoiLaoDong) async {
    await repository.saveNguoiLaoDong(nguoiLaoDong);
    await loadNguoiLaoDongList();
  }

  Future<void> updateNguoiLaoDong(NguoiLaoDong nguoiLaoDong) async {
    await repository.updateNguoiLaoDong(nguoiLaoDong);
    await loadNguoiLaoDongList();
  }

  Future<void> deleteNguoiLaoDong(String id) async {
    await repository.deleteNguoiLaoDong(id);
    await loadNguoiLaoDongList();
  }

  Future<List<NguoiLaoDong>> searchNguoiLaoDong(String query) async {
    final result = await repository.searchNguoiLaoDong(query);
    return result.fold(
      (failure) => [],
      (nguoiLaoDongList) => nguoiLaoDongList,
    );
  }
}

// Provider for NguoiLaoDongNotifier
final nguoiLaoDongProvider = StateNotifierProvider<NguoiLaoDongNotifier, AsyncValue<List<NguoiLaoDong>>>((ref) {
  return NguoiLaoDongNotifier();
});

// Provider for selected nguoi lao dong (for editing/detail view)
final selectedNguoiLaoDongProvider = StateProvider<NguoiLaoDong?>((ref) => null);