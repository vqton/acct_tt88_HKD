// ============================================================================
// TDD - Domain Layer Tests
// ============================================================================
// Naming Convention: feature_name_test.dart
// Pattern: [Entity]Test.dart
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/tai_khoan_ngan_hang.dart';

void main() {
  group('TaiKhoanNganHang Entity Tests', () {
    // TEST 1: Create valid Tai Khoan Ngan Hang
    test('should create Tai Khoan Ngan Hang with required fields', () {
      final tknh = TaiKhoanNganHang(
        id: '1',
        maTaiKhoan: 'TKNH001',
        tenTaiKhoan: 'Tài khoản chính',
        tenNganHang: 'Vietcombank',
        soTaiKhoan: '1234567890',
      );
      
      expect(tknh.tenTaiKhoan, 'Tài khoản chính');
      expect(tknh.maTaiKhoan, 'TKNH001');
      expect(tknh.tenNganHang, 'Vietcombank');
    });
    
    // TEST 2: Default values
    test('should have default trang_thai as HOAT_DONG', () {
      final tknh = TaiKhoanNganHang(
        id: '1',
        maTaiKhoan: 'TKNH001',
        tenTaiKhoan: 'Test',
      );
      
      expect(tknh.trangThai, 'HOAT_DONG');
    });
    
    // TEST 3: CopyWith
    test('should create copy with modified values', () {
      final original = TaiKhoanNganHang(
        id: '1',
        maTaiKhoan: 'TKNH001',
        tenTaiKhoan: 'Tài khoản chính',
        tenNganHang: 'Vietcombank',
        trangThai: 'HOAT_DONG',
      );
      
      final copy = original.copyWith(
        tenTaiKhoan: 'Tài khoản phụ',
        tenNganHang: 'Techcombank',
        trangThai: 'DONG',
      );
      
      expect(copy.tenTaiKhoan, 'Tài khoản phụ');
      expect(copy.tenNganHang, 'Techcombank');
      expect(copy.trangThai, 'DONG');
      // Unchanged values should remain the same
      expect(copy.id, original.id);
      expect(copy.maTaiKhoan, original.maTaiKhoan);
      expect(copy.soTaiKhoan, original.soTaiKhoan);
    });
  });
}