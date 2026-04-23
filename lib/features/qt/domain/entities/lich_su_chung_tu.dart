// ============================================================================
// Domain Layer - Entities
// Based on UC_HKD_TT88_2021 - QT-05: Lịch sử chứng từ
// ============================================================================

import 'package:equatable/equatable.dart';

enum LoaiChungTu {
  phieuThu,
  phieuChi,
  hoaDon,
  phieuNhapKho,
  phieuXuatKho,
}

class LichSuChungTu extends Equatable {
  final String id;
  final LoaiChungTu loaiChungTu;
  final String soPhieu;
  final DateTime ngayLap;
  final String dienGiai;
  final int soTien;
  final String trangThai;
  final String nguoiLap;
  final String nguoiDuyet;
  final DateTime createdAt;
  final DateTime updatedAt;

  const LichSuChungTu({
    required this.id,
    required this.loaiChungTu,
    required this.soPhieu,
    required this.ngayLap,
    required this.dienGiai,
    required this.soTien,
    required this.trangThai,
    required this.nguoiLap,
    required this.nguoiDuyet,
    required this.createdAt,
    required this.updatedAt,
  });

  String get loaiChungTuLabel {
    switch (loaiChungTu) {
      case LoaiChungTu.phieuThu:
        return 'Phiếu thu';
      case LoaiChungTu.phieuChi:
        return 'Phiếu chi';
      case LoaiChungTu.hoaDon:
        return 'Hóa đơn';
      case LoaiChungTu.phieuNhapKho:
        return 'Phiếu nhập kho';
      case LoaiChungTu.phieuXuatKho:
        return 'Phiếu xuất kho';
    }
  }

  LichSuChungTu copyWith({
    String? id,
    LoaiChungTu? loaiChungTu,
    String? soPhieu,
    DateTime? ngayLap,
    String? dienGiai,
    int? soTien,
    String? trangThai,
    String? nguoiLap,
    String? nguoiDuyet,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LichSuChungTu(
      id: id ?? this.id,
      loaiChungTu: loaiChungTu ?? this.loaiChungTu,
      soPhieu: soPhieu ?? this.soPhieu,
      ngayLap: ngayLap ?? this.ngayLap,
      dienGiai: dienGiai ?? this.dienGiai,
      soTien: soTien ?? this.soTien,
      trangThai: trangThai ?? this.trangThai,
      nguoiLap: nguoiLap ?? this.nguoiLap,
      nguoiDuyet: nguoiDuyet ?? this.nguoiDuyet,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        loaiChungTu,
        soPhieu,
        ngayLap,
        dienGiai,
        soTien,
        trangThai,
        nguoiLap,
        nguoiDuyet,
        createdAt,
        updatedAt,
      ];
}