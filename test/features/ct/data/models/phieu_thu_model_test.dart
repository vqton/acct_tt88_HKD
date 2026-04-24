// ============================================================================
// Data Layer - Model Tests
// Based on UC_HKD_TT88_2021 - CT-01: Lập phiếu thu
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_thu.dart';
import 'package:hkd_accounting/features/ct/data/models/phieu_thu_model.dart';

void main() {
  group('PhieuThuModel', () {
    test('should create PhieuThuModel with required fields', () {
      final model = PhieuThuModel(
        id: '1',
        soPhieu: 'PT-001',
        ngayLap: DateTime(2024, 1, 15),
        nguoiNop: 'Nguyễn Văn A',
        diaChiNguoiNop: '123 Đường ABC',
        lyDoNop: 'Thu bán hàng',
        soTien: 1000000,
        soTienBangChu: 'Một triệu đồng',
        chungTuGocKemTheo: 'Hóa đơn số 001',
        hkdInfoId: 'hkd-1',
        khachHangId: 'kh-1',
        kyKeToanId: 'ky-1',
        trangThai: 'CHO_DUYET',
      );

      expect(model.id, '1');
      expect(model.soPhieu, 'PT-001');
      expect(model.ngayLap, DateTime(2024, 1, 15));
      expect(model.soTien, 1000000);
    });

    test('should convert from Entity correctly', () {
      final entity = PhieuThu(
        id: '1',
        soPhieu: 'PT-001',
        ngayLap: DateTime(2024, 1, 15),
        nguoiNop: 'Nguyễn Văn A',
        diaChiNguoiNop: '123 Đường ABC',
        lyDoNop: 'Thu bán hàng',
        soTien: 1000000,
        soTienBangChu: 'Một triệu đồng',
        chungTuGocKemTheo: 'Hóa đơn số 001',
        hkdInfoId: 'hkd-1',
        khachHangId: 'kh-1',
        kyKeToanId: 'ky-1',
        trangThai: 'DA_DUYET',
      );

      final model = PhieuThuModel.fromEntity(entity);

      expect(model.id, entity.id);
      expect(model.soPhieu, entity.soPhieu);
      expect(model.soTien, entity.soTien);
      expect(model.trangThai, 'DA_DUYET');
    });

    test('should convert to Entity correctly', () {
      final model = PhieuThuModel(
        id: '1',
        soPhieu: 'PT-001',
        ngayLap: DateTime(2024, 1, 15),
        nguoiNop: 'Nguyễn Văn A',
        diaChiNguoiNop: '123 Đường ABC',
        lyDoNop: 'Thu bán hàng',
        soTien: 1000000,
        soTienBangChu: 'Một triệu đồng',
        chungTuGocKemTheo: 'Hóa đơn số 001',
        hkdInfoId: 'hkd-1',
        khachHangId: 'kh-1',
        kyKeToanId: 'ky-1',
        trangThai: 'DA_DUYET',
      );

      final entity = model.toEntity();

      expect(entity.id, model.id);
      expect(entity.soPhieu, model.soPhieu);
      expect(entity.soTien, model.soTien);
    });

    test('should serialize to Map correctly', () {
      final model = PhieuThuModel(
        id: '1',
        soPhieu: 'PT-001',
        ngayLap: DateTime(2024, 1, 15),
        nguoiNop: 'Nguyễn Văn A',
        diaChiNguoiNop: '123 Đường ABC',
        lyDoNop: 'Thu bán hàng',
        soTien: 1000000,
        soTienBangChu: 'Một triệu đồng',
        chungTuGocKemTheo: 'Hóa đơn số 001',
        hkdInfoId: 'hkd-1',
        khachHangId: 'kh-1',
        kyKeToanId: 'ky-1',
        trangThai: 'CHO_DUYET',
      );

      final map = model.toMap();

      expect(map['id'], '1');
      expect(map['so_phieu'], 'PT-001');
      expect(map['so_tien'], 1000000);
      expect(map['trang_thai'], 'CHO_DUYET');
    });

    test('should deserialize from Map correctly', () {
      final map = {
        'id': '1',
        'so_phieu': 'PT-001',
        'ngay_lap': '2024-01-15T00:00:00.000',
        'nguoi_nop': 'Nguyễn Văn A',
        'dia_chi_nguoi_nop': '123 Đường ABC',
        'ly_do_nop': 'Thu bán hàng',
        'so_tien': 1000000,
        'so_tien_bang_chu': 'Một triệu đồng',
        'chung_tu_goc_kem_theo': 'Hóa đơn số 001',
        'hkd_info_id': 'hkd-1',
        'khach_hang_id': 'kh-1',
        'ky_ke_toan_id': 'ky-1',
        'trang_thai': 'CHO_DUYET',
        'created_at': null,
        'updated_at': null,
      };

      final model = PhieuThuModel.fromMap(map);

      expect(model.id, '1');
      expect(model.soPhieu, 'PT-001');
      expect(model.soTien, 1000000);
    });
  });
}