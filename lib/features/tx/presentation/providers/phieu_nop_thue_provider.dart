// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - TX-02 Phiếu nộp thuế
// ============================================================================
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/tx/domain/entities/phieu_nop_thue.dart';
import 'package:hkd_accounting/features/tx/domain/repositories/phieu_nop_thue_repository.dart';

class PhieuNopThueNotifier extends StateNotifier<AsyncValue<List<PhieuNopThue>>> {
  final PhieuNopThueRepository _repo;

  PhieuNopThueNotifier()
      : _repo = GetIt.instance.get<PhieuNopThueRepository>(),
        super(const AsyncValue.loading()) {
    loadAll();
  }

  Future<void> loadAll() async {
    state = const AsyncValue.loading();
    final result = await _repo.getAll();
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (data) => AsyncValue.data(data),
    );
  }

  Future<void> loadByKyKeToan(String kyKeToanId) async {
    state = const AsyncValue.loading();
    final result = await _repo.getByKyKeToan(kyKeToanId);
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (data) => AsyncValue.data(data),
    );
  }

  Future<void> createPhieuNopThue(PhieuNopThue phieu) async {
    state = const AsyncValue.loading();
    final result = await _repo.create(phieu);
    result.fold(
      (e) => state = AsyncValue.error(e, StackTrace.current),
      (_) => loadAll(),
    );
  }

  Future<void> deletePhieuNopThue(String id) async {
    await _repo.delete(id);
    loadAll();
  }
}

final phieuNopThueProvider =
    StateNotifierProvider<PhieuNopThueNotifier, AsyncValue<List<PhieuNopThue>>>(
        (ref) {
  return PhieuNopThueNotifier();
});