// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - SK-08: Ghi sổ tiền gửi ngân hàng (S7-HKD)
// ============================================================================

/// Interface data source cho việc lưu trữ local dữ liệu Sổ tiền gửi ngân hàng (S7-HKD).
/// 
/// Interface này định nghĩa contract để truy xuất dữ liệu sổ tiền gửi ngân hàng
/// từ local storage (ví dụ: SQLite database)
/// theo UC_HKD_TT88_2021 - SK-08: Ghi sổ tiền gửi ngân hàng (S7-HKD).
abstract class SoTienGuiNganHangLocalDatasource {
  /// Tạo một dòng mới trong sổ tiền gửi ngân hàng
  /// 
  /// [soTienGuiNganHangModel] Model của dòng sổ cần tạo
  /// @return Future chứa ID của dòng đã tạo
  Future<String> createSoTienGuiNganHang(SoTienGuiNganHangModel soTienGuiNganHangModel);
  
  /// Lấy một dòng sổ theo ID
  /// 
  /// [id] ID duy nhất của dòng sổ cần lấy
  /// @return Future chứa SoTienGuiNganHangModel nếu tìm thấy (null nếu không tìm thấy)
  Future<SoTienGuiNganHangModel?> getSoTienGuiNganHangById(String id);
  
  /// Lấy tất cả các dòng sổ tiền gửi ngân hàng
  /// 
  /// @return Future chứa List của SoTienGuiNganHangModel
  Future<List<SoTienGuiNganHangModel>> getSoTienGuiNganHangList();
  
  /// Lấy các dòng sổ theo ID tài khoản ngân hàng
  /// 
  /// [taiKhoanNganHangId] ID của tài khoản ngân hàng
  /// @return Future chứa List của SoTienGuiNganHangModel thuộc tài khoản đó
  Future<List<SoTienGuiNganHangModel>> getSoTienGuiNganHangByTaiKhoanNganHangId(String taiKhoanNganHangId);
  
  /// Lấy các dòng sổ theo ID kỳ kế toán
  /// 
  /// [kyKeToanId] ID của kỳ kế toán
  /// @return Future chứa List của SoTienGuiNganHangModel thuộc kỳ đó
  Future<List<SoTienGuiNganHangModel>> getSoTienGuiNganHangByKyKeToanId(String kyKeToanId);
  
  /// Cập nhật một dòng sổ đã tồn tại
  /// 
  /// [soTienGuiNganHangModel] Model của dòng sổ với thông tin đã cập nhật
  /// @return Future void nếu thành công
  Future<void> updateSoTienGuiNganHang(SoTienGuiNganHangModel soTienGuiNganHangModel);
  
  /// Xóa một dòng sổ theo ID
  /// 
  /// [id] ID duy nhất của dòng sổ cần xóa
  /// @return Future void nếu thành công
  Future<void> deleteSoTienGuiNganHang(String id);
}