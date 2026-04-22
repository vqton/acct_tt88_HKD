// ============================================================================
// Domain Layer - Entities
// Based on UC_HKD_TT88_2021 - KH-03: Kiểm kê hàng tồn kho
// Triggers: Định kỳ (cuối kỳ kế toán) hoặc đột xuất
// Depends: SK-03
// ============================================================================

import 'package:equatable/equatable.dart';

class PhieuKiemKe extends Equatable {
  final String id;
  final String soPhieu;
  final String ngayKiemKe;
  final String kyKeToanId;
  final String? ghiChu;
  final String nguoiLapId;
  final String? nguoiXacNhanId;
  final String trangThai; // CHO_KIEM_KE, DANG_KIEM_KE, DA_HOAN_THANH
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const PhieuKiemKe({
    required this.id,
    required this.soPhieu,
    required this.ngayKiemKe,
    required this.kyKeToanId,
    this.ghiChu,
    required this.nguoiLapId,
    this.nguoiXacNhanId,
    required this.trangThai,
    this.createdAt,
    this.updatedAt,
  });

  String get trangThaiLabel {
    switch (trangThai) {
      case 'CHO_KIEM_KE':
        return 'Chờ kiểm kê';
      case 'DANG_KIEM_KE':
        return 'Đang kiểm kê';
      case 'DA_HOAN_THANH':
        return 'Hoàn thành';
      default:
        return trangThai;
    }
  }

  bool get isPending => trangThai == 'CHO_KIEM_KE';
  bool get isInProgress => trangThai == 'DANG_KIEM_KE';
  bool get isCompleted => trangThai == 'DA_HOAN_THANH';

  PhieuKiemKe copyWith({
    String? id,
    String? soPhieu,
    String? ngayKiemKe,
    String? kyKeToanId,
    String? ghiChu,
    String? nguoiLapId,
    String? nguoiXacNhanId,
    String? trangThai,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PhieuKiemKe(
      id: id ?? this.id,
      soPhieu: soPhieu ?? this.soPhieu,
      ngayKiemKe: ngayKiemKe ?? this.ngayKiemKe,
      kyKeToanId: kyKeToanId ?? this.kyKeToanId,
      ghiChu: ghiChu ?? this.ghiChu,
      nguoiLapId: nguoiLapId ?? this.nguoiLapId,
      nguoiXacNhanId: nguoiXacNhanId ?? this.nguoiXacNhanId,
      trangThai: trangThai ?? this.trangThai,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        soPhieu,
        ngayKiemKe,
        kyKeToanId,
        ghiChu,
        nguoiLapId,
        nguoiXacNhanId,
        trangThai,
        createdAt,
        updatedAt,
      ];
}

class ChiTietKiemKe extends Equatable {
  final String id;
  final String phieuKiemKeId;
  final String hangHoaId;
  final double soLuongTheoSo; // Số lượng trên sổ SK-03
  final double? soLuongThucTe; // Số lượng đếm được
  final double? chenhLech; // Chênh lệch = Thực tế - Theo sổ
  final String? loaiChenhLech; // THUA, THIEU, HET
  final String? nguyenNhan;
  final String? xuLy;
  final DateTime? createdAt;

  const ChiTietKiemKe({
    required this.id,
    required this.phieuKiemKeId,
    required this.hangHoaId,
    required this.soLuongTheoSo,
    this.soLuongThucTe,
    this.chenhLech,
    this.loaiChenhLech,
    this.nguyenNhan,
    this.xuLy,
    this.createdAt,
  });

  double get chenhLechCalculated {
    if (soLuongThucTe == null) return 0;
    return soLuongThucTe! - soLuongTheoSo;
  }

  ChiTietKiemKe copyWith({
    String? id,
    String? phieuKiemKeId,
    String? hangHoaId,
    double? soLuongTheoSo,
    double? soLuongThucTe,
    double? chenhLech,
    String? loaiChenhLech,
    String? nguyenNhan,
    String? xuLy,
    DateTime? createdAt,
  }) {
    return ChiTietKiemKe(
      id: id ?? this.id,
      phieuKiemKeId: phieuKiemKeId ?? this.phieuKiemKeId,
      hangHoaId: hangHoaId ?? this.hangHoaId,
      soLuongTheoSo: soLuongTheoSo ?? this.soLuongTheoSo,
      soLuongThucTe: soLuongThucTe ?? this.soLuongThucTe,
      chenhLech: chenhLech ?? this.chenhLech,
      loaiChenhLech: loaiChenhLech ?? this.loaiChenhLech,
      nguyenNhan: nguyenNhan ?? this.nguyenNhan,
      xuLy: xuLy ?? this.xuLy,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        phieuKiemKeId,
        hangHoaId,
        soLuongTheoSo,
        soLuongThucTe,
        chenhLech,
        loaiChenhLech,
        nguyenNhan,
        xuLy,
        createdAt,
      ];
}