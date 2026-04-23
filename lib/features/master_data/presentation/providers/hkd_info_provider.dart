// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - MD-01: Quản lý thông tin HKD/CNKD
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/hkd_info.dart';
import 'package:hkd_accounting/features/master_data/domain/repositories/hkd_info_repository.dart';

// StateNotifier to manage the state of hkd info
class HkdInfoNotifier extends StateNotifier<AsyncValue<HkdInfo?>> {
  final HkdInfoRepository repository;

  HkdInfoNotifier()
      : repository = GetIt.instance.get<HkdInfoRepository>(),
        super(const AsyncValue.loading()) {
    loadHkdInfo();
  }

  Future<void> loadHkdInfo() async {
    state = const AsyncValue.loading();
    final result = await repository.getHkdInfo();
    state = result.when(
      success: (hkdInfo) => AsyncValue.data(hkdInfo),
      failure: (failure) => AsyncValue.error(failure, StackTrace.current),
    );
  }

  Future<void> saveHkdInfo(HkdInfo hkdInfo) async {
    await repository.saveHkdInfo(hkdInfo);
    await loadHkdInfo();
  }

  Future<void> updateHkdInfo(HkdInfo hkdInfo) async {
    await repository.updateHkdInfo(hkdInfo);
    await loadHkdInfo();
  }
}

// Provider for HkdInfoNotifier
final hkdInfoProvider = StateNotifierProvider<HkdInfoNotifier, AsyncValue<HkdInfo?>>((ref) {
  return HkdInfoNotifier();
});