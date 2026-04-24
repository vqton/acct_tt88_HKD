// ============================================================================
// Data Layer - Model
// Based on UC_HKD_TT88_2021 - SK-06: Ghi sổ theo dõi thanh toán tiền lương (S5-HKD)
// ============================================================================

import 'package:hkd_accounting/features/sk/domain/entities/so_theo_doi_tien_luong.dart';

class SoTheoDoiTienLuongModel extends SoTheoDoiTienLuong {
  const SoTheoDoiTienLuongModel({
    required super.id,
    required super.kyKeToanId,
    required super.bangLuongId,
    required super.thangNam,
    required super.ngayLap,
    required super.phaiTraLuong,
    required super.daTraLuong,
    required super.conPhaiTraLuong,
    required super.bhxhPhaiNop,
    required super.bhxhDaNop,
    required super.bhxhConPhaiNop,
    required super.bhytPhaiNop,
    required super.bhytDaNop,
    required super.bhytConPhaiNop,
    required super.bhtnPhaiNop,
    required super.bhtnDaNop,
    required super.bhtnConPhaiNop,
    required super.trangThai,
    super.ghiChu,
    super.createdAt,
    super.updatedAt,
  });

  factory SoTheoDoiTienLuongModel.fromEntity(SoTheoDoiTienLuong entity) {
    return SoTheoDoiTienLuongModel(
      id: entity.id,
      kyKeToanId: entity.kyKeToanId,
      bangLuongId: entity.bangLuongId,
      thangNam: entity.thangNam,
      ngayLap: entity.ngayLap,
      phaiTraLuong: entity.phaiTraLuong,
      daTraLuong: entity.daTraLuong,
      conPhaiTraLuong: entity.conPhaiTraLuong,
      bhxhPhaiNop: entity.bhxhPhaiNop,
      bhxhDaNop: entity.bhxhDaNop,
      bhxhConPhaiNop: entity.bhxhConPhaiNop,
      bhytPhaiNop: entity.bhytPhaiNop,
      bhytDaNop: entity.bhytDaNop,
      bhytConPhaiNop: entity.bhytConPhaiNop,
      bhtnPhaiNop: entity.bhtnPhaiNop,
      bhtnDaNop: entity.bhtnDaNop,
      bhtnConPhaiNop: entity.bhtnConPhaiNop,
      trangThai: entity.trangThai,
      ghiChu: entity.ghiChu,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  factory SoTheoDoiTienLuongModel.fromMap(Map<String, dynamic> map) {
    return SoTheoDoiTienLuongModel(
      id: map['id'] as String,
      kyKeToanId: map['ky_ke_toan_id'] as String? ?? '',
      bangLuongId: map['bang_luong_id'] as String? ?? '',
      thangNam: map['thang_nam'] as String? ?? '',
      ngayLap: DateTime.tryParse(map['ngay_lap'] as String? ?? '') ?? DateTime.now(),
      phaiTraLuong: (map['phai_tra_luong'] as num?)?.toDouble() ?? 0,
      daTraLuong: (map['da_tra_luong'] as num?)?.toDouble() ?? 0,
      conPhaiTraLuong: (map['con_phai_tra_luong'] as num?)?.toDouble() ?? 0,
      bhxhPhaiNop: (map['bhxh_phai_nop'] as num?)?.toDouble() ?? 0,
      bhxhDaNop: (map['bhxh_da_nop'] as num?)?.toDouble() ?? 0,
      bhxhConPhaiNop: (map['bhxh_con_phai_nop'] as num?)?.toDouble() ?? 0,
      bhytPhaiNop: (map['bhyt_phai_nop'] as num?)?.toDouble() ?? 0,
      bhytDaNop: (map['bhyt_da_nop'] as num?)?.toDouble() ?? 0,
      bhytConPhaiNop: (map['bhyt_con_phai_nop'] as num?)?.toDouble() ?? 0,
      bhtnPhaiNop: (map['bhtn_phai_nop'] as num?)?.toDouble() ?? 0,
      bhtnDaNop: (map['bhtn_da_nop'] as num?)?.toDouble() ?? 0,
      bhtnConPhaiNop: (map['bhtn_con_phai_nop'] as num?)?.toDouble() ?? 0,
      trangThai: map['trang_thai'] as String? ?? 'CHUA_CHuyen_KHOAN',
      ghiChu: map['ghi_chu'] as String?,
      createdAt: map['created_at'] != null ? DateTime.tryParse(map['created_at'] as String) : null,
      updatedAt: map['updated_at'] != null ? DateTime.tryParse(map['updated_at'] as String) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ky_ke_toan_id': kyKeToanId,
      'bang_luong_id': bangLuongId,
      'thang_nam': thangNam,
      'ngay_lap': ngayLap.toIso8601String(),
      'phai_tra_luong': phaiTraLuong,
      'da_tra_luong': daTraLuong,
      'con_phai_tra_luong': conPhaiTraLuong,
      'bhxh_phai_nop': bhxhPhaiNop,
      'bhxh_da_nop': bhxhDaNop,
      'bhxh_con_phai_nop': bhxhConPhaiNop,
      'bhyt_phai_nop': bhytPhaiNop,
      'bhyt_da_nop': bhytDaNop,
      'bhyt_con_phai_nop': bhytConPhaiNop,
      'bhtn_phai_nop': bhtnPhaiNop,
      'bhtn_da_nop': bhtnDaNop,
      'bhtn_con_phai_nop': bhtnConPhaiNop,
      'trang_thai': trangThai,
      'ghi_chu': ghiChu,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  SoTheoDoiTienLuong toEntity() => this;
}