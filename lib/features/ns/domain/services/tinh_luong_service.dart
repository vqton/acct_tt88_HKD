// ============================================================================
// Domain Layer - Service
// Based on UC_HKD_TT88_2021 - NS-01: Tính lương người lao động
// ============================================================================

import 'package:hkd_accounting/features/ns/domain/entities/tinh_luong_ke_hoach.dart';
import 'package:hkd_accounting/features/ns/domain/entities/khau_tru_bao_hiem.dart';

class TinhLuongService {
  List<TinhLuongKeHoach> tinhLuongChoNhieuNld({
    required List<TinhLuongInput> inputs,
    required String thangNam,
  }) {
    return inputs.asMap().entries.map((entry) {
      final input = entry.value;
      return TinhLuongKeHoach.calculate(
        id: DateTime.now().millisecondsSinceEpoch.toString() + '_${entry.key}',
        nguoiLaoDongId: input.nguoiLaoDongId,
        thangNam: thangNam,
        soCong: input.soCong,
        soSanPham: input.soSanPham,
        donGiaLuongSp: input.donGiaLuongSp,
        donGiaLuongTg: input.donGiaLuongTg,
        heSoLuong: input.heSoLuong,
        phuCapQuyLuong: input.phuCapQuyLuong,
        phuCapNgoaiQuy: input.phuCapNgoaiQuy,
        tienThuong: input.tienThuong,
      );
    }).toList();
  }

  KhauTruBaoHiem tinhBaoHiem({
    required String nguoiLaoDongId,
    required String thangNam,
    required double luongTinhBhxh,
  }) {
    return KhauTruBaoHiem.calculate(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nguoiLaoDongId: nguoiLaoDongId,
      thangNam: thangNam,
      luongTinhBhxh: luongTinhBhxh,
    );
  }

  double tinhTongThuNhap(List<TinhLuongKeHoach> danhSach) {
    return danhSach.fold(0, (sum, item) => sum + item.tongThuNhap);
  }

  double tinhTongBhxh(List<KhauTruBaoHiem> danhSach) {
    return danhSach.fold(0, (sum, item) => sum + item.bhxhNld);
  }
}

class TinhLuongInput {
  final String nguoiLaoDongId;
  final double soCong;
  final double soSanPham;
  final double donGiaLuongSp;
  final double donGiaLuongTg;
  final double heSoLuong;
  final double phuCapQuyLuong;
  final double phuCapNgoaiQuy;
  final double tienThuong;

  const TinhLuongInput({
    required this.nguoiLaoDongId,
    required this.soCong,
    required this.soSanPham,
    required this.donGiaLuongSp,
    required this.donGiaLuongTg,
    required this.heSoLuong,
    required this.phuCapQuyLuong,
    required this.phuCapNgoaiQuy,
    required this.tienThuong,
  });
}