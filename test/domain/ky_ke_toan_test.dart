// ============================================================================
// TDD - Domain Layer Tests
// Based on UC_HKD_TT88_2021 - MD-08: Cấu hình kỳ kế toán
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/ky_ke_toan.dart';

void main() {
  group('KyKeToan Entity Tests', () {
    // TEST 1: Create valid KyKeToan
    test('should create KyKeToan with required fields', () {
      final kyKeToan = KyKeToan(
        id: '1',
        namTaiChinh: 2022,
        ngayBatDauKy: DateTime(2022, 1, 1),
        ngayKetThucKy: DateTime(2022, 12, 31),
        trangThaiKy: 'mo',
      );

      expect(kyKeToan.namTaiChinh, 2022);
      expect(kyKeToan.ngayBatDauKy, DateTime(2022, 1, 1));
      expect(kyKeToan.ngayKetThucKy, DateTime(2022, 12, 31));
      expect(kyKeToan.trangThaiKy, 'mo');
    });

    // TEST 2: Check default ngayKhoaSoThucTe is null
    test('should have nullable ngayKhoaSoThucTe', () {
      final kyKeToan = KyKeToan(
        id: '1',
        namTaiChinh: 2022,
        ngayBatDauKy: DateTime(2022, 1, 1),
        ngayKetThucKy: DateTime(2022, 12, 31),
        trangThaiKy: 'mo',
      );

      expect(kyKeToan.ngayKhoaSoThucTe, isNull);
    });

    // TEST 3: CopyWith
    test('should copyWith correctly', () {
      final original = KyKeToan(
        id: '1',
        namTaiChinh: 2022,
        ngayBatDauKy: DateTime(2022, 1, 1),
        ngayKetThucKy: DateTime(2022, 12, 31),
        trangThaiKy: 'mo',
        ngayKhoaSoThucTe: DateTime(2023, 1, 15),
      );

      final copied = original.copyWith(
        namTaiChinh: 2023,
        trangThaiKy: 'dong',
      );

      expect(copied.id, original.id);
      expect(copied.namTaiChinh, 2023);
      expect(copied.ngayBatDauKy, original.ngayBatDauKy);
      expect(copied.ngayKetThucKy, original.ngayKetThucKy);
      expect(copied.trangThaiKy, 'dong');
      expect(copied.ngayKhoaSoThucTe, original.ngayKhoaSoThucTe); // unchanged
    });
  });
}