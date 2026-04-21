// ============================================================================
// Domain Layer - Entities
// Based on UC_HKD_TT88_2021 - MD-06: Quản lý danh mục người lao động
// ============================================================================

import 'package:equatable/equatable.dart';

class NguoiLaoDong extends Equatable {
  final String id;
  final String maNguoiLaoDong;
  final String hoTen;
  final DateTime? ngaySinh;
  final String? gioiTinh; // NAM / NU / KHAC
  final String? soCccd;
  final String? soBhxh;
  final String? chucVu;
  final String? boPhan;
  final String? diaChi;
  final String? soDienThoai;
  final String? email;
  final DateTime? ngayVaoLam;
  final DateTime? ngayNgungHopDong;
  final double? heSoLuong;
  final double? luongCoBan;
  final String trangThai; // DANG_LAM_VIEC / NGHI_VIEC / NGHI_PHEP
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const NguoiLaoDong({
    required this.id,
    required this.maNguoiLaoDong,
    required this.hoTen,
    this.ngaySinh,
    this.gioiTinh,
    this.soCccd,
    this.soBhxh,
    this.chucVu,
    this.boPhan,
    this.diaChi,
    this.soDienThoai,
    this.email,
    this.ngayVaoLam,
    this.ngayNgungHopDong,
    this.heSoLuong,
    this.luongCoBan,
    this.trangThai = 'DANG_LAM_VIEC',
    this.createdAt,
    this.updatedAt,
  });

  NguoiLaoDong copyWith({
    String? id,
    String? maNguoiLaoDong,
    String? hoTen,
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
    Double? heSoLuong,
    Double? luongCoBan,
    String? trangThai,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NguoiLaoDong(
      id: id ?? this.id,
      maNguoiLaoDong: maNguoiLaoDong ?? this.maNguoiLaoDong,
      hoTen: hoTen ?? this.hoTen,
      ngaySinh: ngaySinh ?? this.ngaySinh,
      gioiTinh: gioiTinh ?? this.gioiTinh,
      soCccd: soCccd ?? this.soCccd,
      soBhxh: soBhxh ?? this.soBhxh,
      chucVu: chucVu ?? this.chucVu,
      boPhan: boPhan ?? this.boPhan,
      diaChi: diaChi ?? this.diaChi,
      soDienThoai: soDienThoai ?? this.soDienThoai,
      email: email ?? this.email,
      ngayVaoLam: ngayVaoLam ?? this.ngayVaoLam,
      ngayNgungHopDong: ngayNgungHopDong ?? this.ngayNgungHopDong,
      heSoLuong: heSoLuong ?? this.heSoLuong,
      luongCoBan: luongCoBan ?? this.luongCoBan,
      trangThai: trangThai ?? this.trangThai,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    maNguoiLaoDong,
    hoTen,
    ngaySinh,
    gioiTinh,
    soCccd,
    soBhxh,
    chucVu,
    boPhan,
    diaChi,
    soDienThoai,
    email,
    ngayVaoLam,
    ngayNgungHopDong,
    heSoLuong,
    luongCoBan,
    trangThai,
    createdAt,
    updatedAt,
  ];
}