import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
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
    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (e) => AsyncValue.error(e, StackTrace.current),
    );
  }

  Future<void> loadByKyKeToan(String kyKeToanId) async {
    state = const AsyncValue.loading();
    final result = await _repo.getByKyKeToan(kyKeToanId);
    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (e) => AsyncValue.error(e, StackTrace.current),
    );
  }
}

final soThueProvider =
    StateNotifierProvider<SoThueNotifier, AsyncValue<List<SoThue>>>((ref) {
  return SoThueNotifier();
});