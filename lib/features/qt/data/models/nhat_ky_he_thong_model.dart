// ============================================================================
// Data Layer - Model
// Based on UC_HKD_TT88_2021 - QT-06: Nhật ký hệ thống và Audit Trail
// ============================================================================

import 'dart:convert';
import 'package:hkd_accounting/features/qt/domain/entities/nhat_ky_he_thong.dart';

class NhatKyHeThongModel extends NhatKyHeThong {
  const NhatKyHeThongModel({
    required super.id,
    required super.userId,
    required super.userName,
    required super.userRole,
    required super.hanhDong,
    required super.doiTuongLoai,
    required super.doiTuongId,
    required super.doiTuongMoTa,
    required super.timestamp,
    super.giaTriCu,
    super.giaTriMoi,
    super.ipAddress,
    super.deviceInfo,
    super.ghiChu,
  });

  factory NhatKyHeThongModel.fromEntity(NhatKyHeThong entity) {
    return NhatKyHeThongModel(
      id: entity.id,
      userId: entity.userId,
      userName: entity.userName,
      userRole: entity.userRole,
      hanhDong: entity.hanhDong,
      doiTuongLoai: entity.doiTuongLoai,
      doiTuongId: entity.doiTuongId,
      doiTuongMoTa: entity.doiTuongMoTa,
      timestamp: entity.timestamp,
      giaTriCu: entity.giaTriCu,
      giaTriMoi: entity.giaTriMoi,
      ipAddress: entity.ipAddress,
      deviceInfo: entity.deviceInfo,
      ghiChu: entity.ghiChu,
    );
  }

  factory NhatKyHeThongModel.fromMap(Map<String, dynamic> map) {
    return NhatKyHeThongModel(
      id: map['id'] as String,
      userId: map['user_id'] as String? ?? '',
      userName: map['user_name'] as String? ?? '',
      userRole: map['user_role'] as String? ?? '',
      hanhDong: HanhDong.values.firstWhere(
        (e) => e.name == map['hanh_dong'],
        orElse: () => HanhDong.create,
      ),
      doiTuongLoai: map['doi_tuong_loai'] as String? ?? '',
      doiTuongId: map['doi_tuong_id'] as String? ?? '',
      doiTuongMoTa: map['doi_tuong_mo_ta'] as String? ?? '',
      timestamp: DateTime.tryParse(map['timestamp'] as String? ?? '') ?? DateTime.now(),
      giaTriCu: map['gia_tri_cu'] != null ? jsonDecode(map['gia_tri_cu'] as String) as Map<String, dynamic> : null,
      giaTriMoi: map['gia_tri_moi'] != null ? jsonDecode(map['gia_tri_moi'] as String) as Map<String, dynamic> : null,
      ipAddress: map['ip_address'] as String?,
      deviceInfo: map['device_info'] as String?,
      ghiChu: map['ghi_chu'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'user_name': userName,
      'user_role': userRole,
      'hanh_dong': hanhDong.name,
      'doi_tuong_loai': doiTuongLoai,
      'doi_tuong_id': doiTuongId,
      'doi_tuong_mo_ta': doiTuongMoTa,
      'timestamp': timestamp.toIso8601String(),
      'gia_tri_cu': giaTriCu != null ? jsonEncode(giaTriCu) : null,
      'gia_tri_moi': giaTriMoi != null ? jsonEncode(giaTriMoi) : null,
      'ip_address': ipAddress,
      'device_info': deviceInfo,
      'ghi_chu': ghiChu,
    };
  }

  NhatKyHeThong toEntity() => this;
}