// ============================================================================
// Data Layer - Models
// Based on UC_HKD_TT88_2021 - CT-04: Lập phiếu xuất kho
// ============================================================================

import 'package:hkd_accounting/features/ct/domain/entities/phieu_xuat_kho.dart';

class PhieuXuatKhoModel extends PhieuXuatKho {
  const PhieuXuatKhoModel({
    required super.id,
    required super.soPhieu,
    required super.ngayLap,
    required super.kyKeToanId,
    super.hoTenNguoiNhan,
    super.boPhan,
    super.lyDoXuat,
    super.diaDiemXuat,
    super.nguoiLapId,
    super.nguoiDuyetId,
    super.trangThai,
    super.ngayDuyet,
    super.createdAt,
    super.updatedAt,
    super.chiTietList,
  });

  factory PhieuXuatKhoModel.fromEntity(PhieuXuatKho entity) {
    return PhieuXuatKhoModel(
      id: entity.id,
      soPhieu: entity.soPhieu,
      ngayLap: entity.ngayLap,
      kyKeToanId: entity.kyKeToanId,
      hoTenNguoiNhan: entity.hoTenNguoiNhan,
      boPhan: entity.boPhan,
      lyDoXuat: entity.lyDoXuat,
      diaDiemXuat: entity.diaDiemXuat,
      nguoiLapId: entity.nguoiLapId,
      nguoiDuyetId: entity.nguoiDuyetId,
      trangThai: entity.trangThai,
      ngayDuyet: entity.ngayDuyet,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      chiTietList: entity.chiTietList,
    );
  }

  factory PhieuXuatKhoModel.fromMap(Map<String, dynamic> map,
      {List<PhieuXuatKhoChiTietModel>? chiTietList}) {
    return PhieuXuatKhoModel(
      id: map['id']?.toString() ?? '',
      soPhieu: map['so_phieu'] ?? '',
      ngayLap: DateTime.tryParse(map['ngay_lap'] ?? '') ?? DateTime.now(),
      kyKeToanId: map['ky_ke_toan_id']?.toString() ?? '',
      hoTenNguoiNhan: map['ho_ten_nguoi_nhan'],
      boPhan: map['bo_phan'],
      lyDoXuat: map['ly_do_xuat'],
      diaDiemXuat: map['dia_diem_xuat'],
      nguoiLapId: map['nguoi_lap_id']?.toString(),
      nguoiDuyetId: map['nguoi_duyet_id']?.toString(),
      trangThai: map['trang_thai'] ?? 'CHO_DUYET',
      ngayDuyet:
          map['ngay_duyet'] != null ? DateTime.tryParse(map['ngay_duyet']) : null,
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'])
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.tryParse(map['updated_at'])
          : null,
      chiTietList: chiTietList ?? const [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'so_phieu': soPhieu,
      'ngay_lap': ngayLap.toIso8601String(),
      'ky_ke_toan_id': kyKeToanId,
      'ho_ten_nguoi_nhan': hoTenNguoiNhan,
      'bo_phan': boPhan,
      'ly_do_xuat': lyDoXuat,
      'dia_diem_xuat': diaDiemXuat,
      'nguoi_lap_id': nguoiLapId,
      'nguoi_duyet_id': nguoiDuyetId,
      'trang_thai': trangThai,
      'ngay_duyet': ngayDuyet?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  PhieuXuatKho toEntity() {
    return PhieuXuatKho(
      id: id,
      soPhieu: soPhieu,
      ngayLap: ngayLap,
      kyKeToanId: kyKeToanId,
      hoTenNguoiNhan: hoTenNguoiNhan,
      boPhan: boPhan,
      lyDoXuat: lyDoXuat,
      diaDiemXuat: diaDiemXuat,
      nguoiLapId: nguoiLapId,
      nguoiDuyetId: nguoiDuyetId,
      trangThai: trangThai,
      ngayDuyet: ngayDuyet,
      createdAt: createdAt,
      updatedAt: updatedAt,
      chiTietList: chiTietList,
    );
  }
}

class PhieuXuatKhoChiTietModel extends PhieuXuatKhoChiTiet {
  const PhieuXuatKhoChiTietModel({
    required super.id,
    required super.phieuXuatKhoId,
    required super.hangHoaId,
    required super.soLuongYeuCau,
    required super.soLuongThucXuat,
    required super.donGia,
    required super.thanhTien,
  });

  factory PhieuXuatKhoChiTietModel.fromEntity(PhieuXuatKhoChiTiet entity) {
    return PhieuXuatKhoChiTietModel(
      id: entity.id,
      phieuXuatKhoId: entity.phieuXuatKhoId,
      hangHoaId: entity.hangHoaId,
      soLuongYeuCau: entity.soLuongYeuCau,
      soLuongThucXuat: entity.soLuongThucXuat,
      donGia: entity.donGia,
      thanhTien: entity.thanhTien,
    );
  }

  factory PhieuXuatKhoChiTietModel.fromMap(Map<String, dynamic> map) {
    return PhieuXuatKhoChiTietModel(
      id: map['id']?.toString() ?? '',
      phieuXuatKhoId: map['phieu_xuat_kho_id']?.toString() ?? '',
      hangHoaId: map['hang_hoa_id']?.toString() ?? '',
      soLuongYeuCau:
          double.tryParse(map['so_luong_yeu_cau']?.toString() ?? '0') ?? 0,
      soLuongThucXuat:
          double.tryParse(map['so_luong_thuc_xuat']?.toString() ?? '0') ?? 0,
      donGia: double.tryParse(map['don_gia']?.toString() ?? '0') ?? 0,
      thanhTien: int.tryParse(map['thanh_tien']?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phieu_xuat_kho_id': phieuXuatKhoId,
      'hang_hoa_id': hangHoaId,
      'so_luong_yeu_cau': soLuongYeuCau,
      'so_luong_thuc_xuat': soLuongThucXuat,
      'don_gia': donGia,
      'thanh_tien': thanhTien,
    };
  }

  PhieuXuatKhoChiTiet toEntity() {
    return PhieuXuatKhoChiTiet(
      id: id,
      phieuXuatKhoId: phieuXuatKhoId,
      hangHoaId: hangHoaId,
      soLuongYeuCau: soLuongYeuCau,
      soLuongThucXuat: soLuongThucXuat,
      donGia: donGia,
      thanhTien: thanhTien,
    );
  }
}
