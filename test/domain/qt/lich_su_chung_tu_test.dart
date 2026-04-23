import 'package:flutter_test/flutter_test.dart';
import 'package:hkd_accounting/features/qt/domain/entities/lich_su_chung_tu.dart';

void main() {
  group('LichSuChungTu Entity (QT-05)', () {
    test('should return correct label for each loaiChungTu', () {
      expect(
        LichSuChungTu(
          id: '1',
          loaiChungTu: LoaiChungTu.phieuThu,
          soPhieu: 'PT/001',
          ngayLap: DateTime(2024, 3, 15),
          dienGiai: 'Thu tiền hàng',
          soTien: 10000000,
          trangThai: 'DA_DUYET',
          nguoiLap: 'Nguyễn Văn A',
          nguoiDuyet: 'Nguyễn Văn B',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ).loaiChungTuLabel,
        'Phiếu thu',
      );

      expect(
        LichSuChungTu(
          id: '2',
          loaiChungTu: LoaiChungTu.phieuChi,
          soPhieu: 'PC/001',
          ngayLap: DateTime(2024, 3, 15),
          dienGiai: 'Chi tiền hàng',
          soTien: 5000000,
          trangThai: 'DA_DUYET',
          nguoiLap: 'Nguyễn Văn A',
          nguoiDuyet: 'Nguyễn Văn B',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ).loaiChungTuLabel,
        'Phiếu chi',
      );

      expect(
        LichSuChungTu(
          id: '3',
          loaiChungTu: LoaiChungTu.hoaDon,
          soPhieu: 'HD/001',
          ngayLap: DateTime(2024, 3, 15),
          dienGiai: 'Bán hàng',
          soTien: 15000000,
          trangThai: 'DA_DUYET',
          nguoiLap: 'Nguyễn Văn A',
          nguoiDuyet: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ).loaiChungTuLabel,
        'Hóa đơn',
      );
    });

    test('should copyWith correctly', () {
      final original = LichSuChungTu(
        id: '1',
        loaiChungTu: LoaiChungTu.phieuThu,
        soPhieu: 'PT/001',
        ngayLap: DateTime(2024, 3, 15),
        dienGiai: 'Thu tiền hàng',
        soTien: 10000000,
        trangThai: 'CHO_DUYET',
        nguoiLap: 'Nguyễn Văn A',
        nguoiDuyet: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final updated = original.copyWith(
        trangThai: 'DA_DUYET',
        nguoiDuyet: 'Nguyễn Văn B',
      );

      expect(updated.trangThai, 'DA_DUYET');
      expect(updated.nguoiDuyet, 'Nguyễn Văn B');
      expect(updated.soPhieu, original.soPhieu);
    });
  });

  group('LoaiChungTu Enum', () {
    test('should have correct values', () {
      expect(LoaiChungTu.values.length, 5);
      expect(LoaiChungTu.phieuThu.name, 'phieuThu');
      expect(LoaiChungTu.phieuChi.name, 'phieuChi');
      expect(LoaiChungTu.hoaDon.name, 'hoaDon');
      expect(LoaiChungTu.phieuNhapKho.name, 'phieuNhapKho');
      expect(LoaiChungTu.phieuXuatKho.name, 'phieuXuatKho');
    });
  });
}