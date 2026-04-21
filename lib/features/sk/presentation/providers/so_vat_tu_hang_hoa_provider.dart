// ============================================================================
// Presentation Layer - SK-03: Sổ chi tiết vật tư hàng hóa (S2-HKD) Provider
// Based on UC_HKD_TT88_2021 - SK-03
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hkd_accounting/features/kh/domain/entities/ton_kho.dart';
import 'package:hkd_accounting/features/kh/domain/repositories/ton_kho_repository.dart';
import 'package:hkd_accounting/features/sk/domain/services/so_vat_tu_hang_hoa_service.dart';

class SoVatTuHangHoaNotifier extends StateNotifier<AsyncValue<List<TonKho>>> {
  final TonKhoRepository repository;
  final SoVatTuHangHoaService service;

  SoVatTuHangHoaNotifier(this.repository, this.service)
      : super(const AsyncValue.loading()) {
    loadSoS2();
  }

  Future<void> loadSoS2() async {
    state = const AsyncValue.loading();
    final result = await repository.getTonKhoList('');
    state = result.when(
      success: (tonKhoList) => AsyncValue.data(tonKhoList),
      failure: (err) => AsyncValue.error(err, StackTrace.current),
    );
  }

  Future<void> loadForKyKeToan(String kyKeToanId) async {
    state = const AsyncValue.loading();
    final result = await repository.getTonKhoList(kyKeToanId);
    state = result.when(
      success: (tonKhoList) => AsyncValue.data(tonKhoList),
      failure: (err) => AsyncValue.error(err, StackTrace.current),
    );
  }

  Future<void> updateAfterNhapKho({
    required String kyKeToanId,
    required String hangHoaId,
    required double soLuongNhap,
    required int thanhTienNhap,
  }) async {
    final tonKhoResult = await repository.getTonKho(kyKeToanId, hangHoaId);

    await tonKhoResult.fold(
      (failure) async {},
      (currentTonKho) async {
        final updated = service.calculateFromNhapKho(
          currentTonKho: currentTonKho,
          soLuongNhap: soLuongNhap,
          thanhTienNhap: thanhTienNhap,
        );
        await repository.saveTonKho(updated);
      },
    );

    await loadSoS2();
  }

  Future<void> updateAfterXuatKho({
    required String kyKeToanId,
    required String hangHoaId,
    required double soLuongXuat,
  }) async {
    final tonKhoResult = await repository.getTonKho(kyKeToanId, hangHoaId);

    await tonKhoResult.fold(
      (failure) async {},
      (currentTonKho) async {
        final updated = service.calculateFromXuatKho(
          currentTonKho: currentTonKho,
          soLuongXuat: soLuongXuat,
        );
        await repository.saveTonKho(updated);
      },
    );

    await loadSoS2();
  }

  Future<void> closePeriod(String kyKeToanId) async {
    final result = await repository.getTonKhoList(kyKeToanId);

    await result.fold(
      (failure) async {},
      (tonKhoList) async {
        for (final tonKho in tonKhoList) {
          final closed = service.calculateEndOfPeriod(tonKho: tonKho);
          await repository.saveTonKho(closed);
        }
      },
    );

    await loadSoS2();
  }
}

final soVatTuHangHoaProvider = StateNotifierProvider<
    SoVatTuHangHoaNotifier, AsyncValue<List<TonKho>>>((ref) {
  return SoVatTuHangHoaNotifier(
    GetIt.instance.get<TonKhoRepository>(),
    SoVatTuHangHoaService(),
  );
});

final selectedKyKeToanForSoS2Provider = StateProvider<String>((ref) => '');