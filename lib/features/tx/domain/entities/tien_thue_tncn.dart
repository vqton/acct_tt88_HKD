// ============================================================================
// Domain Layer - Entity
// Based on UC_HKD_TT88_2021 - TX-03: Tính thuế thu nhập cá nhân (TNCN)
// ============================================================================

import 'package:equatable/equatable.dart';

class TienThueTncn extends Equatable {
  final String id;
  final String kyKeToanId;
  final String? nguoiDungId;
  final String? tenNguoiNopThue;
  final String loaiDoiTuong;
  final int tongThuNhap;
  final int thueTncnPhaiNop;
  final int thueTncnDaNop;
  final String trangThai;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const TienThueTncn({
    required this.id,
    required this.kyKeToanId,
    this.nguoiDungId,
    this.tenNguoiNopThue,
    this.loaiDoiTuong = 'CHU_HKD',
    this.tongThuNhap = 0,
    this.thueTncnPhaiNop = 0,
    this.thueTncnDaNop = 0,
    this.trangThai = 'CHUA_KHAI',
    this.createdAt,
    this.updatedAt,
  });

  int get thueTncnConPhaiNop => thueTncnPhaiNop - thueTncnDaNop;

  TienThueTncn copyWith({
    String? id,
    String? kyKeToanId,
    String? nguoiDungId,
    String? tenNguoiNopThue,
    String? loaiDoiTuong,
    int? tongThuNhap,
    int? thueTncnPhaiNop,
    int? thueTncnDaNop,
    String? trangThai,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TienThueTncn(
      id: id ?? this.id,
      kyKeToanId: kyKeToanId ?? this.kyKeToanId,
      nguoiDungId: nguoiDungId ?? this.nguoiDungId,
      tenNguoiNopThue: tenNguoiNopThue ?? this.tenNguoiNopThue,
      loaiDoiTuong: loaiDoiTuong ?? this.loaiDoiTuong,
      tongThuNhap: tongThuNhap ?? this.tongThuNhap,
      thueTncnPhaiNop: thueTncnPhaiNop ?? this.thueTncnPhaiNop,
      thueTncnDaNop: thueTncnDaNop ?? this.thueTncnDaNop,
      trangThai: trangThai ?? this.trangThai,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id, kyKeToanId, nguoiDungId, tenNguoiNopThue,
        loaiDoiTuong, tongThuNhap, thueTncnPhaiNop,
        thueTncnDaNop, trangThai, createdAt, updatedAt,
      ];
}