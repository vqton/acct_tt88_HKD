// ============================================================================
// Data Layer - Local Datasource Implementation
// Based on UC_HKD_TT88_2021 - SK-06: Ghi sổ theo dõi thanh toán tiền lương (S5-HKD)
// ============================================================================

import 'package:sqflite/sqflite.dart';
import 'package:hkd_accounting/features/sk/data/models/so_theo_doi_tien_luong_model.dart';
import 'package:hkd_accounting/features/sk/data/datasources/so_theo_doi_tien_luong_local_datasource.dart';

class SoTheoDoiTienLuongLocalDatasourceImpl implements SoTheoDoiTienLuongLocalDatasource {
  final Database database;

  SoTheoDoiTienLuongLocalDatasourceImpl(this.database);

  @override
  Future<String> save(SoTheoDoiTienLuongModel model) async {
    await database.insert('so_theo_doi_tien_luong', model.toMap());
    return model.id;
  }

  @override
  Future<SoTheoDoiTienLuongModel?> getById(String id) async {
    final result = await database.query(
      'so_theo_doi_tien_luong',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isEmpty) return null;
    return SoTheoDoiTienLuongModel.fromMap(result.first);
  }

  @override
  Future<List<SoTheoDoiTienLuongModel>> getList() async {
    final result = await database.query('so_theo_doi_tien_luong', orderBy: 'ngay_lap DESC');
    return result.map((e) => SoTheoDoiTienLuongModel.fromMap(e)).toList();
  }

  @override
  Future<List<SoTheoDoiTienLuongModel>> getByKyKeToanId(String kyKeToanId) async {
    final result = await database.query(
      'so_theo_doi_tien_luong',
      where: 'ky_ke_toan_id = ?',
      whereArgs: [kyKeToanId],
      orderBy: 'ngay_lap DESC',
    );
    return result.map((e) => SoTheoDoiTienLuongModel.fromMap(e)).toList();
  }

  @override
  Future<List<SoTheoDoiTienLuongModel>> getByBangLuongId(String bangLuongId) async {
    final result = await database.query(
      'so_theo_doi_tien_luong',
      where: 'bang_luong_id = ?',
      whereArgs: [bangLuongId],
    );
    return result.map((e) => SoTheoDoiTienLuongModel.fromMap(e)).toList();
  }

  @override
  Future<void> update(SoTheoDoiTienLuongModel model) async {
    await database.update(
      'so_theo_doi_tien_luong',
      model.toMap(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  @override
  Future<void> delete(String id) async {
    await database.delete(
      'so_theo_doi_tien_luong',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> updateThanhToan(String id, double soTien) async {
    final record = await getById(id);
    if (record != null) {
      final newDaTra = record.daTraLuong + soTien;
      final newConPhai = record.phaiTraLuong - newDaTra;
      await database.update(
        'so_theo_doi_tien_luong',
        {
          'da_tra_luong': newDaTra,
          'con_phai_tra_luong': newConPhai,
          'updated_at': DateTime.now().toIso8601String(),
        },
        where: 'id = ?',
        whereArgs: [id],
      );
    }
  }

  @override
  Future<void> updateBhxhNop(String id, double bhxhDaNop, double bhytDaNop, double bhtnDaNop) async {
    final record = await getById(id);
    if (record != null) {
      final newBhxhCon = record.bhxhPhaiNop - bhxhDaNop;
      final newBhytCon = record.bhytPhaiNop - bhytDaNop;
      final newBhtnCon = record.bhtnPhaiNop - bhtnDaNop;
      await database.update(
        'so_theo_doi_tien_luong',
        {
          'bhxh_da_nop': bhxhDaNop,
          'bhyt_da_nop': bhytDaNop,
          'bhtn_da_nop': bhtnDaNop,
          'bhxh_con_phai_nop': newBhxhCon,
          'bhyt_con_phai_nop': newBhytCon,
          'bhtn_con_phai_nop': newBhtnCon,
          'updated_at': DateTime.now().toIso8601String(),
        },
        where: 'id = ?',
        whereArgs: [id],
      );
    }
  }
}