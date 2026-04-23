// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - KH-03: Kiểm kê hàng tồn kho
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hkd_accounting/features/kh/domain/entities/phieu_kiem_ke.dart';
import 'package:hkd_accounting/features/kh/domain/repositories/phieu_kiem_ke_repository.dart';

class PhieuKiemKeNotifier extends StateNotifier<AsyncValue<List<PhieuKiemKe>>> {
  final PhieuKiemKeRepository repository;

  PhieuKiemKeNotifier()
      : repository = GetIt.instance.get<PhieuKiemKeRepository>(),
        super(const AsyncValue.loading()) {
    loadPhieuKiemKeList();
  }

  Future<void> loadPhieuKiemKeList() async {
    state = const AsyncValue.loading();
    final result = await repository.getPhieuKiemKeList();
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (data) => AsyncValue.data(data),
    );
  }

  Future<void> savePhieuKiemKe(PhieuKiemKe phieuKiemKe) async {
    await repository.savePhieuKiemKe(phieuKiemKe);
    await loadPhieuKiemKeList();
  }

  Future<void> updatePhieuKiemKe(PhieuKiemKe phieuKiemKe) async {
    await repository.updatePhieuKiemKe(phieuKiemKe);
    await loadPhieuKiemKeList();
  }

  Future<void> deletePhieuKiemKe(String id) async {
    await repository.deletePhieuKiemKe(id);
    await loadPhieuKiemKeList();
  }

  Future<List<ChiTietKiemKe>> getChiTietByPhieuId(String phieuId) async {
    final result = await repository.getChiTietByPhieuId(phieuId);
    return result.fold(
      (failure) => [],
      (chiTietList) => chiTietList,
    );
  }

  Future<void> saveChiTietKiemKe(ChiTietKiemKe chiTietKiemKe) async {
    await repository.saveChiTietKiemKe(chiTietKiemKe);
  }

  Future<void> updateChiTietKiemKe(ChiTietKiemKe chiTietKiemKe) async {
    await repository.updateChiTietKiemKe(chiTietKiemKe);
  }
}

final phieuKiemKeProvider = StateNotifierProvider<PhieuKiemKeNotifier, AsyncValue<List<PhieuKiemKe>>>((ref) {
  return PhieuKiemKeNotifier();
});

final selectedPhieuKiemKeProvider = StateProvider<PhieuKiemKe?>((ref) => null);