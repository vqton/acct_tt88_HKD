// ============================================================================
// Data Layer - Model
// Based on UC_HKD_TT88_2021 - NS-03: Theo dõi và thanh toán lương
// ============================================================================

import 'package:hkd_accounting/features/ns/domain/entities/thanh_toan_luong.dart';

class ThanhToanLuongModel extends ThanhToanLuong {
  const ThanhToanLuongModel({
    required super.id,
    required super.bangLuongId,
    required super.thangNam,
    required super.tongLuongPhaiTra,
    required super.daTraBangChuyenKhoan,
    required super.daTraTienMat,
    required super.conPhaiTra,
    super.ngayThanhToan,
    required super.trangThai,
    super.ghiChu,
    required super.createdAt,
  });

  factory ThanhToanLuongModel.fromEntity(ThanhToanLuong entity) {
    return ThanhToanLuongModel(
      id: entity.id,
      bangLuongId: entity.bangLuongId,
      thangNam: entity.thangNam,
      tongLuongPhaiTra: entity.tongLuongPhaiTra,
      daTraBangChuyenKhoan: entity.daTraBangChuyenKhoan,
      daTraTienMat: entity.daTraTienMat,
      conPhaiTra: entity.conPhaiTra,
      ngayThanhToan: entity.ngayThanhToan,
      trangThai: entity.trangThai,
      ghiChu: entity.ghiChu,
      createdAt: entity.createdAt,
    );
  }

  factory ThanhToanLuongModel.fromMap(Map<String, dynamic> map) {
    return ThanhToanLuongModel(
      id: map['id'] as String,
      bangLuongId: map['bang_luong_id'] as String? ?? '',
      thangNam: map['thang_nam'] as String? ?? '',
      tongLuongPhaiTra: (map['tong_luong_phai_tra'] as num?)?.toDouble() ?? 0,
      daTraBangChuyenKhoan: (map['da_tra_chuyen_khoan'] as num?)?.toDouble() ?? 0,
      daTraTienMat: (map['da_tra_tien_mat'] as num?)?.toDouble() ?? 0,
      conPhaiTra: (map['con_phai_tra'] as num?)?.toDouble() ?? 0,
      ngayThanhToan: map['ngay_thanh_toan'] != null ? DateTime.tryParse(map['ngay_thanh_toan'] as String) : null,
      trangThai: map['trang_thai'] as String? ?? 'CHUA_THANH_TOAN',
      ghiChu: map['ghi_chu'] as String?,
      createdAt: DateTime.tryParse(map['created_at'] as String? ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bang_luong_id': bangLuongId,
      'thang_nam': thangNam,
      'tong_luong_phai_tra': tongLuongPhaiTra,
      'da_tra_chuyen_khoan': daTraBangChuyenKhoan,
      'da_tra_tien_mat': daTraTienMat,
      'con_phai_tra': conPhaiTra,
      'ngay_thanh_toan': ngayThanhToan?.toIso8601String(),
      'trang_thai': trangThai,
      'ghi_chu': ghiChu,
      'created_at': createdAt.toIso8601String(),
    };
  }

  ThanhToanLuong toEntity() => this;
}