// ============================================================================
// TDD - Domain Layer Tests
// ============================================================================
// Naming Convention: feature_name_test.dart
// Pattern: [Entity]Test.dart
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_chi.dart';

void main() {
  group('PhieuChi Entity Tests', () {
    // TEST 1: Create valid Phieu Chi
    test('should create Phieu Chi with required fields', () {
      final phieuChi = PhieuChi(
        id: '1',
        soPhieu: 'PC001',
        ngayLap: DateTime(2023, 5, 15),
        nguoiNop: 'Công ty TNHH ABC',
        diaChiNguoiNop: '123 Đường ABC, Quận 1, TP.HCM',
        lyDoNop: 'Thanh toán hàng hóa',
        soTien: 1000000,
        soTienBangChu: 'Một triệu đồng',
        chungTuGocKemTheo: 'HĐ số 001/2023',
        hkdInfoId: 'hkd001',
        kyKeToanId: 'ky001',
        trangThai: 'CHO_DUYET',
      );
      
      expect(phieuChi.soPhieu, 'PC001');
      expect(phieuChi.nguoiNop, 'Công ty TNHH ABC');
      expect(phieuChi.soTien, 1000000);
    });
    
    // TEST 2: Default values for timestamps
    test('should have null createdAt and updatedAt when not provided', () {
      final phieuChi = PhieuChi(
        id: '1',
        soPhieu: 'PC001',
        ngayLap: DateTime(2023, 5, 15),
        nguoiNop: 'Test',
        diaChiNguoiNop: 'Test',
        lyDoNop: 'Test',
        soTien: 100000,
        soTienBangChu: 'Một trăm nghìn đồng',
        chungTuGocKemTheo: 'Test',
        hkdInfoId: 'hkd001',
        kyKeToanId: 'ky001',
        trangThai: 'CHO_DUYET',
      );
      
      expect(phieuChi.createdAt, isNull);
      expect(phieuChi.updatedAt, isNull);
    });
    
    // TEST 3: CopyWith
    test('should create copy with modified values', () {
      final original = PhieuChi(
        id: '1',
        soPhieu: 'PC001',
        ngayLap: DateTime(2023, 5, 15),
        nguoiNop: 'Công ty TNHH ABC',
        diaChiNguoiNop: '123 Đường ABC',
        lyDoNop: 'Thanh toán hàng hóa',
        soTien: 1000000,
        soTienBangChu: 'Một triệu đồng',
        chungTuGocKemTheo: 'HĐ số 001/2023',
        hkdInfoId: 'hkd001',
        kyKeToanId: 'ky001',
        trangThai: 'CHO_DUYET',
      );
      
      final copy = original.copyWith(
        soTien: 1500000,
        soTienBangChu: 'Một triệu пятьсот nghìn đồng',
        trangThai: 'DA_DUYET',
        nhaCungCapId: 'ncc001',
      );
      
      expect(copy.soTien, 1500000);
      expect(copy.soTienBangChu, 'Một triệu пятьсот nghìn đồng');
      expect(copy.trangThai, 'DA_DUYET');
      expect(copy.nhaCungCapId, 'ncc001');
      // Unchanged values should remain the same
      expect(copy.id, original.id);
      expect(copy.soPhieu, original.soPhieu);
      expect(copy.ngayLap, original.ngayLap);
      expect(copy.nguoiNop, original.nguoiNop);
    });
    
    // TEST 4: Validation - soTien must be > 0
    test('should throw assertion error when soTien is not positive', () {
      expect(
        () => PhieuChi(
          id: '1',
          soPhieu: 'PC001',
          ngayLap: DateTime(2023, 5, 15),
          nguoiNop: 'Test',
          diaChiNguoiNop: 'Test',
          lyDoNop: 'Test',
          soTien: 0, // Invalid: must be > 0
          soTienBangChu: 'Không đồng',
          chungTuGocKemTheo: 'Test',
          hkdInfoId: 'hkd001',
          kyKeToanId: 'ky001',
          trangThai: 'CHO_DUYET',
        ),
        throwsAssertionError,
      );
    });
    
    // TEST 5: Validation - required string fields must not be empty
    test('should throw assertion error when required string fields are empty', () {
      expect(
        () => PhieuChi(
          id: '', // Invalid: must not be empty
          soPhieu: 'PC001',
          ngayLap: DateTime(2023, 5, 15),
          nguoiNop: 'Test',
          diaChiNguoiNop: 'Test',
          lyDoNop: 'Test',
          soTien: 100000,
          soTienBangChu: 'Một trăm nghìn đồng',
          chungTuGocKemTheo: 'Test',
          hkdInfoId: 'hkd001',
          kyKeToanId: 'ky001',
          trangThai: 'CHO_DUYET',
        ),
        throwsAssertionError,
      );
    });
  });
}