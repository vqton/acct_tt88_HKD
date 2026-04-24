// ============================================================================
// Data Layer - Model
// Based on UC_HKD_TT88_2021 - QT-03: Đóng kỳ kế toán và khóa sổ
// ============================================================================

import 'package:hkd_accounting/features/qt/domain/entities/dong_ky_ke_toan.dart';

class DongKyKeToanModel extends DongKyKeToan {
  const DongKyKeToanModel({
    required super.id,
    required super.kyKeToanId,
    required super.thangNam,
    required super.ngayDong,
    required super.nguoiDong,
    required super.trangThai,
    required super.daDoiChieuQuyTienMat,
    required super.daDoiChieuTienGui,
    required super.daKiemKeTonKho,
    required super.daXacNhanThue,
    super.ghiChu,
    required super.createdAt,
  });

  factory DongKyKeToanModel.fromEntity(DongKyKeToan entity) {
    return DongKyKeToanModel(
      id: entity.id,
      kyKeToanId: entity.kyKeToanId,
      thangNam: entity.thangNam,
      ngayDong: entity.ngayDong,
      nguoiDong: entity.nguoiDong,
      trangThai: entity.trangThai,
      daDoiChieuQuyTienMat: entity.daDoiChieuQuyTienMat,
      daDoiChieuTienGui: entity.daDoiChieuTienGui,
      daKiemKeTonKho: entity.daKiemKeTonKho,
      daXacNhanThue: entity.daXacNhanThue,
      ghiChu: entity.ghiChu,
      createdAt: entity.createdAt,
    );
  }

  factory DongKyKeToanModel.fromMap(Map<String, dynamic> map) {
    return DongKyKeToanModel(
      id: map['id'] as String,
      kyKeToanId: map['ky_ke_toan_id'] as String? ?? '',
      thangNam: map['thang_nam'] as String? ?? '',
      ngayDong: DateTime.tryParse(map['ngay_dong'] as String? ?? '') ?? DateTime.now(),
      nguoiDong: map['nguoi_dong'] as String? ?? '',
      trangThai: map['trang_thai'] as String? ?? 'DANG_KIEM_TRA',
      daDoiChieuQuyTienMat: (map['da_doi_chieu_quy_tien_mat'] as num?)?.toInt() == 1,
      daDoiChieuTienGui: (map['da_doi_chieu_tien_gui'] as num?)?.toInt() == 1,
      daKiemKeTonKho: (map['da_kiem_ke_ton_kho'] as num?)?.toInt() == 1,
      daXacNhanThue: (map['da_xac_nhan_thue'] as num?)?.toInt() == 1,
      ghiChu: map['ghi_chu'] as String?,
      createdAt: DateTime.tryParse(map['created_at'] as String? ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ky_ke_toan_id': kyKeToanId,
      'thang_nam': thangNam,
      'ngay_dong': ngayDong.toIso8601String(),
      'nguoi_dong': nguoiDong,
      'trang_thai': trangThai,
      'da_doi_chieu_quy_tien_mat': daDoiChieuQuyTienMat ? 1 : 0,
      'da_doi_chieu_tien_gui': daDoiChieuTienGui ? 1 : 0,
      'da_kiem_ke_ton_kho': daKiemKeTonKho ? 1 : 0,
      'da_xac_nhan_thue': daXacNhanThue ? 1 : 0,
      'ghi_chu': ghiChu,
      'created_at': createdAt.toIso8601String(),
    };
  }

  DongKyKeToan toEntity() => this;
}