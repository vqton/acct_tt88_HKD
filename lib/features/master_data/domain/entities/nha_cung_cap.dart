// ============================================================================
// Domain Layer - Entities
// Based on UC_HKD_TT88_2021 - MD-04: Quản lý danh mục nhà cung cấp
// ============================================================================

import 'package:equatable/equatable.dart';

class NhaCungCap extends Equatable {
  final String id;
  final String maNhaCungCap;
  final String tenNhaCungCap;
  final String? diaChi;
  final String? maSoThue;
  final String? soDienThoai;
  final String? email;
  final String? nguoiDaiDien;
  final String? ngaySinhNguoiDaiDien;
  final String? soCccdNguoiDaiDien;
  final String? taiKhoanNganHang;
  final String? tenNganHang;
  final String? chiNhanhNganHang;
  final String trangThai; // HOAT_DONG / NGUNG_KINH_DOANH
  final String? createdAt;
  final String? updatedAt;

  const NhaCungCap({
    required this.id,
    required this.maNhaCungCap,
    required this.tenNhaCungCap,
    this.diaChi,
    this.maSoThue,
    this.soDienThoai,
    this.email,
    this.nguoiDaiDien,
    this.ngaySinhNguoiDaiDien,
    this.soCccdNguoiDaiDien,
    this.taiKhoanNganHang,
    this.tenNganHang,
    this.chiNhanhNganHang,
    this.trangThai = 'HOAT_DONG',
    this.createdAt,
    this.updatedAt,
  });

  NhaCungCap copyWith({
    String? id,
    String? maNhaCungCap,
    String? tenNhaCungCap,
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
    String? trangThai,
    String? createdAt,
    String? updatedAt,
  }) {
    return NhaCungCap(
      id: id ?? this.id,
      maNhaCungCap: maNhaCungCap ?? this.maNhaCungCap,
      tenNhaCungCap: tenNhaCungCap ?? this.tenNhaCungCap,
      diaChi: diaChi ?? this.diaChi,
      maSoThue: maSoThue ?? this.maSoThue,
      soDienThoai: soDienThoai ?? this.soDienThoai,
      email: email ?? this.email,
      nguoiDaiDien: nguoiDaiDien ?? this.nguoiDaiDien,
      ngaySinhNguoiDaiDien: ngaySinhNguoiDaiDien ?? this.ngaySinhNguoiDaiDien,
      soCccdNguoiDaiDien: soCccdNguoiDaiDien ?? this.soCccdNguoiDaiDien,
      taiKhoanNganHang: taiKhoanNganHang ?? this.taiKhoanNganHang,
      tenNganHang: tenNganHang ?? this.tenNganHang,
      chiNhanhNganHang: chiNhanhNganHang ?? this.chiNhanhNganHang,
      trangThai: trangThai ?? this.trangThai,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    maNhaCungCap,
    tenNhaCungCap,
    diaChi,
    maSoThue,
    soDienThoai,
    email,
    nguoiDaiDien,
    ngaySinhNguoiDaiDien,
    soCccdNguoiDaiDien,
    taiKhoanNganHang,
    tenNganHang,
    chiNhanhNganHang,
    trangThai,
    createdAt,
    updatedAt,
  ];
}