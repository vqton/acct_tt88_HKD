// ============================================================================
// Domain Layer - Entities
// Based on UC_HKD_TT88_2021 - CT-02: Lập phiếu chi
// ============================================================================

import 'package:equatable/equatable.dart';

class PhieuChi extends Equatable {
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
  final String? nhaCungCapId;
  final String kyKeToanId;
  final String trangThai;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const PhieuChi({
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
    this.nhaCungCapId,
    required this.kyKeToanId,
    required this.trangThai,
    this.createdAt,
    this.updatedAt,
  });

  PhieuChi copyWith({
    String? id,
    String? soPhieu,
    DateTime? ngayLap,
    String? nguoiNop,
    String? diaChiNguoiNop,
    String? lyDoNop,
    int? soTien,
    String? soTienBangChu,
    String? chungTuGocKemTheo,
    String? hkdInfoId,
    String? nhaCungCapId,
    String? kyKeToanId,
    String? trangThai,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PhieuChi(
      id: id ?? this.id,
      soPhieu: soPhieu ?? this.soPhieu,
      ngayLap: ngayLap ?? this.ngayLap,
      nguoiNop: nguoiNop ?? this.nguoiNop,
      diaChiNguoiNop: diaChiNguoiNop ?? this.diaChiNguoiNop,
      lyDoNop: lyDoNop ?? this.lyDoNop,
      soTien: soTien ?? this.soTien,
      soTienBangChu: soTienBangChu ?? this.soTienBangChu,
      chungTuGocKemTheo: chungTuGocKemTheo ?? this.chungTuGocKemTheo,
      hkdInfoId: hkdInfoId ?? this.hkdInfoId,
      nhaCungCapId: nhaCungCapId ?? this.nhaCungCapId,
      kyKeToanId: kyKeToanId ?? this.kyKeToanId,
      trangThai: trangThai ?? this.trangThai,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    soPhieu,
    ngayLap,
    nguoiNop,
    diaChiNguoiNop,
    lyDoNop,
    soTien,
    soTienBangChu,
    chungTuGocKemTheo,
    hkdInfoId,
    nhaCungCapId,
    kyKeToanId,
    trangThai,
    createdAt,
    updatedAt,
  ];
}