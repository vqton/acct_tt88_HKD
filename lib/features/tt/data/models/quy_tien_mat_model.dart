// ============================================================================
// Data Layer - Model
// Maps between Entity and Database
// Based on UC_HKD_TT88_2021 - TT-01
// ============================================================================

import 'package:hkd_accounting/features/tt/domain/entities/quy_tien_mat.dart';

class QuyTienMatModel extends QuyTienMat {
  const QuyTienMatModel({
    required String id,
    required String maQuy,
    required String tenQuy,
    required double soDuDauKy,
    required double tongThu,
    required double tongChi,
    required double soDuCuoiKy,
    required String kyKeToanId,
    required String trangThai,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
          id: id,
          maQuy: maQuy,
          tenQuy: tenQuy,
          soDuDauKy: soDuDauKy,
          tongThu: tongThu,
          tongChi: tongChi,
          soDuCuoiKy: soDuCuoiKy,
          kyKeToanId: kyKeToanId,
          trangThai: trangThai,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory QuyTienMatModel.fromEntity(QuyTienMat entity) {
    return QuyTienMatModel(
      id: entity.id,
      maQuy: entity.maQuy,
      tenQuy: entity.tenQuy,
      soDuDauKy: entity.soDuDauKy,
      tongThu: entity.tongThu,
      tongChi: entity.tongChi,
      soDuCuoiKy: entity.soDuCuoiKy,
      kyKeToanId: entity.kyKeToanId,
      trangThai: entity.trangThai,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  QuyTienMat toEntity() {
    return QuyTienMat(
      id: id,
      maQuy: maQuy,
      tenQuy: tenQuy,
      soDuDauKy: soDuDauKy,
      tongThu: tongThu,
      tongChi: tongChi,
      soDuCuoiKy: soDuCuoiKy,
      kyKeToanId: kyKeToanId,
      trangThai: trangThai,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory QuyTienMatModel.fromMap(Map<String, dynamic> map) {
    return QuyTienMatModel(
      id: map['id'] as String,
      maQuy: map['ma_quy'] as String,
      tenQuy: map['ten_quy'] as String,
      soDuDauKy: map['so_du_dau_ky'] as double,
      tongThu: map['tong_thu'] as double,
      tongChi: map['tong_chi'] as double,
      soDuCuoiKy: map['so_du_cuoi_ky'] as double,
      kyKeToanId: map['ky_ke_toan_id'] as String,
      trangThai: map['trang_thai'] as String,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ma_quy': maQuy,
      'ten_quy': tenQuy,
      'so_du_dau_ky': soDuDauKy,
      'tong_thu': tongThu,
      'tong_chi': tongChi,
      'so_du_cuoi_ky': soDuCuoiKy,
      'ky_ke_toan_id': kyKeToanId,
      'trang_thai': trangThai,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}