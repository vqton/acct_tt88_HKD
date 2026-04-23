// ============================================================================
// Data Layer - Model
// Based on UC_HKD_TT88_2021 - KH-03: Kiểm kê hàng tồn kho
// ============================================================================

import 'package:hkd_accounting/features/kh/domain/entities/phieu_kiem_ke.dart';

class PhieuKiemKeModel extends PhieuKiemKe {
  const PhieuKiemKeModel({
    required String id,
    required String soPhieu,
    required String ngayKiemKe,
    required String kyKeToanId,
    String? ghiChu,
    required String nguoiLapId,
    String? nguoiXacNhanId,
    required String trangThai,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
          id: id,
          soPhieu: soPhieu,
          ngayKiemKe: ngayKiemKe,
          kyKeToanId: kyKeToanId,
          ghiChu: ghiChu,
          nguoiLapId: nguoiLapId,
          nguoiXacNhanId: nguoiXacNhanId,
          trangThai: trangThai,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory PhieuKiemKeModel.fromEntity(PhieuKiemKe entity) {
    return PhieuKiemKeModel(
      id: entity.id,
      soPhieu: entity.soPhieu,
      ngayKiemKe: entity.ngayKiemKe,
      kyKeToanId: entity.kyKeToanId,
      ghiChu: entity.ghiChu,
      nguoiLapId: entity.nguoiLapId,
      nguoiXacNhanId: entity.nguoiXacNhanId,
      trangThai: entity.trangThai,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  PhieuKiemKe toEntity() {
    return PhieuKiemKe(
      id: id,
      soPhieu: soPhieu,
      ngayKiemKe: ngayKiemKe,
      kyKeToanId: kyKeToanId,
      ghiChu: ghiChu,
      nguoiLapId: nguoiLapId,
      nguoiXacNhanId: nguoiXacNhanId,
      trangThai: trangThai,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory PhieuKiemKeModel.fromMap(Map<String, dynamic> map) {
    return PhieuKiemKeModel(
      id: map['id'] as String,
      soPhieu: map['so_phieu'] as String,
      ngayKiemKe: map['ngay_kiem_ke'] as String,
      kyKeToanId: map['ky_ke_toan_id'] as String,
      ghiChu: map['ghi_chu'] as String?,
      nguoiLapId: map['nguoi_lap_id'] as String,
      nguoiXacNhanId: map['nguoi_xac_nhan_id'] as String?,
      trangThai: map['trang_thai'] as String,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'so_phieu': soPhieu,
      'ngay_kiem_ke': ngayKiemKe,
      'ky_ke_toan_id': kyKeToanId,
      'ghi_chu': ghiChu,
      'nguoi_lap_id': nguoiLapId,
      'nguoi_xac_nhan_id': nguoiXacNhanId,
      'trang_thai': trangThai,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class ChiTietKiemKeModel extends ChiTietKiemKe {
  const ChiTietKiemKeModel({
    required String id,
    required String phieuKiemKeId,
    required String hangHoaId,
    required double soLuongTheoSo,
    double? soLuongThucTe,
    double? chenhLech,
    String? loaiChenhLech,
    String? nguyenNhan,
    String? xuLy,
    DateTime? createdAt,
  }) : super(
          id: id,
          phieuKiemKeId: phieuKiemKeId,
          hangHoaId: hangHoaId,
          soLuongTheoSo: soLuongTheoSo,
          soLuongThucTe: soLuongThucTe,
          chenhLech: chenhLech,
          loaiChenhLech: loaiChenhLech,
          nguyenNhan: nguyenNhan,
          xuLy: xuLy,
          createdAt: createdAt,
        );

  factory ChiTietKiemKeModel.fromEntity(ChiTietKiemKe entity) {
    return ChiTietKiemKeModel(
      id: entity.id,
      phieuKiemKeId: entity.phieuKiemKeId,
      hangHoaId: entity.hangHoaId,
      soLuongTheoSo: entity.soLuongTheoSo,
      soLuongThucTe: entity.soLuongThucTe,
      chenhLech: entity.chenhLech,
      loaiChenhLech: entity.loaiChenhLech,
      nguyenNhan: entity.nguyenNhan,
      xuLy: entity.xuLy,
      createdAt: entity.createdAt,
    );
  }

  ChiTietKiemKe toEntity() {
    return ChiTietKiemKe(
      id: id,
      phieuKiemKeId: phieuKiemKeId,
      hangHoaId: hangHoaId,
      soLuongTheoSo: soLuongTheoSo,
      soLuongThucTe: soLuongThucTe,
      chenhLech: chenhLech,
      loaiChenhLech: loaiChenhLech,
      nguyenNhan: nguyenNhan,
      xuLy: xuLy,
      createdAt: createdAt,
    );
  }

  factory ChiTietKiemKeModel.fromMap(Map<String, dynamic> map) {
    return ChiTietKiemKeModel(
      id: map['id'] as String,
      phieuKiemKeId: map['phieu_kiem_ke_id'] as String,
      hangHoaId: map['hang_hoa_id'] as String,
      soLuongTheoSo: (map['so_luong_theo_so'] as num).toDouble(),
      soLuongThucTe: map['so_luong_thuc_te'] != null
          ? (map['so_luong_thuc_te'] as num).toDouble()
          : null,
      chenhLech: map['chenh_lech'] != null
          ? (map['chenh_lech'] as num).toDouble()
          : null,
      loaiChenhLech: map['loai_chenh_lech'] as String?,
      nguyenNhan: map['nguyen_nhan'] as String?,
      xuLy: map['xu_ly'] as String?,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phieu_kiem_ke_id': phieuKiemKeId,
      'hang_hoa_id': hangHoaId,
      'so_luong_theo_so': soLuongTheoSo,
      'so_luong_thuc_te': soLuongThucTe,
      'chenh_lech': chenhLech,
      'loai_chenh_lech': loaiChenhLech,
      'nguyen_nhan': nguyenNhan,
      'xu_ly': xuLy,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}