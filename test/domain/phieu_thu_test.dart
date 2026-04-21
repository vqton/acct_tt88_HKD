// ============================================================================
// TDD - Domain Layer Tests
// Based on UC_HKD_TT88_2021 - CT-01: Lập phiếu thu
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_thu.dart';

void main() {
  group('PhieuThu Entity Tests', () {
    // TEST 1: Create valid PhieuThu
    test('should create PhieuThu with required fields', () {
      final phieuThu = PhieuThu(
        id: 'PT001',
        soPhieu: 'PT001',
        ngayLap: DateTime(2023, 1, 15),
        nguoiNop: 'Nguyen Van A',
        diaChiNguoiNop: '123 Street, District 1, HCMC',
        lyDoNop: 'Thanh toan hoa don ban hang',
        soTien: 1000000,
        soTienBangChu: 'Mot tram nghin dong',
        chungTuGocKemTheo: 'HD001',
        hkdInfoId: 'HKD001',
        khachHangId: 'KH001',
        kyKeToanId: 'KKT001',
        trangThai: 'CHO_DUYET',
        createdAt: DateTime(2023, 1, 15),
      );

      expect(phieuThu.soPhieu, 'PT001');
      expect(phieuThu.nguoiNop, 'Nguyen Van A');
      expect(phieuThu.soTien, 1000000);
      expect(phieuThu.trangThai, 'CHO_DUYET');
    });

    // TEST 2: Check default values
    test('should have default trangThai as CHO_DUYET', () {
      final phieuThu = PhieuThu(
        id: 'PT001',
        soPhieu: 'PT001',
        ngayLap: DateTime(2023, 1, 15),
        nguoiNop: 'Nguyen Van A',
        diaChiNguoiNop: '123 Street',
        lyDoNop: 'Test',
        soTien: 100000,
        soTienBangChu: 'Mot tram nghin dong',
        chungTuGocKemTheo: '',
        hkdInfoId: 'HKD001',
        khachHangId: 'KH001',
        kyKeToanId: 'KKT001',
      );

      expect(phieuThu.trangThai, 'CHO_DUYET');
    });

    // TEST 3: CopyWith
    test('should copyWith correctly', () {
      final original = PhieuThu(
        id: 'PT001',
        soPhieu: 'PT001',
        ngayLap: DateTime(2023, 1, 15),
        nguoiNop: 'Nguyen Van A',
        diaChiNguoiNop: '123 Street',
        lyDoNop: 'Original reason',
        soTien: 1000000,
        soTienBangChu: 'Mot tram nghin dong',
        chungTuGocKemTheo: 'HD001',
        hkdInfoId: 'HKD001',
        khachHangId: 'KH001',
        kyKeToanId: 'KKT001',
        trangThai: 'CHO_DUYET',
      );

      final copied = original.copyWith(
        lyDoNop: 'Updated reason',
        soTien: 1500000,
        trangThai: 'DA_DUYET',
      );

      expect(copied.id, original.id);
      expect(copied.soPhieu, original.soPhieu);
      expect(copied.ngayLap, original.ngayLap);
      expect(copied.nguoiNop, original.nguoiNop);
      expect(copied.diaChiNguoiNop, original.diaChiNguoiNop);
      expect(copied.lyDoNop, 'Updated reason');
      expect(copied.soTien, 1500000);
      expect(copied.soTienBangChu, original.soTienBangChu); // unchanged
      expect(copied.chungTuGocKemTheo, original.chungTuGocKemTheo);
      expect(copied.hkdInfoId, original.hkdInfoId);
      expect(copied.khachHangId, original.khachHangId);
      expect(copied.kyKeToanId, original.kyKeToanId);
      expect(copied.trangThai, 'DA_DUYET');
    });

    // TEST 4: Validate soTien must be positive
    test('should validate soTien is positive', () {
      expect(
        () => PhieuThu(
          id: 'PT001',
          soPhieu: 'PT001',
          ngayLap: DateTime(2023, 1, 15),
          nguoiNop: 'Nguyen Van A',
          diaChiNguoiNop: '123 Street',
          lyDoNop: 'Test',
          soTien: -100000, // negative amount
          soTienBangChu: 'Mot tram nghin dong',
          chungTuGocKemTheo: '',
          hkdInfoId: 'HKD001',
          khachHangId: 'KH001',
          kyKeToanId: 'KKT001',
        ),
        throwsAssertionError,
      );
    });

    // TEST 5: Validate required fields are not empty
    test('should validate required string fields are not empty', () {
      expect(
        () => PhieuThu(
          id: '', // empty id
          soPhieu: 'PT001',
          ngayLap: DateTime(2023, 1, 15),
          nguoiNop: 'Nguyen Van A',
          diaChiNguoiNop: '123 Street',
          lyDoNop: 'Test',
          soTien: 100000,
          soTienBangChu: 'Mot tram nghin dong',
          chungTuGocKemTheo: '',
          hkdInfoId: 'HKD001',
          khachHangId: 'KH001',
          kyKeToanId: 'KKT001',
        ),
        throwsAssertionError,
      );
    });
  });
}