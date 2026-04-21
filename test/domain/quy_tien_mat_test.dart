// ============================================================================
// TDD - Domain Layer Tests
// ============================================================================
// Naming Convention: feature_name_test.dart
// Pattern: [Entity]Test.dart
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:hkd_accounting/features/tt/domain/entities/quy_tien_mat.dart';

void main() {
  group('QuyTienMat Entity Tests', () {
    // TEST 1: Create valid Quy Tien Mat
    test('should create Quy Tien Mat with required fields', () {
      final quyTienMat = QuyTienMat(
        id: '1',
        maQuy: 'QTM001',
        tenQuy: 'Quỹ tiền mặt chính',
        soDuDauKy: 1000000,
        tongThu: 5000000,
        tongChi: 3000000,
        soDuCuoiKy: 3000000,
        kyKeToanId: 'ky001',
        trangThai: 'DANG_SU_DUNG',
      );
      
      expect(quyTienMat.tenQuy, 'Quỹ tiền mặt chính');
      expect(quyTienMat.maQuy, 'QTM001');
      expect(quyTienMat.soDuDauKy, 1000000);
    });
    
    // TEST 2: Default values for timestamps
    test('should have null createdAt and updatedAt when not provided', () {
      final quyTienMat = QuyTienMat(
        id: '1',
        maQuy: 'QTM001',
        tenQuy: 'Test',
        soDuDauKy: 0,
        tongThu: 0,
        tongChi: 0,
        soDuCuoiKy: 0,
        kyKeToanId: 'ky001',
        trangThai: 'DANG_SU_DUNG',
      );
      
      expect(quyTienMat.createdAt, isNull);
      expect(quyTienMat.updatedAt, isNull);
    });
    
    // TEST 3: CopyWith
    test('should create copy with modified values', () {
      final original = QuyTienMat(
        id: '1',
        maQuy: 'QTM001',
        tenQuy: 'Quỹ tiền mặt chính',
        soDuDauKy: 1000000,
        tongThu: 5000000,
        tongChi: 3000000,
        soDuCuoiKy: 3000000,
        kyKeToanId: 'ky001',
        trangThai: 'DANG_SU_DUNG',
      );
      
      final copy = original.copyWith(
        tenQuy: 'Quỹ tiền mặt phụ',
        soDuDauKy: 500000,
        trangThai: 'NGUNG_SU_DUNG',
      );
      
      expect(copy.tenQuy, 'Quỹ tiền mặt phụ');
      expect(copy.soDuDauKy, 500000);
      expect(copy.trangThai, 'NGUNG_SU_DUNG');
      // Unchanged values should remain the same
      expect(copy.id, original.id);
      expect(copy.maQuy, original.maQuy);
      expect(copy.tongThu, original.tongThu);
      expect(copy.tongChi, original.tongChi);
    });
    
    // TEST 4: Validation - numeric fields must be >= 0
    test('should throw assertion error when soDuDauKy is negative', () {
      expect(
        () => QuyTienMat(
          id: '1',
          maQuy: 'QTM001',
          tenQuy: 'Test',
          soDuDauKy: -1000, // Invalid: must be >= 0
          tongThu: 0,
          tongChi: 0,
          soDuCuoiKy: 0,
          kyKeToanId: 'ky001',
          trangThai: 'DANG_SU_DUNG',
        ),
        throwsAssertionError,
      );
    });
    
    // TEST 5: Validation - required string fields must not be empty
    test('should throw assertion error when required string fields are empty', () {
      expect(
        () => QuyTienMat(
          id: '', // Invalid: must not be empty
          maQuy: 'QTM001',
          tenQuy: 'Test',
          soDuDauKy: 0,
          tongThu: 0,
          tongChi: 0,
          soDuCuoiKy: 0,
          kyKeToanId: 'ky001',
          trangThai: 'DANG_SU_DUNG',
        ),
        throwsAssertionError,
      );
    });
  });
}