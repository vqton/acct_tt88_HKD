// ============================================================================
// Domain Layer - Entity
// Based on UC_HKD_TT88_2021 - QT-06: Nhật ký hệ thống và Audit Trail
// ============================================================================

import 'package:equatable/equatable.dart';

enum HanhDong {
  create,
  update,
  delete,
  approve,
  reject,
  login,
  logout,
  openBook,
  closeBook,
  adjust,
}

class NhatKyHeThong extends Equatable {
  final String id;
  final String userId;
  final String userName;
  final String userRole;
  final HanhDong hanhDong;
  final String doiTuongLoai;
  final String doiTuongId;
  final String doiTuongMoTa;
  final DateTime timestamp;
  final Map<String, dynamic>? giaTriCu;
  final Map<String, dynamic>? giaTriMoi;
  final String? ipAddress;
  final String? deviceInfo;
  final String? ghiChu;

  const NhatKyHeThong({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userRole,
    required this.hanhDong,
    required this.doiTuongLoai,
    required this.doiTuongId,
    required this.doiTuongMoTa,
    required this.timestamp,
    this.giaTriCu,
    this.giaTriMoi,
    this.ipAddress,
    this.deviceInfo,
    this.ghiChu,
  });

  String get hanhDongLabel {
    switch (hanhDong) {
      case HanhDong.create:
        return 'Tạo mới';
      case HanhDong.update:
        return 'Cập nhật';
      case HanhDong.delete:
        return 'Xóa';
      case HanhDong.approve:
        return 'Phê duyệt';
      case HanhDong.reject:
        return 'Từ chối';
      case HanhDong.login:
        return 'Đăng nhập';
      case HanhDong.logout:
        return 'Đăng xuất';
      case HanhDong.openBook:
        return 'Mở sổ';
      case HanhDong.closeBook:
        return 'Đóng sổ';
      case HanhDong.adjust:
        return 'Điều chỉnh';
    }
  }

  NhatKyHeThong copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userRole,
    HanhDong? hanhDong,
    String? doiTuongLoai,
    String? doiTuongId,
    String? doiTuongMoTa,
    DateTime? timestamp,
    Map<String, dynamic>? giaTriCu,
    Map<String, dynamic>? giaTriMoi,
    String? ipAddress,
    String? deviceInfo,
    String? ghiChu,
  }) {
    return NhatKyHeThong(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userRole: userRole ?? this.userRole,
      hanhDong: hanhDong ?? this.hanhDong,
      doiTuongLoai: doiTuongLoai ?? this.doiTuongLoai,
      doiTuongId: doiTuongId ?? this.doiTuongId,
      doiTuongMoTa: doiTuongMoTa ?? this.doiTuongMoTa,
      timestamp: timestamp ?? this.timestamp,
      giaTriCu: giaTriCu ?? this.giaTriCu,
      giaTriMoi: giaTriMoi ?? this.giaTriMoi,
      ipAddress: ipAddress ?? this.ipAddress,
      deviceInfo: deviceInfo ?? this.deviceInfo,
      ghiChu: ghiChu ?? this.ghiChu,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        userName,
        userRole,
        hanhDong,
        doiTuongLoai,
        doiTuongId,
        doiTuongMoTa,
        timestamp,
        giaTriCu,
        giaTriMoi,
        ipAddress,
        deviceInfo,
        ghiChu,
      ];
}