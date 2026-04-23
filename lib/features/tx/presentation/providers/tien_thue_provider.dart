// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - TX-01 Tiền thuế
// ============================================================================
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
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