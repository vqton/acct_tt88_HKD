// ============================================================================
// Data Layer - Model
// Maps between Entity and Database
// Based on UC_HKD_TT88_2021 - MD-01
// ============================================================================

import 'package:hkd_accounting/features/master_data/domain/entities/hkd_info.dart';

class HkdInfoModel extends HkdInfo {
  const HkdInfoModel({
    required String id,
    required String tenHkd,
    String? diaChiTruSo,
    required String maSoThue,
    String? soCccdNguoiDaiDien,
    String? hoTenNguoiDaiDien,
    String phuongPhapTinhGiaXuatKho = 'BINH_QUAN',
    String trangThai = 'HOAT_DONG',
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
          id: id,
          tenHkd: tenHkd,
          diaChiTruSo: diaChiTruSo,
          maSoThue: maSoThue,
          soCccdNguoiDaiDien: soCccdNguoiDaiDien,
          hoTenNguoiDaiDien: hoTenNguoiDaiDien,
          phuongPhapTinhGiaXuatKho: phuongPhapTinhGiaXuatKho,
          trangThai: trangThai,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory HkdInfoModel.fromEntity(HkdInfo entity) {
    return HkdInfoModel(
      id: entity.id,
      tenHkd: entity.tenHkd,
      diaChiTruSo: entity.diaChiTruSo,
      maSoThue: entity.maSoThue,
      soCccdNguoiDaiDien: entity.soCccdNguoiDaiDien,
      hoTenNguoiDaiDien: entity.hoTenNguoiDaiDien,
      phuongPhapTinhGiaXuatKho: entity.phuongPhapTinhGiaXuatKho,
      trangThai: entity.trangThai,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  HkdInfo toEntity() {
    return HkdInfo(
      id: id,
      tenHkd: tenHkd,
      diaChiTruSo: diaChiTruSo,
      maSoThue: maSoThue,
      soCccdNguoiDaiDien: soCccdNguoiDaiDien,
      hoTenNguoiDaiDien: hoTenNguoiDaiDien,
      phuongPhapTinhGiaXuatKho: phuongPhapTinhGiaXuatKho,
      trangThai: trangThai,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory HkdInfoModel.fromMap(Map<String, dynamic> map) {
    return HkdInfoModel(
      id: map['id'] as String,
      tenHkd: map['ten_hkd'] as String,
      diaChiTruSo: map['dia_chi_tru_so'] as String?,
      maSoThue: map['ma_so_thue'] as String,
      soCccdNguoiDaiDien: map['so_cccd_nguoi_dai_dien'] as String?,
      hoTenNguoiDaiDien: map['ho_ten_nguoi_dai_dien'] as String?,
      phuongPhapTinhGiaXuatKho: map['phuong_phap_tinh_gia_xuat_kho'] as String,
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
      'ten_hkd': tenHkd,
      'dia_chi_tru_so': diaChiTruSo,
      'ma_so_thue': maSoThue,
      'so_cccd_nguoi_dai_dien': soCccdNguoiDaiDien,
      'ho_ten_nguoi_dai_dien': hoTenNguoiDaiDien,
      'phuong_phap_tinh_gia_xuat_kho': phuongPhapTinhGiaXuatKho,
      'trang_thai': trangThai,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
