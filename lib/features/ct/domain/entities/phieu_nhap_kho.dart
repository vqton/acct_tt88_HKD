// ============================================================================
// Domain Layer - Entities
// Based on UC_HKD_TT88_2021 - CT-03: Lập phiếu nhập kho
// ============================================================================

import 'package:equatable/equatable.dart';

class PhieuNhapKho extends Equatable {
  final String id;
  final String soPhieu;
  final DateTime ngayLap;
  final String kyKeToanId;
  final String? nhaCungCapId;
  final String? soHoaDon;
  final String? diaDiemNhap;
  final String? lyDoNhap;
  final String? nguoiGiaoHang;
  final String? nguoiLapId;
  final String? nguoiDuyetId;
  final String trangThai;
  final DateTime? ngayDuyet;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<PhieuNhapKhoChiTiet> chiTietList;

  const PhieuNhapKho({
    required this.id,
    required this.soPhieu,
    required this.ngayLap,
    required this.kyKeToanId,
    this.nhaCungCapId,
    this.soHoaDon,
    this.diaDiemNhap,
    this.lyDoNhap,
    this.nguoiGiaoHang,
    this.nguoiLapId,
    this.nguoiDuyetId,
    this.trangThai = 'CHO_DUYET',
    this.ngayDuyet,
    this.createdAt,
    this.updatedAt,
    this.chiTietList = const [],
  });

  int get tongTien => chiTietList.fold(0, (sum, item) => sum + item.thanhTien);

  PhieuNhapKho copyWith({
    String? id,
    String? soPhieu,
    DateTime? ngayLap,
    String? kyKeToanId,
    String? nhaCungCapId,
    String? soHoaDon,
    String? diaDiemNhap,
    String? lyDoNhap,
    String? nguoiGiaoHang,
    String? nguoiLapId,
    String? nguoiDuyetId,
    String? trangThai,
    DateTime? ngayDuyet,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<PhieuNhapKhoChiTiet>? chiTietList,
  }) {
    return PhieuNhapKho(
      id: id ?? this.id,
      soPhieu: soPhieu ?? this.soPhieu,
      ngayLap: ngayLap ?? this.ngayLap,
      kyKeToanId: kyKeToanId ?? this.kyKeToanId,
      nhaCungCapId: nhaCungCapId ?? this.nhaCungCapId,
      soHoaDon: soHoaDon ?? this.soHoaDon,
      diaDiemNhap: diaDiemNhap ?? this.diaDiemNhap,
      lyDoNhap: lyDoNhap ?? this.lyDoNhap,
      nguoiGiaoHang: nguoiGiaoHang ?? this.nguoiGiaoHang,
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
        nhaCungCapId,
        soHoaDon,
        diaDiemNhap,
        lyDoNhap,
        nguoiGiaoHang,
        nguoiLapId,
        nguoiDuyetId,
        trangThai,
        ngayDuyet,
        createdAt,
        updatedAt,
        chiTietList,
      ];
}

class PhieuNhapKhoChiTiet extends Equatable {
  final String id;
  final String phieuNhapKhoId;
  final String hangHoaId;
  final double soLuongTheoChungTu;
  final double soLuongThucNhan;
  final double donGia;
  final int thanhTien;

  const PhieuNhapKhoChiTiet({
    required this.id,
    required this.phieuNhapKhoId,
    required this.hangHoaId,
    required this.soLuongTheoChungTu,
    required this.soLuongThucNhan,
    required this.donGia,
    required this.thanhTien,
  });

  PhieuNhapKhoChiTiet copyWith({
    String? id,
    String? phieuNhapKhoId,
    String? hangHoaId,
    double? soLuongTheoChungTu,
    double? soLuongThucNhan,
    double? donGia,
    int? thanhTien,
  }) {
    return PhieuNhapKhoChiTiet(
      id: id ?? this.id,
      phieuNhapKhoId: phieuNhapKhoId ?? this.phieuNhapKhoId,
      hangHoaId: hangHoaId ?? this.hangHoaId,
      soLuongTheoChungTu: soLuongTheoChungTu ?? this.soLuongTheoChungTu,
      soLuongThucNhan: soLuongThucNhan ?? this.soLuongThucNhan,
      donGia: donGia ?? this.donGia,
      thanhTien: thanhTien ?? this.thanhTien,
    );
  }

  @override
  List<Object?> get props => [
        id,
        phieuNhapKhoId,
        hangHoaId,
        soLuongTheoChungTu,
        soLuongThucNhan,
        donGia,
        thanhTien,
      ];
}
