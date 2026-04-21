// ============================================================================
// Domain Layer - Entities
// Based on UC_HKD_TT88_2021 - MD-08: Cấu hình kỳ kế toán
// ============================================================================

import 'package:equatable/equatable.dart';

class KyKeToan extends Equatable {
  final String id;
  final int namTaiChinh;
  final DateTime ngayBatDauKy;
  final DateTime ngayKetThucKy;
  final String trangThaiKy; // MO, DONG, KHOA_SO
  final DateTime? ngayKhoaSoThucTe;
  final String? createdAt;
  final String? updatedAt;

  const KyKeToan({
    required this.id,
    required this.namTaiChinh,
    required this.ngayBatDauKy,
    required this.ngayKetThucKy,
    required this.trangThaiKy,
    this.ngayKhoaSoThucTe,
    this.createdAt,
    this.updatedAt,
  });

  KyKeToan copyWith({
    String? id,
    int? namTaiChinh,
    DateTime? ngayBatDauKy,
    DateTime? ngayKetThucKy,
    String? trangThaiKy,
    DateTime? ngayKhoaSoThucTe,
    String? createdAt,
    String? updatedAt,
  }) {
    return KyKeToan(
      id: id ?? this.id,
      namTaiChinh: namTaiChinh ?? this.namTaiChinh,
      ngayBatDauKy: ngayBatDauKy ?? this.ngayBatDauKy,
      ngayKetThucKy: ngayKetThucKy ?? this.ngayKetThucKy,
      trangThaiKy: trangThaiKy ?? this.trangThaiKy,
      ngayKhoaSoThucTe: ngayKhoaSoThucTe ?? this.ngayKhoaSoThucTe,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    namTaiChinh,
    ngayBatDauKy,
    ngayKetThucKy,
    trangThaiKy,
    ngayKhoaSoThucTe,
    createdAt,
    updatedAt,
  ];
}