import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
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