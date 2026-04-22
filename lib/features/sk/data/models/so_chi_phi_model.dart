// ============================================================================
// Data Layer - SK-04: Sổ chi phí (S3-HKD) - Model
// ============================================================================

import 'package:hkd_accounting/features/sk/domain/entities/so_chi_phi.dart';

class SoChiPhiModel extends SoChiPhi {
  const SoChiPhiModel({required super.id, required super.kyKeToanId, required super.ngayChungTu, super.soHieuChungTu, super.dienGiai, super.tongTien, super.cpNhanCong, super.cpDien, super.cpNuoc, super.cpVienThong, super.cpThueKhoBaiphaMatBang, super.cpQuanLy, super.cpKhac, super.createdAt, super.updatedAt});

  factory SoChiPhiModel.fromEntity(SoChiPhi e) => SoChiPhiModel(id: e.id, kyKeToanId: e.kyKeToanId, ngayChungTu: e.ngayChungTu, soHieuChungTu: e.soHieuChungTu, dienGiai: e.dienGiai, tongTien: e.tongTien, cpNhanCong: e.cpNhanCong, cpDien: e.cpDien, cpNuoc: e.cpNuoc, cpVienThong: e.cpVienThong, cpThueKhoBaiphaMatBang: e.cpThueKhoBaiphaMatBang, cpQuanLy: e.cpQuanLy, cpKhac: e.cpKhac, createdAt: e.createdAt, updatedAt: e.updatedAt);

  factory SoChiPhiModel.fromMap(Map<String, dynamic> m) => SoChiPhiModel(
    id: m['id']?.toString() ?? '', kyKeToanId: m['ky_ke_toan_id']?.toString() ?? '',
    ngayChungTu: DateTime.tryParse(m['ngay_chung_tu'] ?? '') ?? DateTime.now(),
    soHieuChungTu: m['so_hieu_chung_tu'], dienGiai: m['dien_giai'],
    tongTien: int.tryParse(m['tong_tien']?.toString() ?? '0') ?? 0,
    cpNhanCong: int.tryParse(m['cp_nhan_cong']?.toString() ?? '0') ?? 0,
    cpDien: int.tryParse(m['cp_dien']?.toString() ?? '0') ?? 0,
    cpNuoc: int.tryParse(m['cp_nuoc']?.toString() ?? '0') ?? 0,
    cpVienThong: int.tryParse(m['cp_vien_thong']?.toString() ?? '0') ?? 0,
    cpThueKhoBaiphaMatBang: int.tryParse(m['cp_thue_kho_baipha_mat_bang']?.toString() ?? '0') ?? 0,
    cpQuanLy: int.tryParse(m['cp_quan_ly']?.toString() ?? '0') ?? 0,
    cpKhac: int.tryParse(m['cp_khac']?.toString() ?? '0') ?? 0,
    createdAt: m['created_at'] != null ? DateTime.tryParse(m['created_at']) : null,
    updatedAt: m['updated_at'] != null ? DateTime.tryParse(m['updated_at']) : null,
  );

  Map<String, dynamic> toMap() => {'id': id, 'ky_ke_toan_id': kyKeToanId, 'ngay_chung_tu': ngayChungTu.toIso8601String(), 'so_hieu_chung_tu': soHieuChungTu, 'dien_giai': dienGiai, 'tong_tien': tongTien, 'cp_nhan_cong': cpNhanCong, 'cp_dien': cpDien, 'cp_nuoc': cpNuoc, 'cp_vien_thong': cpVienThong, 'cp_thue_kho_baipha_mat_bang': cpThueKhoBaiphaMatBang, 'cp_quan_ly': cpQuanLy, 'cp_khac': cpKhac, 'created_at': createdAt?.toIso8601String(), 'updated_at': updatedAt?.toIso8601String()};

  SoChiPhi toEntity() => SoChiPhi(id: id, kyKeToanId: kyKeToanId, ngayChungTu: ngayChungTu, soHieuChungTu: soHieuChungTu, dienGiai: dienGiai, tongTien: tongTien, cpNhanCong: cpNhanCong, cpDien: cpDien, cpNuoc: cpNuoc, cpVienThong: cpVienThong, cpThueKhoBaiphaMatBang: cpThueKhoBaiphaMatBang, cpQuanLy: cpQuanLy, cpKhac: cpKhac, createdAt: createdAt, updatedAt: updatedAt);
}