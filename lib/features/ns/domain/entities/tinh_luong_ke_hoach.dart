// ============================================================================
// Domain Layer - Entity
// Based on UC_HKD_TT88_2021 - NS-01: Tính lương người lao động
// ============================================================================

import 'package:equatable/equatable.dart';

class TinhLuongKeHoach extends Equatable {
  final String id;
  final String nguoiLaoDongId;
  final String thangNam;
  final double soCong;
  final double soSanPham;
  final double donGiaLuongSp;
  final double donGiaLuongTg;
  final double heSoLuong;
  final double luongSanPham;
  final double luongThoiGian;
  final double phuCapQuyLuong;
  final double phuCapNgoaiQuy;
  final double tienThuong;
  final double tongThuNhap;
  final DateTime createdAt;

  const TinhLuongKeHoach({
    required this.id,
    required this.nguoiLaoDongId,
    required this.thangNam,
    required this.soCong,
    required this.soSanPham,
    required this.donGiaLuongSp,
    required this.donGiaLuongTg,
    required this.heSoLuong,
    required this.luongSanPham,
    required this.luongThoiGian,
    required this.phuCapQuyLuong,
    required this.phuCapNgoaiQuy,
    required this.tienThuong,
    required this.tongThuNhap,
    required this.createdAt,
  });

  factory TinhLuongKeHoach.calculate({
    required String id,
    required String nguoiLaoDongId,
    required String thangNam,
    required double soCong,
    required double soSanPham,
    required double donGiaLuongSp,
    required double donGiaLuongTg,
    required double heSoLuong,
    required double phuCapQuyLuong,
    required double phuCapNgoaiQuy,
    required double tienThuong,
  }) {
    final luongSp = soSanPham * donGiaLuongSp;
    final luongTg = soCong * donGiaLuongTg * heSoLuong;
    final tongThuNhap = luongSp + luongTg + phuCapQuyLuong + phuCapNgoaiQuy + tienThuong;
    return TinhLuongKeHoach(
      id: id,
      nguoiLaoDongId: nguoiLaoDongId,
      thangNam: thangNam,
      soCong: soCong,
      soSanPham: soSanPham,
      donGiaLuongSp: donGiaLuongSp,
      donGiaLuongTg: donGiaLuongTg,
      heSoLuong: heSoLuong,
      luongSanPham: luongSp,
      luongThoiGian: luongTg,
      phuCapQuyLuong: phuCapQuyLuong,
      phuCapNgoaiQuy: phuCapNgoaiQuy,
      tienThuong: tienThuong,
      tongThuNhap: tongThuNhap,
      createdAt: DateTime.now(),
    );
  }

  TinhLuongKeHoach copyWith({
    String? id,
    String? nguoiLaoDongId,
    String? thangNam,
    double? soCong,
    double? soSanPham,
    double? donGiaLuongSp,
    double? donGiaLuongTg,
    double? heSoLuong,
    double? luongSanPham,
    double? luongThoiGian,
    double? phuCapQuyLuong,
    double? phuCapNgoaiQuy,
    double? tienThuong,
    double? tongThuNhap,
    DateTime? createdAt,
  }) {
    return TinhLuongKeHoach(
      id: id ?? this.id,
      nguoiLaoDongId: nguoiLaoDongId ?? this.nguoiLaoDongId,
      thangNam: thangNam ?? this.thangNam,
      soCong: soCong ?? this.soCong,
      soSanPham: soSanPham ?? this.soSanPham,
      donGiaLuongSp: donGiaLuongSp ?? this.donGiaLuongSp,
      donGiaLuongTg: donGiaLuongTg ?? this.donGiaLuongTg,
      heSoLuong: heSoLuong ?? this.heSoLuong,
      luongSanPham: luongSanPham ?? this.luongSanPham,
      luongThoiGian: luongThoiGian ?? this.luongThoiGian,
      phuCapQuyLuong: phuCapQuyLuong ?? this.phuCapQuyLuong,
      phuCapNgoaiQuy: phuCapNgoaiQuy ?? this.phuCapNgoaiQuy,
      tienThuong: tienThuong ?? this.tienThuong,
      tongThuNhap: tongThuNhap ?? this.tongThuNhap,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        nguoiLaoDongId,
        thangNam,
        soCong,
        soSanPham,
        donGiaLuongSp,
        donGiaLuongTg,
        heSoLuong,
        luongSanPham,
        luongThoiGian,
        phuCapQuyLuong,
        phuCapNgoaiQuy,
        tienThuong,
        tongThuNhap,
        createdAt,
      ];
}