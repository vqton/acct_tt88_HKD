// ============================================================================
// Data Layer - Model
// Based on UC_HKD_TT88_2021 - SK-08: Ghi sổ tiền gửi ngân hàng (S7-HKD)
// ============================================================================

/// Model đại diện cho dữ liệu Sổ tiền gửi ngân hàng (S7-HKD) trong database.
/// 
/// Model này xử lý việc chuyển đổi giữa entity domain và database map
/// theo UC_HKD_TT88_2021 - SK-08: Ghi sổ tiền gửi ngân hàng (S7-HKD).
class SoTienGuiNganHangModel {
  /// ID duy nhất cho dòng sổ
  final String id;
  
  /// Ngày lập chứng từ
  final DateTime ngayLap;
  
  /// Số chứng từ
  final String soChungTu;
  
  /// Loại chứng từ
  final String loaiChungTu;
  
  /// Lý do nghiệp vụ
  final String lyDo;
  
  /// Số tiền
  final int soTien;
  
  /// ID của tài khoản ngân hàng
  final String taiKhoanNganHangId;
  
  /// ID của kỳ kế toán
  final String kyKeToanId;
  
  /// Thời điểm tạo
  final DateTime? createdAt;
  
  /// Thời điểm cập nhật
  final DateTime? updatedAt;

  /// Tạo instance từ Map database
  SoTienGuiNganHangModel({
    required this.id,
    required this.ngayLap,
    required this.soChungTu,
    required this.loaiChungTu,
    required this.lyDo,
    required this.soTien,
    required this.taiKhoanNganHangId,
    required this.kyKeToanId,
    this.createdAt,
    this.updatedAt,
  });

  /// Tạo instance từ Map database
  factory SoTienGuiNganHangModel.fromMap(Map<String, dynamic> map) {
    return SoTienGuiNganHangModel(
      id: map['id'] as String,
      ngayLap: DateTime.parse(map['ngay_lap'] as String),
      soChungTu: map['so_chung_tu'] as String,
      loaiChungTu: map['loai_chung_tu'] as String,
      lyDo: map['ly_do'] as String,
      soTien: map['so_tien'] as int,
      taiKhoanNganHangId: map['tai_khoan_ngan_hang_id'] as String,
      kyKeToanId: map['ky_ke_toan_id'] as String,
      createdAt: map['created_at'] != null 
          ? DateTime.parse(map['created_at'] as String) 
          : null,
      updatedAt: map['updated_at'] != null 
          ? DateTime.parse(map['updated_at'] as String) 
          : null,
    );
  }

  /// Chuyển đổi sang Map cho database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ngay_lap': ngayLap.toIso8601String(),
      'so_chung_tu': soChungTu,
      'loai_chung_tu': loaiChungTu,
      'ly_do': lyDo,
      'so_tien': soTien,
      'tai_khoan_ngan_hang_id': taiKhoanNganHangId,
      'ky_ke_toan_id': kyKeToanId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  /// Tạo instance từ entity domain
  factory SoTienGuiNganHangModel.fromEntity(SoTienGuiNganHang entity) {
    return SoTienGuiNganHangModel(
      id: entity.id,
      ngayLap: entity.ngayLap,
      soChungTu: entity.soChungTu,
      loaiChungTu: entity.loaiChungTu,
      lyDo: entity.lyDo,
      soTien: entity.soTien,
      taiKhoanNganHangId: entity.taiKhoanNganHangId,
      kyKeToanId: entity.kyKeToanId,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// Chuyển đổi sang entity domain
  SoTienGuiNganHang toEntity() {
    return SoTienGuiNganHang(
      id: id,
      ngayLap: ngayLap,
      soChungTu: soChungTu,
      loaiChungTu: loaiChungTu,
      lyDo: lyDo,
      soTien: soTien,
      taiKhoanNganHangId: taiKhoanNganHangId,
      kyKeToanId: kyKeToanId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}