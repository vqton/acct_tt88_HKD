// ============================================================================
// Domain Layer - SK-02: Sổ doanh thu (S1-HKD)
// Based on UC_HKD_TT88_2021
// ============================================================================

import 'package:equatable/equatable.dart';

class SoDoanhThu extends Equatable {
  final String id;
  final String kyKeToanId;
  final String nhomNgheId;
  final DateTime ngayChungTu;
  final String? soHieuChungTu;
  final String? dienGiai;
  final int doanhThu;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const SoDoanhThu({
    required this.id,
    required this.kyKeToanId,
    required this.nhomNgheId,
    required this.ngayChungTu,
    this.soHieuChungTu,
    this.dienGiai,
    this.doanhThu = 0,
    this.createdAt,
    this.updatedAt,
  });

  SoDoanhThu copyWith({
    String? id,
    String? kyKeToanId,
    String? nhomNgheId,
    DateTime? ngayChungTu,
    String? soHieuChungTu,
    String? dienGiai,
    int? doanhThu,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SoDoanhThu(
      id: id ?? this.id,
      kyKeToanId: kyKeToanId ?? this.kyKeToanId,
      nhomNgheId: nhomNgheId ?? this.nhomNgheId,
      ngayChungTu: ngayChungTu ?? this.ngayChungTu,
      soHieuChungTu: soHieuChungTu ?? this.soHieuChungTu,
      dienGiai: dienGiai ?? this.dienGiai,
      doanhThu: doanhThu ?? this.doanhThu,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id, kyKeToanId, nhomNgheId, ngayChungTu,
        soHieuChungTu, dienGiai, doanhThu, createdAt, updatedAt
      ];
}