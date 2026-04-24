// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - QT-02: Sửa chữa / điều chỉnh sổ kế toán
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/features/qt/domain/entities/dieu_chinh_so.dart';

final dieuChinhSoProvider = StateNotifierProvider<DieuChinhSoNotifier, AsyncValue<List<DieuChinhSo>>>((ref) {
  return DieuChinhSoNotifier();
});

class DieuChinhSoNotifier extends StateNotifier<AsyncValue<List<DieuChinhSo>>> {
  final List<DieuChinhSo> _items = [];

  DieuChinhSoNotifier() : super(const AsyncValue.data([]));

  void createDieuChinh(
    String soKeToanLoai,
    PhuongPhapSuaChua phuongPhap,
    String noiDungSai,
    String noiDungDung,
    double giaTriTruoc,
    double giaTriSau,
    String lyDo,
  ) {
    final item = DieuChinhSo.create(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      soKeToanLoai: soKeToanLoai,
      soKeToanId: '1',
      phuongPhap: phuongPhap,
      noiDungSai: noiDungSai,
      noiDungDung: noiDungDung,
      giaTriTruoc: giaTriTruoc,
      giaTriSau: giaTriSau,
      lyDo: lyDo,
      nguoiThucHien: 'Kế toán viên',
    );
    _items.insert(0, item);
    state = AsyncValue.data(List.from(_items));
  }

  void approve(String id) {
    final index = _items.indexWhere((e) => e.id == id);
    if (index != -1) {
      _items[index] = _items[index].copyWith(
        trangThai: 'DA_XAC_NHAN',
        nguoiXacNhan: 'Người đại diện',
        ngayXacNhan: DateTime.now(),
      );
      state = AsyncValue.data(List.from(_items));
    }
  }

  void delete(String id) {
    _items.removeWhere((e) => e.id == id);
    state = AsyncValue.data(List.from(_items));
  }
}