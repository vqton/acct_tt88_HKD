// ============================================================================
// Data Layer - SK-02: Sổ doanh thu (S1-HKD) - Datasource
// ============================================================================

import 'package:sqflite/sqflite.dart';
import 'package:hkd_accounting/features/sk/data/models/so_doanh_thu_model.dart';

abstract class SoDoanhThuLocalDatasource {
  Future<SoDoanhThuModel?> getById(String id);
  Future<List<SoDoanhThuModel>> getAll();
  Future<List<SoDoanhThuModel>> getByKyKeToan(String kyKeToanId);
  Future<void> save(SoDoanhThuModel model);
  Future<void> update(SoDoanhThuModel model);
  Future<void> delete(String id);
}

class SoDoanhThuLocalDatasourceImpl implements SoDoanhThuLocalDatasource {
  final Database _database;

  SoDoanhThuLocalDatasourceImpl(this._database);

  @override
  Future<SoDoanhThuModel?> getById(String id) async {
    final maps = await _database.query('so_doanh_thu', where: 'id = ?', whereArgs: [id], limit: 1);
    return maps.isEmpty ? null : SoDoanhThuModel.fromMap(maps.first);
  }

  @override
  Future<List<SoDoanhThuModel>> getAll() async {
    final maps = await _database.query('so_doanh_thu', orderBy: 'ngay_chung_tu DESC');
    return List.generate(maps.length, (i) => SoDoanhThuModel.fromMap(maps[i]));
  }

  @override
  Future<List<SoDoanhThuModel>> getByKyKeToan(String kyKeToanId) async {
    final maps = await _database.query(
      'so_doanh_thu',
      where: 'ky_ke_toan_id = ?',
      whereArgs: [kyKeToanId],
      orderBy: 'ngay_chung_tu DESC',
    );
    return List.generate(maps.length, (i) => SoDoanhThuModel.fromMap(maps[i]));
  }

  @override
  Future<void> save(SoDoanhThuModel model) async {
    final existing = await getById(model.id);
    if (existing != null) {
      await update(model);
    } else {
      await _database.insert('so_doanh_thu', model.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  @override
  Future<void> update(SoDoanhThuModel model) async {
    await _database.update('so_doanh_thu', model.toMap(), where: 'id = ?', whereArgs: [model.id]);
  }

  @override
  Future<void> delete(String id) async {
    await _database.delete('so_doanh_thu', where: 'id = ?', whereArgs: [id]);
  }
}