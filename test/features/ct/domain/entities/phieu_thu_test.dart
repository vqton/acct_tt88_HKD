// ============================================================================
// Domain Layer - Entity Tests
// Based on UC_HKD_TT88_2021 - CT-01: Lập phiếu thu
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_thu.dart';

void main() {
  group('PhieuThu Entity', () {
    test('should create PhieuThu with required fields', () {
      final phieuThu = PhieuThu(
        id: '1',
        soPhieu: 'PT-001',
        ngayLap: DateTime(2024, 1, 15),
        nguoiNop: 'Nguyễn Văn A',
        diaChiNguoiNop: '123 Đường ABC',
        lyDoNop: 'Thu bán hàng',
        soTien: 1000000,
        soTienBangChu: 'Một triệu đồng',
        chungTuGocKemTheo: 'Hóa đơn số 001',
        hkdInfoId: 'hkd-1',
        khachHangId: 'kh-1',
        kyKeToanId: 'ky-1',
      );

      expect(phieuThu.id, '1');
      expect(phieuThu.soPhieu, 'PT-001');
      expect(phieuThu.ngayLap, DateTime(2024, 1, 15));
      expect(phieuThu.nguoiNop, 'Nguyễn Văn A');
      expect(phieuThu.soTien, 1000000);
      expect(phieuThu.trangThai, 'CHO_DUYET');
    });

    test('should create PhieuThu with all fields', () {
      final now = DateTime.now();
      final phieuThu = PhieuThu(
        id: '1',
        soPhieu: 'PT-001',
        ngayLap: DateTime(2024, 1, 15),
        nguoiNop: 'Nguyễn Văn A',
        diaChiNguoiNop: '123 Đường ABC',
        lyDoNop: 'Thu bán hàng',
        soTien: 1000000,
        soTienBangChu: 'Một triệu đồng',
        chungTuGocKemTheo: 'Hóa đơn số 001',
        hkdInfoId: 'hkd-1',
        khachHangId: 'kh-1',
        kyKeToanId: 'ky-1',
        trangThai: 'DA_DUYET',
        ngayDuyet: now,
        createdAt: now,
        updatedAt: now,
      );

      expect(phieuThu.trangThai, 'DA_DUYET');
      expect(phieuThu.ngayDuyet, now);
    });

    test('should support copyWith for immutable updates', () {
      final phieuThu = PhieuThu(
        id: '1',
        soPhieu: 'PT-001',
        ngayLap: DateTime(2024, 1, 15),
        nguoiNop: 'Nguyễn Văn A',
        diaChiNguoiNop: '123 Đường ABC',
        lyDoNop: 'Thu bán hàng',
        soTien: 1000000,
        soTienBangChu: 'Một triệu đồng',
        chungTuGocKemTheo: 'Hóa đơn số 001',
        hkdInfoId: 'hkd-1',
        khachHangId: 'kh-1',
        kyKeToanId: 'ky-1',
      );

      final updated = phieuThu.copyWith(
        trangThai: 'DA_DUYET',
        ngayDuyet: DateTime(2024, 1, 16),
      );

      expect(updated.id, '1');
      expect(updated.soPhieu, 'PT-001');
      expect(updated.trangThai, 'DA_DUYET');
      expect(updated.soTien, 1000000);
    });

    test('should calculate tongTien correctly', () {
      final phieuThu = PhieuThu(
        id: '1',
        soPhieu: 'PT-001',
        ngayLap: DateTime(2024, 1, 15),
        nguoiNop: 'Nguyễn Văn A',
        diaChiNguoiNop: '123 Đường ABC',
        lyDoNop: 'Thu bán hàng',
        soTien: 1000000,
        soTienBangChu: 'Một triệu đồng',
        chungTuGocKemTheo: 'Hóa đơn số 001',
        hkdInfoId: 'hkd-1',
        khachHangId: 'kh-1',
        kyKeToanId: 'ky-1',
      );

      expect(phieuThu.tongTien, 1000000);
    });

    test('should support Equatable comparison', () {
      final pt1 = PhieuThu(
        id: '1',
        soPhieu: 'PT-001',
        ngayLap: DateTime(2024, 1, 15),
        nguoiNop: 'Nguyễn Văn A',
        diaChiNguoiNop: '123 Đường ABC',
        lyDoNop: 'Thu bán hàng',
        soTien: 1000000,
        soTienBangChu: 'Một triệu đồng',
        chungTuGocKemTheo: 'Hóa đơn số 001',
        hkdInfoId: 'hkd-1',
        khachHangId: 'kh-1',
        kyKeToanId: 'ky-1',
      );

      final pt2 = PhieuThu(
        id: '1',
        soPhieu: 'PT-001',
        ngayLap: DateTime(2024, 1, 15),
        nguoiNop: 'Nguyễn Văn A',
        diaChiNguoiNop: '123 Đường ABC',
        lyDoNop: 'Thu bán hàng',
        soTien: 1000000,
        soTienBangChu: 'Một triệu đồng',
        chungTuGocKemTheo: 'Hóa đơn số 001',
        hkdInfoId: 'hkd-1',
        khachHangId: 'kh-1',
        kyKeToanId: 'ky-1',
      );

      expect(pt1, pt2);
    });
  });
}