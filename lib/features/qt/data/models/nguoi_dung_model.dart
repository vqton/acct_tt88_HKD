// ============================================================================
// Data Layer - Model
// Based on UC_HKD_TT88_2021 - QT-01: Quản lý tài khoản người dùng & phân quyền
// ============================================================================

import 'package:hkd_accounting/features/qt/domain/entities/nguoi_dung.dart';

class NguoiDungModel extends NguoiDung {
  const NguoiDungModel({
    required String id,
    required String maNguoiDung,
    required String hoTen,
    String? email,
    String? soDienThoai,
    required String vaiTro,
    required String trangThai,
    String? matKhauHash,
    String? hkdId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
          id: id,
          maNguoiDung: maNguoiDung,
          hoTen: hoTen,
          email: email,
          soDienThoai: soDienThoai,
          vaiTro: vaiTro,
          trangThai: trangThai,
          matKhauHash: matKhauHash,
          hkdId: hkdId,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory NguoiDungModel.fromEntity(NguoiDung entity) {
    return NguoiDungModel(
      id: entity.id,
      maNguoiDung: entity.maNguoiDung,
      hoTen: entity.hoTen,
      email: entity.email,
      soDienThoai: entity.soDienThoai,
      vaiTro: entity.vaiTro,
      trangThai: entity.trangThai,
      matKhauHash: entity.matKhauHash,
      hkdId: entity.hkdId,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  NguoiDung toEntity() {
    return NguoiDung(
      id: id,
      maNguoiDung: maNguoiDung,
      hoTen: hoTen,
      email: email,
      soDienThoai: soDienThoai,
      vaiTro: vaiTro,
      trangThai: trangThai,
      matKhauHash: matKhauHash,
      hkdId: hkdId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory NguoiDungModel.fromMap(Map<String, dynamic> map) {
    return NguoiDungModel(
      id: map['id'] as String,
      maNguoiDung: map['ma_nguoi_dung'] as String,
      hoTen: map['ho_ten'] as String,
      email: map['email'] as String?,
      soDienThoai: map['so_dien_thoai'] as String?,
      vaiTro: map['vai_tro'] as String,
      trangThai: map['trang_thai'] as String,
      matKhauHash: map['mat_khau_hash'] as String?,
      hkdId: map['hkd_id'] as String?,
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
      'ma_nguoi_dung': maNguoiDung,
      'ho_ten': hoTen,
      'email': email,
      'so_dien_thoai': soDienThoai,
      'vai_tro': vaiTro,
      'trang_thai': trangThai,
      'mat_khau_hash': matKhauHash,
      'hkd_id': hkdId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}