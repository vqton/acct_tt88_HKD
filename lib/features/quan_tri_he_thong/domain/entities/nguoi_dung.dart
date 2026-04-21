// ============================================================================
// Domain Layer - Entities
// Based on UC_HKD_TT88_2021 - QT-01: Quản lý danh mục tài khoản người dùng & phân quyền
// ============================================================================

import 'package:equatable/equatable.dart';

class NguoiDung extends Equatable {
  final String id;
  final String tenDangNhap;
  final String matKhauHash; // Hashed password
  final String hoTen;
  final String? email;
  final String? soDienThoai;
  final bool trangThai; // true = hoat dong, false = khoa
  final DateTime? ngayTao;
  final DateTime? ngayCapNhat;

  const NguoiDung({
    required this.id,
    required this.tenDangNhap,
    required this.matKhauHash,
    required this.hoTen,
    this.email,
    this.soDienThoai,
    required this.trangThai,
    this.ngayTao,
    this.ngayCapNhat,
  });

  NguoiDung copyWith({
    String? id,
    String? tenDangNhap,
    String? matKhauHash,
    String? hoTen,
    String? email,
    String? soDienThoai,
    bool? trangThai,
    DateTime? ngayTao,
    DateTime? ngayCapNhat,
  }) {
    return NguoiDung(
      id: id ?? this.id,
      tenDangNhap: tenDangNhap ?? this.tenDangNhap,
      matKhauHash: matKhauHash ?? this.matKhauHash,
      hoTen: hoTen ?? this.hoTen,
      email: email ?? this.email,
      soDienThoai: soDienThoai ?? this.soDienThoai,
      trangThai: trangThai ?? this.trangThai,
      ngayTao: ngayTao ?? this.ngayTao,
      ngayCapNhat: ngayCapNhat ?? this.ngayCapNhat,
    );
  }

  @override
  List<Object?> get props => [
    id,
    tenDangNhap,
    matKhauHash,
    hoTen,
    email,
    soDienThoai,
    trangThai,
    ngayTao,
    ngayCapNhat,
  ];
}