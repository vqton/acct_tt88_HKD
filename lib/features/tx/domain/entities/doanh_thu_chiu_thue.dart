// ============================================================================
// Domain Layer - Entity
// Based on UC_HKD_TT88_2021 - TX-01: Xác định doanh thu chịu thuế
// ============================================================================

import 'package:equatable/equatable.dart';

class DoanhThuChiuThue extends Equatable {
  final String id;
  final String kyKeToanId;
  final String nhomNgheId;
  final String tenNhomNghe;
  final int tongDoanhThu;
  final int thueGtgtPhaiNop;
  final int thueTncnPhaiNop;
  final int thueGtgtDaNop;
  final int thueTncnDaNop;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const DoanhThuChiuThue({
    required this.id,
    required this.kyKeToanId,
    required this.nhomNgheId,
    required this.tenNhomNghe,
    required this.tongDoanhThu,
    this.thueGtgtPhaiNop = 0,
    this.thueTncnPhaiNop = 0,
    this.thueGtgtDaNop = 0,
    this.thueTncnDaNop = 0,
    this.createdAt,
    this.updatedAt,
  });

  int get thueGtgtConPhaiNop => thueGtgtPhaiNop - thueGtgtDaNop;
  int get thueTncnConPhaiNop => thueTncnPhaiNop - thueTncnDaNop;
  int get tongThuePhaiNop => thueGtgtPhaiNop + thueTncnPhaiNop;
  int get tongThueDaNop => thueGtgtDaNop + thueTncnDaNop;
  int get tongThueConPhaiNop => tongThuePhaiNop - tongThueDaNop;

  DoanhThuChiuThue copyWith({
    String? id,
    String? kyKeToanId,
    String? nhomNgheId,
    String? tenNhomNghe,
    int? tongDoanhThu,
    int? thueGtgtPhaiNop,
    int? thueTncnPhaiNop,
    int? thueGtgtDaNop,
    int? thueTncnDaNop,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DoanhThuChiuThue(
      id: id ?? this.id,
      kyKeToanId: kyKeToanId ?? this.kyKeToanId,
      nhomNgheId: nhomNgheId ?? this.nhomNgheId,
      tenNhomNghe: tenNhomNghe ?? this.tenNhomNghe,
      tongDoanhThu: tongDoanhThu ?? this.tongDoanhThu,
      thueGtgtPhaiNop: thueGtgtPhaiNop ?? this.thueGtgtPhaiNop,
      thueTncnPhaiNop: thueTncnPhaiNop ?? this.thueTncnPhaiNop,
      thueGtgtDaNop: thueGtgtDaNop ?? this.thueGtgtDaNop,
      thueTncnDaNop: thueTncnDaNop ?? this.thueTncnDaNop,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id, kyKeToanId, nhomNgheId, tenNhomNghe,
        tongDoanhThu, thueGtgtPhaiNop, thueTncnPhaiNop,
        thueGtgtDaNop, thueTncnDaNop, createdAt, updatedAt,
      ];
}