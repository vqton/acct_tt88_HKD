// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - CT-01: Lập phiếu thu
// ============================================================================

import 'package:sqflite/sqflite.dart';
import 'package:hkd_accounting/features/ct/data/models/phieu_thu_model.dart';

abstract class PhieuThuLocalDatasource {
  Future<String> createPhieuThu(PhieuThuModel phieuThuModel);
  Future<PhieuThuModel?> getPhieuThuById(String id);
  Future<List<PhieuThuModel>> getPhieuThuList();
  Future<void> updatePhieuThu(PhieuThuModel phieuThuModel);
  Future<void> deletePhieuThu(String id);
}

class PhieuThuLocalDatasourceImpl implements PhieuThuLocalDatasource {
  final Database _database;

  PhieuThuLocalDatasourceImpl(this._database);

  @override
  Future<String> createPhieuThu(PhieuThuModel phieuThuModel) async {
    final existing = await getPhieuThuById(phieuThuModel.id);
    if (existing != null) {
      await updatePhieuThu(phieuThuModel);
      return existing.id;
    } else {
      final id = await _database.insert(
        'phieu_thu',
        phieuThuModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id.toString();
    }
  }

  @override
  Future<PhieuThuModel?> getPhieuThuById(String id) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'phieu_thu',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return PhieuThuModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<List<PhieuThuModel>> getPhieuThuList() async {
    final List<Map<String, dynamic>> maps = await _database.query('phieu_thu');
    return List.generate(maps.length, (i) => PhieuThuModel.fromMap(maps[i]));
  }

  @override
  Future<void> updatePhieuThu(PhieuThuModel phieuThuModel) async {
    await _database.update(
      'phieu_thu',
      phieuThuModel.toMap(),
      where: 'id = ?',
      whereArgs: [phieuThuModel.id],
    );
  }

  @override
  Future<void> deletePhieuThu(String id) async {
    await _database.delete(
      'phieu_thu',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}