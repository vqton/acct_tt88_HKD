// ============================================================================
// Domain Layer - Entity
// Based on UC_HKD_TT88_2021 - QT-03: Đóng kỳ kế toán và khóa sổ
// ============================================================================

import 'package:equatable/equatable.dart';

class DongKyKeToan extends Equatable {
  final String id;
  final String kyKeToanId;
  final String thangNam;
  final DateTime ngayDong;
  final String nguoiDong;
  final String trangThai;
  final bool daDoiChieuQuyTienMat;
  final bool daDoiChieuTienGui;
  final bool daKiemKeTonKho;
  final bool daXacNhanThue;
  final String? ghiChu;
  final DateTime createdAt;

  const DongKyKeToan({
    required this.id,
    required this.kyKeToanId,
    required this.thangNam,
    required this.ngayDong,
    required this.nguoiDong,
    required this.trangThai,
    required this.daDoiChieuQuyTienMat,
    required this.daDoiChieuTienGui,
    required this.daKiemKeTonKho,
    required this.daXacNhanThue,
    this.ghiChu,
    required this.createdAt,
  });

  bool get daHoanThanhKiemTra =>
      daDoiChieuQuyTienMat && daDoiChieuTienGui && daKiemKeTonKho && daXacNhanThue;

  factory DongKyKeToan.createForKyKeToan({
    required String id,
    required String kyKeToanId,
    required String thangNam,
    required String nguoiDong,
  }) {
    return DongKyKeToan(
      id: id,
      kyKeToanId: kyKeToanId,
      thangNam: thangNam,
      ngayDong: DateTime.now(),
      nguoiDong: nguoiDong,
      trangThai: 'DANG_KIEM_TRA',
      daDoiChieuQuyTienMat: false,
      daDoiChieuTienGui: false,
      daKiemKeTonKho: false,
      daXacNhanThue: false,
      createdAt: DateTime.now(),
    );
  }

  DongKyKeToan copyWith({
    String? id,
    String? kyKeToanId,
    String? thangNam,
    DateTime? ngayDong,
    String? nguoiDong,
    String? trangThai,
    bool? daDoiChieuQuyTienMat,
    bool? daDoiChieuTienGui,
    bool? daKiemKeTonKho,
    bool? daXacNhanThue,
    String? ghiChu,
    DateTime? createdAt,
  }) {
    return DongKyKeToan(
      id: id ?? this.id,
      kyKeToanId: kyKeToanId ?? this.kyKeToanId,
      thangNam: thangNam ?? this.thangNam,
      ngayDong: ngayDong ?? this.ngayDong,
      nguoiDong: nguoiDong ?? this.nguoiDong,
      trangThai: trangThai ?? this.trangThai,
      daDoiChieuQuyTienMat: daDoiChieuQuyTienMat ?? this.daDoiChieuQuyTienMat,
      daDoiChieuTienGui: daDoiChieuTienGui ?? this.daDoiChieuTienGui,
      daKiemKeTonKho: daKiemKeTonKho ?? this.daKiemKeTonKho,
      daXacNhanThue: daXacNhanThue ?? this.daXacNhanThue,
      ghiChu: ghiChu ?? this.ghiChu,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        kyKeToanId,
        thangNam,
        ngayDong,
        nguoiDong,
        trangThai,
        daDoiChieuQuyTienMat,
        daDoiChieuTienGui,
        daKiemKeTonKho,
        daXacNhanThue,
        ghiChu,
        createdAt,
      ];
}