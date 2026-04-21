// ============================================================================
// Data Layer - Model
// Maps between Entity and Database
// Based on UC_HKD_TT88_2021 - MD-02
// ============================================================================

import 'package:hkd_accounting/features/master_data/domain/entities/hang_hoa.dart';

class HangHoaModel extends HangHoa {
  const HangHoaModel({
    required String id,
    required String maHangHoa,
    required String tenHangHoa,
    String? donViTinh,
    String? loaiHangHoa,
    double? giaVon,
    double? giaBan,
    String? moTa,
    String trangThai = 'HOAT_DONG',
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
          id: id,
          maHangHoa: maHangHoa,
          tenHangHoa: tenHangHoa,
          donViTinh: donViTinh,
          loaiHangHoa: loaiHangHoa,
          giaVon: giaVon,
          giaBan: giaBan,
          moTa: moTa,
          trangThai: trangThai,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory HangHoaModel.fromEntity(HangHoa entity) {
    return HangHoaModel(
      id: entity.id,
      maHangHoa: entity.maHangHoa,
      tenHangHoa: entity.tenHangHoa,
      donViTinh: entity.donViTinh,
      loaiHangHoa: entity.loaiHangHoa,
      giaVon: entity.giaVon,
      giaBan: entity.giaBan,
      moTa: entity.moTa,
      trangThai: entity.trangThai,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  HangHoa toEntity() {
    return HangHoa(
      id: id,
      maHangHoa: maHangHoa,
      tenHangHoa: tenHangHoa,
      donViTinh: donViTinh,
      loaiHangHoa: loaiHangHoa,
      giaVon: giaVon,
      giaBan: giaBan,
      moTa: moTa,
      trangThai: trangThai,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory HangHoaModel.fromMap(Map<String, dynamic> map) {
    return HangHoaModel(
      id: map['id'] as String,
      maHangHoa: map['ma_hang_hoa'] as String,
      tenHangHoa: map['ten_hang_hoa'] as String,
      donViTinh: map['don_vi_tinh'] as String?,
      loaiHangHoa: map['loai_hang_hoa'] as String?,
      giaVon: map['gia_von'] != null ? (map['gia_von'] as num).toDouble() : null,
      giaBan: map['gia_ban'] != null ? (map['gia_ban'] as num).toDouble() : null,
      moTa: map['mo_ta'] as String?,
      trangThai: map['trang_thai'] as String,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ma_hang_hoa': maHangHoa,
      'ten_hang_hoa': tenHangHoa,
      'don_vi_tinh': donViTinh,
      'loai_hang_hoa': loaiHangHoa,
      'gia_von': giaVon,
      'gia_ban': giaBan,
      'mo_ta': moTa,
      'trang_thai': trangThai,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}