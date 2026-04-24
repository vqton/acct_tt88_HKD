// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - QT-06: Nhật ký hệ thống và Audit Trail
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/features/qt/domain/entities/nhat_ky_he_thong.dart';
import 'package:hkd_accounting/features/qt/domain/repositories/nhat_ky_he_thong_repository.dart';
import 'package:hkd_accounting/features/qt/data/datasources/nhat_ky_he_thong_local_datasource_impl.dart';
import 'package:hkd_accounting/features/qt/data/repositories/nhat_ky_he_thong_repository_impl.dart';
import 'package:get_it/get_it.dart';

final nhatKyHeThongDatasourceProvider = Provider<NhatKyHeThongLocalDatasourceImpl>((ref) {
  return GetIt.instance<NhatKyHeThongLocalDatasourceImpl>();
});

final nhatKyHeThongRepositoryProvider = Provider<NhatKyHeThongRepository>((ref) {
  return NhatKyHeThongRepositoryImpl(ref.watch(nhatKyHeThongDatasourceProvider));
});

final nhatKyHeThongListProvider = StateNotifierProvider<NhatKyHeThongNotifier, AsyncValue<List<NhatKyHeThong>>>((ref) {
  return NhatKyHeThongNotifier(ref.watch(nhatKyHeThongRepositoryProvider));
});

class NhatKyHeThongNotifier extends StateNotifier<AsyncValue<List<NhatKyHeThong>>> {
  final NhatKyHeThongRepository _repository;

  NhatKyHeThongNotifier(this._repository) : super(const AsyncValue.loading()) {
    load();
  }

  Future<void> load({int? limit, int? offset}) async {
    state = const AsyncValue.loading();
    final result = await _repository.getList(limit: limit, offset: offset);
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (data) => AsyncValue.data(data),
    );
  }

  Future<bool> createLog(NhatKyHeThong entity) async {
    final result = await _repository.create(entity);
    if (result.isRight()) {
      await load();
      return true;
    }
    return false;
  }

  Future<List<NhatKyHeThong>> getByDoiTuong(String doiTuongLoai, String doiTuongId) async {
    final result = await _repository.getByDoiTuong(doiTuongLoai, doiTuongId);
    return result.fold(
      (failure) => [],
      (data) => data,
    );
  }
}