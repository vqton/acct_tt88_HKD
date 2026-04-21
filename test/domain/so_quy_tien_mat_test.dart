/// Test file for SoQuyTienMat entity (Sổ quỹ tiền mặt - S6-HKD)
/// Based on UC_HKD_TT88_2021 - SK-07: Ghi sổ quỹ tiền mặt (S6-HKD)

import 'package:flutter_test/flutter_test.dart';
import 'package:hkd_accounting/features/sk/domain/entities/so_quy_tien_mat.dart';

void main() {
  group('SoQuyTienMat Entity Tests', () {
    // TEST 1: Create valid SoQuyTienMat
    test('should create SoQuyTienMat with required fields', () {
      final soQuy = SoQuyTienMat(
        id: 'SQTM001',
        ngayLap: DateTime(2023, 1, 15),
        soChungTu: 'PT001',
        loaiChungTu: 'PHIEU_THU',
        lyDo: 'Thanh toan hoa don ban hang',
        soTien: 1000000,
        quyTienMatId: 'QTM001',
        kyKeToanId: 'KKT001',
        createdAt: DateTime(2023, 1, 15),
      );

      expect(soQuy.id, 'SQTM001');
      expect(soQuy.soChungTu, 'PT001');
      expect(soQuy.loaiChungTu, 'PHIEU_THU');
      expect(soQuy.soTien, 1000000);
    });

    // TEST 2: Check PHIEU_THU increases balance
    test('should have isThu as true for PHIEU_THU', () {
      final soQuy = SoQuyTienMat(
        id: 'SQTM001',
        ngayLap: DateTime(2023, 1, 15),
        soChungTu: 'PT001',
        loaiChungTu: 'PHIEU_THU',
        lyDo: 'Thu tien',
        soTien: 500000,
        quyTienMatId: 'QTM001',
        kyKeToanId: 'KKT001',
      );

      expect(soQuy.isThu, true);
    });

    // TEST 3: Check PHIEU_CHI decreases balance
    test('should have isChi as true for PHIEU_CHI', () {
      final soQuy = SoQuyTienMat(
        id: 'SQTM002',
        ngayLap: DateTime(2023, 1, 15),
        soChungTu: 'PC001',
        loaiChungTu: 'PHIEU_CHI',
        lyDo: 'Chi tien mua vat tu',
        soTien: 300000,
        quyTienMatId: 'QTM001',
        kyKeToanId: 'KKT001',
      );

      expect(soQuy.isChi, true);
    });

    // TEST 4: CopyWith
    test('should copyWith correctly', () {
      final original = SoQuyTienMat(
        id: 'SQTM001',
        ngayLap: DateTime(2023, 1, 15),
        soChungTu: 'PT001',
        loaiChungTu: 'PHIEU_THU',
        lyDo: 'Thu tien',
        soTien: 500000,
        quyTienMatId: 'QTM001',
        kyKeToanId: 'KKT001',
      );

      final copied = original.copyWith(
        soTien: 750000,
        lyDo: 'Updated reason',
      );

      expect(copied.id, original.id);
      expect(copied.soChungTu, original.soChungTu);
      expect(copied.loaiChungTu, original.loaiChungTu);
      expect(copied.soTien, 750000);
      expect(copied.lyDo, 'Updated reason');
    });

    // TEST 5: Validate soTien must be positive
    test('should validate soTien is positive', () {
      expect(
        () => SoQuyTienMat(
          id: 'SQTM001',
          ngayLap: DateTime(2023, 1, 15),
          soChungTu: 'PT001',
          loaiChungTu: 'PHIEU_THU',
          lyDo: 'Test',
          soTien: -100000, // negative amount
          quyTienMatId: 'QTM001',
          kyKeToanId: 'KKT001',
        ),
        throwsAssertionError,
      );
    });

    // TEST 6: Validate required fields are not empty
    test('should validate required string fields are not empty', () {
      expect(
        () => SoQuyTienMat(
          id: '', // empty id
          ngayLap: DateTime(2023, 1, 15),
          soChungTu: 'PT001',
          loaiChungTu: 'PHIEU_THU',
          lyDo: 'Test',
          soTien: 100000,
          quyTienMatId: 'QTM001',
          kyKeToanId: 'KKT001',
        ),
        throwsAssertionError,
      );
    });

    // TEST 7: Validate loaiChungTu is valid
    test('should validate loaiChungTu is either PHIEU_THU or PHIEU_CHI', () {
      expect(
        () => SoQuyTienMat(
          id: 'SQTM001',
          ngayLap: DateTime(2023, 1, 15),
          soChungTu: 'ABC001',
          loaiChungTu: 'INVALID_TYPE',
          lyDo: 'Test',
          soTien: 100000,
          quyTienMatId: 'QTM001',
          kyKeToanId: 'KKT001',
        ),
        throwsAssertionError,
      );
    });
  });
}