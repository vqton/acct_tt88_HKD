// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - TX-04: Sổ thuế
// ============================================================================
import 'package:sqflite/sqflite.dart';
import 'package:hkd_accounting/features/tx/domain/entities/so_thue.dart';

abstract class SoThueLocalDatasource {
  Future<List<Map<String, dynamic>>> getByKyKeToan(String kyKeToanId);
  Future<List<Map<String, dynamic>>> getAll();
  Future<void> save(Map<String, dynamic> row);
  Future<void> update(Map<String, dynamic> row);
  Future<void> delete(String id);
}

class SoThueLocalDatasourceImpl implements SoThueLocalDatasource {
  final Database _db;

  SoThueLocalDatasourceImpl(this._db);

  @override
  Future<List<Map<String, dynamic>>> getByKyKeToan(String kyKeToanId) async {
    return _db.query(
      'so_thue',
      where: 'ky_ke_toan_id = ?',
      whereArgs: [kyKeToanId],
      orderBy: 'ngay_chung_tu DESC',
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getAll() async {
    return _db.query('so_thue', orderBy: 'ngay_chung_tu DESC');
  }

  @override
  Future<void> save(Map<String, dynamic> row) async {
    await _db.insert('so_thue', row, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> update(Map<String, dynamic> row) async {
    await _db.update('so_thue', row, where: 'id = ?', whereArgs: [row['id']]);
  }

  @override
  Future<void> delete(String id) async {
    await _db.delete('so_thue', where: 'id = ?', whereArgs: [id]);
  }
}