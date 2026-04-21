// ============================================================================
// TDD - Domain Layer Tests
// ============================================================================
// Naming Convention: feature_name_test.dart
// Pattern: [Entity]Test.dart
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/hang_hoa.dart';

void main() {
  group('HangHoa Entity Tests', () {
    // TEST 1: Create valid Hang Hoa
    test('should create Hang Hoa with required fields', () {
      final hangHoa = HangHoa(
        id: '1',
        maHangHoa: 'HH001',
        tenHangHoa: 'Bánh mì',
        donViTinh: 'Cái',
        loaiHangHoa: 'HANG_HOA',
        giaVon: 5000,
        giaBan: 10000,
      );
      
      expect(hangHoa.tenHangHoa, 'Bánh mì');
      expect(hangHoa.maHangHoa, 'HH001');
      expect(hangHoa.giaVon, 5000);
    });
    
    // TEST 2: Default values
    test('should have default trang_thai as HOAT_DONG', () {
      final hangHoa = HangHoa(
        id: '1',
        maHangHoa: 'HH001',
        tenHangHoa: 'Test',
      );
      
      expect(hangHoa.trangThai, 'HOAT_DONG');
    });
    
    // TEST 3: CopyWith
    test('should create copy with modified values', () {
      final original = HangHoa(
        id: '1',
        maHangHoa: 'HH001',
        tenHangHoa: 'Bánh mì',
        donViTinh: 'Cái',
        giaVon: 5000,
        giaBan: 10000,
        trangThai: 'HOAT_DONG',
      );
      
      final copy = original.copyWith(
        tenHangHoa: 'Bánh bao',
        giaVon: 6000,
        trangThai: 'NGUNG_KINH_DOANH',
      );
      
      expect(copy.tenHangHoa, 'Bánh bao');
      expect(copy.giaVon, 6000);
      expect(copy.trangThai, 'NGUNG_KINH_DOANH');
      // Unchanged values should remain the same
      expect(copy.id, original.id);
      expect(copy.maHangHoa, original.maHangHoa);
      expect(copy.donViTinh, original.donViTinh);
      expect(copy.giaBan, original.giaBan);
    });
  });
}