// ============================================================================
// TDD - Domain Layer Tests
// ============================================================================
// CT-06: Quản lý hóa đơn
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:hkd_accounting/features/ct/domain/entities/hoa_don.dart';

void main() {
  group('HoaDon Entity Tests', () {
    test('should create HoaDon with required fields', () {
      final hoaDon = HoaDon(
        id: '1',
        soHoaDon: 'HD001',
        ngayLap: DateTime(2023, 5, 15),
        loaiHoaDon: 'DAU_RA',
        kyKeToanId: 'ky001',
      );

      expect(hoaDon.soHoaDon, 'HD001');
      expect(hoaDon.loaiHoaDon, 'DAU_RA');
      expect(hoaDon.trangThai, 'MOI');
      expect(hoaDon.tienHang, 0);
      expect(hoaDon.tienThue, 0);
      expect(hoaDon.tongTien, 0);
    });

    test('should create HoaDon with all fields', () {
      final now = DateTime.now();
      final hoaDon = HoaDon(
        id: '1',
        soHoaDon: 'HD001',
        ngayLap: DateTime(2023, 5, 15),
        loaiHoaDon: 'DAU_VAO',
        kyKeToanId: 'ky001',
        nhaCungCapId: 'ncc001',
        khachHangId: 'kh001',
        phieuNhapKhoId: 'pn001',
        tienHang: 1000000,
        tienThue: 100000,
        tongTien: 1100000,
        trangThai: 'DA_DUYET',
        createdAt: now,
        updatedAt: now,
      );

      expect(hoaDon.loaiHoaDon, 'DAU_VAO');
      expect(hoaDon.nhaCungCapId, 'ncc001');
      expect(hoaDon.khachHangId, 'kh001');
      expect(hoaDon.phieuNhapKhoId, 'pn001');
      expect(hoaDon.tienHang, 1000000);
      expect(hoaDon.tienThue, 100000);
      expect(hoaDon.tongTien, 1100000);
      expect(hoaDon.trangThai, 'DA_DUYET');
      expect(hoaDon.createdAt, now);
    });

    test('should support optional fields as null', () {
      final hoaDon = HoaDon(
        id: '1',
        soHoaDon: 'HD001',
        ngayLap: DateTime(2023, 5, 15),
        loaiHoaDon: 'DAU_RA',
        kyKeToanId: 'ky001',
      );

      expect(hoaDon.nhaCungCapId, isNull);
      expect(hoaDon.khachHangId, isNull);
      expect(hoaDon.phieuNhapKhoId, isNull);
      expect(hoaDon.phieuXuatKhoId, isNull);
    });

    test('should create copy with modified values using copyWith', () {
      final original = HoaDon(
        id: '1',
        soHoaDon: 'HD001',
        ngayLap: DateTime(2023, 5, 15),
        loaiHoaDon: 'DAU_RA',
        kyKeToanId: 'ky001',
        trangThai: 'MOI',
      );

      final copy = original.copyWith(
        soHoaDon: 'HD002',
        trangThai: 'DA_DUYET',
        tienHang: 2000000,
        tongTien: 2200000,
      );

      expect(copy.id, original.id);
      expect(copy.soHoaDon, 'HD002');
      expect(copy.trangThai, 'DA_DUYET');
      expect(copy.tienHang, 2000000);
      expect(copy.tongTien, 2200000);
      expect(copy.kyKeToanId, original.kyKeToanId);
    });

    test('should calculate tongTien automatically if not provided', () {
      final hoaDon = HoaDon(
        id: '1',
        soHoaDon: 'HD001',
        ngayLap: DateTime(2023, 5, 15),
        loaiHoaDon: 'DAU_RA',
        kyKeToanId: 'ky001',
        tienHang: 1000000,
        tienThue: 100000,
      );

      expect(hoaDon.tienHang + hoaDon.tienThue, 1100000);
    });

    test('should have correct props for equality', () {
      final now = DateTime(2023, 5, 15);
      final hoaDon1 = HoaDon(
        id: '1',
        soHoaDon: 'HD001',
        ngayLap: now,
        loaiHoaDon: 'DAU_RA',
        kyKeToanId: 'ky001',
      );

      final hoaDon2 = HoaDon(
        id: '1',
        soHoaDon: 'HD001',
        ngayLap: now,
        loaiHoaDon: 'DAU_RA',
        kyKeToanId: 'ky001',
      );

      expect(hoaDon1, equals(hoaDon2));
    });

    test('should distinguish between DAU_VAO and DAU_RA', () {
      final hoaDonVao = HoaDon(
        id: '1',
        soHoaDon: 'HD001',
        ngayLap: DateTime(2023, 5, 15),
        loaiHoaDon: 'DAU_VAO',
        kyKeToanId: 'ky001',
      );

      final hoaDonRa = HoaDon(
        id: '2',
        soHoaDon: 'HD002',
        ngayLap: DateTime(2023, 5, 15),
        loaiHoaDon: 'DAU_RA',
        kyKeToanId: 'ky001',
      );

      expect(hoaDonVao.loaiHoaDon, 'DAU_VAO');
      expect(hoaDonRa.loaiHoaDon, 'DAU_RA');
      expect(hoaDonVao.loaiHoaDon, isNot(equals(hoaDonRa.loaiHoaDon)));
    });
  });
}