// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - TT-01: Quản lý quỹ tiền mặt
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/tt/domain/entities/quy_tien_mat.dart';
import 'package:hkd_accounting/features/tt/domain/repositories/quy_tien_mat_repository.dart';

// StateNotifier to manage the state of quy tien mat list
class QuyTienMatNotifier extends StateNotifier<AsyncValue<List<QuyTienMat>>> {
  final QuyTienMatRepository repository;

  QuyTienMatNotifier()
      : repository = GetIt.instance.get<QuyTienMatRepository>(),
        super(const AsyncValue.loading()) {
    loadQuyTienMatList();
  }

  Future<void> loadQuyTienMatList() async {
    state = const AsyncValue.loading();
    final result = await repository.getQuyTienMatList();
    state = result.when(
      success: (quyTienMatList) => AsyncValue.data(quyTienMatList),
      failure: (failure) => AsyncValue.error(failure, StackTrace.current),
    );
  }

  Future<void> saveQuyTienMat(QuyTienMat quyTienMat) async {
    await repository.createQuyTienMat(quyTienMat);
    await loadQuyTienMatList();
  }

  Future<void> updateQuyTienMat(QuyTienMat quyTienMat) async {
    await repository.updateQuyTienMat(quyTienMat);
    await loadQuyTienMatList();
  }

  Future<void> deleteQuyTienMat(String id) async {
    await repository.deleteQuyTienMat(id);
    await loadQuyTienMatList();
  }

  Future<List<QuyTienMat>> searchQuyTienMat(String query) async {
    // TODO: Implement search in repository if needed
    final result = await repository.getQuyTienMatList();
    return result.fold(
      (failure) => [],
      (quyTienMatList) => quyTienMatList
          .where((quyTienMat) =>
              quyTienMat.maQuy.contains(query) ||
              quyTienMat.tenQuy.contains(query))
          .toList(),
    );
  }
}

// Provider for QuyTienMatNotifier
final quyTienMatProvider = StateNotifierProvider<QuyTienMatNotifier, AsyncValue<List<QuyTienMat>>>((ref) {
  return QuyTienMatNotifier();
});

// Provider for selected quy tien mat (for editing/detail view)
final selectedQuyTienMatProvider = StateProvider<QuyTienMat?>((ref) => null);