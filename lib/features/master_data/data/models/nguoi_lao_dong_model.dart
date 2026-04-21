// ============================================================================
// Data Layer - Model
// Maps between Entity and Database
// Based on UC_HKD_TT88_2021 - MD-06
// ============================================================================

import 'package:hkd_accounting/features/master_data/domain/entities/nguoi_lao_dong.dart';

class NguoiLaoDongModel extends NguoiLaoDong {
  const NguoiLaoDongModel({
    required String id,
    required String maNguoiLaoDong,
    required String hoTen,
    DateTime? ngaySinh,
    String? gioiTinh,
    String? soCccd,
    String? soBhxh,
    String? chucVu,
    String? boPhan,
    String? diaChi,
    String? soDienThoai,
    String? email,
    DateTime? ngayVaoLam,
    DateTime? ngayNgungHopDong,
    double? heSoLuong,
    double? luongCoBan,
    String trangThai = 'DANG_LAM_VIEC',
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
          id: id,
          maNguoiLaoDong: maNguoiLaoDong,
          hoTen: hoTen,
          ngaySinh: ngaySinh,
          gioiTinh: gioiTinh,
          soCccd: soCccd,
          soBhxh: soBhxh,
          chucVu: chucVu,
          boPhan: boPhan,
          diaChi: diaChi,
          soDienThoai: soDienThoai,
          email: email,
          ngayVaoLam: ngayVaoLam,
          ngayNgungHopDong: ngayNgungHopDong,
          heSoLuong: heSoLuong,
          luongCoBan: luongCoBan,
          trangThai: trangThai,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory NguoiLaoDongModel.fromEntity(NguoiLaoDong entity) {
    return NguoiLaoDongModel(
      id: entity.id,
      maNguoiLaoDong: entity.maNguoiLaoDong,
      hoTen: entity.hoTen,
      ngaySinh: entity.ngaySinh,
      gioiTinh: entity.gioiTinh,
      soCccd: entity.soCccd,
      soBhxh: entity.soBhxh,
      chucVu: entity.chucVu,
      boPhan: entity.boPhan,
      diaChi: entity.diaChi,
      soDienThoai: entity.soDienThoai,
      email: entity.email,
      ngayVaoLam: entity.ngayVaoLam,
      ngayNgungHopDong: entity.ngayNgungHopDong,
      heSoLuong: entity.heSoLuong,
      luongCoBan: entity.luongCoBan,
      trangThai: entity.trangThai,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  NguoiLaoDong toEntity() {
    return NguoiLaoDong(
      id: id,
      maNguoiLaoDong: maNguoiLaoDong,
      hoTen: hoTen,
      ngaySinh: ngaySinh,
      gioiTinh: gioiTinh,
      soCccd: soCccd,
      soBhxh: soBhxh,
      chucVu: chucVu,
      boPhan: boPhan,
      diaChi: diaChi,
      soDienThoai: soDienThoai,
      email: email,
      ngayVaoLam: ngayVaoLam,
      ngayNgungHopDong: ngayNgungHopDong,
      heSoLuong: heSoLuong,
      luongCoBan: luongCoBan,
      trangThai: trangThai,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory NguoiLaoDongModel.fromMap(Map<String, dynamic> map) {
    return NguoiLaoDongModel(
      id: map['id'] as String,
      maNguoiLaoDong: map['ma_nguoi_lao_dong'] as String,
      hoTen: map['ho_ten'] as String,
      ngaySinh: map['ngay_sinh'] != null
          ? DateTime.parse(map['ngay_sinh'] as String)
          : null,
      gioiTinh: map['gioi_tinh'] as String?,
      soCccd: map['so_cccd'] as String?,
      soBhxh: map['so_bhxh'] as String?,
      chucVu: map['chuc_vu'] as String?,
      boPhan: map['bo_phan'] as String?,
      diaChi: map['dia_chi'] as String?,
      soDienThoai: map['so_dien_thoai'] as String?,
      email: map['email'] as String?,
      ngayVaoLam: map['ngay_vao_lam'] != null
          ? DateTime.parse(map['ngay_vao_lam'] as String)
          : null,
      ngayNgungHopDong: map['ngay_ngung_hop_dong'] != null
          ? DateTime.parse(map['ngay_ngung_hop_dong'] as String)
          : null,
      heSoLuong: map['he_so_luong'] != null ? (map['he_so_luong'] as num).toDouble() : null,
      luongCoBan: map['luong_co_ban'] != null ? (map['luong_co_ban'] as num).toDouble() : null,
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
      'ma_nguoi_lao_dong': maNguoiLaoDong,
      'ho_ten': hoTen,
      'ngay_sinh': ngaySinh?.toIso8601String(),
      'gioi_tinh': gioiTinh,
      'so_cccd': soCccd,
      'so_bhxh': soBhxh,
      'chuc_vu': chucVu,
      'bo_phan': boPhan,
      'dia_chi': diaChi,
      'so_dien_thoai': soDienThoai,
      'email': email,
      'ngay_vao_lam': ngayVaoLam?.toIso8601String(),
      'ngay_ngung_hop_dong': ngayNgungHopDong?.toIso8601String(),
      'he_so_luong': heSoLuong,
      'luong_co_ban': luongCoBan,
      'trang_thai': trangThai,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}