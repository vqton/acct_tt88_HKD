// ============================================================================
// Domain Layer - Entities
// Based on UC_HKD_TT88_2021 - CT-04: Lập phiếu xuất kho
// ============================================================================

import 'package:equatable/equatable.dart';

class PhieuXuatKho extends Equatable {
  final String id;
  final String soPhieu;
  final DateTime ngayLap;
  final String kyKeToanId;
  final String? hoTenNguoiNhan;
  final String? boPhan;
  final String? lyDoXuat;
  final String? diaDiemXuat;
  final String? nguoiLapId;
  final String? nguoiDuyetId;
  final String trangThai;
  final DateTime? ngayDuyet;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<PhieuXuatKhoChiTiet> chiTietList;

  const PhieuXuatKho({
    required this.id,
    required this.soPhieu,
    required this.ngayLap,
    required this.kyKeToanId,
    this.hoTenNguoiNhan,
    this.boPhan,
    this.lyDoXuat,
    this.diaDiemXuat,
    this.nguoiLapId,
    this.nguoiDuyetId,
    this.trangThai = 'CHO_DUYET',
    this.ngayDuyet,
    this.createdAt,
    this.updatedAt,
    this.chiTietList = const [],
  });

  int get tongTien => chiTietList.fold(0, (sum, item) => sum + item.thanhTien);

  PhieuXuatKho copyWith({
    String? id,
    String? soPhieu,
    DateTime? ngayLap,
    String? kyKeToanId,
    String? hoTenNguoiNhan,
    String? boPhan,
    String? lyDoXuat,
    String? diaDiemXuat,
    String? nguoiLapId,
    String? nguoiDuyetId,
    String? trangThai,
    DateTime? ngayDuyet,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<PhieuXuatKhoChiTiet>? chiTietList,
  }) {
    return PhieuXuatKho(
      id: id ?? this.id,
      soPhieu: soPhieu ?? this.soPhieu,
      ngayLap: ngayLap ?? this.ngayLap,
      kyKeToanId: kyKeToanId ?? this.kyKeToanId,
      hoTenNguoiNhan: hoTenNguoiNhan ?? this.hoTenNguoiNhan,
      boPhan: boPhan ?? this.boPhan,
      lyDoXuat: lyDoXuat ?? this.lyDoXuat,
      diaDiemXuat: diaDiemXuat ?? this.diaDiemXuat,
      nguoiLapId: nguoiLapId ?? this.nguoiLapId,
      nguoiDuyetId: nguoiDuyetId ?? this.nguoiDuyetId,
      trangThai: trangThai ?? this.trangThai,
      ngayDuyet: ngayDuyet ?? this.ngayDuyet,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      chiTietList: chiTietList ?? this.chiTietList,
    );
  }

  @override
  List<Object?> get props => [
        id,
        soPhieu,
        ngayLap,
        kyKeToanId,
        hoTenNguoiNhan,
        boPhan,
        lyDoXuat,
        diaDiemXuat,
        nguoiLapId,
        nguoiDuyetId,
        trangThai,
        ngayDuyet,
        createdAt,
        updatedAt,
        chiTietList,
      ];
}

class PhieuXuatKhoChiTiet extends Equatable {
  final String id;
  final String phieuXuatKhoId;
  final String hangHoaId;
  final double soLuongYeuCau;
  final double soLuongThucXuat;
  final double donGia;
  final int thanhTien;

  const PhieuXuatKhoChiTiet({
    required this.id,
    required this.phieuXuatKhoId,
    required this.hangHoaId,
    required this.soLuongYeuCau,
    required this.soLuongThucXuat,
    required this.donGia,
    required this.thanhTien,
  });

  PhieuXuatKhoChiTiet copyWith({
    String? id,
    String? phieuXuatKhoId,
    String? hangHoaId,
    double? soLuongYeuCau,
    double? soLuongThucXuat,
    double? donGia,
    int? thanhTien,
  }) {
    return PhieuXuatKhoChiTiet(
      id: id ?? this.id,
      phieuXuatKhoId: phieuXuatKhoId ?? this.phieuXuatKhoId,
      hangHoaId: hangHoaId ?? this.hangHoaId,
      soLuongYeuCau: soLuongYeuCau ?? this.soLuongYeuCau,
      soLuongThucXuat: soLuongThucXuat ?? this.soLuongThucXuat,
      donGia: donGia ?? this.donGia,
      thanhTien: thanhTien ?? this.thanhTien,
    );
  }

  @override
  List<Object?> get props => [
        id,
        phieuXuatKhoId,
        hangHoaId,
        soLuongYeuCau,
        soLuongThucXuat,
        donGia,
        thanhTien,
      ];
}
