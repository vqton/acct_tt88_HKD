// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - NS-03: Theo dõi và thanh toán lương
// ============================================================================

import 'package:hkd_accounting/features/ns/data/models/thanh_toan_luong_model.dart';

abstract class ThanhToanLuongLocalDatasource {
  Future<String> save(ThanhToanLuongModel model);
  Future<ThanhToanLuongModel?> getById(String id);
  Future<List<ThanhToanLuongModel>> getList();
  Future<List<ThanhToanLuongModel>> getByBangLuongId(String bangLuongId);
  Future<void> update(ThanhToanLuongModel model);
  Future<void> delete(String id);
  Future<void> updateThanhToan(String id, double soTienChuyenKhoan, double soTienMat);
}