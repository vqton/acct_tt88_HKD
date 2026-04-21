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

  // Factory method to create a model from an entity
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

  // Convert model to entity
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
}