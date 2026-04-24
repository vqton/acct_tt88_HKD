// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - QT-05: Lưu trữ và tra cứu lịch sử chứng từ
// ============================================================================

import 'package:sqflite/sqflite.dart';
import 'package:hkd_accounting/features/qt/domain/entities/lich_su_chung_tu.dart';

class LichSuChungTuLocalDatasource {
  final Database db;

  LichSuChungTuLocalDatasource(this.db);

  Future<List<LichSuChungTu>> search({
    String? query,
    LoaiChungTu? loaiChungTu,
    DateTime? tuNgay,
    DateTime? denNgay,
    String? trangThai,
  }) async {
    final results = <LichSuChungTu>[];
    final now = DateTime.now();

    final phieuThuList = await _searchPhieuThu(query, tuNgay, denNgay, trangThai);
    results.addAll(phieuThuList);

    final phieuChiList = await _searchPhieuChi(query, tuNgay, denNgay, trangThai);
    results.addAll(phieuChiList);

    final hoaDonList = await _searchHoaDon(query, tuNgay, denNgay, trangThai);
    results.addAll(hoaDonList);

    final phieuNhapKhoList = await _searchPhieuNhapKho(query, tuNgay, denNgay, trangThai);
    results.addAll(phieuNhapKhoList);

    final phieuXuatKhoList = await _searchPhieuXuatKho(query, tuNgay, denNgay, trangThai);
    results.addAll(phieuXuatKhoList);

    results.sort((a, b) => b.ngayLap.compareTo(a.ngayLap));

    return results;
  }

  Future<List<LichSuChungTu>> _searchPhieuThu(
    String? query,
    DateTime? tuNgay,
    DateTime? denNgay,
    String? trangThai,
  ) async {
    final conditions = <String>[];
    final args = <dynamic>[];
    final now = DateTime.now();

    conditions.add('1=1');
    if (query != null && query.isNotEmpty) {
      conditions.add('(so_phieu LIKE ? OR dien_giai LIKE ?)');
      args.add('%$query%');
      args.add('%$query%');
    }
    if (tuNgay != null) {
      conditions.add('ngay_lap >= ?');
      args.add(tuNgay.toIso8601String());
    }
    if (denNgay != null) {
      conditions.add('ngay_lap <= ?');
      args.add(denNgay.toIso8601String());
    }
    if (trangThai != null && trangThai.isNotEmpty) {
      conditions.add('trang_thai = ?');
      args.add(trangThai);
    }

    final sql = '''
      SELECT * FROM phieu_thu 
      WHERE ${conditions.join(' AND ')} 
      ORDER BY ngay_lap DESC
    ''';

    final rows = await db.rawQuery(sql, args);
    return rows.map((row) => LichSuChungTu(
      id: row['id'] as String,
      loaiChungTu: LoaiChungTu.phieuThu,
      soPhieu: row['so_phieu'] as String? ?? '',
      ngayLap: DateTime.parse(row['ngay_lap'] as String),
      dienGiai: row['ly_do_nop'] as String? ?? '',
      soTien: row['so_tien'] as int? ?? 0,
      trangThai: row['trang_thai'] as String? ?? '',
      nguoiLap: row['nguoi_nop'] as String? ?? '',
      nguoiDuyet: '',
      createdAt: row['created_at'] != null
          ? DateTime.parse(row['created_at'] as String)
          : now,
      updatedAt: row['updated_at'] != null
          ? DateTime.parse(row['updated_at'] as String)
          : now,
    )).toList();
  }

  Future<List<LichSuChungTu>> _searchPhieuChi(
    String? query,
    DateTime? tuNgay,
    DateTime? denNgay,
    String? trangThai,
  ) async {
    final conditions = <String>[];
    final args = <dynamic>[];
    final now = DateTime.now();

    conditions.add('1=1');
    if (query != null && query.isNotEmpty) {
      conditions.add('(so_phieu LIKE ? OR dien_giai LIKE ?)');
      args.add('%$query%');
      args.add('%$query%');
    }
    if (tuNgay != null) {
      conditions.add('ngay_lap >= ?');
      args.add(tuNgay.toIso8601String());
    }
    if (denNgay != null) {
      conditions.add('ngay_lap <= ?');
      args.add(denNgay.toIso8601String());
    }
    if (trangThai != null && trangThai.isNotEmpty) {
      conditions.add('trang_thai = ?');
      args.add(trangThai);
    }

    final sql = '''
      SELECT * FROM phieu_chi 
      WHERE ${conditions.join(' AND ')} 
      ORDER BY ngay_lap DESC
    ''';

    final rows = await db.rawQuery(sql, args);
    return rows.map((row) => LichSuChungTu(
      id: row['id'] as String,
      loaiChungTu: LoaiChungTu.phieuChi,
      soPhieu: row['so_phieu'] as String? ?? '',
      ngayLap: DateTime.parse(row['ngay_lap'] as String),
      dienGiai: row['ly_do_chi'] as String? ?? '',
      soTien: row['so_tien'] as int? ?? 0,
      trangThai: row['trang_thai'] as String? ?? '',
      nguoiLap: row['nguoi_nhan'] as String? ?? '',
      nguoiDuyet: '',
      createdAt: row['created_at'] != null
          ? DateTime.parse(row['created_at'] as String)
          : now,
      updatedAt: row['updated_at'] != null
          ? DateTime.parse(row['updated_at'] as String)
          : now,
    )).toList();
  }

