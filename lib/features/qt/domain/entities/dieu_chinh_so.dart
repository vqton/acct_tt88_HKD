// ============================================================================
// Domain Layer - Entity
// Based on UC_HKD_TT88_2021 - QT-02: Sửa chữa / điều chỉnh sổ kế toán
// ============================================================================

import 'package:equatable/equatable.dart';

enum PhuongPhapSuaChua {
  gapDon,
  ghiSoDu,
  ghiBu,
}

class DieuChinhSo extends Equatable {
  final String id;
  final String soKeToanLoai;
  final String soKeToanId;
  final DateTime ngayDieuChinh;
  final PhuongPhapSuaChua phuongPhap;
  final String noiDungSai;
  final String noiDungDung;
  final double giaTriTruoc;
  final double giaTriSau;
  final String lyDo;
  final String nguoiThucHien;
  final String? nguoiXacNhan;
  final DateTime? ngayXacNhan;
  final String trangThai;
  final DateTime createdAt;

  const DieuChinhSo({
    required this.id,
    required this.soKeToanLoai,
    required this.soKeToanId,
    required this.ngayDieuChinh,
    required this.phuongPhap,
    required this.noiDungSai,
    required this.noiDungDung,
    required this.giaTriTruoc,
    required this.giaTriSau,
    required this.lyDo,
    required this.nguoiThucHien,
    this.nguoiXacNhan,
    this.ngayXacNhan,
    required this.trangThai,
    required this.createdAt,
  });

  String get phuongPhapLabel {
    switch (phuongPhap) {
      case PhuongPhapSuaChua.gapDon:
        return 'Gạch đơn';
      case PhuongPhapSuaChua.ghiSoDu:
        return 'Ghi số dư';
      case PhuongPhapSuaChua.ghiBu:
        return 'Ghi bổ sung';
    }
  }

  factory DieuChinhSo.create({
    required String id,
    required String soKeToanLoai,
    required String soKeToanId,
    required PhuongPhapSuaChua phuongPhap,
    required String noiDungSai,
    required String noiDungDung,
    required double giaTriTruoc,
    required double giaTriSau,
    required String lyDo,
    required String nguoiThucHien,
  }) {
    return DieuChinhSo(
      id: id,
      soKeToanLoai: soKeToanLoai,
      soKeToanId: soKeToanId,
      ngayDieuChinh: DateTime.now(),
      phuongPhap: phuongPhap,
      noiDungSai: noiDungSai,
      noiDungDung: noiDungDung,
      giaTriTruoc: giaTriTruoc,
      giaTriSau: giaTriSau,
      lyDo: lyDo,
      nguoiThucHien: nguoiThucHien,
      trangThai: 'CHO_XAC_NHAN',
      createdAt: DateTime.now(),
    );
  }

  DieuChinhSo copyWith({
    String? id,
    String? soKeToanLoai,
    String? soKeToanId,
    DateTime? ngayDieuChinh,
    PhuongPhapSuaChua? phuongPhap,
    String? noiDungSai,
    String? noiDungDung,
    double? giaTriTruoc,
    double? giaTriSau,
    String? lyDo,
    String? nguoiThucHien,
    String? nguoiXacNhan,
    DateTime? ngayXacNhan,
    String? trangThai,
    DateTime? createdAt,
  }) {
    return DieuChinhSo(
      id: id ?? this.id,
      soKeToanLoai: soKeToanLoai ?? this.soKeToanLoai,
      soKeToanId: soKeToanId ?? this.soKeToanId,
      ngayDieuChinh: ngayDieuChinh ?? this.ngayDieuChinh,
      phuongPhap: phuongPhap ?? this.phuongPhap,
      noiDungSai: noiDungSai ?? this.noiDungSai,
      noiDungDung: noiDungDung ?? this.noiDungDung,
      giaTriTruoc: giaTriTruoc ?? this.giaTriTruoc,
      giaTriSau: giaTriSau ?? this.giaTriSau,
      lyDo: lyDo ?? this.lyDo,
      nguoiThucHien: nguoiThucHien ?? this.nguoiThucHien,
      nguoiXacNhan: nguoiXacNhan ?? this.nguoiXacNhan,
      ngayXacNhan: ngayXacNhan ?? this.ngayXacNhan,
      trangThai: trangThai ?? this.trangThai,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        soKeToanLoai,
        soKeToanId,
        ngayDieuChinh,
        phuongPhap,
        noiDungSai,
        noiDungDung,
        giaTriTruoc,
        giaTriSau,
        lyDo,
        nguoiThucHien,
        nguoiXacNhan,
        ngayXacNhan,
        trangThai,
        createdAt,
      ];
}