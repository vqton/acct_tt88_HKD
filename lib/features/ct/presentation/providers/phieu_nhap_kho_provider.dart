// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - CT-03: Lập phiếu nhập kho
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_nhap_kho.dart';
import 'package:hkd_accounting/features/ct/domain/repositories/phieu_nhap_kho_repository.dart';

class PhieuNhapKhoNotifier
    extends StateNotifier<AsyncValue<List<PhieuNhapKho>>> {
  final PhieuNhapKhoRepository repository;

  PhieuNhapKhoNotifier()
      : repository = GetIt.instance.get<PhieuNhapKhoRepository>(),
        super(const AsyncValue.loading()) {
    loadPhieuNhapKhoList();
  }

  Future<void> loadPhieuNhapKhoList() async {
    state = const AsyncValue.loading();
    final result = await repository.getPhieuNhapKhoList();
    state = result.when(
      success: (phieuNhapKhoList) => AsyncValue.data(phieuNhapKhoList),
      failure: (failure) => AsyncValue.error(failure, StackTrace.current),
    );
  }

  Future<void> savePhieuNhapKho(PhieuNhapKho phieuNhapKho) async {
    await repository.createPhieuNhapKho(phieuNhapKho);
    await loadPhieuNhapKhoList();
  }

  Future<void> updatePhieuNhapKho(PhieuNhapKho phieuNhapKho) async {
    await repository.updatePhieuNhapKho(phieuNhapKho);
    await loadPhieuNhapKhoList();
  }

  Future<void> deletePhieuNhapKho(String id) async {
    await repository.deletePhieuNhapKho(id);
    await loadPhieuNhapKhoList();
  }

  Future<void> approvePhieuNhapKho(String id) async {
    await repository.approvePhieuNhapKho(id);
    await loadPhieuNhapKhoList();
  }

  Future<List<PhieuNhapKho>> searchPhieuNhapKho(String query) async {
    final result = await repository.getPhieuNhapKhoList();
    return result.fold(
      (failure) => [],
      (phieuNhapKhoList) => phieuNhapKhoList
          .where((phieuNhapKho) =>
              phieuNhapKho.soPhieu.contains(query) ||
              (phieuNhapKho.lyDoNhap?.contains(query) ?? false) ||
              (phieuNhapKho.nguoiGiaoHang?.contains(query) ?? false))
          .toList(),
    );
  }
}

final phieuNhapKhoProvider = StateNotifierProvider<
    PhieuNhapKhoNotifier, AsyncValue<List<PhieuNhapKho>>>((ref) {
  return PhieuNhapKhoNotifier();
});

final selectedPhieuNhapKhoProvider = StateProvider<PhieuNhapKho?>((ref) => null);
