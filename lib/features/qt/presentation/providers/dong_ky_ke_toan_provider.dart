// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - QT-03: Đóng kỳ kế toán và khóa sổ
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/features/qt/domain/entities/dong_ky_ke_toan.dart';
import 'package:hkd_accounting/features/qt/domain/repositories/dong_ky_ke_toan_repository.dart';
import 'package:hkd_accounting/features/qt/data/datasources/dong_ky_ke_toan_local_datasource_impl.dart';
import 'package:hkd_accounting/features/qt/data/repositories/dong_ky_ke_toan_repository_impl.dart';
import 'package:get_it/get_it.dart';

final dongKyKeToanDatasourceProvider = Provider<DongKyKeToanLocalDatasourceImpl>((ref) {
  return GetIt.instance<DongKyKeToanLocalDatasourceImpl>();
});

final dongKyKeToanRepositoryProvider = Provider<DongKyKeToanRepository>((ref) {
  return DongKyKeToanRepositoryImpl(ref.watch(dongKyKeToanDatasourceProvider));
});

final dongKyKeToanProvider = StateNotifierProvider<DongKyKeToanNotifier, AsyncValue<DongKyKeToan?>>((ref) {
  return DongKyKeToanNotifier(ref.watch(dongKyKeToanRepositoryProvider));
});

class DongKyKeToanNotifier extends StateNotifier<AsyncValue<DongKyKeToan?>> {
  final DongKyKeToanRepository _repository;

  DongKyKeToanNotifier(this._repository) : super(const AsyncValue.loading()) {
    load();
  }

  Future<void> load() async {
    state = const AsyncValue.loading();
    final result = await _repository.getCurrent();
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (data) => AsyncValue.data(data),
    );
  }

  Future<bool> createNew(String kyKeToanId, String thangNam) async {
    final entity = DongKyKeToan.createForKyKeToan(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      kyKeToanId: kyKeToanId,
      thangNam: thangNam,
      nguoiDong: 'Admin',
    );
    final result = await _repository.create(entity);
    if (result.isRight()) {
      await load();
      return true;
    }
    return false;
  }

  Future<bool> toggleQuyTienMat(DongKyKeToan item) async {
    final updated = item.copyWith(daDoiChieuQuyTienMat: !item.daDoiChieuQuyTienMat);
    final result = await _repository.update(updated);
    if (result.isRight()) {
      await load();
      return true;
    }
    return false;
  }

  Future<bool> toggleTienGui(DongKyKeToan item) async {
    final updated = item.copyWith(daDoiChieuTienGui: !item.daDoiChieuTienGui);
    final result = await _repository.update(updated);
    if (result.isRight()) {
      await load();
      return true;
    }
    return false;
  }

  Future<bool> toggleKiemKeTonKho(DongKyKeToan item) async {
    final updated = item.copyWith(daKiemKeTonKho: !item.daKiemKeTonKho);
    final result = await _repository.update(updated);
    if (result.isRight()) {
      await load();
      return true;
    }
    return false;
  }

  Future<bool> toggleXacNhanThue(DongKyKeToan item) async {
    final updated = item.copyWith(daXacNhanThue: !item.daXacNhanThue);
    final result = await _repository.update(updated);
    if (result.isRight()) {
      await load();
      return true;
    }
    return false;
  }

  Future<bool> closePeriod(DongKyKeToan item) async {
    final updated = item.copyWith(trangThai: 'DA_KHOA_SO');
    final result = await _repository.update(updated);
    if (result.isRight()) {
      await load();
      return true;
    }
    return false;
  }
}