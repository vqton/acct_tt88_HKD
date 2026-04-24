// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - QT-06: Nhật ký hệ thống và Audit Trail
// ============================================================================

import 'package:hkd_accounting/features/qt/data/models/nhat_ky_he_thong_model.dart';

abstract class NhatKyHeThongLocalDatasource {
  Future<String> save(NhatKyHeThongModel model);
  Future<List<NhatKyHeThongModel>> getList({int? limit, int? offset});
  Future<List<NhatKyHeThongModel>> getByUserId(String userId);
  Future<List<NhatKyHeThongModel>> getByDoiTuong(String doiTuongLoai, String doiTuongId);
  Future<List<NhatKyHeThongModel>> getByDateRange(DateTime from, DateTime to);
  Future<List<NhatKyHeThongModel>> getByHanhDong(String hanhDong);
  Future<NhatKyHeThongModel?> getById(String id);
  Future<int> getCount();
}