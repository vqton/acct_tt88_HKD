// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - CT-02: Lập phiếu chi
// ============================================================================

import 'package:sqflite/sqflite.dart';
import 'package:hkd_accounting/features/ct/data/models/phieu_chi_model.dart';

abstract class PhieuChiLocalDatasource {
  Future<PhieuChiModel?> getPhieuChiById(String id);
  Future<List<PhieuChiModel>> getPhieuChiList();
  Future<String> savePhieuChi(PhieuChiModel phieuChiModel);
  Future<void> updatePhieuChi(PhieuChiModel phieuChiModel);
  Future<void> deletePhieuChi(String id);
  Future<List<PhieuChiModel>> searchPhieuChi(String query);
}

class PhieuChiLocalDatasourceImpl implements PhieuChiLocalDatasource {
  final Database _database;

  PhieuChiLocalDatasourceImpl(this._database);

  @override
  Future<PhieuChiModel?> getPhieuChiById(String id) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'phieu_chi',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return PhieuChiModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<List<PhieuChiModel>> getPhieuChiList() async {
    final List<Map<String, dynamic>> maps = await _database.query('phieu_chi');
    return List.generate(maps.length, (i) => PhieuChiModel.fromMap(maps[i]));
  }

  @override
  Future<String> savePhieuChi(PhieuChiModel phieuChiModel) async {
    final existing = await getPhieuChiById(phieuChiModel.id);
    if (existing != null) {
      await updatePhieuChi(phieuChiModel);
      return existing.id;
    } else {
      final id = await _database.insert(
        'phieu_chi',
        phieuChiModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id.toString();
    }
  }

  @override
  Future<void> updatePhieuChi(PhieuChiModel phieuChiModel) async {
    await _database.update(
      'phieu_chi',
      phieuChiModel.toMap(),
      where: 'id = ?',
      whereArgs: [phieuChiModel.id],
    );
  }

  @override
  Future<void> deletePhieuChi(String id) async {
    await _database.delete(
      'phieu_chi',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<PhieuChiModel>> searchPhieuChi(String query) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'phieu_chi',
      where: 'so_phieu LIKE ? OR nguoi_nop LIKE ? OR ly_do_nop LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
    );
    return List.generate(maps.length, (i) => PhieuChiModel.fromMap(maps[i]));
  }
}