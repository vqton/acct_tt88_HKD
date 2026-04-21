// ============================================================================
// Domain Layer - Entities
// Based on UC_HKD_TT88_2021 - MD-01: Quản lý thông tin HKD/CNKD
// ============================================================================

import 'package:equatable/equatable.dart';

class HkdInfo extends Equatable {
  final String id;
  final String tenHkd;
  final String? diaChiTruSo;
  final String maSoThue;
  final String? soCccdNguoiDaiDien;
  final String? hoTenNguoiDaiDien;
  final String phuongPhapTinhGiaXuatKho;
  final String trangThai;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  
  const HkdInfo({
    required this.id,
    required this.tenHkd,
    this.diaChiTruSo,
    required this.maSoThue,
    this.soCccdNguoiDaiDien,
    this.hoTenNguoiDaiDien,
    this.phuongPhapTinhGiaXuatKho = 'BINH_QUAN',
    this.trangThai = 'HOAT_DONG',
    this.createdAt,
    this.updatedAt,
  });
  
  HkdInfo copyWith({
    String? id,
    String? tenHkd,
    String? diaChiTruSo,
    String? maSoThue,
    String? soCccdNguoiDaiDien,
    String? hoTenNguoiDaiDien,
    String? phuongPhapTinhGiaXuatKho,
    String? trangThai,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return HkdInfo(
      id: id ?? this.id,
      tenHkd: tenHkd ?? this.tenHkd,
      diaChiTruSo: diaChiTruSo ?? this.diaChiTruSo,
      maSoThue: maSoThue ?? this.maSoThue,
      soCccdNguoiDaiDien: soCccdNguoiDaiDien ?? this.soCccdNguoiDaiDien,
      hoTenNguoiDaiDien: hoTenNguoiDaiDien ?? this.hoTenNguoiDaiDien,
      phuongPhapTinhGiaXuatKho: phuongPhapTinhGiaXuatKho ?? this.phuongPhapTinhGiaXuatKho,
      trangThai: trangThai ?? this.trangThai,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  
  @override
  List<Object?> get props => [
    id, tenHkd, diaChiTruSo, maSoThue, 
    soCccdNguoiDaiDien, hoTenNguoiDaiDien,
    phuongPhapTinhGiaXuatKho, trangThai, createdAt, updatedAt
  ];
}
