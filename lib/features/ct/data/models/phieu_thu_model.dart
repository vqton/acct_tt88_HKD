// ============================================================================
// Data Layer - Models
// Based on UC_HKD_TT88_2021 - CT-01: Lập phiếu thu
// ============================================================================

import 'package:hkd_accounting/features/ct/domain/entities/phieu_thu.dart';

class PhieuThuModel {
  final String id;
  final String soPhieu;
  final DateTime ngayLap;
  final String nguoiNop;
  final String diaChiNguoiNop;
  final String lyDoNop;
  final int soTien;
  final String soTienBangChu;
  final String chungTuGocKemTheo;
  final String hkdInfoId;
  final String khachHangId;
  final String kyKeToanId;
  final String trangThai;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const PhieuThuModel({
    required this.id,
    required this.soPhieu,
    required this.ngayLap,
    required this.nguoiNop,
    required this.diaChiNguoiNop,
    required this.lyDoNop,
    required this.soTien,
    required this.soTienBangChu,
    required this.chungTuGocKemTheo,
    required this.hkdInfoId,
    required this.khachHangId,
    required this.kyKeToanId,
    required this.trangThai,
    this.createdAt,
    this.updatedAt,
  });

  factory PhieuThuModel.fromEntity(PhieuThu entity) {
    return PhieuThuModel(
      id: entity.id,
      soPhieu: entity.soPhieu,
      ngayLap: entity.ngayLap,
      nguoiNop: entity.nguoiNop,
      diaChiNguoiNop: entity.diaChiNguoiNop,
      lyDoNop: entity.lyDoNop,
      soTien: entity.soTien,
      soTienBangChu: entity.soTienBangChu,
      chungTuGocKemTheo: entity.chungTuGocKemTheo,
      hkdInfoId: entity.hkdInfoId,
      khachHangId: entity.khachHangId,
      kyKeToanId: entity.kyKeToanId,
      trangThai: entity.trangThai,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  PhieuThu toEntity() {
    return PhieuThu(
      id: id,
      soPhieu: soPhieu,
      ngayLap: ngayLap,
      nguoiNop: nguoiNop,
      diaChiNguoiNop: diaChiNguoiNop,
      lyDoNop: lyDoNop,
      soTien: soTien,
      soTienBangChu: soTienBangChu,
      chungTuGocKemTheo: chungTuGocKemTheo,
      hkdInfoId: hkdInfoId,
      khachHangId: khachHangId,
      kyKeToanId: kyKeToanId,
      trangThai: trangThai,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'so_phieu': soPhieu,
      'ngay_lap': ngayLap.toIso8601String(),
      'nguoi_nop': nguoiNop,
      'dia_chi_nguoi_nop': diaChiNguoiNop,
      'ly_do_nop': lyDoNop,
      'so_tien': soTien,
      'so_tien_bang_chu': soTienBangChu,
      'chung_tu_goc_kem_theo': chungTuGocKemTheo,
      'hkd_info_id': hkdInfoId,
      'khach_hang_id': khachHangId,
      'ky_ke_toan_id': kyKeToanId,
      'trang_thai': trangThai,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory PhieuThuModel.fromMap(Map<String, dynamic> map) {
    return PhieuThuModel(
      id: map['id'] as String,
      soPhieu: map['so_phieu'] as String,
      ngayLap: DateTime.parse(map['ngay_lap'] as String),
      nguoiNop: map['nguoi_nop'] as String,
      diaChiNguoiNop: map['dia_chi_nguoi_nop'] as String,
      lyDoNop: map['ly_do_nop'] as String,
      soTien: map['so_tien'] as int,
      soTienBangChu: map['so_tien_bang_chu'] as String,
      chungTuGocKemTheo: map['chung_tu_goc_kem_theo'] as String,
      hkdInfoId: map['hkd_info_id'] as String,
      khachHangId: map['khach_hang_id'] as String,
      kyKeToanId: map['ky_ke_toan_id'] as String,
      trangThai: map['trang_thai'] as String,
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at'] as String) : null,
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at'] as String) : null,
    );
  }
}