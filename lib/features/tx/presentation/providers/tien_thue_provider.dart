import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hkd_accounting/features/tx/domain/entities/doanh_thu_chiu_thue.dart';
import 'package:hkd_accounting/features/tx/domain/entities/tien_thue_gtgt.dart';
import 'package:hkd_accounting/features/tx/domain/repositories/tien_thue_repository.dart';

class TienThueNotifier extends StateNotifier<AsyncValue<List<TienThueGtgt>>> {
  final TienThueRepository _repo;

  TienThueNotifier()
      : _repo = GetIt.instance.get<TienThueRepository>(),
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

  Future<void> calculateGtgt(String kyKeToanId) async {
    state = const AsyncValue.loading();
    final result = await _repo.calculateGtgt(kyKeToanId);
    result.fold(
      (e) => state = AsyncValue.error(e, StackTrace.current),
      (_) => loadByKyKeToan(kyKeToanId),
    );
  }

  Future<List<DoanhThuChiuThue>> getDoanhThuChiuThue(String kyKeToanId) async {
    final result = await _repo.getDoanhThuChiuThue(kyKeToanId);
    return result.fold((e) => [], (data) => data);
  }
}

final tienThueGtgtProvider =
    StateNotifierProvider<TienThueNotifier, AsyncValue<List<TienThueGtgt>>>((ref) {
  return TienThueNotifier();
});

final tienThueTncnProvider =
    StateNotifierProvider<TienThueNotifier, AsyncValue<List<TienThueGtgt>>>((ref) {
  return TienThueNotifier();
});