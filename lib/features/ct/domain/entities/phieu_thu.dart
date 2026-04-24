// ============================================================================
// Domain Layer - Entities
// Based on UC_HKD_TT88_2021 - CT-01: Lập phiếu thu
// ============================================================================

import 'package:equatable/equatable.dart';

class PhieuThu extends Equatable {
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
  final DateTime? ngayDuyet;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const PhieuThu({
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
    this.trangThai = 'CHO_DUYET',
    this.ngayDuyet,
    this.createdAt,
    this.updatedAt,
  });

  int get tongTien => soTien;

  bool get isDaDuyet => trangThai == 'DA_DUYET';
  bool get isChoDuyet => trangThai == 'CHO_DUYET';

  PhieuThu copyWith({
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
    String? khachHangId,
    String? kyKeToanId,
    String? trangThai,
    DateTime? ngayDuyet,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PhieuThu(
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
      khachHangId: khachHangId ?? this.khachHangId,
      kyKeToanId: kyKeToanId ?? this.kyKeToanId,
      trangThai: trangThai ?? this.trangThai,
      ngayDuyet: ngayDuyet ?? this.ngayDuyet,
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
        khachHangId,
        kyKeToanId,
        trangThai,
        ngayDuyet,
        createdAt,
        updatedAt,
      ];
}