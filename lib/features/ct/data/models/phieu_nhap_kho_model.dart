// ============================================================================
// Data Layer - Models
// Based on UC_HKD_TT88_2021 - CT-03: Lập phiếu nhập kho
// ============================================================================

import 'package:hkd_accounting/features/ct/domain/entities/phieu_nhap_kho.dart';

class PhieuNhapKhoModel extends PhieuNhapKho {
  const PhieuNhapKhoModel({
    required super.id,
    required super.soPhieu,
    required super.ngayLap,
    required super.kyKeToanId,
    super.nhaCungCapId,
    super.soHoaDon,
    super.diaDiemNhap,
    super.lyDoNhap,
    super.nguoiGiaoHang,
    super.nguoiLapId,
    super.nguoiDuyetId,
    super.trangThai,
    super.ngayDuyet,
    super.createdAt,
    super.updatedAt,
    super.chiTietList,
  });

  factory PhieuNhapKhoModel.fromEntity(PhieuNhapKho entity) {
    return PhieuNhapKhoModel(
      id: entity.id,
      soPhieu: entity.soPhieu,
      ngayLap: entity.ngayLap,
      kyKeToanId: entity.kyKeToanId,
      nhaCungCapId: entity.nhaCungCapId,
      soHoaDon: entity.soHoaDon,
      diaDiemNhap: entity.diaDiemNhap,
      lyDoNhap: entity.lyDoNhap,
      nguoiGiaoHang: entity.nguoiGiaoHang,
      nguoiLapId: entity.nguoiLapId,
      nguoiDuyetId: entity.nguoiDuyetId,
      trangThai: entity.trangThai,
      ngayDuyet: entity.ngayDuyet,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      chiTietList: entity.chiTietList,
    );
  }

  factory PhieuNhapKhoModel.fromMap(Map<String, dynamic> map,
      {List<PhieuNhapKhoChiTietModel>? chiTietList}) {
    return PhieuNhapKhoModel(
      id: map['id']?.toString() ?? '',
      soPhieu: map['so_phieu'] ?? '',
      ngayLap: DateTime.tryParse(map['ngay_lap'] ?? '') ?? DateTime.now(),
      kyKeToanId: map['ky_ke_toan_id']?.toString() ?? '',
      nhaCungCapId: map['nha_cung_cap_id']?.toString(),
      soHoaDon: map['so_hoa_don'],
      diaDiemNhap: map['dia_diem_nhap'],
      lyDoNhap: map['ly_do_nhap'],
      nguoiGiaoHang: map['nguoi_giao_hang'],
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
      'nha_cung_cap_id': nhaCungCapId,
      'so_hoa_don': soHoaDon,
      'dia_diem_nhap': diaDiemNhap,
      'ly_do_nhap': lyDoNhap,
      'nguoi_giao_hang': nguoiGiaoHang,
      'nguoi_lap_id': nguoiLapId,
      'nguoi_duyet_id': nguoiDuyetId,
      'trang_thai': trangThai,
      'ngay_duyet': ngayDuyet?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  PhieuNhapKho toEntity() {
    return PhieuNhapKho(
      id: id,
      soPhieu: soPhieu,
      ngayLap: ngayLap,
      kyKeToanId: kyKeToanId,
      nhaCungCapId: nhaCungCapId,
      soHoaDon: soHoaDon,
      diaDiemNhap: diaDiemNhap,
      lyDoNhap: lyDoNhap,
      nguoiGiaoHang: nguoiGiaoHang,
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

class PhieuNhapKhoChiTietModel extends PhieuNhapKhoChiTiet {
  const PhieuNhapKhoChiTietModel({
    required super.id,
    required super.phieuNhapKhoId,
    required super.hangHoaId,
    required super.soLuongTheoChungTu,
    required super.soLuongThucNhan,
    required super.donGia,
    required super.thanhTien,
  });

  factory PhieuNhapKhoChiTietModel.fromEntity(PhieuNhapKhoChiTiet entity) {
    return PhieuNhapKhoChiTietModel(
      id: entity.id,
      phieuNhapKhoId: entity.phieuNhapKhoId,
      hangHoaId: entity.hangHoaId,
      soLuongTheoChungTu: entity.soLuongTheoChungTu,
      soLuongThucNhan: entity.soLuongThucNhan,
      donGia: entity.donGia,
      thanhTien: entity.thanhTien,
    );
  }

  factory PhieuNhapKhoChiTietModel.fromMap(Map<String, dynamic> map) {
    return PhieuNhapKhoChiTietModel(
      id: map['id']?.toString() ?? '',
      phieuNhapKhoId: map['phieu_nhap_kho_id']?.toString() ?? '',
      hangHoaId: map['hang_hoa_id']?.toString() ?? '',
      soLuongTheoChungTu:
          double.tryParse(map['so_luong_theo_chung_tu']?.toString() ?? '0') ?? 0,
      soLuongThucNhan:
          double.tryParse(map['so_luong_thuc_nhan']?.toString() ?? '0') ?? 0,
      donGia: double.tryParse(map['don_gia']?.toString() ?? '0') ?? 0,
      thanhTien: int.tryParse(map['thanh_tien']?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phieu_nhap_kho_id': phieuNhapKhoId,
      'hang_hoa_id': hangHoaId,
      'so_luong_theo_chung_tu': soLuongTheoChungTu,
      'so_luong_thuc_nhan': soLuongThucNhan,
      'don_gia': donGia,
      'thanh_tien': thanhTien,
    };
  }

  PhieuNhapKhoChiTiet toEntity() {
    return PhieuNhapKhoChiTiet(
      id: id,
      phieuNhapKhoId: phieuNhapKhoId,
      hangHoaId: hangHoaId,
      soLuongTheoChungTu: soLuongTheoChungTu,
      soLuongThucNhan: soLuongThucNhan,
      donGia: donGia,
      thanhTien: thanhTien,
    );
  }
}
