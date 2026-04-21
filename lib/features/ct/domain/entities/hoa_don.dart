// ============================================================================
// Domain Layer - Entities
// Based on UC_HKD_TT88_2021 - CT-06: Quản lý hóa đơn
// ============================================================================

import 'package:equatable/equatable.dart';

class HoaDon extends Equatable {
  final String id;
  final String soHoaDon;
  final DateTime ngayLap;
  final String loaiHoaDon; // DAU_VAO (mua hàng) | DAU_RA (bán hàng)
  final String kyKeToanId;
  final String? nhaCungCapId;
  final String? khachHangId;
  final String? phieuNhapKhoId;
  final String? phieuXuatKhoId;
  final int tienHang;
  final int tienThue;
  final int tongTien;
  final String trangThai; // MOI, DA_DUYET, HUY
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const HoaDon({
    required this.id,
    required this.soHoaDon,
    required this.ngayLap,
    required this.loaiHoaDon,
    required this.kyKeToanId,
    this.nhaCungCapId,
    this.khachHangId,
    this.phieuNhapKhoId,
    this.phieuXuatKhoId,
    this.tienHang = 0,
    this.tienThue = 0,
    this.tongTien = 0,
    this.trangThai = 'MOI',
    this.createdAt,
    this.updatedAt,
  });

  HoaDon copyWith({
    String? id,
    String? soHoaDon,
    DateTime? ngayLap,
    String? loaiHoaDon,
    String? kyKeToanId,
    String? nhaCungCapId,
    String? khachHangId,
    String? phieuNhapKhoId,
    String? phieuXuatKhoId,
    int? tienHang,
    int? tienThue,
    int? tongTien,
    String? trangThai,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return HoaDon(
      id: id ?? this.id,
      soHoaDon: soHoaDon ?? this.soHoaDon,
      ngayLap: ngayLap ?? this.ngayLap,
      loaiHoaDon: loaiHoaDon ?? this.loaiHoaDon,
      kyKeToanId: kyKeToanId ?? this.kyKeToanId,
      nhaCungCapId: nhaCungCapId ?? this.nhaCungCapId,
      khachHangId: khachHangId ?? this.khachHangId,
      phieuNhapKhoId: phieuNhapKhoId ?? this.phieuNhapKhoId,
      phieuXuatKhoId: phieuXuatKhoId ?? this.phieuXuatKhoId,
      tienHang: tienHang ?? this.tienHang,
      tienThue: tienThue ?? this.tienThue,
      tongTien: tongTien ?? this.tongTien,
      trangThai: trangThai ?? this.trangThai,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        soHoaDon,
        ngayLap,
        loaiHoaDon,
        kyKeToanId,
        nhaCungCapId,
        khachHangId,
        phieuNhapKhoId,
        phieuXuatKhoId,
        tienHang,
        tienThue,
        tongTien,
        trangThai,
        createdAt,
        updatedAt,
      ];
}
