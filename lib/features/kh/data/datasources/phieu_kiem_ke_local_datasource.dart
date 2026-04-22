// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - KH-03: Kiểm kê hàng tồn kho
// ============================================================================

import 'package:sqflite/sqflite.dart';
import 'package:hkd_accounting/features/kh/data/models/phieu_kiem_ke_model.dart';

abstract class PhieuKiemKeLocalDatasource {
  Future<List<PhieuKiemKeModel>> getPhieuKiemKeList();
  Future<PhieuKiemKeModel?> getPhieuKiemKeById(String id);
  Future<String> savePhieuKiemKe(PhieuKiemKeModel phieuKiemKeModel);
  Future<void> updatePhieuKiemKe(PhieuKiemKeModel phieuKiemKeModel);
  Future<void> deletePhieuKiemKe(String id);
  Future<List<ChiTietKiemKeModel>> getChiTietByPhieuId(String phieuId);
  Future<void> saveChiTietKiemKe(ChiTietKiemKeModel chiTietKiemKeModel);
  Future<void> updateChiTietKiemKe(ChiTietKiemKeModel chiTietKiemKeModel);
}

class PhieuKiemKeLocalDatasourceImpl implements PhieuKiemKeLocalDatasource {
  final Database _database;

  PhieuKiemKeLocalDatasourceImpl(this._database);

  @override
  Future<List<PhieuKiemKeModel>> getPhieuKiemKeList() async {
    final List<Map<String, dynamic>> maps = await _database.query('phieu_kiem_ke');
    return List.generate(maps.length, (i) {
      return PhieuKiemKeModel.fromMap(maps[i]);
    });
  }

  @override
  Future<PhieuKiemKeModel?> getPhieuKiemKeById(String id) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'phieu_kiem_ke',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return PhieuKiemKeModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<String> savePhieuKiemKe(PhieuKiemKeModel phieuKiemKeModel) async {
    final existing = await getPhieuKiemKeById(phieuKiemKeModel.id);
    if (existing != null) {
      await updatePhieuKiemKe(phieuKiemKeModel);
      return existing.id;
    } else {
      final id = await _database.insert(
        'phieu_kiem_ke',
        phieuKiemKeModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id.toString();
    }
  }

  @override
  Future<void> updatePhieuKiemKe(PhieuKiemKeModel phieuKiemKeModel) async {
    await _database.update(
      'phieu_kiem_ke',
      phieuKiemKeModel.toMap(),
      where: 'id = ?',
      whereArgs: [phieuKiemKeModel.id],
    );
  }

  @override
  Future<void> deletePhieuKiemKe(String id) async {
    await _database.delete(
      'phieu_kiem_ke',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<ChiTietKiemKeModel>> getChiTietByPhieuId(String phieuId) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'chi_tiet_kiem_ke',
      where: 'phieu_kiem_ke_id = ?',
      whereArgs: [phieuId],
    );
    return List.generate(maps.length, (i) {
      return ChiTietKiemKeModel.fromMap(maps[i]);
    });
  }

  @override
  Future<void> saveChiTietKiemKe(ChiTietKiemKeModel chiTietKiemKeModel) async {
    await _database.insert(
      'chi_tiet_kiem_ke',
      chiTietKiemKeModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateChiTietKiemKe(ChiTietKiemKeModel chiTietKiemKeModel) async {
    await _database.update(
      'chi_tiet_kiem_ke',
      chiTietKiemKeModel.toMap(),
      where: 'id = ?',
      whereArgs: [chiTietKiemKeModel.id],
    );
  }
}