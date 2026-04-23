// ============================================================================
// TDD - Domain Layer Tests
// ============================================================================
// CT-02: Lập phiếu chi
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_chi.dart';

void main() {
  group('PhieuChi Entity Tests', () {
    test('should create PhieuChi with required fields', () {
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

    test('should support optional nhaCungCapId', () {
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
        nhaCungCapId: 'ncc001',
        kyKeToanId: 'ky001',
        trangThai: 'CHO_DUYET',
      );
      
      expect(phieuChi.nhaCungCapId, 'ncc001');
    });

    test('should create copy with modified values using copyWith', () {
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
        soTienBangChu: 'Một triệu năm trăm nghìn đồng',
        trangThai: 'DA_DUYET',
        nhaCungCapId: 'ncc001',
      );
      
      expect(copy.soTien, 1500000);
      expect(copy.soTienBangChu, 'Một triệu năm trăm nghìn đồng');
      expect(copy.trangThai, 'DA_DUYET');
      expect(copy.nhaCungCapId, 'ncc001');
      expect(copy.id, original.id);
      expect(copy.soPhieu, original.soPhieu);
      expect(copy.ngayLap, original.ngayLap);
      expect(copy.nguoiNop, original.nguoiNop);
    });

    test('should support timestamp fields', () {
      final now = DateTime.now();
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
        createdAt: now,
        updatedAt: now,
      );
      
      expect(phieuChi.createdAt, now);
      expect(phieuChi.updatedAt, now);
    });

    test('should have correct props for equality', () {
      final now = DateTime(2023, 5, 15);
      final phieuChi1 = PhieuChi(
        id: '1',
        soPhieu: 'PC001',
        ngayLap: now,
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
      
      final phieuChi2 = PhieuChi(
        id: '1',
        soPhieu: 'PC001',
        ngayLap: now,
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
      
      expect(phieuChi1, equals(phieuChi2));
    });
  });
}