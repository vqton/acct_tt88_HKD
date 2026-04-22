// ============================================================================
// Data Layer - SK-02: Sổ doanh thu (S1-HKD) - Model
// ============================================================================

import 'package:hkd_accounting/features/sk/domain/entities/so_doanh_thu.dart';

class SoDoanhThuModel extends SoDoanhThu {
  const SoDoanhThuModel({
    required super.id,
    required super.kyKeToanId,
    required super.nhomNgheId,
    required super.ngayChungTu,
    super.soHieuChungTu,
    super.dienGiai,
    super.doanhThu,
    super.createdAt,
    super.updatedAt,
  });

  factory SoDoanhThuModel.fromEntity(SoDoanhThu entity) {
    return SoDoanhThuModel(
      id: entity.id,
      kyKeToanId: entity.kyKeToanId,
      nhomNgheId: entity.nhomNgheId,
      ngayChungTu: entity.ngayChungTu,
      soHieuChungTu: entity.soHieuChungTu,
      dienGiai: entity.dienGiai,
      doanhThu: entity.doanhThu,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  factory SoDoanhThuModel.fromMap(Map<String, dynamic> map) {
    return SoDoanhThuModel(
      id: map['id']?.toString() ?? '',
      kyKeToanId: map['ky_ke_toan_id']?.toString() ?? '',
      nhomNgheId: map['nhom_nghe_id']?.toString() ?? '',
      ngayChungTu: DateTime.tryParse(map['ngay_chung_tu'] ?? '') ?? DateTime.now(),
      soHieuChungTu: map['so_hieu_chung_tu'],
      dienGiai: map['dien_giai'],
      doanhThu: int.tryParse(map['doanh_thu']?.toString() ?? '0') ?? 0,
      createdAt: map['created_at'] != null ? DateTime.tryParse(map['created_at']) : null,
      updatedAt: map['updated_at'] != null ? DateTime.tryParse(map['updated_at']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ky_ke_toan_id': kyKeToanId,
      'nhom_nghe_id': nhomNgheId,
      'ngay_chung_tu': ngayChungTu.toIso8601String(),
      'so_hieu_chung_tu': soHieuChungTu,
      'dien_giai': dienGiai,
      'doanh_thu': doanhThu,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  SoDoanhThu toEntity() => SoDoanhThu(
    id: id,
    kyKeToanId: kyKeToanId,
    nhomNgheId: nhomNgheId,
    ngayChungTu: ngayChungTu,
    soHieuChungTu: soHieuChungTu,
    dienGiai: dienGiai,
    doanhThu: doanhThu,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}