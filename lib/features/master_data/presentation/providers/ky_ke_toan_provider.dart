// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - MD-08: Cấu hình kỳ kế toán
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/ky_ke_toan.dart';
import 'package:hkd_accounting/features/master_data/domain/repositories/ky_ke_toan_repository.dart';

// StateNotifier to manage the state of ky ke toan
class KyKeToanNotifier extends StateNotifier<AsyncValue<KyKeToan?>> {
  final KyKeToanRepository repository;

  KyKeToanNotifier()
      : repository = GetIt.instance.get<KyKeToanRepository>(),
        super(const AsyncValue.loading()) {
    loadKyKeToan();
  }

  Future<void> loadKyKeToan() async {
    state = const AsyncValue.loading();
    final result = await repository.getKyKeToan();
    state = result.when(
      success: (kyKeToan) => AsyncValue.data(kyKeToan),
      failure: (failure) => AsyncValue.error(failure, StackTrace.current),
    );
  }

  Future<void> saveKyKeToan(KyKeToan kyKeToan) async {
    await repository.saveKyKeToan(kyKeToan);
    await loadKyKeToan();
  }

  Future<void> updateKyKeToan(KyKeToan kyKeToan) async {
    await repository.updateKyKeToan(kyKeToan);
    await loadKyKeToan();
  }
}

// Provider for KyKeToanNotifier
final kyKeToanProvider = StateNotifierProvider<KyKeToanNotifier, AsyncValue<KyKeToan?>>((ref) {
  return KyKeToanNotifier();
});