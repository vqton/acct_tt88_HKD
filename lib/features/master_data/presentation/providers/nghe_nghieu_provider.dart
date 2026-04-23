// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - MD-03
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/nghe_nghiep.dart';
import 'package:hkd_accounting/features/master_data/domain/repositories/nghe_nghiep_repository.dart';

// StateNotifier to manage the state of nghe nghieu list
class NgheNghiepNotifier extends StateNotifier<AsyncValue<List<NgheNghiep>>> {
  final NgheNghiepRepository repository;

  NgheNghiepNotifier()
      : repository = GetIt.instance.get<NgheNghiepRepository>(),
        super(const AsyncValue.loading()) {
    loadNgheNghiepList();
  }

  Future<void> loadNgheNghiepList() async {
    state = const AsyncValue.loading();
    final result = await repository.getNgheNghiepList();
    state = result.when(
      success: (list) => AsyncValue.data(list),
      failure: (failure) => AsyncValue.error(failure, StackTrace.current),
    );
  }

  Future<void> addOrUpdateNgheNghiep(NgheNghiep ngheNghieu) async {
    final maybeId = ngheNghieu.id.isEmpty ? null : ngheNghieu.id;
    if (maybeId != null) {
      await repository.updateNgheNghiep(ngheNghieu);
    } else {
      await repository.saveNgheNghiep(ngheNghieu);
    }
    await loadNgheNghiepList();
  }

  Future<void> deleteNgheNghiep(String id) async {
    await repository.deleteNgheNghiep(id);
    await loadNgheNghiepList();
  }
}

// Provider for NgheNghiepNotifier
final ngheNghieuProvider = StateNotifierProvider<NgheNghiepNotifier, AsyncValue<List<NgheNghiep>>>((ref) {
  return NgheNghiepNotifier();
});