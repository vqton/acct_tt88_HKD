import 'package:flutter_test/flutter_test.dart';
import 'package:hkd_accounting/features/tx/domain/entities/tien_thue_tncn.dart';

void main() {
  group('TienThueTncn Entity', () {
    test('should calculate thueTncnConPhaiNop correctly', () {
      final tienThue = TienThueTncn(
        id: '1',
        kyKeToanId: 'ky_2024',
        loaiDoiTuong: 'CHU_HKD',
        tenNguoiNopThue: 'Nguyễn Văn A',
        tongThuNhap: 120000000,
        thueTncnPhaiNop: 12000000,
        thueTncnDaNop: 6000000,
      );

      expect(tienThue.thueTncnConPhaiNop, 6000000);
    });

    test('should handle default loaiDoiTuong as CHU_HKD', () {
      final tienThue = TienThueTncn(
        id: '1',
        kyKeToanId: 'ky_2024',
        tongThuNhap: 120000000,
        thueTncnPhaiNop: 12000000,
      );

      expect(tienThue.loaiDoiTuong, 'CHU_HKD');
    });

    test('should handle NLĐ employee type', () {
      final tienThue = TienThueTncn(
        id: '1',
        kyKeToanId: 'ky_2024',
        nguoiDungId: 'nld_1',
        tenNguoiNopThue: 'Nguyễn Văn B',
        loaiDoiTuong: 'NGUOI_LAO_DONG',
        tongThuNhap: 60000000,
        thueTncnPhaiNop: 3000000,
      );

      expect(tienThue.loaiDoiTuong, 'NGUOI_LAO_DONG');
    });

    test('should copyWith correctly', () {
      final original = TienThueTncn(
        id: '1',
        kyKeToanId: 'ky_2024',
        loaiDoiTuong: 'CHU_HKD',
        tongThuNhap: 120000000,
        thueTncnPhaiNop: 12000000,
        thueTncnDaNop: 0,
      );

      final updated = original.copyWith(
        thueTncnDaNop: 12000000,
        trangThai: 'DA_NOP',
      );

      expect(updated.thueTncnDaNop, 12000000);
      expect(updated.thueTncnConPhaiNop, 0);
      expect(updated.trangThai, 'DA_NOP');
    });
  });
}