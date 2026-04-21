// ============================================================================
// Data Layer - Model
// Based on UC_HKD_TT88_2021 - MD-08: Cấu hình kỳ kế toán
// ============================================================================

import 'package:hkd_accounting/features/master_data/domain/entities/ky_ke_toan.dart';

class KyKeToanModel extends KyKeToan {
  const KyKeToanModel({
    required String id,
    required int namTaiChinh,
    required DateTime ngayBatDauKy,
    required DateTime ngayKetThucKy,
    required String trangThaiKy,
    DateTime? ngayKhoaSoThucTe,
  }) : super(
          id: id,
          namTaiChinh: namTaiChinh,
          ngayBatDauKy: ngayBatDauKy,
          ngayKetThucKy: ngayKetThucKy,
          trangThaiKy: trangThaiKy,
          ngayKhoaSoThucTe: ngayKhoaSoThucTe,
        );

  factory KyKeToanModel.fromMap(Map<String, dynamic> map) {
    return KyKeToanModel(
      id: map['id'] as String,
      namTaiChinh: map['nam_tai_chinh'] as int,
      ngayBatDauKy: DateTime.parse(map['ngay_bat_dau_ky'] as String),
      ngayKetThucKy: DateTime.parse(map['ngay_ket_thuc_ky'] as String),
      trangThaiKy: map['trang_thai_ky'] as String,
      ngayKhoaSoThucTe: map['ngay_khoa_so_thuc_te'] != null
          ? DateTime.parse(map['ngay_khoa_so_thuc_te'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nam_tai_chinh': namTaiChinh,
      'ngay_bat_dau_ky': ngayBatDauKy.toIso8601String(),
      'ngay_ket_thuc_ky': ngayKetThucKy.toIso8601String(),
      'trang_thai_ky': trangThaiKy,
      'ngay_khoa_so_thuc_te': ngayKhoaSoThucTe?.toIso8601String(),
    };
  }

  KyKeToan toEntity() {
    return KyKeToan(
      id: id,
      namTaiChinh: namTaiChinh,
      ngayBatDauKy: ngayBatDauKy,
      ngayKetThucKy: ngayKetThucKy,
      trangThaiKy: trangThaiKy,
      ngayKhoaSoThucTe: ngayKhoaSoThucTe,
    );
  }
}