// ============================================================================
// Domain Layer - SK-03: Sổ chi tiết vật tư hàng hóa (S2-HKD) Service
// Based on UC_HKD_TT88_2021 - SK-03
// ============================================================================

import 'package:hkd_accounting/features/kh/domain/entities/ton_kho.dart';
import 'package:hkd_accounting/features/kh/domain/services/tinh_gia_xuat_kho_service.dart';

class SoVatTuHangHoaService {
  final TinhGiaXuatKhoService cogsService;

  SoVatTuHangHoaService({this.cogsService = const TinhGiaXuatKhoService()});

  TonKho calculateFromNhapKho({
    required TonKho currentTonKho,
    required double soLuongNhap,
    required int thanhTienNhap,
  }) {
    final newNhapSoLuong = currentTonKho.nhapSoLuong + soLuongNhap;
    final newNhapThanhTien = currentTonKho.nhapThanhTien + thanhTienNhap;

    final tonCuoiSoLuong =
        currentTonKho.tonDauSoLuong + newNhapSoLuong - currentTonKho.xuatSoLuong;
    final tonCuoiThanhTien =
        currentTonKho.tonDauThanhTien + newNhapThanhTien - currentTonKho.xuatThanhTien;

    final donGiaBinhQuan = (currentTonKho.tonDauSoLuong + newNhapSoLuong) > 0
        ? (currentTonKho.tonDauThanhTien + newNhapThanhTien) /
            (currentTonKho.tonDauSoLuong + newNhapSoLuong)
        : 0.0;

    return currentTonKho.copyWith(
      nhapSoLuong: newNhapSoLuong,
      nhapThanhTien: newNhapThanhTien,
      tonCuoiSoLuong: tonCuoiSoLuong,
      tonCuoiThanhTien: tonCuoiThanhTien,
      donGiaXuatKho: donGiaBinhQuan,
    );
  }

  TonKho calculateFromXuatKho({
    required TonKho currentTonKho,
    required double soLuongXuat,
  }) {
    final newXuatSoLuong = currentTonKho.xuatSoLuong + soLuongXuat;
    final giaXuat = cogsService.tinhGiaXuatBinhQuan(
      tonDauSoLuong: currentTonKho.tonDauSoLuong,
      tonDauThanhTien: currentTonKho.tonDauThanhTien,
      nhapSoLuong: currentTonKho.nhapSoLuong,
      nhapThanhTien: currentTonKho.nhapThanhTien,
      soLuongXuat: soLuongXuat,
    );
    final newXuatThanhTien = currentTonKho.xuatThanhTien + giaXuat;

    final tonCuoiSoLuong =
        currentTonKho.tonDauSoLuong + currentTonKho.nhapSoLuong - newXuatSoLuong;
    final tonCuoiThanhTien =
        currentTonKho.tonDauThanhTien + currentTonKho.nhapThanhTien - newXuatThanhTien;

    return currentTonKho.copyWith(
      xuatSoLuong: newXuatSoLuong,
      xuatThanhTien: newXuatThanhTien,
      tonCuoiSoLuong: tonCuoiSoLuong,
      tonCuoiThanhTien: tonCuoiThanhTien,
      donGiaXuatKho: giaXuat / soLuongXuat,
    );
  }

  TonKho calculateEndOfPeriod({
    required TonKho tonKho,
  }) {
    final tonCuoiSoLuong =
        tonKho.tonDauSoLuong + tonKho.nhapSoLuong - tonKho.xuatSoLuong;
    final tonCuoiThanhTien =
        tonKho.tonDauThanhTien + tonKho.nhapThanhTien - tonKho.xuatThanhTien;

    final tongSoLuong = tonKho.tonDauSoLuong + tonKho.nhapSoLuong;
    final tongThanhTien = tonKho.tonDauThanhTien + tonKho.nhapThanhTien;
    final donGiaXuat = tongSoLuong > 0 ? tongThanhTien / tongSoLuong : 0.0;

    return tonKho.copyWith(
      tonCuoiSoLuong: tonCuoiSoLuong,
      tonCuoiThanhTien: tonCuoiThanhTien,
      donGiaXuatKho: donGiaXuat,
    );
  }

  List<Map<String, dynamic>> generateSoS2Report({
    required List<TonKho> tonKhoList,
    required String kyKeToanId,
  }) {
    return tonKhoList.map((tk) {
      return {
        'ky_ke_toan_id': kyKeToanId,
        'hang_hoa_id': tk.hangHoaId,
        'ton_dau_so_luong': tk.tonDauSoLuong,
        'ton_dau_thanh_tien': tk.tonDauThanhTien,
        'nhap_so_luong': tk.nhapSoLuong,
        'nhap_thanh_tien': tk.nhapThanhTien,
        'xuat_so_luong': tk.xuatSoLuong,
        'xuat_thanh_tien': tk.xuatThanhTien,
        'ton_cuoi_so_luong': tk.tonCuoiSoLuong,
        'ton_cuoi_thanh_tien': tk.tonCuoiThanhTien,
        'don_gia_xuat_kho': tk.donGiaXuatKho,
      };
    }).toList();
  }
}