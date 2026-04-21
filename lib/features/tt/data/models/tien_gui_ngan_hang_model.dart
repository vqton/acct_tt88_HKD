// ============================================================================
// Data Layer - Model
// Maps between Entity and Database
// Based on UC_HKD_TT88_2021 - TT-02
// ============================================================================

import 'package:hkd_accounting/features/tt/domain/entities/tien_gui_ngan_hang.dart';

class TienGuiNganHangModel extends TienGuiNganHang {
  const TienGuiNganHangModel({
    required String id,
    required String maTaiKhoan,
    required String tenTaiKhoan,
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
          maTaiKhoan: maTaiKhoan,
          tenTaiKhoan: tenTaiKhoan,
          soDuDauKy: soDuDauKy,
          tongThu: tongThu,
          tongChi: tongChi,
          soDuCuoiKy: soDuCuoiKy,
          kyKeToanId: kyKeToanId,
          trangThai: trangThai,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory TienGuiNganHangModel.fromEntity(TienGuiNganHang entity) {
    return TienGuiNganHangModel(
      id: entity.id,
      maTaiKhoan: entity.maTaiKhoan,
      tenTaiKhoan: entity.tenTaiKhoan,
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

  TienGuiNganHang toEntity() {
    return TienGuiNganHang(
      id: id,
      maTaiKhoan: maTaiKhoan,
      tenTaiKhoan: tenTaiKhoan,
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

  factory TienGuiNganHangModel.fromMap(Map<String, dynamic> map) {
    return TienGuiNganHangModel(
      id: map['id'] as String,
      maTaiKhoan: map['ma_tai_khoan'] as String,
      tenTaiKhoan: map['ten_tai_khoan'] as String,
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
      'ma_tai_khoan': maTaiKhoan,
      'ten_tai_khoan': tenTaiKhoan,
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