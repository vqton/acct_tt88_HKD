// ============================================================================
// TDD - Domain Layer Tests
// ============================================================================
// Naming Convention: feature_name_test.dart
// Pattern: [Entity]Test.dart
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:hkd_accounting/features/tt/domain/entities/tien_gui_ngan_hang.dart';

void main() {
  group('TienGuiNganHang Entity Tests', () {
    // TEST 1: Create valid Tien Gui Ngan Hang
    test('should create Tien Gui Ngan Hang with required fields', () {
      final tienGuiNganHang = TienGuiNganHang(
        id: '1',
        maTaiKhoan: 'TKNH001',
        tenTaiKhoan: 'Tài khoản ngân hàng chính',
        soDuDauKy: 5000000,
        tongThu: 10000000,
        tongChi: 7000000,
        soDuCuoiKy: 8000000,
        kyKeToanId: 'ky001',
        trangThai: 'HOAT_DONG',
      );
      
      expect(tienGuiNganHang.tenTaiKhoan, 'Tài khoản ngân hàng chính');
      expect(tienGuiNganHang.maTaiKhoan, 'TKNH001');
      expect(tienGuiNganHang.soDuDauKy, 5000000);
    });
    
    // TEST 2: Default values for timestamps
    test('should have null createdAt and updatedAt when not provided', () {
      final tienGuiNganHang = TienGuiNganHang(
        id: '1',
        maTaiKhoan: 'TKNH001',
        tenTaiKhoan: 'Test',
        soDuDauKy: 0,
        tongThu: 0,
        tongChi: 0,
        soDuCuoiKy: 0,
        kyKeToanId: 'ky001',
        trangThai: 'HOAT_DONG',
      );
      
      expect(tienGuiNganHang.createdAt, isNull);
      expect(tienGuiNganHang.updatedAt, isNull);
    });
    
    // TEST 3: CopyWith
    test('should create copy with modified values', () {
      final original = TienGuiNganHang(
        id: '1',
        maTaiKhoan: 'TKNH001',
        tenTaiKhoan: 'Tài khoản ngân hàng chính',
        soDuDauKy: 5000000,
        tongThu: 10000000,
        tongChi: 7000000,
        soDuCuoiKy: 8000000,
        kyKeToanId: 'ky001',
        trangThai: 'HOAT_DONG',
      );
      
      final copy = original.copyWith(
        tenTaiKhoan: 'Tài khoản ngân hàng phụ',
        soDuDauKy: 3000000,
        trangThai: 'DONG',
      );
      
      expect(copy.tenTaiKhoan, 'Tài khoản ngân hàng phụ');
      expect(copy.soDuDauKy, 3000000);
      expect(copy.trangThai, 'DONG');
      // Unchanged values should remain the same
      expect(copy.id, original.id);
      expect(copy.maTaiKhoan, original.maTaiKhoan);
      expect(copy.tongThu, original.tongThu);
      expect(copy.tongChi, original.tongChi);
    });
    
    // TEST 4: Validation - numeric fields must be >= 0
    test('should throw assertion error when soDuDauKy is negative', () {
      expect(
        () => TienGuiNganHang(
          id: '1',
          maTaiKhoan: 'TKNH001',
          tenTaiKhoan: 'Test',
          soDuDauKy: -1000, // Invalid: must be >= 0
          tongThu: 0,
          tongChi: 0,
          soDuCuoiKy: 0,
          kyKeToanId: 'ky001',
          trangThai: 'HOAT_DONG',
        ),
        throwsAssertionError,
      );
    });
    
    // TEST 5: Validation - required string fields must not be empty
    test('should throw assertion error when required string fields are empty', () {
      expect(
        () => TienGuiNganHang(
          id: '', // Invalid: must not be empty
          maTaiKhoan: 'TKNH001',
          tenTaiKhoan: 'Test',
          soDuDauKy: 0,
          tongThu: 0,
          tongChi: 0,
          soDuCuoiKy: 0,
          kyKeToanId: 'ky001',
          trangThai: 'HOAT_DONG',
        ),
        throwsAssertionError,
      );
    });
  });
}