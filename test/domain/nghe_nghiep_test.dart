// ============================================================================
// TDD - Domain Layer Tests
// Based on UC_HKD_TT88_2021 - MD-03: Quản lý danh mục ngành nghề & thuế suất
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/nghe_nghiep.dart';

void main() {
  group('NgheNghiep Entity Tests', () {
    // TEST 1: Create valid NgheNghiep
    test('should create NgheNghiep with required fields', () {
      final ngheNghiep = NgheNghiep(
        id: '1',
        maNhomNgheNghe: 'NN001',
        tenNhomNgheNghe: 'Công Nghệ Thông Tin',
        tyLeThueGTGT: 10.0,
        tyLeThueTNCN: 5.0,
        ngayHieuLuc: DateTime(2022, 1, 1),
      );

      expect(ngheNghiep.maNhomNgheNghe, 'NN001');
      expect(ngheNghiep.tenNhomNgheNghe, 'Công Nghệ Thông Tin');
      expect(ngheNghiep.tyLeThueGTGT, 10.0);
      expect(ngheNghiep.tyLeThueTNCN, 5.0);
      expect(ngheNghiep.ngayHieuLuc, DateTime(2022, 1, 1));
    });

    // TEST 2: Check default ngayHetHieuLuc is null
    test('should have nullable ngayHetHieuLuc', () {
      final ngheNghiep = NgheNghiep(
        id: '1',
        maNhomNgheNghe: 'NN001',
        tenNhomNgheNghe: 'Test',
        tyLeThueGTGT: 0.0,
        tyLeThueTNCN: 0.0,
        ngayHieuLuc: DateTime(2022, 1, 1),
      );

      expect(ngheNghiep.ngayHetHieuLuc, isNull);
    });

    // TEST 3: CopyWith
    test('should copyWith correctly', () {
      final original = NgheNghiep(
        id: '1',
        maNhomNgheNghe: 'NN001',
        tenNhomNgheNghe: 'Original',
        tyLeThueGTGT: 5.0,
        tyLeThueTNCN: 2.0,
        ngayHieuLuc: DateTime(2022, 1, 1),
        ngayHetHieuLuc: DateTime(2023, 1, 1),
      );

      final copied = original.copyWith(
        tenNhomNgheNghe: 'Copied',
        tyLeThueGTGT: 10.0,
      );

      expect(copied.id, original.id);
      expect(copied.tenNhomNgheNghe, 'Copied');
      expect(copied.tyLeThueGTGT, 10.0);
      expect(copied.tyLeThueTNCN, original.tyLeThueTNCN); // unchanged
      expect(copied.ngayHieuLuc, original.ngayHieuLuc);
      expect(copied.ngayHetHieuLuc, original.ngayHetHieuLuc);
    });
  });
}