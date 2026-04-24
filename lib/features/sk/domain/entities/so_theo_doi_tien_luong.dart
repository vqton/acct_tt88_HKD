// ============================================================================
// Domain Layer - Entity
// Based on UC_HKD_TT88_2021 - SK-06: Ghi sổ theo dõi thanh toán tiền lương (S5-HKD)
// ============================================================================

import 'package:equatable/equatable.dart';

class SoTheoDoiTienLuong extends Equatable {
  final String id;
  final String kyKeToanId;
  final String bangLuongId;
  final String thangNam;
  final DateTime ngayLap;
  final double phaiTraLuong;
  final double daTraLuong;
  final double conPhaiTraLuong;
  final double bhxhPhaiNop;
  final double bhxhDaNop;
  final double bhxhConPhaiNop;
  final double bhytPhaiNop;
  final double bhytDaNop;
  final double bhytConPhaiNop;
  final double bhtnPhaiNop;
  final double bhtnDaNop;
  final double bhtnConPhaiNop;
  final String trangThai;
  final String? ghiChu;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const SoTheoDoiTienLuong({
    required this.id,
    required this.kyKeToanId,
    required this.bangLuongId,
    required this.thangNam,
    required this.ngayLap,
    required this.phaiTraLuong,
    required this.daTraLuong,
    required this.conPhaiTraLuong,
    required this.bhxhPhaiNop,
    required this.bhxhDaNop,
    required this.bhxhConPhaiNop,
    required this.bhytPhaiNop,
    required this.bhytDaNop,
    required this.bhytConPhaiNop,
    required this.bhtnPhaiNop,
    required this.bhtnDaNop,
    required this.bhtnConPhaiNop,
    required this.trangThai,
    this.ghiChu,
    this.createdAt,
    this.updatedAt,
  });

  double get tongPhaiTraBhxh => bhxhPhaiNop + bhytPhaiNop + bhtnPhaiNop;
  double get tongDaNopBhxh => bhxhDaNop + bhytDaNop + bhtnDaNop;
  double get tongConPhaiNopBhxh => bhxhConPhaiNop + bhytConPhaiNop + bhtnConPhaiNop;

  SoTheoDoiTienLuong copyWith({
    String? id,
    String? kyKeToanId,
    String? bangLuongId,
    String? thangNam,
    DateTime? ngayLap,
    double? phaiTraLuong,
    double? daTraLuong,
    double? conPhaiTraLuong,
    double? bhxhPhaiNop,
    double? bhxhDaNop,
    double? bhxhConPhaiNop,
    double? bhytPhaiNop,
    double? bhytDaNop,
    double? bhytConPhaiNop,
    double? bhtnPhaiNop,
    double? bhtnDaNop,
    double? bhtnConPhaiNop,
    String? trangThai,
    String? ghiChu,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SoTheoDoiTienLuong(
      id: id ?? this.id,
      kyKeToanId: kyKeToanId ?? this.kyKeToanId,
      bangLuongId: bangLuongId ?? this.bangLuongId,
      thangNam: thangNam ?? this.thangNam,
      ngayLap: ngayLap ?? this.ngayLap,
      phaiTraLuong: phaiTraLuong ?? this.phaiTraLuong,
      daTraLuong: daTraLuong ?? this.daTraLuong,
      conPhaiTraLuong: conPhaiTraLuong ?? this.conPhaiTraLuong,
      bhxhPhaiNop: bhxhPhaiNop ?? this.bhxhPhaiNop,
      bhxhDaNop: bhxhDaNop ?? this.bhxhDaNop,
      bhxhConPhaiNop: bhxhConPhaiNop ?? this.bhxhConPhaiNop,
      bhytPhaiNop: bhytPhaiNop ?? this.bhytPhaiNop,
      bhytDaNop: bhytDaNop ?? this.bhytDaNop,
      bhytConPhaiNop: bhytConPhaiNop ?? this.bhytConPhaiNop,
      bhtnPhaiNop: bhtnPhaiNop ?? this.bhtnPhaiNop,
      bhtnDaNop: bhtnDaNop ?? this.bhtnDaNop,
      bhtnConPhaiNop: bhtnConPhaiNop ?? this.bhtnConPhaiNop,
      trangThai: trangThai ?? this.trangThai,
      ghiChu: ghiChu ?? this.ghiChu,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        kyKeToanId,
        bangLuongId,
        thangNam,
        ngayLap,
        phaiTraLuong,
        daTraLuong,
        conPhaiTraLuong,
        bhxhPhaiNop,
        bhxhDaNop,
        bhxhConPhaiNop,
        bhytPhaiNop,
        bhytDaNop,
        bhytConPhaiNop,
        bhtnPhaiNop,
        bhtnDaNop,
        bhtnConPhaiNop,
        trangThai,
        ghiChu,
        createdAt,
        updatedAt,
      ];
}