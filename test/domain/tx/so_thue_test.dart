import 'package:flutter_test/flutter_test.dart';
import 'package:hkd_accounting/features/tx/domain/entities/so_thue.dart';

void main() {
  group('SoThue Entity (SK-05 - S4-HKD)', () {
    test('should calculate tongThuePhaiNop correctly', () {
      final soThue = SoThue(
        id: '1',
        kyKeToanId: 'ky_2024',
        ngayChungTu: DateTime(2024, 3, 31),
        dienGiai: 'Tổng hợp thuế tháng 3/2024',
        thueGtgtPhaiNop: 10000000,
        thueTncnPhaiNop: 5000000,
        thueGtgtDaNop: 8000000,
        thueTncnDaNop: 3000000,
      );

      expect(soThue.tongThuePhaiNop, 15000000);
    });

    test('should calculate tongThueDaNop correctly', () {
      final soThue = SoThue(
        id: '1',
        kyKeToanId: 'ky_2024',
        ngayChungTu: DateTime(2024, 3, 31),
        dienGiai: 'Tổng hợp thuế tháng 3/2024',
        thueGtgtPhaiNop: 10000000,
        thueTncnPhaiNop: 5000000,
        thueGtgtDaNop: 8000000,
        thueTncnDaNop: 3000000,
      );

      expect(soThue.tongThueDaNop, 11000000);
    });

    test('should calculate tongThueConPhaiNop correctly', () {
      final soThue = SoThue(
        id: '1',
        kyKeToanId: 'ky_2024',
        ngayChungTu: DateTime(2024, 3, 31),
        dienGiai: 'Tổng hợp thuế tháng 3/2024',
        thueGtgtPhaiNop: 10000000,
        thueTncnPhaiNop: 5000000,
        thueGtgtDaNop: 8000000,
        thueTncnDaNop: 3000000,
      );

      expect(soThue.tongThueConPhaiNop, 4000000);
    });

    test('should handle zero payments', () {
      final soThue = SoThue(
        id: '1',
        kyKeToanId: 'ky_2024',
        ngayChungTu: DateTime(2024, 3, 31),
        thueGtgtPhaiNop: 10000000,
        thueTncnPhaiNop: 5000000,
        thueGtgtDaNop: 0,
        thueTncnDaNop: 0,
      );

      expect(soThue.tongThueConPhaiNop, 15000000);
    });

    test('should handle overpayment', () {
      final soThue = SoThue(
        id: '1',
        kyKeToanId: 'ky_2024',
        ngayChungTu: DateTime(2024, 3, 31),
        thueGtgtPhaiNop: 10000000,
        thueTncnPhaiNop: 5000000,
        thueGtgtDaNop: 12000000,
        thueTncnDaNop: 6000000,
      );

      expect(soThue.tongThueConPhaiNop, -3000000);
    });

    test('should copyWith correctly', () {
      final original = SoThue(
        id: '1',
        kyKeToanId: 'ky_2024',
        ngayChungTu: DateTime(2024, 3, 31),
        thueGtgtPhaiNop: 10000000,
        thueTncnPhaiNop: 5000000,
        thueGtgtDaNop: 0,
        thueTncnDaNop: 0,
      );

      final updated = original.copyWith(
        thueGtgtDaNop: 10000000,
        thueTncnDaNop: 5000000,
        trangThai: 'DA_NOP',
      );

      expect(updated.tongThueConPhaiNop, 0);
      expect(updated.trangThai, 'DA_NOP');
    });
  });
}