  Future<List<LichSuChungTu>> _searchHoaDon(
    String? query,
    DateTime? tuNgay,
    DateTime? denNgay,
    String? trangThai,
  ) async {
    final conditions = <String>[];
    final args = <dynamic>[];
    final now = DateTime.now();

    conditions.add('1=1');
    if (query != null && query.isNotEmpty) {
      conditions.add('(so_hoa_don LIKE ? OR dien_giai LIKE ?)');
      args.add('%$query%');
      args.add('%$query%');
    }
    if (tuNgay != null) {
      conditions.add('ngay_lap >= ?');
      args.add(tuNgay.toIso8601String());
    }
    if (denNgay != null) {
      conditions.add('ngay_lap <= ?');
      args.add(denNgay.toIso8601String());
    }
    if (trangThai != null && trangThai.isNotEmpty) {
      conditions.add('trang_thai = ?');
      args.add(trangThai);
    }

    final sql = '''
      SELECT * FROM hoa_don 
      WHERE ${conditions.join(' AND ')} 
      ORDER BY ngay_lap DESC
    ''';

    final rows = await db.rawQuery(sql, args);
    return rows.map((row) => LichSuChungTu(
      id: row['id'] as String,
      loaiChungTu: LoaiChungTu.hoaDon,
      soPhieu: row['so_hoa_don'] as String? ?? '',
      ngayLap: DateTime.parse(row['ngay_lap'] as String),
      dienGiai: row['dien_giai'] as String? ?? '',
      soTien: row['tong_tien'] as int? ?? 0,
      trangThai: row['trang_thai'] as String? ?? '',
      nguoiLap: '',
      nguoiDuyet: '',
      createdAt: row['created_at'] != null
          ? DateTime.parse(row['created_at'] as String)
          : now,
      updatedAt: row['updated_at'] != null
          ? DateTime.parse(row['updated_at'] as String)
          : now,
    )).toList();
  }

  Future<List<LichSuChungTu>> _searchPhieuNhapKho(
    String? query,
    DateTime? tuNgay,
    DateTime? denNgay,
    String? trangThai,
  ) async {
    final conditions = <String>[];
    final args = <dynamic>[];
    final now = DateTime.now();

    conditions.add('1=1');
    if (query != null && query.isNotEmpty) {
      conditions.add('(so_phieu LIKE ? OR dien_giai LIKE ?)');
      args.add('%$query%');
      args.add('%$query%');
    }
    if (tuNgay != null) {
      conditions.add('ngay_lap >= ?');
      args.add(tuNgay.toIso8601String());
    }
    if (denNgay != null) {
      conditions.add('ngay_lap <= ?');
      args.add(denNgay.toIso8601String());
    }
    if (trangThai != null && trangThai.isNotEmpty) {
      conditions.add('trang_thai = ?');
      args.add(trangThai);
    }

    final sql = '''
      SELECT * FROM phieu_nhap_kho 
      WHERE ${conditions.join(' AND ')} 
      ORDER BY ngay_lap DESC
    ''';

    final rows = await db.rawQuery(sql, args);
    return rows.map((row) => LichSuChungTu(
      id: row['id'] as String,
      loaiChungTu: LoaiChungTu.phieuNhapKho,
      soPhieu: row['so_phieu'] as String? ?? '',
      ngayLap: DateTime.parse(row['ngay_lap'] as String),
      dienGiai: row['dien_giai'] as String? ?? '',
      soTien: row['tong_tien'] as int? ?? 0,
      trangThai: row['trang_thai'] as String? ?? '',
      nguoiLap: row['nguoi_lap'] as String? ?? '',
      nguoiDuyet: '',
      createdAt: row['created_at'] != null
          ? DateTime.parse(row['created_at'] as String)
          : now,
      updatedAt: row['updated_at'] != null
          ? DateTime.parse(row['updated_at'] as String)
          : now,
    )).toList();
  }

  Future<List<LichSuChungTu>> _searchPhieuXuatKho(
    String? query,
    DateTime? tuNgay,
    DateTime? denNgay,
    String? trangThai,
  ) async {
    final conditions = <String>[];
    final args = <dynamic>[];
    final now = DateTime.now();

    conditions.add('1=1');
    if (query != null && query.isNotEmpty) {
      conditions.add('(so_phieu LIKE ? OR dien_giai LIKE ?)');
      args.add('%$query%');
      args.add('%$query%');
    }
    if (tuNgay != null) {
      conditions.add('ngay_lap >= ?');
      args.add(tuNgay.toIso8601String());
    }
    if (denNgay != null) {
      conditions.add('ngay_lap <= ?');
      args.add(denNgay.toIso8601String());
    }
    if (trangThai != null && trangThai.isNotEmpty) {
      conditions.add('trang_thai = ?');
      args.add(trangThai);
    }

    final sql = '''
      SELECT * FROM phieu_xuat_kho 
      WHERE ${conditions.join(' AND ')} 
      ORDER BY ngay_lap DESC
    ''';

    final rows = await db.rawQuery(sql, args);
    return rows.map((row) => LichSuChungTu(
      id: row['id'] as String,
      loaiChungTu: LoaiChungTu.phieuXuatKho,
      soPhieu: row['so_phieu'] as String? ?? '',
      ngayLap: DateTime.parse(row['ngay_lap'] as String),
      dienGiai: row['dien_giai'] as String? ?? '',
      soTien: row['tong_tien'] as int? ?? 0,
      trangThai: row['trang_thai'] as String? ?? '',
      nguoiLap: row['nguoi_lap'] as String? ?? '',
      nguoiDuyet: '',
      createdAt: row['created_at'] != null
          ? DateTime.parse(row['created_at'] as String)
          : now,
      updatedAt: row['updated_at'] != null
          ? DateTime.parse(row['updated_at'] as String)
          : now,
    )).toList();
  }
}