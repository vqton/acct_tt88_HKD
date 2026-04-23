// ============================================================================
// Domain Layer - Entities
// Based on UC_HKD_TT88_2021 - TT-01: Quản lý quỹ tiền mặt
// ============================================================================

import 'package:equatable/equatable.dart';

class QuyTienMat extends Equatable {
  final String id;
  final String maQuy; // Cash fund code (e.g., QTM001)
  final String tenQuy; // Cash fund name
  final double soDuDauKy; // Opening balance
  final double tongThu; // Total receipts
  final double tongChi; // Total payments
  final double soDuCuoiKy; // Closing balance
  final String kyKeToanId; // Reference to accounting period
  final String trangThai; // e.g., DANG_SU_DUNG, NGUNG_SU_DUNG
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const QuyTienMat({
    required this.id,
    required this.maQuy,
    required this.tenQuy,
    required this.soDuDauKy,
    required this.tongThu,
    required this.tongChi,
    required this.soDuCuoiKy,
    required this.kyKeToanId,
    required this.trangThai,
    this.createdAt,
    this.updatedAt,
  });

  QuyTienMat copyWith({
    String? id,
    String? maQuy,
    String? tenQuy,
    double? soDuDauKy,
    double? tongThu,
    double? tongChi,
    double? soDuCuoiKy,
    String? kyKeToanId,
    String? trangThai,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return QuyTienMat(
      id: id ?? this.id,
      maQuy: maQuy ?? this.maQuy,
      tenQuy: tenQuy ?? this.tenQuy,
      soDuDauKy: soDuDauKy ?? this.soDuDauKy,
      tongThu: tongThu ?? this.tongThu,
      tongChi: tongChi ?? this.tongChi,
      soDuCuoiKy: soDuCuoiKy ?? this.soDuCuoiKy,
      kyKeToanId: kyKeToanId ?? this.kyKeToanId,
      trangThai: trangThai ?? this.trangThai,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    maQuy,
    tenQuy,
    soDuDauKy,
    tongThu,
    tongChi,
    soDuCuoiKy,
    kyKeToanId,
    trangThai,
    createdAt,
    updatedAt,
  ];
}