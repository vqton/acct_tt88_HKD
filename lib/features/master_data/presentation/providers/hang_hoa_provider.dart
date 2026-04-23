// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - MD-02: Quản lý danh mục hàng hóa/dịch vụ
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/hang_hoa.dart';
import 'package:hkd_accounting/features/master_data/domain/repositories/hang_hoa_repository.dart';

// StateNotifier to manage the state of hang hoa list
class HangHoaNotifier extends StateNotifier<AsyncValue<List<HangHoa>>> {
  final HangHoaRepository repository;

  HangHoaNotifier()
      : repository = GetIt.instance.get<HangHoaRepository>(),
        super(const AsyncValue.loading()) {
    loadHangHoaList();
  }

  Future<void> loadHangHoaList() async {
    state = const AsyncValue.loading();
    final result = await repository.getHangHoaList();
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (hangHoaList) => AsyncValue.data(hangHoaList),
    );
  }

  Future<void> saveHangHoa(HangHoa hangHoa) async {
    await repository.saveHangHoa(hangHoa);
    await loadHangHoaList();
  }

  Future<void> updateHangHoa(HangHoa hangHoa) async {
    await repository.updateHangHoa(hangHoa);
    await loadHangHoaList();
  }

  Future<void> deleteHangHoa(String id) async {
    await repository.deleteHangHoa(id);
    await loadHangHoaList();
  }

  Future<List<HangHoa>> searchHangHoa(String query) async {
    final result = await repository.searchHangHoa(query);
    return result.fold(
      (failure) => [],
      (hangHoaList) => hangHoaList,
    );
  }
}

// Provider for HangHoaNotifier
final hangHoaProvider = StateNotifierProvider<HangHoaNotifier, AsyncValue<List<HangHoa>>>((ref) {
  return HangHoaNotifier();
});

// Provider for selected hang hoa (for editing/detail view)
final selectedHangHoaProvider = StateProvider<HangHoa?>((ref) => null);