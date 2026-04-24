// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - QT-04: Báo cáo tổng hợp cuối kỳ
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/features/qt/domain/entities/bao_cao_tong_hop.dart';

final baoCaoTongHopProvider = StateNotifierProvider<BaoCaoTongHopNotifier, AsyncValue<BaoCaoTongHop?>>((ref) {
  return BaoCaoTongHopNotifier();
});

class BaoCaoTongHopNotifier extends StateNotifier<AsyncValue<BaoCaoTongHop?>> {
  BaoCaoTongHopNotifier() : super(const AsyncValue.data(null));

  Future<void> generateReport() async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(milliseconds: 500));

    final now = DateTime.now();
    final report = BaoCaoTongHop(
      id: now.millisecondsSinceEpoch.toString(),
      kyKeToanId: '1',
      thangNam: DateTime(now.year, now.month).toString().substring(0, 7),
      ngayTao: now,
      tongDoanhThu: 150000000,
      tongChiPhi: 98000000,
      loiNhuan: 52000000,
      tongQuyTienMat: 25000000,
      tongTienGui: 75000000,
      tongTonKho: 45000000,
      tongBhxhPhaiNop: 12000000,
      tongThuePhaiNop: 8500000,
      doanhThuTheoNghe: {'Dịch vụ': 100000000, 'Bán lẻ': 50000000},
      chiPhiTheoLoai: {'Nhân sự': 45000000, 'Vật tư': 35000000, 'Khác': 18000000},
    );

    state = AsyncValue.data(report);
  }
}