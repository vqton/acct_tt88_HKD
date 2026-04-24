// ============================================================================
// Domain Layer - Entity Tests
// Based on UC_HKD_TT88_2021 - MD-01: Quản lý thông tin HKD/CNKD
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/hkd_info.dart';

void main() {
  group('HkdInfo Entity', () {
    test('should create HkdInfo with required fields', () {
      final hkd = HkdInfo(
        id: '1',
        tenHkd: 'HKD Nguyễn Văn A',
        maSoThue: '0123456789',
      );

      expect(hkd.id, '1');
      expect(hkd.tenHkd, 'HKD Nguyễn Văn A');
      expect(hkd.maSoThue, '0123456789');
      expect(hkd.phuongPhapTinhGiaXuatKho, 'BINH_QUAN');
      expect(hkd.trangThai, 'HOAT_DONG');
    });

    test('should create HkdInfo with all fields', () {
      final now = DateTime.now();
      final hkd = HkdInfo(
        id: '1',
        tenHkd: 'HKD Nguyễn Văn A',
        diaChiTruSo: '123 Đường ABC, Quận 1, TP.HCM',
        maSoThue: '0123456789',
        soCccdNguoiDaiDien: '123456789',
        hoTenNguoiDaiDien: 'Nguyễn Văn B',
        phuongPhapTinhGiaXuatKho: 'FIFO',
        trangThai: 'HOAT_DONG',
        createdAt: now,
        updatedAt: now,
      );

      expect(hkd.diaChiTruSo, '123 Đường ABC, Quận 1, TP.HCM');
      expect(hkd.soCccdNguoiDaiDien, '123456789');
      expect(hkd.hoTenNguoiDaiDien, 'Nguyễn Văn B');
      expect(hkd.phuongPhapTinhGiaXuatKho, 'FIFO');
      expect(hkd.createdAt, now);
      expect(hkd.updatedAt, now);
    });

    test('should support copyWith for immutable updates', () {
      final hkd = HkdInfo(
        id: '1',
        tenHkd: 'HKD Nguyễn Văn A',
        maSoThue: '0123456789',
      );

      final updated = hkd.copyWith(
        tenHkd: 'HKD Nguyễn Văn B',
        diaChiTruSo: '456 Đường XYZ',
      );

      expect(updated.id, '1');
      expect(updated.tenHkd, 'HKD Nguyễn Văn B');
      expect(updated.diaChiTruSo, '456 Đường XYZ');
      expect(updated.maSoThue, '0123456789');
    });

    test('should support Equatable comparison', () {
      final hkd1 = HkdInfo(
        id: '1',
        tenHkd: 'HKD Nguyễn Văn A',
        maSoThue: '0123456789',
      );

      final hkd2 = HkdInfo(
        id: '1',
        tenHkd: 'HKD Nguyễn Văn A',
        maSoThue: '0123456789',
      );

      final hkd3 = HkdInfo(
        id: '2',
        tenHkd: 'HKD Nguyễn Văn B',
        maSoThue: '9876543210',
      );

      expect(hkd1, hkd2);
      expect(hkd1, isNot(hkd3));
    });
  });
}