// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - QT-03: Đóng kỳ kế toán và khóa sổ
// ============================================================================

import 'package:hkd_accounting/features/qt/data/models/dong_ky_ke_toan_model.dart';

abstract class DongKyKeToanLocalDatasource {
  Future<String> save(DongKyKeToanModel model);
  Future<DongKyKeToanModel?> getCurrent();
  Future<List<DongKyKeToanModel>> getList();
  Future<void> update(DongKyKeToanModel model);
  Future<void> delete(String id);
}