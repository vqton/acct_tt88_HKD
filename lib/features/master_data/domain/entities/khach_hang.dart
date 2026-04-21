// ============================================================================
// Domain Layer - Entities
// Based on UC_HKD_TT88_2021 - MD-05: Quản lý danh mục khách hàng
// ============================================================================

import 'package:equatable/equatable.dart';

class KhachHang extends Equatable {
  final String id;
  final String maKhachHang;
  final String tenKhachHang;
  final String? diaChi;
  final String? maSoThue;
  final String? soDienThoai;
  final String loaiKhachHang; // TO_CHUC / CA_NHAN / BAN_LE
  final String trangThai; // DANG_GIAO_DICH / NGUNG
  final String? createdAt;
  final String? updatedAt;

  const KhachHang({
    required this.id,
    required this.maKhachHang,
    required this.tenKhachHang,
    this.diaChi,
    this.maSoThue,
    this.soDienThoai,
    required this.loaiKhachHang,
    required this.trangThai,
    this.createdAt,
    this.updatedAt,
  });

  KhachHang copyWith({
    String? id,
    String? maKhachHang,
    String? tenKhachHang,
    String? diaChi,
    String? maSoThue,
    String? soDienThoai,
    String? loaiKhachHang,
    String? trangThai,
    String? createdAt,
    String? updatedAt,
  }) {
    return KhachHang(
      id: id ?? this.id,
      maKhachHang: maKhachHang ?? this.maKhachHang,
      tenKhachHang: tenKhachHang ?? this.tenKhachHang,
      diaChi: diaChi ?? this.diaChi,
      maSoThue: maSoThue ?? this.maSoThue,
      soDienThoai: soDienThoai ?? this.soDienThoai,
      loaiKhachHang: loaiKhachHang ?? this.loaiKhachHang,
      trangThai: trangThai ?? this.trangThai,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    maKhachHang,
    tenKhachHang,
    diaChi,
    maSoThue,
    soDienThoai,
    loaiKhachHang,
    trangThai,
    createdAt,
    updatedAt,
  ];
}