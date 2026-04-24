// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - SK-06: Ghi sổ theo dõi thanh toán tiền lương (S5-HKD)
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/features/sk/domain/entities/so_theo_doi_tien_luong.dart';
import 'package:hkd_accounting/features/sk/domain/repositories/so_theo_doi_tien_luong_repository.dart';
import 'package:hkd_accounting/features/sk/data/datasources/so_theo_doi_tien_luong_local_datasource_impl.dart';
import 'package:hkd_accounting/features/sk/data/repositories/so_theo_doi_tien_luong_repository_impl.dart';
import 'package:get_it/get_it.dart';

final soTheoDoiTienLuongDatasourceProvider = Provider<SoTheoDoiTienLuongLocalDatasourceImpl>((ref) {
  return GetIt.instance<SoTheoDoiTienLuongLocalDatasourceImpl>();
});

final soTheoDoiTienLuongRepositoryProvider = Provider<SoTheoDoiTienLuongRepository>((ref) {
  return SoTheoDoiTienLuongRepositoryImpl(ref.watch(soTheoDoiTienLuongDatasourceProvider));
});

final soTheoDoiTienLuongListProvider = StateNotifierProvider<SoTheoDoiTienLuongNotifier, AsyncValue<List<SoTheoDoiTienLuong>>>((ref) {
  return SoTheoDoiTienLuongNotifier(ref.watch(soTheoDoiTienLuongRepositoryProvider));
});

class SoTheoDoiTienLuongNotifier extends StateNotifier<AsyncValue<List<SoTheoDoiTienLuong>>> {
  final SoTheoDoiTienLuongRepository _repository;

  SoTheoDoiTienLuongNotifier(this._repository) : super(const AsyncValue.loading()) {
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

  Future<bool> create(SoTheoDoiTienLuong entity) async {
    final result = await _repository.create(entity);
    if (result.isRight()) {
      await load();
      return true;
    }
    return false;
  }

  Future<bool> updateThanhToan(String id, double soTien) async {
    final result = await _repository.updateThanhToan(id, soTien);
    if (result.isRight()) {
      await load();
      return true;
    }
    return false;
  }

  Future<bool> updateBhxhNop(String id, double bhxhDaNop, double bhytDaNop, double bhtnDaNop) async {
    final result = await _repository.updateBhxhNop(id, bhxhDaNop, bhytDaNop, bhtnDaNop);
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