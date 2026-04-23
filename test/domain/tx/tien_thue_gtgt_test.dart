import 'package:flutter_test/flutter_test.dart';
import 'package:hkd_accounting/features/tx/domain/entities/tien_thue_gtgt.dart';

void main() {
  group('TienThueGtgt Entity', () {
    test('should calculate thueGtgtConPhaiNop correctly', () {
      final tienThue = TienThueGtgt(
        id: '1',
        kyKeToanId: 'ky_2024',
        nhomNgheId: 'nghe_1',
        tenNhomNghe: 'Thương mại',
        tyLeThueGtgt: 0.1,
        doanhThu: 100000000,
        thueGtgtPhaiNop: 10000000,
        thueGtgtDaNop: 5000000,
      );

      expect(tienThue.thueGtgtConPhaiNop, 5000000);
    });

    test('should handle zero daNop', () {
      final tienThue = TienThueGtgt(
        id: '1',
        kyKeToanId: 'ky_2024',
        nhomNgheId: 'nghe_1',
        tenNhomNghe: 'Thương mại',
        tyLeThueGtgt: 0.1,
        doanhThu: 100000000,
        thueGtgtPhaiNop: 10000000,
        thueGtgtDaNop: 0,
      );

      expect(tienThue.thueGtgtConPhaiNop, 10000000);
    });

    test('should handle full payment', () {
      final tienThue = TienThueGtgt(
        id: '1',
        kyKeToanId: 'ky_2024',
        nhomNgheId: 'nghe_1',
        tenNhomNghe: 'Thương mại',
        tyLeThueGtgt: 0.1,
        doanhThu: 100000000,
        thueGtgtPhaiNop: 10000000,
        thueGtgtDaNop: 10000000,
      );

      expect(tienThue.thueGtgtConPhaiNop, 0);
    });

    test('should copyWith correctly', () {
      final original = TienThueGtgt(
        id: '1',
        kyKeToanId: 'ky_2024',
        nhomNgheId: 'nghe_1',
        tenNhomNghe: 'Thương mại',
        tyLeThueGtgt: 0.1,
        doanhThu: 100000000,
        thueGtgtPhaiNop: 10000000,
        thueGtgtDaNop: 0,
      );

      final updated = original.copyWith(
        thueGtgtDaNop: 5000000,
      );

      expect(updated.thueGtgtDaNop, 5000000);
      expect(updated.thueGtgtConPhaiNop, 5000000);
      expect(updated.id, original.id);
    });

    test('should calculate VAT correctly from percentage', () {
      final tienThue = TienThueGtgt(
        id: '1',
        kyKeToanId: 'ky_2024',
        nhomNgheId: 'nghe_1',
        tenNhomNghe: 'Thương mại',
        tyLeThueGtgt: 0.05,
        doanhThu: 100000000,
        thueGtgtPhaiNop: 5000000,
      );

      expect(tienThue.thueGtgtPhaiNop, 5000000);
      expect(tienThue.tyLeThueGtgt, 0.05);
    });
  });
}