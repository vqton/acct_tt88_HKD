import 'package:equatable/equatable.dart';

class TienThueGtgt extends Equatable {
  final String id;
  final String kyKeToanId;
  final String nhomNgheId;
  final String tenNhomNghe;
  final double tyLeThueGtgt;
  final int doanhThu;
  final int thueGtgtPhaiNop;
  final int thueGtgtDaNop;
  final String trangThai;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const TienThueGtgt({
    required this.id,
    required this.kyKeToanId,
    required this.nhomNgheId,
    required this.tenNhomNghe,
    required this.tyLeThueGtgt,
    required this.doanhThu,
    required this.thueGtgtPhaiNop,
    this.thueGtgtDaNop = 0,
    this.trangThai = 'CHUA_KHAI',
    this.createdAt,
    this.updatedAt,
  });

  int get thueGtgtConPhaiNop => thueGtgtPhaiNop - thueGtgtDaNop;

  TienThueGtgt copyWith({
    String? id,
    String? kyKeToanId,
    String? nhomNgheId,
    String? tenNhomNghe,
    double? tyLeThueGtgt,
    int? doanhThu,
    int? thueGtgtPhaiNop,
    int? thueGtgtDaNop,
    String? trangThai,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TienThueGtgt(
      id: id ?? this.id,
      kyKeToanId: kyKeToanId ?? this.kyKeToanId,
      nhomNgheId: nhomNgheId ?? this.nhomNgheId,
      tenNhomNghe: tenNhomNghe ?? this.tenNhomNghe,
      tyLeThueGtgt: tyLeThueGtgt ?? this.tyLeThueGtgt,
      doanhThu: doanhThu ?? this.doanhThu,
      thueGtgtPhaiNop: thueGtgtPhaiNop ?? this.thueGtgtPhaiNop,
      thueGtgtDaNop: thueGtgtDaNop ?? this.thueGtgtDaNop,
      trangThai: trangThai ?? this.trangThai,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id, kyKeToanId, nhomNgheId, tenNhomNghe,
        tyLeThueGtgt, doanhThu, thueGtgtPhaiNop,
        thueGtgtDaNop, trangThai, createdAt, updatedAt,
      ];
}