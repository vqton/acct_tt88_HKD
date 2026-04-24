// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - NS-03: Theo dõi và thanh toán lương
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/features/ns/domain/entities/thanh_toan_luong.dart';
import 'package:hkd_accounting/features/ns/domain/repositories/thanh_toan_luong_repository.dart';
import 'package:hkd_accounting/features/ns/data/datasources/thanh_toan_luong_local_datasource_impl.dart';
import 'package:hkd_accounting/features/ns/data/repositories/thanh_toan_luong_repository_impl.dart';
import 'package:get_it/get_it.dart';

final thanhToanLuongDatasourceProvider = Provider<ThanhToanLuongLocalDatasourceImpl>((ref) {
  return GetIt.instance<ThanhToanLuongLocalDatasourceImpl>();
});

final thanhToanLuongRepositoryProvider = Provider<ThanhToanLuongRepository>((ref) {
  return ThanhToanLuongRepositoryImpl(ref.watch(thanhToanLuongDatasourceProvider));
});

final thanhToanLuongListProvider = StateNotifierProvider<ThanhToanLuongNotifier, AsyncValue<List<ThanhToanLuong>>>((ref) {
  return ThanhToanLuongNotifier(ref.watch(thanhToanLuongRepositoryProvider));
});

class ThanhToanLuongNotifier extends StateNotifier<AsyncValue<List<ThanhToanLuong>>> {
  final ThanhToanLuongRepository _repository;

  ThanhToanLuongNotifier(this._repository) : super(const AsyncValue.loading()) {
    load();
  }

  Future<void> load() async {
    state = const AsyncValue.loading();
    final result = await _repository.getList();
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (data) => AsyncValue.data(data),
    );
  }

  Future<bool> create(ThanhToanLuong entity) async {
    final result = await _repository.create(entity);
    if (result.isRight()) {
      await load();
      return true;
    }
    return false;
  }

  Future<bool> updateThanhToan(String id, double soTienChuyenKhoan, double soTienMat) async {
    final result = await _repository.updateThanhToan(id, soTienChuyenKhoan, soTienMat);
    if (result.isRight()) {
      await load();
      return true;
    }
    return false;
  }

  Future<bool> delete(String id) async {
    final result = await _repository.delete(id);
    if (result.isRight()) {
      await load();
      return true;
    }
    return false;
  }
}