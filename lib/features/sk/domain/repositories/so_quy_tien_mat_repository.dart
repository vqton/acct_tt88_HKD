// ============================================================================
// Domain Layer - Repository Interface
// Based on UC_HKD_TT88_2021 - SK-07: Ghi sổ quỹ tiền mặt (S6-HKD)
// ============================================================================

/// Repository interface cho các thao tác dữ liệu Sổ quỹ tiền mặt (S6-HKD).
/// 
/// Interface này định nghĩa contract để truy xuất và lưu trữ dữ liệu sổ quỹ tiền mặt
/// theo UC_HKD_TT88_2021 - SK-07: Ghi sổ quỹ tiền mặt (S6-HKD).
/// 
/// Implementations nên xử lý việc lưu trữ dữ liệu (local/remote) và trả về kết quả
/// bọc trong Either<Failure, Success> để xử lý lỗi đúng cách.
abstract class SoQuyTienMatRepository {
  /// Tạo một dòng mới trong sổ quỹ tiền mặt
  /// 
  /// [soQuyTienMat] Dòng sổ cần tạo
  /// @return Future chứa Failure hoặc ID của dòng sổ đã tạo
  Future<Either<Failure, SoQuyTienMat>> createSoQuyTienMat(SoQuyTienMat soQuyTienMat);
  
  /// Lấy một dòng sổ theo ID
  /// 
  /// [id] ID duy nhất của dòng sổ cần lấy
  /// @return Future chứa Failure hoặc SoQuyTienMat nếu tìm thấy (null nếu không tìm thấy)
  Future<Either<Failure, SoQuyTienMat?>> getSoQuyTienMatById(String id);
  
  /// Lấy tất cả các dòng sổ quỹ tiền mặt
  /// 
  /// @return Future chứa Failure hoặc List các SoQuyTienMat
  Future<Either<Failure, List<SoQuyTienMat>>> getSoQuyTienMatList();
  
  /// Lấy các dòng sổ theo ID quỹ tiền mặt
  /// 
  /// [quyTienMatId] ID của quỹ tiền mặt
  /// @return Future chứa Failure hoặc List các SoQuyTienMat thuộc quỹ đó
  Future<Either<Failure, List<SoQuyTienMat>>> getSoQuyTienMatByQuyTienMatId(String quyTienMatId);
  
  /// Lấy các dòng sổ theo ID kỳ kế toán
  /// 
  /// [kyKeToanId] ID của kỳ kế toán
  /// @return Future chứa Failure hoặc List các SoQuyTienMat thuộc kỳ đó
  Future<Either<Failure, List<SoQuyTienMat>>> getSoQuyTienMatByKyKeToanId(String kyKeToanId);
  
  /// Cập nhật một dòng sổ đã tồn tại
  /// 
  /// [soQuyTienMat] Dòng sổ với thông tin đã cập nhật
  /// @return Future chứa Failure hoặc void nếu thành công
  Future<Either<Failure, void>> updateSoQuyTienMat(SoQuyTienMat soQuyTienMat);
  
  /// Xóa một dòng sổ theo ID
  /// 
  /// [id] ID duy nhất của dòng sổ cần xóa
  /// @return Future chứa Failure hoặc void nếu thành công
  Future<Either<Failure, void>> deleteSoQuyTienMat(String id);
}