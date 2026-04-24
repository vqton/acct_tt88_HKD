// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - NS-01: Tính lương người lao động
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/features/ns/domain/services/tinh_luong_service.dart';
import 'package:hkd_accounting/features/ns/domain/entities/tinh_luong_ke_hoach.dart';

final tinhLuongServiceProvider = Provider<TinhLuongService>((ref) {
  return TinhLuongService();
});

final tinhLuongListProvider = StateNotifierProvider<TinhLuongNotifier, AsyncValue<List<TinhLuongKeHoach>>>((ref) {
  return TinhLuongNotifier(ref.watch(tinhLuongServiceProvider));
});

class TinhLuongNotifier extends StateNotifier<AsyncValue<List<TinhLuongKeHoach>>> {
  final TinhLuongService _service;

  TinhLuongNotifier(this._service) : super(const AsyncValue.data([]));

  void calculateForList({
    required List<TinhLuongInput> inputs,
    required String thangNam,
  }) {
    final results = _service.tinhLuongChoNhieuNld(inputs: inputs, thangNam: thangNam);
    state = AsyncValue.data(results);
  }

  void clear() {
    state = const AsyncValue.data([]);
  }

  double get tongThuNhap => state.valueOrNull?.fold<double>(0, (sum, e) => sum + e.tongThuNhap) ?? 0;
}