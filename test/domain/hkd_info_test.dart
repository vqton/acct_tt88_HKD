// ============================================================================
// TDD - Domain Layer Tests
// ============================================================================
// Naming Convention: feature_name_test.dart
// Pattern: [Entity]Test.dart
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/hkd_info.dart';

void main() {
  group('HkdInfo Entity Tests', () {
    // TEST 1: Create valid HKD info
    test('should create HKD info with required fields', () {
      final hkd = HkdInfo(
        id: '1',
        tenHkd: 'Cửa hàng tạp hóa Minh',
        diaChiTruSo: '123 Nguyễn Trãi, Q1, TP.HCM',
        maSoThue: '0123456789',
        phuongPhapTinhGiaXuatKho: 'BINH_QUAN',
      );
      
      expect(hkd.tenHkd, 'Cửa hàng tạp hóa Minh');
      expect(hkd.maSoThue, '0123456789');
    });
    
    // TEST 2: Default values
    test('should have default trang_thai as HOAT_DONG', () {
      final hkd = HkdInfo(
        id: '1',
        tenHkd: 'Test',
        diaChiTruSo: 'Test',
        maSoThue: '0123456789',
      );
      
      expect(hkd.trangThai, 'HOAT_DONG');
    });
    
    // TEST 3: Phương pháp tính giá xuất kho validation
    test('should accept BINH_QUAN or FIFO', () {
      final hkdBinhQuan = HkdInfo(
        id: '1', tenHkd: 'Test', diaChiTruSo: 'Test', 
        maSoThue: '0123456789', phuongPhapTinhGiaXuatKho: 'BINH_QUAN',
      );
      
      final hkdFifo = HkdInfo(
        id: '2', tenHkd: 'Test2', diaChiTruSo: 'Test2', 
        maSoThue: '0123456788', phuongPhapTinhGiaXuatKho: 'FIFO',
      );
      
      expect(hkdBinhQuan.phuongPhapTinhGiaXuatKho, 'BINH_QUAN');
      expect(hkdFifo.phuongPhapTinhGiaXuatKho, 'FIFO');
    });
  });
}
