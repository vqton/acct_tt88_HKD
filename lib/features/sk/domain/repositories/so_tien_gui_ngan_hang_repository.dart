/// Repository interface cho các thao tác dữ liệu Sổ tiền gửi ngân hàng (S7-HKD).
/// 
/// Interface này định nghĩa contract để truy xuất và lưu trữ dữ liệu sổ tiền gửi ngân hàng
/// theo UC_HKD_TT88_2021 - SK-08: Ghi sổ tiền gửi ngân hàng (S7-HKD).
abstract class SoTienGuiNganHangRepository {
  Future<Either<Failure, SoTienGuiNganHang>> createSoTienGuiNganHang(SoTienGuiNganHang soTienGuiNganHang);
  
  Future<Either<Failure, SoTienGuiNganHang?>> getSoTienGuiNganHangById(String id);
  
  Future<Either<Failure, List<SoTienGuiNganHang>>> getSoTienGuiNganHangList();
  
  Future<Either<Failure, List<SoTienGuiNganHang>>> getSoTienGuiNganHangByTaiKhoanNganHangId(String taiKhoanNganHangId);
  
  Future<Either<Failure, List<SoTienGuiNganHang>>> getSoTienGuiNganHangByKyKeToanId(String kyKeToanId);
  
  Future<Either<Failure, void>> updateSoTienGuiNganHang(SoTienGuiNganHang soTienGuiNganHang);
  
  Future<Either<Failure, void>> deleteSoTienGuiNganHang(String id);
}