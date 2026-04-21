// ============================================================================
// Domain Layer - Entities
// Based on UC_HKD_TT88_2021 - MD-03: Quản lý danh mục ngành nghề & thuế suất
// ============================================================================

import 'package:equatable/equatable.dart';

class NgheNghiep extends Equatable {
  final String id;
  final String maNhomNgheNghe;
  final String tenNhomNgheNghe;
  final double tyLeThueGTGT;
  final double tyLeThueTNCN;
  final DateTime ngayHieuLuc;
  final DateTime? ngayHetHieuLuc;

  const NgheNghiep({
    required this.id,
    required this.maNhomNgheNghe,
    required this.tenNhomNgheNghe,
    required this.tyLeThueGTGT,
    required this.tyLeThueTNCN,
    required this.ngayHieuLuc,
    this.ngayHetHieuLuc,
  });

  NgheNghiep copyWith({
    String? id,
    String? maNhomNgheNghe,
    String? tenNhomNgheNghe,
    double? tyLeThueGTGT,
    double? tyLeThueTNCN,
    DateTime? ngayHieuLuc,
    DateTime? ngayHetHieuLuc,
  }) {
    return NgheNghiep(
      id: id ?? this.id,
      maNhomNgheNghe: maNhomNgheNghe ?? this.maNhomNgheNghe,
      tenNhomNgheNghe: tenNhomNgheNghe ?? this.tenNhomNgheNghe,
      tyLeThueGTGT: tyLeThueGTGT ?? this.tyLeThueGTGT,
      tyLeThueTNCN: tyLeThueTNCN ?? this.tyLeThueTNCN,
      ngayHieuLuc: ngayHieuLuc ?? this.ngayHieuLuc,
      ngayHetHieuLuc: ngayHetHieuLuc ?? this.ngayHetHieuLuc,
    );
  }

  @override
  List<Object?> get props => [
    id,
    maNhomNgheNghe,
    tenNhomNgheNghe,
    tyLeThueGTGT,
    tyLeThueTNCN,
    ngayHieuLuc,
    ngayHetHieuLuc,
  ];
}