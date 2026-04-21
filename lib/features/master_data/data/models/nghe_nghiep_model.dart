// ============================================================================
// Data Layer - Model
// Based on UC_HKD_TT88_2021 - MD-03
// ============================================================================

import 'package:hkd_accounting/features/master_data/domain/entities/nghe_nghiep.dart';

class NgheNghiepModel extends NgheNghiep {
  const NgheNghiepModel({
    required String id,
    required String maNhomNgheNghe,
    required String tenNhomNgheNghe,
    required double tyLeThueGTGT,
    required double tyLeThueTNCN,
    required DateTime ngayHieuLuc,
    DateTime? ngayHetHieuLuc,
  }) : super(
          id: id,
          maNhomNgheNghe: maNhomNgheNghe,
          tenNhomNgheNghe: tenNhomNgheNghe,
          tyLeThueGTGT: tyLeThueGTGT,
          tyLeThueTNCN: tyLeThueTNCN,
          ngayHieuLuc: ngayHieuLuc,
          ngayHetHieuLuc: ngayHetHieuLuc,
        );

  factory NgheNghiepModel.fromMap(Map<String, dynamic> map) {
    return NgheNghiepModel(
      id: map['id'] as String,
      maNhomNgheNghe: map['ma_nhom_nghe_nghe'] as String,
      tenNhomNgheNghe: map['ten_nhom_nghe_nghe'] as String,
      tyLeThueGTGT: (map['ty_le_thue_gtgt'] as num).toDouble(),
      tyLeThueTNCN: (map['ty_le_thue_tncn'] as num).toDouble(),
      ngayHieuLuc: DateTime.parse(map['ngay_hieu_luc'] as String),
      ngayHetHieuLuc: map['ngay_het_hieu_luc'] != null
          ? DateTime.parse(map['ngay_het_hieu_luc'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ma_nhom_nghe_nghe': maNhomNgheNghe,
      'ten_nhom_nghe_nghe': tenNhomNgheNghe,
      'ty_le_thue_gtgt': tyLeThueGTGT,
      'ty_le_thue_tncn': tyLeThueTNCN,
      'ngay_hieu_luc': ngayHieuLuc.toIso8601String(),
      'ngay_het_hieu_luc': ngayHetHieuLuc?.toIso8601String(),
    };
  }

  NgheNghiep toEntity() {
    return NgheNghiep(
      id: id,
      maNhomNgheNghe: maNhomNgheNghe,
      tenNhomNgheNghe: tenNhomNgheNghe,
      tyLeThueGTGT: tyLeThueGTGT,
      tyLeThueTNCN: tyLeThueTNCN,
      ngayHieuLuc: ngayHieuLuc,
      ngayHetHieuLuc: ngayHetHieuLuc,
    );
  }
}