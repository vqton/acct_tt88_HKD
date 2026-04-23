// ============================================================================
// Presentation Layer - SK-02: Sổ doanh thu (S1-HKD) Provider
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/sk/domain/entities/so_doanh_thu.dart';
import 'package:hkd_accounting/features/sk/domain/repositories/so_doanh_thu_repository.dart';
import 'package:hkd_accounting/features/ct/domain/entities/hoa_don.dart';
import 'package:hkd_accounting/features/ct/domain/repositories/hoa_don_repository.dart';

class SoDoanhThuNotifier extends StateNotifier<AsyncValue<List<SoDoanhThu>>> {
  final SoDoanhThuRepository repository;
  final HoaDonRepository hoaDonRepository;

  SoDoanhThuNotifier(this.repository, this.hoaDonRepository)
      : super(const AsyncValue.loading()) {
    loadSoS1();
  }

  Future<void> loadSoS1() async {
    state = const AsyncValue.loading();
    final result = await repository.getAll();
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (data) => AsyncValue.data(data),
    );
  }

  Future<void> loadByKyKeToan(String kyKeToanId) async {
    state = const AsyncValue.loading();
    final result = await repository.getByKyKeToan(kyKeToanId);
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (data) => AsyncValue.data(data),
    );
  }

  Future<void> generateFromHoaDon(String kyKeToanId) async {
    final hoaDonResult = await hoaDonRepository.getHoaDonByLoai('DAU_RA');
    
    await hoaDonResult.fold(
      (failure) async {},
      (hoaDonList) async {
        for (final hoaDon in hoaDonList) {
          final soDoanhThu = SoDoanhThu(
            id: '${kyKeToanId}_${hoaDon.id}',
            kyKeToanId: kyKeToanId,
            nhomNgheId: 'DEFAULT',
            ngayChungTu: hoaDon.ngayLap,
            soHieuChungTu: hoaDon.soHoaDon,
            dienGiai: 'Doanh thu từ hóa đơn ${hoaDon.soHoaDon}',
            doanhThu: hoaDon.tienHang,
          );
          await repository.create(soDoanhThu);
        }
      },
    );
    
    await loadSoS1();
  }
}

final soDoanhThuProvider =
    StateNotifierProvider<SoDoanhThuNotifier, AsyncValue<List<SoDoanhThu>>>((ref) {
  return SoDoanhThuNotifier(
    GetIt.instance.get<SoDoanhThuRepository>(),
    GetIt.instance.get<HoaDonRepository>(),
  );
});