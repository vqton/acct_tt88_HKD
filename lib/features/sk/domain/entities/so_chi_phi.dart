// ============================================================================
// Domain Layer - SK-04: Sổ chi phí (S3-HKD)
// ============================================================================

import 'package:equatable/equatable.dart';

class SoChiPhi extends Equatable {
  final String id;
  final String kyKeToanId;
  final DateTime ngayChungTu;
  final String? soHieuChungTu;
  final String? dienGiai;
  final int tongTien;
  final int cpNhanCong;
  final int cpDien;
  final int cpNuoc;
  final int cpVienThong;
  final int cpThueKhoBaiphaMatBang;
  final int cpQuanLy;
  final int cpKhac;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const SoChiPhi({
    required this.id,
    required this.kyKeToanId,
    required this.ngayChungTu,
    this.soHieuChungTu,
    this.dienGiai,
    this.tongTien = 0,
    this.cpNhanCong = 0,
    this.cpDien = 0,
    this.cpNuoc = 0,
    this.cpVienThong = 0,
    this.cpThueKhoBaiphaMatBang = 0,
    this.cpQuanLy = 0,
    this.cpKhac = 0,
    this.createdAt,
    this.updatedAt,
  });

  SoChiPhi copyWith({
    String? id, String? kyKeToanId, DateTime? ngayChungTu,
    String? soHieuChungTu, String? dienGiai, int? tongTien,
    int? cpNhanCong, int? cpDien, int? cpNuoc, int? cpVienThong,
    int? cpThueKhoBaiphaMatBang, int? cpQuanLy, int? cpKhac,
    DateTime? createdAt, DateTime? updatedAt,
  }) {
    return SoChiPhi(
      id: id ?? this.id, kyKeToanId: kyKeToanId ?? this.kyKeToanId,
      ngayChungTu: ngayChungTu ?? this.ngayChungTu,
      soHieuChungTu: soHieuChungTu ?? this.soHieuChungTu,
      dienGiai: dienGiai ?? this.dienGiai, tongTien: tongTien ?? this.tongTien,
      cpNhanCong: cpNhanCong ?? this.cpNhanCong, cpDien: cpDien ?? this.cpDien,
      cpNuoc: cpNuoc ?? this.cpNuoc, cpVienThong: cpVienThong ?? this.cpVienThong,
      cpThueKhoBaiphaMatBang: cpThueKhoBaiphaMatBang ?? this.cpThueKhoBaiphaMatBang,
      cpQuanLy: cpQuanLy ?? this.cpQuanLy, cpKhac: cpKhac ?? this.cpKhac,
      createdAt: createdAt ?? this.createdAt, updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, kyKeToanId, ngayChungTu, soHieuChungTu, dienGiai, tongTien, cpNhanCong, cpDien, cpNuoc, cpVienThong, cpThueKhoBaiphaMatBang, cpQuanLy, cpKhac, createdAt, updatedAt];
}