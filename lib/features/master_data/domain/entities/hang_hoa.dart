// ============================================================================
// Domain Layer - Entities
// Based on UC_HKD_TT88_2021 - MD-02: Quản lý danh mục hàng hóa/dịch vụ
// ============================================================================

import 'package:equatable/equatable.dart';

class HangHoa extends Equatable {
  final String id;
  final String maHangHoa;
  final String tenHangHoa;
  final String? donViTinh;
  final String? loaiHangHoa; // HANG_HOA / DICH_VU
  final double? giaVon;
  final double? giaBan;
  final String? moTa;
  final String trangThai; // HOAT_DONG / NGUNG_KINH_DOANH
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const HangHoa({
    required this.id,
    required this.maHangHoa,
    required this.tenHangHoa,
    this.donViTinh,
    this.loaiHangHoa,
    this.giaVon,
    this.giaBan,
    this.moTa,
    this.trangThai = 'HOAT_DONG',
    this.createdAt,
    this.updatedAt,
  });

  HangHoa copyWith({
    String? id,
    String? maHangHoa,
    String? tenHangHoa,
    String? donViTinh,
    String? loaiHangHoa,
    double? giaVon,
    double? giaBan,
    String? moTa,
    String? trangThai,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return HangHoa(
      id: id ?? this.id,
      maHangHoa: maHangHoa ?? this.maHangHoa,
      tenHangHoa: tenHangHoa ?? this.tenHangHoa,
      donViTinh: donViTinh ?? this.donViTinh,
      loaiHangHoa: loaiHangHoa ?? this.loaiHangHoa,
      giaVon: giaVon ?? this.giaVon,
      giaBan: giaBan ?? this.giaBan,
      moTa: moTa ?? this.moTa,
      trangThai: trangThai ?? this.trangThai,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    maHangHoa,
    tenHangHoa,
    donViTinh,
    loaiHangHoa,
    giaVon,
    giaBan,
    moTa,
    trangThai,
    createdAt,
    updatedAt,
  ];
}