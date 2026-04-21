// ============================================================================
// Data Layer - Model
// Maps between Entity and Database
// Based on UC_HKD_TT88_2021 - MD-07
// ============================================================================

import 'package:hkd_accounting/features/master_data/domain/entities/tai_khoan_ngan_hang.dart';

class TaiKhoanNganHangModel extends TaiKhoanNganHang {
  const TaiKhoanNganHangModel({
    required String id,
    required String maTaiKhoan,
    required String tenTaiKhoan,
    String? tenNganHang,
    String? chiNhanh,
    String? soTaiKhoan,
    String? loaiTaiKhoan,
    String? diaChiNganHang,
    String? soDienThoaiNganHang,
    String? emailNganHang,
    String trangThai = 'HOAT_DONG',
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
          id: id,
          maTaiKhoan: maTaiKhoan,
          tenTaiKhoan: tenTaiKhoan,
          tenNganHang: tenNganHang,
          chiNhanh: chiNhanh,
          soTaiKhoan: soTaiKhoan,
          loaiTaiKhoan: loaiTaiKhoan,
          diaChiNganHang: diaChiNganHang,
          soDienThoaiNganHang: soDienThoaiNganHang,
          emailNganHang: emailNganHang,
          trangThai: trangThai,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory TaiKhoanNganHangModel.fromEntity(TaiKhoanNganHang entity) {
    return TaiKhoanNganHangModel(
      id: entity.id,
      maTaiKhoan: entity.maTaiKhoan,
      tenTaiKhoan: entity.tenTaiKhoan,
      tenNganHang: entity.tenNganHang,
      chiNhanh: entity.chiNhanh,
      soTaiKhoan: entity.soTaiKhoan,
      loaiTaiKhoan: entity.loaiTaiKhoan,
      diaChiNganHang: entity.diaChiNganHang,
      soDienThoaiNganHang: entity.soDienThoaiNganHang,
      emailNganHang: entity.emailNganHang,
      trangThai: entity.trangThai,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  TaiKhoanNganHang toEntity() {
    return TaiKhoanNganHang(
      id: id,
      maTaiKhoan: maTaiKhoan,
      tenTaiKhoan: tenTaiKhoan,
      tenNganHang: tenNganHang,
      chiNhanh: chiNhanh,
      soTaiKhoan: soTaiKhoan,
      loaiTaiKhoan: loaiTaiKhoan,
      diaChiNganHang: diaChiNganHang,
      soDienThoaiNganHang: soDienThoaiNganHang,
      emailNganHang: emailNganHang,
      trangThai: trangThai,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory TaiKhoanNganHangModel.fromMap(Map<String, dynamic> map) {
    return TaiKhoanNganHangModel(
      id: map['id'] as String,
      maTaiKhoan: map['ma_tai_khoan'] as String,
      tenTaiKhoan: map['ten_tai_khoan'] as String,
      tenNganHang: map['ten_ngan_hang'] as String?,
      chiNhanh: map['chi_nhanh'] as String?,
      soTaiKhoan: map['so_tai_khoan'] as String?,
      loaiTaiKhoan: map['loai_tai_khoan'] as String?,
      diaChiNganHang: map['dia_chi_ngan_hang'] as String?,
      soDienThoaiNganHang: map['so_dien_thoai_ngan_hang'] as String?,
      emailNganHang: map['email_ngan_hang'] as String?,
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
      'ma_tai_khoan': maTaiKhoan,
      'ten_tai_khoan': tenTaiKhoan,
      'ten_ngan_hang': tenNganHang,
      'chi_nhanh': chiNhanh,
      'so_tai_khoan': soTaiKhoan,
      'loai_tai_khoan': loaiTaiKhoan,
      'dia_chi_ngan_hang': diaChiNganHang,
      'so_dien_thoai_ngan_hang': soDienThoaiNganHang,
      'email_ngan_hang': emailNganHang,
      'trang_thai': trangThai,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}