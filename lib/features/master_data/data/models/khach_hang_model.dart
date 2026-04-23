// ============================================================================
// Data Layer - Model
// Maps between Entity and Database
// Based on UC_HKD_TT88_2021 - MD-05: Quản lý danh mục khách hàng
// ============================================================================

import 'package:hkd_accounting/features/master_data/domain/entities/khach_hang.dart';

class KhachHangModel extends KhachHang {
  const KhachHangModel({
    required String id,
    required String maKhachHang,
    required String tenKhachHang,
    String? diaChi,
    String? maSoThue,
    String? soDienThoai,
    required String loaiKhachHang,
    required String trangThai,
    String? createdAt,
    String? updatedAt,
  }) : super(
          id: id,
          maKhachHang: maKhachHang,
          tenKhachHang: tenKhachHang,
          diaChi: diaChi,
          maSoThue: maSoThue,
          soDienThoai: soDienThoai,
          loaiKhachHang: loaiKhachHang,
          trangThai: trangThai,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory KhachHangModel.fromEntity(KhachHang entity) {
    return KhachHangModel(
      id: entity.id,
      maKhachHang: entity.maKhachHang,
      tenKhachHang: entity.tenKhachHang,
      diaChi: entity.diaChi,
      maSoThue: entity.maSoThue,
      soDienThoai: entity.soDienThoai,
      loaiKhachHang: entity.loaiKhachHang,
      trangThai: entity.trangThai,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  KhachHang toEntity() {
    return KhachHang(
      id: id,
      maKhachHang: maKhachHang,
      tenKhachHang: tenKhachHang,
      diaChi: diaChi,
      maSoThue: maSoThue,
      soDienThoai: soDienThoai,
      loaiKhachHang: loaiKhachHang,
      trangThai: trangThai,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory KhachHangModel.fromMap(Map<String, dynamic> map) {
    return KhachHangModel(
      id: map['id'] as String,
      maKhachHang: map['ma_khach_hang'] as String,
      tenKhachHang: map['ten_khach_hang'] as String,
      diaChi: map['dia_chi'] as String?,
      maSoThue: map['ma_so_thue'] as String?,
      soDienThoai: map['so_dien_thoai'] as String?,
      loaiKhachHang: map['loai_khach_hang'] as String,
      trangThai: map['trang_thai'] as String,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ma_khach_hang': maKhachHang,
      'ten_khach_hang': tenKhachHang,
      'dia_chi': diaChi,
      'ma_so_thue': maSoThue,
      'so_dien_thoai': soDienThoai,
      'loai_khach_hang': loaiKhachHang,
      'trang_thai': trangThai,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}