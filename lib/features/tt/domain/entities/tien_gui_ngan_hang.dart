// ============================================================================
// Domain Layer - Entities
// Based on UC_HKD_TT88_2021 - TT-02: Quản lý tiền gửi ngân hàng
// ============================================================================

import 'package:equatable/equatable.dart';

class TienGuiNganHang extends Equatable {
  final String id;
  final String maTaiKhoan; // Bank account code
  final String tenTaiKhoan; // Bank account name
  final double soDuDauKy; // Opening balance
  final double tongThu; // Total deposits
  final double tongChi; // Total withdrawals
  final double soDuCuoiKy; // Closing balance
  final String kyKeToanId; // Reference to accounting period
  final String trangThai; // e.g., HOAT_DONG, DONG
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const TienGuiNganHang({
    required this.id,
    required this.maTaiKhoan,
    required this.tenTaiKhoan,
    required this.soDuDauKy,
    required this.tongThu,
    required this.tongChi,
    required this.soDuCuoiKy,
    required this.kyKeToanId,
    required this.trangThai,
    this.createdAt,
    this.updatedAt,
  });

  static bool isValidTienGuiNganHang(TienGuiNganHang q) {
    return q.id.isNotEmpty &&
        q.maTaiKhoan.isNotEmpty &&
        q.tenTaiKhoan.isNotEmpty &&
        q.kyKeToanId.isNotEmpty &&
        q.trangThai.isNotEmpty &&
        q.soDuDauKy >= 0 &&
        q.tongThu >= 0 &&
        q.tongChi >= 0 &&
        q.soDuCuoiKy >= 0;
  }

  TienGuiNganHang copyWith({
    String? id,
    String? maTaiKhoan,
    String? tenTaiKhoan,
    double? soDuDauKy,
    double? tongThu,
    double? tongChi,
    double? soDuCuoiKy,
    String? kyKeToanId,
    String? trangThai,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TienGuiNganHang(
      id: id ?? this.id,
      maTaiKhoan: maTaiKhoan ?? this.maTaiKhoan,
      tenTaiKhoan: tenTaiKhoan ?? this.tenTaiKhoan,
      soDuDauKy: soDuDauKy ?? this.soDuDauKy,
      tongThu: tongThu ?? this.tongThu,
      tongChi: tongChi ?? this.tongChi,
      soDuCuoiKy: soDuCuoiKy ?? this.soDuCuoiKy,
      kyKeToanId: kyKeToanId ?? this.kyKeToanId,
      trangThai: trangThai ?? this.trangThai,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    maTaiKhoan,
    tenTaiKhoan,
    soDuDauKy,
    tongThu,
    tongChi,
    soDuCuoiKy,
    kyKeToanId,
    trangThai,
    createdAt,
    updatedAt,
  ];
}