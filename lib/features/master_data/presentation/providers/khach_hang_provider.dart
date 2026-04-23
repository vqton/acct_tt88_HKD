// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - MD-05: Quản lý danh mục khách hàng
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/khach_hang.dart';
import 'package:hkd_accounting/features/master_data/domain/repositories/khach_hang_repository.dart';

class KhachHangNotifier extends StateNotifier<AsyncValue<List<KhachHang>>> {
  final KhachHangRepository repository;

  KhachHangNotifier()
      : repository = GetIt.instance.get<KhachHangRepository>(),
        super(const AsyncValue.loading()) {
    loadKhachHangList();
  }

  Future<void> loadKhachHangList() async {
    state = const AsyncValue.loading();
    final result = await repository.getKhachHangList();
    state = result.when(
      success: (khachHangList) => AsyncValue.data(khachHangList),
      failure: (failure) => AsyncValue.error(failure, StackTrace.current),
    );
  }

  Future<void> saveKhachHang(KhachHang khachHang) async {
    await repository.saveKhachHang(khachHang);
    await loadKhachHangList();
  }

  Future<void> updateKhachHang(KhachHang khachHang) async {
    await repository.updateKhachHang(khachHang);
    await loadKhachHangList();
  }

  Future<void> deleteKhachHang(String id) async {
    await repository.deleteKhachHang(id);
    await loadKhachHangList();
  }

  Future<List<KhachHang>> searchKhachHang(String query) async {
    final result = await repository.searchKhachHang(query);
    return result.fold(
      (failure) => [],
      (khachHangList) => khachHangList,
    );
  }
}

final khachHangProvider = StateNotifierProvider<KhachHangNotifier, AsyncValue<List<KhachHang>>>((ref) {
  return KhachHangNotifier();
});

final selectedKhachHangProvider = StateProvider<KhachHang?>((ref) => null);
