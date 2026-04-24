// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - CT-05: Lập bảng thanh toán tiền lương
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/ct/domain/entities/bang_luong.dart';
import 'package:hkd_accounting/features/ct/domain/repositories/bang_luong_repository.dart';

class BangLuongNotifier extends StateNotifier<AsyncValue<List<BangLuong>>> {
  final BangLuongRepository repository;

  BangLuongNotifier()
      : repository = GetIt.instance.get<BangLuongRepository>(),
        super(const AsyncValue.loading()) {
    loadList();
  }

  Future<void> loadList() async {
    state = const AsyncValue.loading();
    final result = await repository.getList();
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (list) => AsyncValue.data(list),
    );
  }

  Future<void> createBangLuong(BangLuong bangLuong) async {
    await repository.create(bangLuong);
    await loadList();
  }

  Future<void> updateBangLuong(BangLuong bangLuong) async {
    await repository.update(bangLuong);
    await loadList();
  }

  Future<void> deleteBangLuong(String id) async {
    await repository.delete(id);
    await loadList();
  }

  Future<void> approveBangLuong(String id, String nguoiDuyet) async {
    await repository.approve(id, nguoiDuyet);
    await loadList();
  }

  Future<void> addChiTiet(ChiTietBangLuong chiTiet) async {
    await repository.addChiTiet(chiTiet);
    await loadList();
  }

  Future<void> deleteChiTiet(String chiTietId) async {
    await repository.deleteChiTiet(chiTietId);
    await loadList();
  }
}

final bangLuongProvider =
    StateNotifierProvider<BangLuongNotifier, AsyncValue<List<BangLuong>>>((ref) {
  return BangLuongNotifier();
});

final selectedBangLuongProvider = StateProvider<BangLuong?>((ref) => null);