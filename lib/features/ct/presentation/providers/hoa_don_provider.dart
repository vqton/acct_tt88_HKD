// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - CT-06: Quản lý hóa đơn
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hkd_accounting/features/ct/domain/entities/hoa_don.dart';
import 'package:hkd_accounting/features/ct/domain/repositories/hoa_don_repository.dart';

class HoaDonNotifier extends StateNotifier<AsyncValue<List<HoaDon>>> {
  final HoaDonRepository repository;

  HoaDonNotifier()
      : repository = GetIt.instance.get<HoaDonRepository>(),
        super(const AsyncValue.loading()) {
    loadHoaDonList();
  }

  Future<void> loadHoaDonList() async {
    state = const AsyncValue.loading();
    final result = await repository.getHoaDonList();
    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (err) => AsyncValue.error(err, StackTrace.current),
    );
  }

  Future<void> loadByLoai(String loaiHoaDon) async {
    state = const AsyncValue.loading();
    final result = await repository.getHoaDonByLoai(loaiHoaDon);
    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (err) => AsyncValue.error(err, StackTrace.current),
    );
  }

  Future<void> saveHoaDon(HoaDon hoaDon) async {
    await repository.createHoaDon(hoaDon);
    await loadHoaDonList();
  }

  Future<void> updateHoaDon(HoaDon hoaDon) async {
    await repository.updateHoaDon(hoaDon);
    await loadHoaDonList();
  }

  Future<void> deleteHoaDon(String id) async {
    await repository.deleteHoaDon(id);
    await loadHoaDonList();
  }

  Future<void> approveHoaDon(String id) async {
    await repository.approveHoaDon(id);
    await loadHoaDonList();
  }

  Future<List<HoaDon>> searchHoaDon(String query) async {
    final result = await repository.searchHoaDon(query);
    return result.fold((failure) => [], (list) => list);
  }
}

final hoaDonProvider = StateNotifierProvider<HoaDonNotifier, AsyncValue<List<HoaDon>>>((ref) {
  return HoaDonNotifier();
});

final hoaDonFilterProvider = StateProvider<String>((ref) => 'ALL');

final selectedHoaDonProvider = StateProvider<HoaDon?>((ref) => null);