// ============================================================================
// TDD - Domain Layer Tests
// ============================================================================
// Naming Convention: feature_name_test.dart
// Pattern: [Entity]Test.dart
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/nha_cung_cap.dart';

void main() {
  group('NhaCungCap Entity Tests', () {
    // TEST 1: Create valid Nha Cung Cap
    test('should create Nha Cung Cap with required fields', () {
      final ncc = NhaCungCap(
        id: '1',
        maNhaCungCap: 'NCC001',
        tenNhaCungCap: 'Công ty TNHH ABC',
        diaChi: '123 Đường ABC, Quận 1, TP.HCM',
        maSoThue: '0123456789',
        soDienThoai: '0909123456',
      );
      
      expect(ncc.tenNhaCungCap, 'Công ty TNHH ABC');
      expect(ncc.maNhaCungCap, 'NCC001');
      expect(ncc.diaChi, '123 Đường ABC, Quận 1, TP.HCM');
    });
    
    // TEST 2: Default values
    test('should have default trang_thai as HOAT_DONG', () {
      final ncc = NhaCungCap(
        id: '1',
        maNhaCungCap: 'NCC001',
        tenNhaCungCap: 'Test',
      );
      
      expect(ncc.trangThai, 'HOAT_DONG');
    });
    
    // TEST 3: CopyWith
    test('should create copy with modified values', () {
      final original = NhaCungCap(
        id: '1',
        maNhaCungCap: 'NCC001',
        tenNhaCungCap: 'Công ty TNHH ABC',
        diaChi: '123 Đường ABC',
        trangThai: 'HOAT_DONG',
      );
      
      final copy = original.copyWith(
        tenNhaCungCap: 'Công ty TNHH XYZ',
        diaChi: '456 Đường XYZ',
        trangThai: 'NGUNG_KINH_DOANH',
      );
      
      expect(copy.tenNhaCungCap, 'Công ty TNHH XYZ');
      expect(copy.diaChi, '456 Đường XYZ');
      expect(copy.trangThai, 'NGUNG_KINH_DOANH');
      // Unchanged values should remain the same
      expect(copy.id, original.id);
      expect(copy.maNhaCungCap, original.maNhaCungCap);
      expect(copy.soDienThoai, original.soDienThoai);
    });
  });
}