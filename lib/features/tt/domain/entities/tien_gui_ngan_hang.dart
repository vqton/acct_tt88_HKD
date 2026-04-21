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
  }) : assert(soDuDauKy >= 0, 'So du dau ky phai lon hon hoac bang 0'),
        assert(tongThu >= 0, 'Tong thu phai lon hon hoac bang 0'),
        assert(tongChi >= 0, 'Tong chi phai lon hon hoac bang 0'),
        assert(soDuCuoiKy >= 0, 'So du cuoi ky phai lon hon hoac bang 0'),
        assert(id.isNotEmpty, 'Id khong duoc de trong'),
        assert(maTaiKhoan.isNotEmpty, 'Ma tai khoan khong duoc de trong'),
        assert(tenTaiKhoan.isNotEmpty, 'Ten tai khoan khong duoc de trong'),
        assert(kyKeToanId.isNotEmpty, 'Ky ke toan id khong duoc de trong'),
        assert(trangThai.isNotEmpty, 'Trang thai khong duoc de trong');

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