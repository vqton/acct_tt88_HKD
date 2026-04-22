// ============================================================================
// Domain Layer - Entities
// Based on UC_HKD_TT88_2021 - QT-01: Quản lý tài khoản người dùng & phân quyền
// ============================================================================

import 'package:equatable/equatable.dart';

enum VaiTro {
  admin,
  keToanVien,
  thuQuy,
  thuKho,
  nguoiDaiDien,
}

class NguoiDung extends Equatable {
  final String id;
  final String maNguoiDung;
  final String hoTen;
  final String? email;
  final String? soDienThoai;
  final String vaiTro; // ADMIN, KE_TOAN_VIEN, THU_QUY, THU_KHO, NGUOI_DAI_DIEN
  final String trangThai; // HOAT_DONG, NGHI_VIEC, KHOA
  final String? matKhauHash;
  final String? hkdId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const NguoiDung({
    required this.id,
    required this.maNguoiDung,
    required this.hoTen,
    this.email,
    this.soDienThoai,
    required this.vaiTro,
    required this.trangThai,
    this.matKhauHash,
    this.hkdId,
    this.createdAt,
    this.updatedAt,
  });

  String get vaiTroLabel {
    switch (vaiTro) {
      case 'ADMIN':
        return 'Quản trị viên';
      case 'KE_TOAN_VIEN':
        return 'Kế toán viên';
      case 'THU_QUY':
        return 'Thủ quỹ';
      case 'THU_KHO':
        return 'Thủ kho';
      case 'NGUOI_DAI_DIEN':
        return 'Người đại diện';
      default:
        return vaiTro;
    }
  }

  bool get isAdmin => vaiTro == 'ADMIN';
  bool get isKeToan => vaiTro == 'KE_TOAN_VIEN';
  bool get isThuQuy => vaiTro == 'THU_QUY';
  bool get isThuKho => vaiTro == 'THU_KHO';
  bool get isNguoiDaiDien => vaiTro == 'NGUOI_DAI_DIEN';

  bool coTheLapChungTu => isKeToan;
  bool coThePheDuyetChungTu => isNguoiDaiDien;
  bool coTheThuChiTienMat => isThuQuy;
  bool coTheNhapXuatKho => isThuKho;
  bool coTheGhiSoKeToan => isKeToan;
  bool coTheTinhThue => isKeToan;
  bool coTheCauHinhHeThong => isAdmin;
  bool coThePhanQuyen => isAdmin;

  NguoiDung copyWith({
    String? id,
    String? maNguoiDung,
    String? hoTen,
    String? email,
    String? soDienThoai,
    String? vaiTro,
    String? trangThai,
    String? matKhauHash,
    String? hkdId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NguoiDung(
      id: id ?? this.id,
      maNguoiDung: maNguoiDung ?? this.maNguoiDung,
      hoTen: hoTen ?? this.hoTen,
      email: email ?? this.email,
      soDienThoai: soDienThoai ?? this.soDienThoai,
      vaiTro: vaiTro ?? this.vaiTro,
      trangThai: trangThai ?? this.trangThai,
      matKhauHash: matKhauHash ?? this.matKhauHash,
      hkdId: hkdId ?? this.hkdId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        maNguoiDung,
        hoTen,
        email,
        soDienThoai,
        vaiTro,
        trangThai,
        matKhauHash,
        hkdId,
        createdAt,
        updatedAt,
      ];
}
