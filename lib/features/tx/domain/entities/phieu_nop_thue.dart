// ============================================================================
// Domain Layer - Entity
// Based on UC_HKD_TT88_2021 - TX-04: Theo dõi nộp thuế vào NSNN
// ============================================================================

import 'package:equatable/equatable.dart';

enum LoaiThue { gtgt, tncn, both }

class PhieuNopThue extends Equatable {
  final String id;
  final String kyKeToanId;
  final LoaiThue loaiThue;
  final DateTime ngayNop;
  final int soTienGtgt;
  final int soTienTncn;
  final int tongTien;
  final String soGiayNopTien;
  final String hinhThucNop;
  final String nganHangNop;
  final String dienGiai;
  final String trangThai;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const PhieuNopThue({
    required this.id,
    required this.kyKeToanId,
    required this.loaiThue,
    required this.ngayNop,
    this.soTienGtgt = 0,
    this.soTienTncn = 0,
    required this.tongTien,
    this.soGiayNopTien = '',
    this.hinhThucNop = 'CHUYEN_KHOAN',
    this.nganHangNop = '',
    this.dienGiai = '',
    this.trangThai = 'DA_NOP',
    this.createdAt,
    this.updatedAt,
  });

  PhieuNopThue copyWith({
    String? id,
    String? kyKeToanId,
    LoaiThue? loaiThue,
    DateTime? ngayNop,
    int? soTienGtgt,
    int? soTienTncn,
    int? tongTien,
    String? soGiayNopTien,
    String? hinhThucNop,
    String? nganHangNop,
    String? dienGiai,
    String? trangThai,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PhieuNopThue(
      id: id ?? this.id,
      kyKeToanId: kyKeToanId ?? this.kyKeToanId,
      loaiThue: loaiThue ?? this.loaiThue,
      ngayNop: ngayNop ?? this.ngayNop,
      soTienGtgt: soTienGtgt ?? this.soTienGtgt,
      soTienTncn: soTienTncn ?? this.soTienTncn,
      tongTien: tongTien ?? this.tongTien,
      soGiayNopTien: soGiayNopTien ?? this.soGiayNopTien,
      hinhThucNop: hinhThucNop ?? this.hinhThucNop,
      nganHangNop: nganHangNop ?? this.nganHangNop,
      dienGiai: dienGiai ?? this.dienGiai,
      trangThai: trangThai ?? this.trangThai,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id, kyKeToanId, loaiThue, ngayNop,
        soTienGtgt, soTienTncn, tongTien,
        soGiayNopTien, hinhThucNop, nganHangNop,
        dienGiai, trangThai, createdAt, updatedAt,
      ];
}