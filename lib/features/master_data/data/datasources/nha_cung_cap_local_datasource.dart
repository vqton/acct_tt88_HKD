// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - MD-04
// ============================================================================

import 'package:sqflite/sqflite.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/nha_cung_cap.dart';
import 'package:hkd_accounting/features/master_data/data/models/nha_cung_cap_model.dart';

abstract class NhaCungCapLocalDatasource {
  Future<List<NhaCungCapModel>> getNhaCungCapList();
  Future<NhaCungCapModel?> getNhaCungCapById(String id);
  Future<String> saveNhaCungCap(NhaCungCapModel nhaCungCapModel);
  Future<void> updateNhaCungCap(NhaCungCapModel nhaCungCapModel);
  Future<void> deleteNhaCungCap(String id);
  Future<List<NhaCungCapModel>> searchNhaCungCap(String query);
}

class NhaCungCapLocalDatasourceImpl implements NhaCungCapLocalDatasource {
  final Database _database;

  NhaCungCapLocalDatasourceImpl(this._database);

  @override
  Future<List<NhaCungCapModel>> getNhaCungCapList() async {
    final List<Map<String, dynamic>> maps = await _database.query('nha_cung_cap');
    return List.generate(maps.length, (i) {
      return NhaCungCapModel.fromMap(maps[i]);
    });
  }

  @override
  Future<NhaCungCapModel?> getNhaCungCapById(String id) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'nha_cung_cap',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return NhaCungCapModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<String> saveNhaCungCap(NhaCungCapModel nhaCungCapModel) async {
    final existing = await getNhaCungCapById(nhaCungCapModel.id);
    if (existing != null) {
      await updateNhaCungCap(nhaCungCapModel);
      return existing.id;
    } else {
      final id = await _database.insert(
        'nha_cung_cap',
        nhaCungCapModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id.toString();
    }
  }

  @override
  Future<void> updateNhaCungCap(NhaCungCapModel nhaCungCapModel) async {
    await _database.update(
      'nha_cung_cap',
      nhaCungCapModel.toMap(),
      where: 'id = ?',
      whereArgs: [nhaCungCapModel.id],
    );
  }

  @override
  Future<void> deleteNhaCungCap(String id) async {
    await _database.delete(
      'nha_cung_cap',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<NhaCungCapModel>> searchNhaCungCap(String query) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'nha_cung_cap',
      where: 'ma_nha_cung_cap LIKE ? OR ten_nha_cung_cap LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );
    return List.generate(maps.length, (i) {
      return NhaCungCapModel.fromMap(maps[i]);
    });
  }
}