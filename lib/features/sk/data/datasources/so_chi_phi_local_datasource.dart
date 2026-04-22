// ============================================================================
// Data Layer - SK-04: Sổ chi phí (S3-HKD) - Datasource
// ============================================================================

import 'package:sqflite/sqflite.dart';
import 'package:hkd_accounting/features/sk/data/models/so_chi_phi_model.dart';

abstract class SoChiPhiLocalDatasource {
  Future<List<SoChiPhiModel>> getAll();
  Future<List<SoChiPhiModel>> getByKyKeToan(String kyKeToanId);
  Future<void> save(SoChiPhiModel model);
  Future<void> delete(String id);
}

class SoChiPhiLocalDatasourceImpl implements SoChiPhiLocalDatasource {
  final Database _database;
  SoChiPhiLocalDatasourceImpl(this._database);

  @override
  Future<List<SoChiPhiModel>> getAll() async {
    final maps = await _database.query('so_chi_phi', orderBy: 'ngay_chung_tu DESC');
    return List.generate(maps.length, (i) => SoChiPhiModel.fromMap(maps[i]));
  }

  @override
  Future<List<SoChiPhiModel>> getByKyKeToan(String kyKeToanId) async {
    final maps = await _database.query('so_chi_phi', where: 'ky_ke_toan_id = ?', whereArgs: [kyKeToanId], orderBy: 'ngay_chung_tu DESC');
    return List.generate(maps.length, (i) => SoChiPhiModel.fromMap(maps[i]));
  }

  @override
  Future<void> save(SoChiPhiModel model) async {
    await _database.insert('so_chi_phi', model.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> delete(String id) async {
    await _database.delete('so_chi_phi', where: 'id = ?', whereArgs: [id]);
  }
}