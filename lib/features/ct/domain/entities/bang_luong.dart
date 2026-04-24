// ============================================================================
// Domain Layer - Entity
// Based on UC_HKD_TT88_2021 - CT-05: Lập bảng thanh toán tiền lương & thu nhập NLĐ
// ============================================================================

import 'package:equatable/equatable.dart';

class BangLuong extends Equatable {
  final String id;
  final String maBangLuong;
  final String kyKeToanId;
  final String thangNam;
  final DateTime ngayLap;
  final List<ChiTietBangLuong> chiTietList;
  final double tongLuongSanPham;
  final double tongLuongThoiGian;
  final double tongPhuCapQuyLuong;
  final double tongPhuCapNgoaiQuy;
  final double tongTienThuong;
  final double tongThuNhap;
  final double tongBhxh;
  final double tongBhyt;
  final double tongBhtn;
  final double tongThueTNCN;
  final double tongKhauTru;
  final double tongTraNhanVien;
  final String trangThai;
  final String? nguoiLap;
  final String? nguoiDuyet;
  final DateTime? ngayDuyet;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const BangLuong({
    required this.id,
    required this.maBangLuong,
    required this.kyKeToanId,
    required this.thangNam,
    required this.ngayLap,
    required this.chiTietList,
    required this.tongLuongSanPham,
    required this.tongLuongThoiGian,
    required this.tongPhuCapQuyLuong,
    required this.tongPhuCapNgoaiQuy,
    required this.tongTienThuong,
    required this.tongThuNhap,
    required this.tongBhxh,
    required this.tongBhyt,
    required this.tongBhtn,
    required this.tongThueTNCN,
    required this.tongKhauTru,
    required this.tongTraNhanVien,
    required this.trangThai,
    this.nguoiLap,
    this.nguoiDuyet,
    this.ngayDuyet,
    this.createdAt,
    this.updatedAt,
  });

  double get tongLuongCoBan => chiTietList.fold(0, (sum, ct) => sum + ct.luongCoBan);
  double get tongHeSoLuong => chiTietList.fold(0, (sum, ct) => sum + (ct.heSoLuong * ct.luongCoBan));
  double get tongSoCong => chiTietList.fold(0, (sum, ct) => sum + ct.soCong);

  BangLuong copyWith({
    String? id,
    String? maBangLuong,
    String? kyKeToanId,
    String? thangNam,
    DateTime? ngayLap,
    List<ChiTietBangLuong>? chiTietList,
    double? tongLuongSanPham,
    double? tongLuongThoiGian,
    double? tongPhuCapQuyLuong,
    double? tongPhuCapNgoaiQuy,
    double? tongTienThuong,
    double? tongThuNhap,
    double? tongBhxh,
    double? tongBhyt,
    double? tongBhtn,
    double? tongThueTNCN,
    double? tongKhauTru,
    double? tongTraNhanVien,
    String? trangThai,
    String? nguoiLap,
    String? nguoiDuyet,
    DateTime? ngayDuyet,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BangLuong(
      id: id ?? this.id,
      maBangLuong: maBangLuong ?? this.maBangLuong,
      kyKeToanId: kyKeToanId ?? this.kyKeToanId,
      thangNam: thangNam ?? this.thangNam,
      ngayLap: ngayLap ?? this.ngayLap,
      chiTietList: chiTietList ?? this.chiTietList,
      tongLuongSanPham: tongLuongSanPham ?? this.tongLuongSanPham,
      tongLuongThoiGian: tongLuongThoiGian ?? this.tongLuongThoiGian,
      tongPhuCapQuyLuong: tongPhuCapQuyLuong ?? this.tongPhuCapQuyLuong,
      tongPhuCapNgoaiQuy: tongPhuCapNgoaiQuy ?? this.tongPhuCapNgoaiQuy,
      tongTienThuong: tongTienThuong ?? this.tongTienThuong,
      tongThuNhap: tongThuNhap ?? this.tongThuNhap,
      tongBhxh: tongBhxh ?? this.tongBhxh,
      tongBhyt: tongBhyt ?? this.tongBhyt,
      tongBhtn: tongBhtn ?? this.tongBhtn,
      tongThueTNCN: tongThueTNCN ?? this.tongThueTNCN,
      tongKhauTru: tongKhauTru ?? this.tongKhauTru,
      tongTraNhanVien: tongTraNhanVien ?? this.tongTraNhanVien,
      trangThai: trangThai ?? this.trangThai,
      nguoiLap: nguoiLap ?? this.nguoiLap,
      nguoiDuyet: nguoiDuyet ?? this.nguoiDuyet,
      ngayDuyet: ngayDuyet ?? this.ngayDuyet,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        maBangLuong,
        kyKeToanId,
        thangNam,
        ngayLap,
        chiTietList,
        tongLuongSanPham,
        tongLuongThoiGian,
        tongPhuCapQuyLuong,
        tongPhuCapNgoaiQuy,
        tongTienThuong,
        tongThuNhap,
        tongBhxh,
        tongBhyt,
        tongBhtn,
        tongThueTNCN,
        tongKhauTru,
        tongTraNhanVien,
        trangThai,
        nguoiLap,
        nguoiDuyet,
        ngayDuyet,
        createdAt,
        updatedAt,
      ];
}

class ChiTietBangLuong extends Equatable {
  final String id;
  final String bangLuongId;
  final String nguoiLaoDongId;
  final String maNld;
  final String hoTen;
  final double soCong;
  final double donGiaLuong;
  final double luongSanPham;
  final double luongCoBan;
  final double heSoLuong;
  final double phuCapQuyLuong;
  final double phuCapNgoaiQuy;
  final double tienThuong;
  final double thuNhap;
  final double bhxh;
  final double bhyt;
  final double bhtn;
  final double thueTNCN;
  final double tongKhauTru;
  final double soPhaiTra;
  final String? kyNhan;
  final DateTime? ngayNhan;

  const ChiTietBangLuong({
    required this.id,
    required this.bangLuongId,
    required this.nguoiLaoDongId,
    required this.maNld,
    required this.hoTen,
    required this.soCong,
    required this.donGiaLuong,
    required this.luongSanPham,
    required this.luongCoBan,
    required this.heSoLuong,
    required this.phuCapQuyLuong,
    required this.phuCapNgoaiQuy,
    required this.tienThuong,
    required this.thuNhap,
    required this.bhxh,
    required this.bhyt,
    required this.bhtn,
    required this.thueTNCN,
    required this.tongKhauTru,
    required this.soPhaiTra,
    this.kyNhan,
    this.ngayNhan,
  });

  @override
  List<Object?> get props => [
        id,
        bangLuongId,
        nguoiLaoDongId,
        maNld,
        hoTen,
        soCong,
        donGiaLuong,
        luongSanPham,
        luongCoBan,
        heSoLuong,
        phuCapQuyLuong,
        phuCapNgoaiQuy,
        tienThuong,
        thuNhap,
        bhxh,
        bhyt,
        bhtn,
        thueTNCN,
        tongKhauTru,
        soPhaiTra,
        kyNhan,
        ngayNhan,
      ];
}