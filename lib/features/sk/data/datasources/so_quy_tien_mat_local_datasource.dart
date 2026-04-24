// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - SK-07: Ghi sổ quỹ tiền mặt (S6-HKD)
// ============================================================================

import 'package:hkd_accounting/features/sk/data/models/so_quy_tien_mat_model.dart';

/// Interface data source cho việc lưu trữ local dữ liệu Sổ quỹ tiền mặt (S6-HKD).
/// 
/// Interface này định nghĩa contract để truy xuất dữ liệu sổ quỹ tiền mặt
/// từ local storage (ví dụ: SQLite database)
/// theo UC_HKD_TT88_2021 - SK-07: Ghi sổ quỹ tiền mặt (S6-HKD).
abstract class SoQuyTienMatLocalDatasource {
  /// Tạo một dòng mới trong sổ quỹ tiền mặt
  /// 
  /// [soQuyTienMatModel] Model của dòng sổ cần tạo
  /// @return Future chứa ID của dòng đã tạo
  Future<String> createSoQuyTienMat(SoQuyTienMatModel soQuyTienMatModel);
  
  /// Lấy một dòng sổ theo ID
  /// 
  /// [id] ID duy nhất của dòng sổ cần lấy
  /// @return Future chứa SoQuyTienMatModel nếu tìm thấy (null nếu không tìm thấy)
  Future<SoQuyTienMatModel?> getSoQuyTienMatById(String id);
  
  /// Lấy tất cả các dòng sổ quỹ tiền mặt
  /// 
  /// @return Future chứa List của SoQuyTienMatModel
  Future<List<SoQuyTienMatModel>> getSoQuyTienMatList();
  
  /// Lấy các dòng sổ theo ID quỹ tiền mặt
  /// 
  /// [quyTienMatId] ID của quỹ tiền mặt
  /// @return Future chứa List của SoQuyTienMatModel thuộc quỹ đó
  Future<List<SoQuyTienMatModel>> getSoQuyTienMatByQuyTienMatId(String quyTienMatId);
  
  /// Lấy các dòng sổ theo ID kỳ kế toán
  /// 
  /// [kyKeToanId] ID của kỳ kế toán
  /// @return Future chứa List của SoQuyTienMatModel thuộc kỳ đó
  Future<List<SoQuyTienMatModel>> getSoQuyTienMatByKyKeToanId(String kyKeToanId);
  
  /// Cập nhật một dòng sổ đã tồn tại
  /// 
  /// [soQuyTienMatModel] Model của dòng sổ với thông tin đã cập nhật
  /// @return Future void nếu thành công
  Future<void> updateSoQuyTienMat(SoQuyTienMatModel soQuyTienMatModel);
  
  /// Xóa một dòng sổ theo ID
  /// 
  /// [id] ID duy nhất của dòng sổ cần xóa
  /// @return Future void nếu thành công
  Future<void> deleteSoQuyTienMat(String id);
}