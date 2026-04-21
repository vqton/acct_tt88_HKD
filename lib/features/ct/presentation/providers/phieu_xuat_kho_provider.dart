// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - CT-04: Lập phiếu xuất kho
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_xuat_kho.dart';
import 'package:hkd_accounting/features/ct/domain/repositories/phieu_xuat_kho_repository.dart';

class PhieuXuatKhoNotifier
    extends StateNotifier<AsyncValue<List<PhieuXuatKho>>> {
  final PhieuXuatKhoRepository repository;

  PhieuXuatKhoNotifier()
      : repository = GetIt.instance.get<PhieuXuatKhoRepository>(),
        super(const AsyncValue.loading()) {
    loadPhieuXuatKhoList();
  }

  Future<void> loadPhieuXuatKhoList() async {
    state = const AsyncValue.loading();
    final result = await repository.getPhieuXuatKhoList();
    state = result.when(
      success: (phieuXuatKhoList) => AsyncValue.data(phieuXuatKhoList),
      failure: (failure) => AsyncValue.error(failure, StackTrace.current),
    );
  }

  Future<void> savePhieuXuatKho(PhieuXuatKho phieuXuatKho) async {
    await repository.createPhieuXuatKho(phieuXuatKho);
    await loadPhieuXuatKhoList();
  }

  Future<void> updatePhieuXuatKho(PhieuXuatKho phieuXuatKho) async {
    await repository.updatePhieuXuatKho(phieuXuatKho);
    await loadPhieuXuatKhoList();
  }

  Future<void> deletePhieuXuatKho(String id) async {
    await repository.deletePhieuXuatKho(id);
    await loadPhieuXuatKhoList();
  }

  Future<void> approvePhieuXuatKho(String id) async {
    await repository.approvePhieuXuatKho(id);
    await loadPhieuXuatKhoList();
  }

  Future<List<PhieuXuatKho>> searchPhieuXuatKho(String query) async {
    final result = await repository.getPhieuXuatKhoList();
    return result.fold(
      (failure) => [],
      (phieuXuatKhoList) => phieuXuatKhoList
          .where((phieuXuatKho) =>
              phieuXuatKho.soPhieu.contains(query) ||
              (phieuXuatKho.lyDoXuat?.contains(query) ?? false) ||
              (phieuXuatKho.hoTenNguoiNhan?.contains(query) ?? false))
          .toList(),
    );
  }
}

final phieuXuatKhoProvider = StateNotifierProvider<
    PhieuXuatKhoNotifier, AsyncValue<List<PhieuXuatKho>>>((ref) {
  return PhieuXuatKhoNotifier();
});

final selectedPhieuXuatKhoProvider = StateProvider<PhieuXuatKho?>((ref) => null);
