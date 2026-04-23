import 'package:flutter_test/flutter_test.dart';
import 'package:hkd_accounting/features/tx/domain/entities/phieu_nop_thue.dart';

void main() {
  group('PhieuNopThue Entity', () {
    test('should calculate tongTien correctly for GTGT only', () {
      final phieu = PhieuNopThue(
        id: '1',
        kyKeToanId: 'ky_2024',
        loaiThue: LoaiThue.gtgt,
        ngayNop: DateTime(2024, 3, 20),
        soTienGtgt: 10000000,
        soTienTncn: 0,
        tongTien: 10000000,
      );

      expect(phieu.tongTien, 10000000);
    });

    test('should calculate tongTien correctly for TNCN only', () {
      final phieu = PhieuNopThue(
        id: '1',
        kyKeToanId: 'ky_2024',
        loaiThue: LoaiThue.tncn,
        ngayNop: DateTime(2024, 3, 20),
        soTienGtgt: 0,
        soTienTncn: 5000000,
        tongTien: 5000000,
      );

      expect(phieu.tongTien, 5000000);
    });

    test('should calculate tongTien correctly for both', () {
      final phieu = PhieuNopThue(
        id: '1',
        loaiThue: LoaiThue.both,
        ngayNop: DateTime(2024, 3, 20),
        kyKeToanId: 'ky_2024',
        soTienGtgt: 10000000,
        soTienTncn: 5000000,
        tongTien: 15000000,
      );

      expect(phieu.tongTien, 15000000);
    });

    test('should have default values', () {
      final phieu = PhieuNopThue(
        id: '1',
        kyKeToanId: 'ky_2024',
        loaiThue: LoaiThue.gtgt,
        ngayNop: DateTime(2024, 3, 20),
        tongTien: 10000000,
      );

      expect(phieu.soGiayNopTien, '');
      expect(phieu.hinhThucNop, 'CHUYEN_KHOAN');
      expect(phieu.nganHangNop, '');
      expect(phieu.dienGiai, '');
      expect(phieu.trangThai, 'DA_NOP');
    });

    test('should copyWith correctly', () {
      final original = PhieuNopThue(
        id: '1',
        kyKeToanId: 'ky_2024',
        loaiThue: LoaiThue.gtgt,
        ngayNop: DateTime(2024, 3, 20),
        tongTien: 10000000,
        soGiayNopTien: '',
      );

      final updated = original.copyWith(
        soGiayNopTien: 'GT/2024/001',
        hinhThucNop: 'TIEN_MAT',
        dienGoi: 'Nộp thuế GTGT tháng 3/2024',
      );

      expect(updated.soGiayNopTien, 'GT/2024/001');
      expect(updated.hinhThucNop, 'TIEN_MAT');
      expect(updated.dienGoi, 'Nộp thuế GTGT tháng 3/2024');
    });
  });

  group('LoaiThue Enum', () {
    test('should have correct values', () {
      expect(LoaiThue.values.length, 3);
      expect(LoaiThue.gtgt.name, 'gtgt');
      expect(LoaiThue.tncn.name, 'tncn');
      expect(LoaiThue.both.name, 'both');
    });
  });
}