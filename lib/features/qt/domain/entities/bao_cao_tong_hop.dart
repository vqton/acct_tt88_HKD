// ============================================================================
// Domain Layer - Entity
// Based on UC_HKD_TT88_2021 - QT-04: Báo cáo tổng hợp cuối kỳ
// ============================================================================

import 'package:equatable/equatable.dart';

class BaoCaoTongHop extends Equatable {
  final String id;
  final String kyKeToanId;
  final String thangNam;
  final DateTime ngayTao;
  final double tongDoanhThu;
  final double tongChiPhi;
  final double loiNhuan;
  final double tongQuyTienMat;
  final double tongTienGui;
  final double tongTonKho;
  final double tongBhxhPhaiNop;
  final double tongThuePhaiNop;
  final Map<String, double> doanhThuTheoNghe;
  final Map<String, double> chiPhiTheoLoai;

  const BaoCaoTongHop({
    required this.id,
    required this.kyKeToanId,
    required this.thangNam,
    required this.ngayTao,
    required this.tongDoanhThu,
    required this.tongChiPhi,
    required this.loiNhuan,
    required this.tongQuyTienMat,
    required this.tongTienGui,
    required this.tongTonKho,
    required this.tongBhxhPhaiNop,
    required this.tongThuePhaiNop,
    required this.doanhThuTheoNghe,
    required this.chiPhiTheoLoai,
  });

  double get tiLeLoiNhuan => tongDoanhThu > 0 ? (loiNhuan / tongDoanhThu) * 100 : 0;

  @override
  List<Object?> get props => [
        id,
        kyKeToanId,
        thangNam,
        ngayTao,
        tongDoanhThu,
        tongChiPhi,
        loiNhuan,
        tongQuyTienMat,
        tongTienGui,
        tongTonKho,
        tongBhxhPhaiNop,
        tongThuePhaiNop,
        doanhThuTheoNghe,
        chiPhiTheoLoai,
      ];
}