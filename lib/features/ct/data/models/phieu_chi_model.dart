// ============================================================================
// Data Layer - Model
// Maps between Entity and Database
// Based on UC_HKD_TT88_2021 - CT-02
// ============================================================================

import 'package:hkd_accounting/features/ct/domain/entities/phieu_chi.dart';

class PhieuChiModel extends PhieuChi {
  const PhieuChiModel({
    required String id,
    required String soPhieu,
    required DateTime ngayLap,
    required String nguoiNop,
    required String diaChiNguoiNop,
    required String lyDoNop,
    required int soTien,
    required String soTienBangChu,
    required String chungTuGocKemTheo,
    required String hkdInfoId,
    String? nhaCungCapId,
    required String kyKeToanId,
    required String trangThai,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
          id: id,
          soPhieu: soPhieu,
          ngayLap: ngayLap,
          nguoiNop: nguoiNop,
          diaChiNguoiNop: diaChiNguoiNop,
          lyDoNop: lyDoNop,
          soTien: soTien,
          soTienBangChu: soTienBangChu,
          chungTuGocKemTheo: chungTuGocKemTheo,
          hkdInfoId: hkdInfoId,
          nhaCungCapId: nhaCungCapId,
          kyKeToanId: kyKeToanId,
          trangThai: trangThai,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory PhieuChiModel.fromEntity(PhieuChi entity) {
    return PhieuChiModel(
      id: entity.id,
      soPhieu: entity.soPhieu,
      ngayLap: entity.ngayLap,
      nguoiNop: entity.nguoiNop,
      diaChiNguoiNop: entity.diaChiNguoiNop,
      lyDoNop: entity.lyDoNop,
      soTien: entity.soTien,
      soTienBangChu: entity.soTienBangChu,
      chungTuGocKemTheo: entity.chungTuGocKemTheo,
      hkdInfoId: entity.hkdInfoId,
      nhaCungCapId: entity.nhaCungCapId,
      kyKeToanId: entity.kyKeToanId,
      trangThai: entity.trangThai,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  PhieuChi toEntity() {
    return PhieuChi(
      id: id,
      soPhieu: soPhieu,
      ngayLap: ngayLap,
      nguoiNop: nguoiNop,
      diaChiNguoiNop: diaChiNguoiNop,
      lyDoNop: lyDoNop,
      soTien: soTien,
      soTienBangChu: soTienBangChu,
      chungTuGocKemTheo: chungTuGocKemTheo,
      hkdInfoId: hkdInfoId,
      nhaCungCapId: nhaCungCapId,
      kyKeToanId: kyKeToanId,
      trangThai: trangThai,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory PhieuChiModel.fromMap(Map<String, dynamic> map) {
    return PhieuChiModel(
      id: map['id'] as String,
      soPhieu: map['so_phieu'] as String,
      ngayLap: DateTime.parse(map['ngay_lap'] as String),
      nguoiNop: map['nguoi_nop'] as String,
      diaChiNguoiNop: map['dia_chi_nguoi_nop'] as String,
      lyDoNop: map['ly_do_nop'] as String,
      soTien: map['so_tien'] as int,
      soTienBangChu: map['so_tien_bang_chu'] as String,
      chungTuGocKemTheo: map['chung_tu_goc_kem_theo'] as String,
      hkdInfoId: map['hkd_info_id'] as String,
      nhaCungCapId: map['nha_cung_cap_id'] != null
          ? map['nha_cung_cap_id'] as String
          : null,
      kyKeToanId: map['ky_ke_toan_id'] as String,
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
      'ngay_lap': ngayLap.toIso8601String(),
      'nguoi_nop': nguoiNop,
      'dia_chi_nguoi_nop': diaChiNguoiNop,
      'ly_do_nop': lyDoNop,
      'so_tien': soTien,
      'so_tien_bang_chu': soTienBangChu,
      'chung_tu_goc_kem_theo': chungTuGocKemTheo,
      'hkd_info_id': hkdInfoId,
      'nha_cung_cap_id': nhaCungCapId,
      'ky_ke_toan_id': kyKeToanId,
      'trang_thai': trangThai,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}