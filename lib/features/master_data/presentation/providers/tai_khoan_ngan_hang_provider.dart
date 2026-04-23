// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - MD-07: Quản lý danh mục tài khoản ngân hàng
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/tai_khoan_ngan_hang.dart';
import 'package:hkd_accounting/features/master_data/domain/repositories/tai_khoan_ngan_hang_repository.dart';

// StateNotifier to manage the state of tai khoan ngan hang list
class TaiKhoanNganHangNotifier extends StateNotifier<AsyncValue<List<TaiKhoanNganHang>>> {
  final TaiKhoanNganHangRepository repository;

  TaiKhoanNganHangNotifier()
      : repository = GetIt.instance.get<TaiKhoanNganHangRepository>(),
        super(const AsyncValue.loading()) {
    loadTaiKhoanNganHangList();
  }

  Future<void> loadTaiKhoanNganHangList() async {
    state = const AsyncValue.loading();
    final result = await repository.getTaiKhoanNganHangList();
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (taiKhoanNganHangList) => AsyncValue.data(taiKhoanNganHangList),
    );
  }

  Future<void> saveTaiKhoanNganHang(TaiKhoanNganHang taiKhoanNganHang) async {
    await repository.saveTaiKhoanNganHang(taiKhoanNganHang);
    await loadTaiKhoanNganHangList();
  }

  Future<void> updateTaiKhoanNganHang(TaiKhoanNganHang taiKhoanNganHang) async {
    await repository.updateTaiKhoanNganHang(taiKhoanNganHang);
    await loadTaiKhoanNganHangList();
  }

  Future<void> deleteTaiKhoanNganHang(String id) async {
    await repository.deleteTaiKhoanNganHang(id);
    await loadTaiKhoanNganHangList();
  }

  Future<List<TaiKhoanNganHang>> searchTaiKhoanNganHang(String query) async {
    final result = await repository.searchTaiKhoanNganHang(query);
    return result.fold(
      (failure) => [],
      (taiKhoanNganHangList) => taiKhoanNganHangList,
    );
  }
}

// Provider for TaiKhoanNganHangNotifier
final taiKhoanNganHangProvider = StateNotifierProvider<TaiKhoanNganHangNotifier, AsyncValue<List<TaiKhoanNganHang>>>((ref) {
  return TaiKhoanNganHangNotifier();
});

// Provider for selected tai khoan ngan hang (for editing/detail view)
final selectedTaiKhoanNganHangProvider = StateProvider<TaiKhoanNganHang?>((ref) => null);