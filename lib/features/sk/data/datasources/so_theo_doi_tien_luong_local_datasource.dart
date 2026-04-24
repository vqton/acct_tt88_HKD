// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - SK-06: Ghi sổ theo dõi thanh toán tiền lương (S5-HKD)
// ============================================================================

import 'package:hkd_accounting/features/sk/data/models/so_theo_doi_tien_luong_model.dart';

abstract class SoTheoDoiTienLuongLocalDatasource {
  Future<String> save(SoTheoDoiTienLuongModel model);
  Future<SoTheoDoiTienLuongModel?> getById(String id);
  Future<List<SoTheoDoiTienLuongModel>> getList();
  Future<List<SoTheoDoiTienLuongModel>> getByKyKeToanId(String kyKeToanId);
  Future<List<SoTheoDoiTienLuongModel>> getByBangLuongId(String bangLuongId);
  Future<void> update(SoTheoDoiTienLuongModel model);
  Future<void> delete(String id);
  Future<void> updateThanhToan(String id, double soTien);
  Future<void> updateBhxhNop(String id, double bhxhDaNop, double bhytDaNop, double bhtnDaNop);
}