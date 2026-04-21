// ============================================================================
// Data Layer - Models
// Based on UC_HKD_TT88_2021 - KH-04: Tính giá xuất kho
// ============================================================================

import 'package:hkd_accounting/features/kh/domain/entities/ton_kho.dart';

class TonKhoModel extends TonKho {
  const TonKhoModel({
    required super.id,
    required super.kyKeToanId,
    required super.hangHoaId,
    super.tonDauSoLuong,
    super.tonDauThanhTien,
    super.nhapSoLuong,
    super.nhapThanhTien,
    super.xuatSoLuong,
    super.xuatThanhTien,
    super.tonCuoiSoLuong,
    super.tonCuoiThanhTien,
    super.donGiaXuatKho,
    super.createdAt,
    super.updatedAt,
  });

  factory TonKhoModel.fromEntity(TonKho entity) {
    return TonKhoModel(
      id: entity.id,
      kyKeToanId: entity.kyKeToanId,
      hangHoaId: entity.hangHoaId,
      tonDauSoLuong: entity.tonDauSoLuong,
      tonDauThanhTien: entity.tonDauThanhTien,
      nhapSoLuong: entity.nhapSoLuong,
      nhapThanhTien: entity.nhapThanhTien,
      xuatSoLuong: entity.xuatSoLuong,
      xuatThanhTien: entity.xuatThanhTien,
      tonCuoiSoLuong: entity.tonCuoiSoLuong,
      tonCuoiThanhTien: entity.tonCuoiThanhTien,
      donGiaXuatKho: entity.donGiaXuatKho,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  factory TonKhoModel.fromMap(Map<String, dynamic> map) {
    return TonKhoModel(
      id: map['id']?.toString() ?? '',
      kyKeToanId: map['ky_ke_toan_id']?.toString() ?? '',
      hangHoaId: map['hang_hoa_id']?.toString() ?? '',
      tonDauSoLuong:
          double.tryParse(map['ton_dau_so_luong']?.toString() ?? '0') ?? 0,
      tonDauThanhTien:
          int.tryParse(map['ton_dau_thanh_tien']?.toString() ?? '0') ?? 0,
      nhapSoLuong: double.tryParse(map['nhap_so_luong']?.toString() ?? '0') ?? 0,
      nhapThanhTien:
          int.tryParse(map['nhap_thanh_tien']?.toString() ?? '0') ?? 0,
      xuatSoLuong:
          double.tryParse(map['xuat_so_luong']?.toString() ?? '0') ?? 0,
      xuatThanhTien:
          int.tryParse(map['xuat_thanh_tien']?.toString() ?? '0') ?? 0,
      tonCuoiSoLuong:
          double.tryParse(map['ton_cuoi_so_luong']?.toString() ?? '0') ?? 0,
      tonCuoiThanhTien:
          int.tryParse(map['ton_cuoi_thanh_tien']?.toString() ?? '0') ?? 0,
      donGiaXuatKho:
          double.tryParse(map['don_gia_xuat_kho']?.toString() ?? '0') ?? 0,
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'])
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.tryParse(map['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ky_ke_toan_id': kyKeToanId,
      'hang_hoa_id': hangHoaId,
      'ton_dau_so_luong': tonDauSoLuong,
      'ton_dau_thanh_tien': tonDauThanhTien,
      'nhap_so_luong': nhapSoLuong,
      'nhap_thanh_tien': nhapThanhTien,
      'xuat_so_luong': xuatSoLuong,
      'xuat_thanh_tien': xuatThanhTien,
      'ton_cuoi_so_luong': tonCuoiSoLuong,
      'ton_cuoi_thanh_tien': tonCuoiThanhTien,
      'don_gia_xuat_kho': donGiaXuatKho,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  TonKho toEntity() {
    return TonKho(
      id: id,
      kyKeToanId: kyKeToanId,
      hangHoaId: hangHoaId,
      tonDauSoLuong: tonDauSoLuong,
      tonDauThanhTien: tonDauThanhTien,
      nhapSoLuong: nhapSoLuong,
      nhapThanhTien: nhapThanhTien,
      xuatSoLuong: xuatSoLuong,
      xuatThanhTien: xuatThanhTien,
      tonCuoiSoLuong: tonCuoiSoLuong,
      tonCuoiThanhTien: tonCuoiThanhTien,
      donGiaXuatKho: donGiaXuatKho,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

class PhieuNhapKhoLotModel extends PhieuNhapKhoLot {
  const PhieuNhapKhoLotModel({
    required super.id,
    required super.phieuNhapKhoId,
    required super.hangHoaId,
    required super.soLuong,
    required super.donGia,
    required super.thanhTien,
    required super.ngayNhap,
    super.soLuongConLai,
  });

  factory PhieuNhapKhoLotModel.fromMap(Map<String, dynamic> map) {
    return PhieuNhapKhoLotModel(
      id: map['id']?.toString() ?? '',
      phieuNhapKhoId: map['phieu_nhap_kho_id']?.toString() ?? '',
      hangHoaId: map['hang_hoa_id']?.toString() ?? '',
      soLuong: double.tryParse(map['so_luong_thuc_nhan']?.toString() ?? '0') ?? 0,
      donGia: double.tryParse(map['don_gia']?.toString() ?? '0') ?? 0,
      thanhTien: int.tryParse(map['thanh_tien']?.toString() ?? '0') ?? 0,
      ngayNhap: DateTime.tryParse(map['ngay_lap'] ?? '') ?? DateTime.now(),
      soLuongConLai:
          double.tryParse(map['so_luong_thuc_nhan']?.toString() ?? '0') ?? 0,
    );
  }
}