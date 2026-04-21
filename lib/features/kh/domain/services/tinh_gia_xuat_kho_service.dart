// ============================================================================
// Domain Layer - COGS Calculation Service
// Based on UC_HKD_TT88_2021 - KH-04: Tính giá xuất kho
// ============================================================================

import 'package:hkd_accounting/features/kh/domain/entities/ton_kho.dart';

enum PhuongPhapGiaXuatKho { BINH_QUAN, FIFO }

class TinhGiaXuatKhoService {
  final PhuongPhapGiaXuatKho phuongPhap;

  TinhGiaXuatKhoService({this.phuongPhap = PhuongPhapGiaXuatKho.BINH_QUAN});

  int tinhGiaXuatBinhQuan({
    required double tonDauSoLuong,
    required int tonDauThanhTien,
    required double nhapSoLuong,
    required int nhapThanhTien,
    required double soLuongXuat,
  }) {
    if (soLuongXuat <= 0) return 0;

    final tongSoLuong = tonDauSoLuong + nhapSoLuong;
    if (tongSoLuong <= 0) return 0;

    final tongThanhTien = tonDauThanhTien + nhapThanhTien;
    final donGiaBinhQuan = tongThanhTien / tongSoLuong;

    return (soLuongXuat * donGiaBinhQuan).round();
  }

  int tinhGiaXuatFIFO({
    required List<PhieuNhapKhoLot> lots,
    required double soLuongXuat,
  }) {
    if (soLuongXuat <= 0 || lots.isEmpty) return 0;

    final sortedLots = List<PhieuNhapKhoLot>.from(lots)
      ..sort((a, b) => a.ngayNhap.compareTo(b.ngayNhap));

    int totalCost = 0;
    double remainingQty = soLuongXuat;

    for (final lot in sortedLots) {
      if (remainingQty <= 0) break;

      final availableQty = lot.soLuongConLai > 0 ? lot.soLuongConLai : lot.soLuong;
      final qtyToUse = remainingQty > availableQty ? availableQty : remainingQty;
      final costForLot = (qtyToUse * lot.donGia).round();

      totalCost += costForLot;
      remainingQty -= qtyToUse;
    }

    return totalCost;
  }

  double tinhDonGiaXuat({
    required List<PhieuNhapKhoLot> lots,
    required double tonDauSoLuong,
    required int tonDauThanhTien,
    required double nhapSoLuong,
    required int nhapThanhTien,
    required double soLuongXuat,
  }) {
    if (phuongPhap == PhuongPhapGiaXuatKho.FIFO) {
      if (lots.isEmpty) return 0;
      return lots.first.donGia;
    }

    return (tonDauThanhTien + nhapThanhTien) /
        (tonDauSoLuong + nhapSoLuong);
  }

  Map<String, dynamic> tinhTonCuoiKy({
    required double tonDauSoLuong,
    required int tonDauThanhTien,
    required double nhapSoLuong,
    required int nhapThanhTien,
    required double xuatSoLuong,
    required int xuatThanhTien,
  }) {
    final tonCuoiSoLuong = tonDauSoLuong + nhapSoLuong - xuatSoLuong;
    final tonCuoiThanhTien = tonDauThanhTien + nhapThanhTien - xuatThanhTien;

    double donGiaXuat = 0;
    if ((tonDauSoLuong + nhapSoLuong) > 0) {
      donGiaXuat = (tonDauThanhTien + nhapThanhTien) / (tonDauSoLuong + nhapSoLuong);
    }

    return {
      'tonCuoiSoLuong': tonCuoiSoLuong,
      'tonCuoiThanhTien': tonCuoiThanhTien,
      'donGiaXuatKho': donGiaXuat,
    };
  }
}