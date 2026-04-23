// ============================================================================
// Domain Layer - Entity
// Based on UC_HKD_TT88_2021 - SK-05: Ghi sổ theo dõi nghĩa vụ thuế với NSNN
// ============================================================================

import 'package:equatable/equatable.dart';

class SoThue extends Equatable {
  final String id;
  final String kyKeToanId;
  final String? soHieuChungTu;
  final DateTime ngayChungTu;
  final String dienGiai;
  final int thueGtgtPhaiNop;
  final int thueGtgtDaNop;
  final int thueTncnPhaiNop;
  final int thueTncnDaNop;
  final int thueGtgtConPhaiNop;
  final int thueTncnConPhaiNop;
  final String trangThai;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const SoThue({
    required this.id,
    required this.kyKeToanId,
    this.soHieuChungTu,
    required this.ngayChungTu,
    required this.dienGiai,
    this.thueGtgtPhaiNop = 0,
    this.thueGtgtDaNop = 0,
    this.thueTncnPhaiNop = 0,
    this.thueTncnDaNop = 0,
    this.thueGtgtConPhaiNop = 0,
    this.thueTncnConPhaiNop = 0,
    this.trangThai = 'MOI',
    this.createdAt,
    this.updatedAt,
  });

  int get tongThuePhaiNop => thueGtgtPhaiNop + thueTncnPhaiNop;
  int get tongThueDaNop => thueGtgtDaNop + thueTncnDaNop;
  int get tongThueConPhaiNop => thueGtgtConPhaiNop + thueTncnConPhaiNop;

  SoThue copyWith({
    String? id,
    String? kyKeToanId,
    String? soHieuChungTu,
    DateTime? ngayChungTu,
    String? dienGiai,
    int? thueGtgtPhaiNop,
    int? thueGtgtDaNop,
    int? thueTncnPhaiNop,
    int? thueTncnDaNop,
    int? thueGtgtConPhaiNop,
    int? thueTncnConPhaiNop,
    String? trangThai,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SoThue(
      id: id ?? this.id,
      kyKeToanId: kyKeToanId ?? this.kyKeToanId,
      soHieuChungTu: soHieuChungTu ?? this.soHieuChungTu,
      ngayChungTu: ngayChungTu ?? this.ngayChungTu,
      dienGiai: dienGiai ?? this.dienGiai,
      thueGtgtPhaiNop: thueGtgtPhaiNop ?? this.thueGtgtPhaiNop,
      thueGtgtDaNop: thueGtgtDaNop ?? this.thueGtgtDaNop,
      thueTncnPhaiNop: thueTncnPhaiNop ?? this.thueTncnPhaiNop,
      thueTncnDaNop: thueTncnDaNop ?? this.thueTncnDaNop,
      thueGtgtConPhaiNop: thueGtgtConPhaiNop ?? this.thueGtgtConPhaiNop,
      thueTncnConPhaiNop: thueTncnConPhaiNop ?? this.thueTncnConPhaiNop,
      trangThai: trangThai ?? this.trangThai,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id, kyKeToanId, soHieuChungTu, ngayChungTu,
        dienGiai, thueGtgtPhaiNop, thueGtgtDaNop,
        thueTncnPhaiNop, thueTncnDaNop,
        thueGtgtConPhaiNop, thueTncnConPhaiNop,
        trangThai, createdAt, updatedAt,
      ];
}