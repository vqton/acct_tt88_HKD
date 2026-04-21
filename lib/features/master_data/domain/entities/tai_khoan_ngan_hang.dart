// ============================================================================
// Domain Layer - Entities
// Based on UC_HKD_TT88_2021 - MD-07: Quản lý danh mục tài khoản ngân hàng
// ============================================================================

import 'package:equatable/equatable.dart';

class TaiKhoanNganHang extends Equatable {
  final String id;
  final String maTaiKhoan;
  final String tenTaiKhoan;
  final String? tenNganHang;
  final String? chiNhanh;
  final String? soTaiKhoan;
  final String? loaiTaiKhoan; // TIET_KIEM / THANH_TOAN / PHAT_TRIEN
  final String? diaChiNganHang;
  final String? soDienThoaiNganHang;
  final String? emailNganHang;
  final String trangThai; // HOAT_DONG / DONG
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const TaiKhoanNganHang({
    required this.id,
    required this.maTaiKhoan,
    required this.tenTaiKhoan,
    this.tenNganHang,
    this.chiNhanh,
    this.soTaiKhoan,
    this.loaiTaiKhoan,
    this.diaChiNganHang,
    this.soDienThoaiNganHang,
    this.emailNganHang,
    this.trangThai = 'HOAT_DONG',
    this.createdAt,
    this.updatedAt,
  });

  TaiKhoanNganHang copyWith({
    String? id,
    String? maTaiKhoan,
    String? tenTaiKhoan,
    String? tenNganHang,
    String? chiNhanh,
    String? soTaiKhoan,
    String? loaiTaiKhoan,
    String? diaChiNganHang,
    String? soDienThoaiNganHang,
    String? emailNganHang,
    String? trangThai,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TaiKhoanNganHang(
      id: id ?? this.id,
      maTaiKhoan: maTaiKhoan ?? this.maTaiKhoan,
      tenTaiKhoan: tenTaiKhoan ?? this.tenTaiKhoan,
      tenNganHang: tenNganHang ?? this.tenNganHang,
      chiNhanh: chiNhanh ?? this.chiNhanh,
      soTaiKhoan: soTaiKhoan ?? this.soTaiKhoan,
      loaiTaiKhoan: loaiTaiKhoan ?? this.loaiTaiKhoan,
      diaChiNganHang: diaChiNganHang ?? this.diaChiNganHang,
      soDienThoaiNganHang: soDienThoaiNganHang ?? this.soDienThoaiNganHang,
      emailNganHang: emailNganHang ?? this.emailNganHang,
      trangThai: trangThai ?? this.trangThai,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    maTaiKhoan,
    tenTaiKhoan,
    tenNganHang,
    chiNhanh,
    soTaiKhoan,
    loaiTaiKhoan,
    diaChiNganHang,
    soDienThoaiNganHang,
    emailNganHang,
    trangThai,
    createdAt,
    updatedAt,
  ];
}