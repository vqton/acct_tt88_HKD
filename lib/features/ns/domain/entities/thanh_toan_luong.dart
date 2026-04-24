// ============================================================================
// Domain Layer - Entity
// Based on UC_HKD_TT88_2021 - NS-03: Theo dõi và thanh toán lương
// ============================================================================

import 'package:equatable/equatable.dart';

class ThanhToanLuong extends Equatable {
  final String id;
  final String bangLuongId;
  final String thangNam;
  final double tongLuongPhaiTra;
  final double daTraBangChuyenKhoan;
  final double daTraTienMat;
  final double conPhaiTra;
  final DateTime? ngayThanhToan;
  final String trangThai;
  final String? ghiChu;
  final DateTime createdAt;

  const ThanhToanLuong({
    required this.id,
    required this.bangLuongId,
    required this.thangNam,
    required this.tongLuongPhaiTra,
    required this.daTraBangChuyenKhoan,
    required this.daTraTienMat,
    required this.conPhaiTra,
    this.ngayThanhToan,
    required this.trangThai,
    this.ghiChu,
    required this.createdAt,
  });

  bool get daHoanThanh => conPhaiTra <= 0;

  factory ThanhToanLuong.fromBangLuong({
    required String id,
    required String bangLuongId,
    required String thangNam,
    required double tongTraNhanVien,
  }) {
    return ThanhToanLuong(
      id: id,
      bangLuongId: bangLuongId,
      thangNam: thangNam,
      tongLuongPhaiTra: tongTraNhanVien,
      daTraBangChuyenKhoan: 0,
      daTraTienMat: 0,
      conPhaiTra: tongTraNhanVien,
      trangThai: 'CHUA_THANH_TOAN',
      createdAt: DateTime.now(),
    );
  }

  ThanhToanLuong copyWith({
    String? id,
    String? bangLuongId,
    String? thangNam,
    double? tongLuongPhaiTra,
    double? daTraBangChuyenKhoan,
    double? daTraTienMat,
    double? conPhaiTra,
    DateTime? ngayThanhToan,
    String? trangThai,
    String? ghiChu,
    DateTime? createdAt,
  }) {
    return ThanhToanLuong(
      id: id ?? this.id,
      bangLuongId: bangLuongId ?? this.bangLuongId,
      thangNam: thangNam ?? this.thangNam,
      tongLuongPhaiTra: tongLuongPhaiTra ?? this.tongLuongPhaiTra,
      daTraBangChuyenKhoan: daTraBangChuyenKhoan ?? this.daTraBangChuyenKhoan,
      daTraTienMat: daTraTienMat ?? this.daTraTienMat,
      conPhaiTra: conPhaiTra ?? this.conPhaiTra,
      ngayThanhToan: ngayThanhToan ?? this.ngayThanhToan,
      trangThai: trangThai ?? this.trangThai,
      ghiChu: ghiChu ?? this.ghiChu,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        bangLuongId,
        thangNam,
        tongLuongPhaiTra,
        daTraBangChuyenKhoan,
        daTraTienMat,
        conPhaiTra,
        ngayThanhToan,
        trangThai,
        ghiChu,
        createdAt,
      ];
}