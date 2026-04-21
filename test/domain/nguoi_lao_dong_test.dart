// ============================================================================
// TDD - Domain Layer Tests
// ============================================================================
// Naming Convention: feature_name_test.dart
// Pattern: [Entity]Test.dart
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/nguoi_lao_dong.dart';

void main() {
  group('NguoiLaoDong Entity Tests', () {
    // TEST 1: Create valid Nguoi Lao Dong
    test('should create Nguoi Lao Dong with required fields', () {
      final nld = NguoiLaoDong(
        id: '1',
        maNguoiLaoDong: 'NLD001',
        hoTen: 'Nguyễn Văn A',
        gioiTinh: 'NAM',
        soCccd: '123456789012',
        chucVu: 'Kế toán',
        boPhan: 'Tài chính',
        heSoLuong: 2.5,
        luongCoBan: 5000000,
      );
      
      expect(nld.hoTen, 'Nguyễn Văn A');
      expect(nld.maNguoiLaoDong, 'NLD001');
      expect(nld.heSoLuong, 2.5);
    });
    
    // TEST 2: Default values
    test('should have default trang_thai as DANG_LAM_VIEC', () {
      final nld = NguoiLaoDong(
        id: '1',
        maNguoiLaoDong: 'NLD001',
        hoTen: 'Test',
      );
      
      expect(nld.trangThai, 'DANG_LAM_VIEC');
    });
    
    // TEST 3: CopyWith
    test('should create copy with modified values', () {
      final original = NguoiLaoDong(
        id: '1',
        maNguoiLaoDong: 'NLD001',
        hoTen: 'Nguyễn Văn A',
        gioiTinh: 'NAM',
        chucVu: 'Kế toán',
        trangThai: 'DANG_LAM_VIEC',
      );
      
      final copy = original.copyWith(
        hoTen: 'Nguyễn Văn B',
        gioiTinh: 'NU',
        chucVu: 'Trưởng phòng',
        trangThai: 'NGHI_VIEC',
      );
      
      expect(copy.hoTen, 'Nguyễn Văn B');
      expect(copy.gioiTinh, 'NU');
      expect(copy.chucVu, 'Trưởng phòng');
      expect(copy.trangThai, 'NGHI_VIEC');
      // Unchanged values should remain the same
      expect(copy.id, original.id);
      expect(copy.maNguoiLaoDong, original.maNguoiLaoDong);
      expect(copy.soCccd, original.soCccd);
    });
  });
}