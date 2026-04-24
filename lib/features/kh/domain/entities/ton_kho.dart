// ============================================================================
// Domain Layer - Entities
// Based on UC_HKD_TT88_2021 - KH-04: Tính giá xuất kho
// ============================================================================

import 'package:equatable/equatable.dart';

class TonKho extends Equatable {
  final String id;
  final String kyKeToanId;
  final String hangHoaId;
  final double tonDauSoLuong;
  final int tonDauThanhTien;
  final double nhapSoLuong;
  final int nhapThanhTien;
  final double xuatSoLuong;
  final int xuatThanhTien;
  final double tonCuoiSoLuong;
  final int tonCuoiThanhTien;
  final double donGiaXuatKho;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const TonKho({
    required this.id,
    required this.kyKeToanId,
    required this.hangHoaId,
    this.tonDauSoLuong = 0,
    this.tonDauThanhTien = 0,
    this.nhapSoLuong = 0,
    this.nhapThanhTien = 0,
    this.xuatSoLuong = 0,
    this.xuatThanhTien = 0,
    this.tonCuoiSoLuong = 0,
    this.tonCuoiThanhTien = 0,
    this.donGiaXuatKho = 0,
    this.createdAt,
    this.updatedAt,
  });

  factory TonKho.empty({required String kyKeToanId, required String hangHoaId}) {
    return TonKho(
      id: '',
      kyKeToanId: kyKeToanId,
      hangHoaId: hangHoaId,
    );
  }

  double get tonDauDonGia =>
      tonDauSoLuong > 0 ? tonDauThanhTien / tonDauSoLuong : 0;

  double get donGiaBinhQuan =>
      (tonDauSoLuong + nhapSoLuong) > 0
          ? (tonDauThanhTien + nhapThanhTien) / (tonDauSoLuong + nhapSoLuong)
          : 0;

  TonKho copyWith({
    String? id,
    String? kyKeToanId,
    String? hangHoaId,
    double? tonDauSoLuong,
    int? tonDauThanhTien,
    double? nhapSoLuong,
    int? nhapThanhTien,
    double? xuatSoLuong,
    int? xuatThanhTien,
    double? tonCuoiSoLuong,
    int? tonCuoiThanhTien,
    double? donGiaXuatKho,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TonKho(
      id: id ?? this.id,
      kyKeToanId: kyKeToanId ?? this.kyKeToanId,
      hangHoaId: hangHoaId ?? this.hangHoaId,
      tonDauSoLuong: tonDauSoLuong ?? this.tonDauSoLuong,
      tonDauThanhTien: tonDauThanhTien ?? this.tonDauThanhTien,
      nhapSoLuong: nhapSoLuong ?? this.nhapSoLuong,
      nhapThanhTien: nhapThanhTien ?? this.nhapThanhTien,
      xuatSoLuong: xuatSoLuong ?? this.xuatSoLuong,
      xuatThanhTien: xuatThanhTien ?? this.xuatThanhTien,
      tonCuoiSoLuong: tonCuoiSoLuong ?? this.tonCuoiSoLuong,
      tonCuoiThanhTien: tonCuoiThanhTien ?? this.tonCuoiThanhTien,
      donGiaXuatKho: donGiaXuatKho ?? this.donGiaXuatKho,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        kyKeToanId,
        hangHoaId,
        tonDauSoLuong,
        tonDauThanhTien,
        nhapSoLuong,
        nhapThanhTien,
        xuatSoLuong,
        xuatThanhTien,
        tonCuoiSoLuong,
        tonCuoiThanhTien,
        donGiaXuatKho,
        createdAt,
        updatedAt,
      ];
}

class PhieuNhapKhoLot extends Equatable {
  final String id;
  final String phieuNhapKhoId;
  final String hangHoaId;
  final double soLuong;
  final double donGia;
  final int thanhTien;
  final DateTime ngayNhap;
  final double soLuongConLai;

  const PhieuNhapKhoLot({
    required this.id,
    required this.phieuNhapKhoId,
    required this.hangHoaId,
    required this.soLuong,
    required this.donGia,
    required this.thanhTien,
    required this.ngayNhap,
    this.soLuongConLai = 0,
  });

  @override
  List<Object?> get props => [
        id,
        phieuNhapKhoId,
        hangHoaId,
        soLuong,
        donGia,
        thanhTien,
        ngayNhap,
        soLuongConLai,
      ];
}