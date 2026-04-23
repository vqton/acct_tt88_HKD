// ============================================================================
// Data Layer - Model
// Maps between Entity and Database
// Based on UC_HKD_TT88_2021 - MD-04
// ============================================================================

import 'package:hkd_accounting/features/master_data/domain/entities/nha_cung_cap.dart';

class NhaCungCapModel extends NhaCungCap {
  const NhaCungCapModel({
    required String id,
    required String maNhaCungCap,
    required String tenNhaCungCap,
    String? diaChi,
    String? maSoThue,
    String? soDienThoai,
    String? email,
    String? nguoiDaiDien,
    String? ngaySinhNguoiDaiDien,
    String? soCccdNguoiDaiDien,
    String? taiKhoanNganHang,
    String? tenNganHang,
    String? chiNhanhNganHang,
    String trangThai = 'HOAT_DONG',
    String? createdAt,
    String? updatedAt,
  }) : super(
          id: id,
          maNhaCungCap: maNhaCungCap,
          tenNhaCungCap: tenNhaCungCap,
          diaChi: diaChi,
          maSoThue: maSoThue,
          soDienThoai: soDienThoai,
          email: email,
          nguoiDaiDien: nguoiDaiDien,
          ngaySinhNguoiDaiDien: ngaySinhNguoiDaiDien,
          soCccdNguoiDaiDien: soCccdNguoiDaiDien,
          taiKhoanNganHang: taiKhoanNganHang,
          tenNganHang: tenNganHang,
          chiNhanhNganHang: chiNhanhNganHang,
          trangThai: trangThai,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory NhaCungCapModel.fromEntity(NhaCungCap entity) {
    return NhaCungCapModel(
      id: entity.id,
      maNhaCungCap: entity.maNhaCungCap,
      tenNhaCungCap: entity.tenNhaCungCap,
      diaChi: entity.diaChi,
      maSoThue: entity.maSoThue,
      soDienThoai: entity.soDienThoai,
      email: entity.email,
      nguoiDaiDien: entity.nguoiDaiDien,
      ngaySinhNguoiDaiDien: entity.ngaySinhNguoiDaiDien,
      soCccdNguoiDaiDien: entity.soCccdNguoiDaiDien,
      taiKhoanNganHang: entity.taiKhoanNganHang,
      tenNganHang: entity.tenNganHang,
      chiNhanhNganHang: entity.chiNhanhNganHang,
      trangThai: entity.trangThai,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  NhaCungCap toEntity() {
    return NhaCungCap(
      id: id,
      maNhaCungCap: maNhaCungCap,
      tenNhaCungCap: tenNhaCungCap,
      diaChi: diaChi,
      maSoThue: maSoThue,
      soDienThoai: soDienThoai,
      email: email,
      nguoiDaiDien: nguoiDaiDien,
      ngaySinhNguoiDaiDien: ngaySinhNguoiDaiDien,
      soCccdNguoiDaiDien: soCccdNguoiDaiDien,
      taiKhoanNganHang: taiKhoanNganHang,
      tenNganHang: tenNganHang,
      chiNhanhNganHang: chiNhanhNganHang,
      trangThai: trangThai,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory NhaCungCapModel.fromMap(Map<String, dynamic> map) {
    return NhaCungCapModel(
      id: map['id'] as String,
      maNhaCungCap: map['ma_nha_cung_cap'] as String,
      tenNhaCungCap: map['ten_nha_cung_cap'] as String,
      diaChi: map['dia_chi'] as String?,
      maSoThue: map['ma_so_thue'] as String?,
      soDienThoai: map['so_dien_thoai'] as String?,
      email: map['email'] as String?,
      nguoiDaiDien: map['nguoi_dai_dien'] as String?,
      ngaySinhNguoiDaiDien: map['ngay_sinh_nguoi_dai_dien'] as String?,
      soCccdNguoiDaiDien: map['so_cccd_nguoi_dai_dien'] as String?,
      taiKhoanNganHang: map['tai_khoan_ngan_hang'] as String?,
      tenNganHang: map['ten_ngan_hang'] as String?,
      chiNhanhNganHang: map['chi_nhanh_ngan_hang'] as String?,
      trangThai: map['trang_thai'] as String,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ma_nha_cung_cap': maNhaCungCap,
      'ten_nha_cung_cap': tenNhaCungCap,
      'dia_chi': diaChi,
      'ma_so_thue': maSoThue,
      'so_dien_thoai': soDienThoai,
      'email': email,
      'nguoi_dai_dien': nguoiDaiDien,
      'ngay_sinh_nguoi_dai_dien': ngaySinhNguoiDaiDien,
      'so_cccd_nguoi_dai_dien': soCccdNguoiDaiDien,
      'tai_khoan_ngan_hang': taiKhoanNganHang,
      'ten_ngan_hang': tenNganHang,
      'chi_nhanh_ngan_hang': chiNhanhNganHang,
      'trang_thai': trangThai,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}