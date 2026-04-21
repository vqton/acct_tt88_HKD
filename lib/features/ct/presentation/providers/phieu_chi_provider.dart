// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - CT-02: Lập phiếu chi
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_chi.dart';
import 'package:hkd_accounting/features/ct/domain/repositories/phieu_chi_repository.dart';

// StateNotifier to manage the state of phieu chi list
class PhieuChiNotifier extends StateNotifier<AsyncValue<List<PhieuChi>>> {
  final PhieuChiRepository repository;

  PhieuChiNotifier()
      : repository = GetIt.instance.get<PhieuChiRepository>(),
        super(const AsyncValue.loading()) {
    loadPhieuChiList();
  }

  Future<void> loadPhieuChiList() async {
    state = const AsyncValue.loading();
    final result = await repository.getPhieuChiList();
    state = result.when(
      success: (phieuChiList) => AsyncValue.data(phieuChiList),
      failure: (failure) => AsyncValue.error(failure, StackTrace.current),
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

  Future<List<PhieuChi>> searchPhieuChi(String query) async {
    // TODO: Implement search in repository if needed
    final result = await repository.getPhieuChiList();
    return result.fold(
      (failure) => [],
      (phieuChiList) => phieuChiList
          .where((phieuChi) =>
              phieuChi.soPhieu.contains(query) ||
              phieuChi.nguoiNop.contains(query) ||
              phieuChi.lyDoNop.contains(query))
          .toList(),
    );
  }
}

// Provider for PhieuChiNotifier
final phieuChiProvider = StateNotifierProvider<PhieuChiNotifier, AsyncValue<List<PhieuChi>>>((ref) {
  return PhieuChiNotifier();
});

// Provider for selected phieu chi (for editing/detail view)
final selectedPhieuChiProvider = StateProvider<PhieuChi?>((ref) => null);