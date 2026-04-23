// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - TX-04 Sổ thuế
// ============================================================================
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/tx/domain/entities/so_thue.dart';
import 'package:hkd_accounting/features/tx/domain/repositories/so_thue_repository.dart';

class SoThueNotifier extends StateNotifier<AsyncValue<List<SoThue>>> {
  final SoThueRepository _repo;

  SoThueNotifier()
      : _repo = GetIt.instance.get<SoThueRepository>(),
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
}

final soThueProvider =
    StateNotifierProvider<SoThueNotifier, AsyncValue<List<SoThue>>>((ref) {
  return SoThueNotifier();
});