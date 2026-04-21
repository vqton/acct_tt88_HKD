/// Test file for SoTienGuiNganHang entity (Sổ tiền gửi ngân hàng - S7-HKD)
/// Based on UC_HKD_TT88_2021 - SK-08: Ghi sổ tiền gửi ngân hàng (S7-HKD)

import 'package:flutter_test/flutter_test.dart';
import 'package:hkd_accounting/features/sk/domain/entities/so_tien_gui_ngan_hang.dart';

void main() {
  group('SoTienGuiNganHang Entity Tests', () {
    // TEST 1: Create valid SoTienGuiNganHang
    test('should create SoTienGuiNganHang with required fields', () {
      final soTien = SoTienGuiNganHang(
        id: 'STGNH001',
        ngayLap: DateTime(2023, 1, 15),
        soChungTu: 'BC001',
        loaiChungTu: 'GUI_TIEN',
        lyDo: 'Gui tien vao tai khoan',
        soTien: 5000000,
        taiKhoanNganHangId: 'TKNH001',
        kyKeToanId: 'KKT001',
        createdAt: DateTime(2023, 1, 15),
      );

      expect(soTien.id, 'STGNH001');
      expect(soTien.soChungTu, 'BC001');
      expect(soTien.loaiChungTu, 'GUI_TIEN');
      expect(soTien.soTien, 5000000);
    });

    // TEST 2: Check GUI_TIEN increases balance
    test('should have isGui as true for GUI_TIEN', () {
      final soTien = SoTienGuiNganHang(
        id: 'STGNH001',
        ngayLap: DateTime(2023, 1, 15),
        soChungTu: 'BC001',
        loaiChungTu: 'GUI_TIEN',
        lyDo: 'Gui tien',
        soTien: 5000000,
        taiKhoanNganHangId: 'TKNH001',
        kyKeToanId: 'KKT001',
      );

      expect(soTien.isGui, true);
    });

    // TEST 3: Check RUT_TIEN decreases balance
    test('should have isRut as true for RUT_TIEN', () {
      final soTien = SoTienGuiNganHang(
        id: 'STGNH002',
        ngayLap: DateTime(2023, 1, 15),
        soChungTu: 'BN001',
        loaiChungTu: 'RUT_TIEN',
        lyDo: 'Rut tien',
        soTien: 2000000,
        taiKhoanNganHangId: 'TKNH001',
        kyKeToanId: 'KKT001',
      );

      expect(soTien.isRut, true);
    });

    // TEST 4: CopyWith
    test('should copyWith correctly', () {
      final original = SoTienGuiNganHang(
        id: 'STGNH001',
        ngayLap: DateTime(2023, 1, 15),
        soChungTu: 'BC001',
        loaiChungTu: 'GUI_TIEN',
        lyDo: 'Gui tien',
        soTien: 5000000,
        taiKhoanNganHangId: 'TKNH001',
        kyKeToanId: 'KKT001',
      );

      final copied = original.copyWith(
        soTien: 7500000,
        lyDo: 'Updated reason',
      );

      expect(copied.id, original.id);
      expect(copied.soChungTu, original.soChungTu);
      expect(copied.loaiChungTu, original.loaiChungTu);
      expect(copied.soTien, 7500000);
      expect(copied.lyDo, 'Updated reason');
    });

    // TEST 5: Validate soTien must be positive
    test('should validate soTien is positive', () {
      expect(
        () => SoTienGuiNganHang(
          id: 'STGNH001',
          ngayLap: DateTime(2023, 1, 15),
          soChungTu: 'BC001',
          loaiChungTu: 'GUI_TIEN',
          lyDo: 'Test',
          soTien: -100000, // negative amount
          taiKhoanNganHangId: 'TKNH001',
          kyKeToanId: 'KKT001',
        ),
        throwsAssertionError,
      );
    });

    // TEST 6: Validate required fields are not empty
    test('should validate required string fields are not empty', () {
      expect(
        () => SoTienGuiNganHang(
          id: '', // empty id
          ngayLap: DateTime(2023, 1, 15),
          soChungTu: 'BC001',
          loaiChungTu: 'GUI_TIEN',
          lyDo: 'Test',
          soTien: 100000,
          taiKhoanNganHangId: 'TKNH001',
          kyKeToanId: 'KKT001',
        ),
        throwsAssertionError,
      );
    });

    // TEST 7: Validate loaiChungTu is valid
    test('should validate loaiChungTu is either GUI_TIEN or RUT_TIEN', () {
      expect(
        () => SoTienGuiNganHang(
          id: 'STGNH001',
          ngayLap: DateTime(2023, 1, 15),
          soChungTu: 'ABC001',
          loaiChungTu: 'INVALID_TYPE',
          lyDo: 'Test',
          soTien: 100000,
          taiKhoanNganHangId: 'TKNH001',
          kyKeToanId: 'KKT001',
        ),
        throwsAssertionError,
      );
    });
  });
}