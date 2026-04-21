// ============================================================================
// Data Layer - Models
// Based on UC_HKD_TT88_2021 - CT-06: Quản lý hóa đơn
// ============================================================================

import 'package:hkd_accounting/features/ct/domain/entities/hoa_don.dart';

class HoaDonModel extends HoaDon {
  const HoaDonModel({
    required super.id,
    required super.soHoaDon,
    required super.ngayLap,
    required super.loaiHoaDon,
    required super.kyKeToanId,
    super.nhaCungCapId,
    super.khachHangId,
    super.phieuNhapKhoId,
    super.phieuXuatKhoId,
    super.tienHang,
    super.tienThue,
    super.tongTien,
    super.trangThai,
    super.createdAt,
    super.updatedAt,
  });

  factory HoaDonModel.fromEntity(HoaDon entity) {
    return HoaDonModel(
      id: entity.id,
      soHoaDon: entity.soHoaDon,
      ngayLap: entity.ngayLap,
      loaiHoaDon: entity.loaiHoaDon,
      kyKeToanId: entity.kyKeToanId,
      nhaCungCapId: entity.nhaCungCapId,
      khachHangId: entity.khachHangId,
      phieuNhapKhoId: entity.phieuNhapKhoId,
      phieuXuatKhoId: entity.phieuXuatKhoId,
      tienHang: entity.tienHang,
      tienThue: entity.tienThue,
      tongTien: entity.tongTien,
      trangThai: entity.trangThai,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  factory HoaDonModel.fromMap(Map<String, dynamic> map) {
    return HoaDonModel(
      id: map['id']?.toString() ?? '',
      soHoaDon: map['so_hoa_don'] ?? '',
      ngayLap: DateTime.tryParse(map['ngay_lap'] ?? '') ?? DateTime.now(),
      loaiHoaDon: map['loai_hoa_don'] ?? 'DAU_RA',
      kyKeToanId: map['ky_ke_toan_id']?.toString() ?? '',
      nhaCungCapId: map['nha_cung_cap_id']?.toString(),
      khachHangId: map['khach_hang_id']?.toString(),
      phieuNhapKhoId: map['phieu_nhap_kho_id']?.toString(),
      phieuXuatKhoId: map['phieu_xuat_kho_id']?.toString(),
      tienHang: int.tryParse(map['tien_hang']?.toString() ?? '0') ?? 0,
      tienThue: int.tryParse(map['tien_thue']?.toString() ?? '0') ?? 0,
      tongTien: int.tryParse(map['tong_tien']?.toString() ?? '0') ?? 0,
      trangThai: map['trang_thai'] ?? 'MOI',
      createdAt: map['created_at'] != null ? DateTime.tryParse(map['created_at']) : null,
      updatedAt: map['updated_at'] != null ? DateTime.tryParse(map['updated_at']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'so_hoa_don': soHoaDon,
      'ngay_lap': ngayLap.toIso8601String(),
      'loai_hoa_don': loaiHoaDon,
      'ky_ke_toan_id': kyKeToanId,
      'nha_cung_cap_id': nhaCungCapId,
      'khach_hang_id': khachHangId,
      'phieu_nhap_kho_id': phieuNhapKhoId,
      'phieu_xuat_kho_id': phieuXuatKhoId,
      'tien_hang': tienHang,
      'tien_thue': tienThue,
      'tong_tien': tongTien,
      'trang_thai': trangThai,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  HoaDon toEntity() {
    return HoaDon(
      id: id,
      soHoaDon: soHoaDon,
      ngayLap: ngayLap,
      loaiHoaDon: loaiHoaDon,
      kyKeToanId: kyKeToanId,
      nhaCungCapId: nhaCungCapId,
      khachHangId: khachHangId,
      phieuNhapKhoId: phieuNhapKhoId,
      phieuXuatKhoId: phieuXuatKhoId,
      tienHang: tienHang,
      tienThue: tienThue,
      tongTien: tongTien,
      trangThai: trangThai,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}