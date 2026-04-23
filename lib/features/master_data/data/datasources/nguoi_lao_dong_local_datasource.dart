// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - MD-06
// ============================================================================

import 'package:sqflite/sqflite.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/nguoi_lao_dong.dart';
import 'package:hkd_accounting/features/master_data/data/models/nguoi_lao_dong_model.dart';

abstract class NguoiLaoDongLocalDatasource {
  Future<List<NguoiLaoDongModel>> getNguoiLaoDongList();
  Future<NguoiLaoDongModel?> getNguoiLaoDongById(String id);
  Future<String> saveNguoiLaoDong(NguoiLaoDongModel nguoiLaoDongModel);
  Future<void> updateNguoiLaoDong(NguoiLaoDongModel nguoiLaoDongModel);
  Future<void> deleteNguoiLaoDong(String id);
  Future<List<NguoiLaoDongModel>> searchNguoiLaoDong(String query);
}

class NguoiLaoDongLocalDatasourceImpl implements NguoiLaoDongLocalDatasource {
  final Database _database;

  NguoiLaoDongLocalDatasourceImpl(this._database);

  @override
  Future<List<NguoiLaoDongModel>> getNguoiLaoDongList() async {
    final List<Map<String, dynamic>> maps = await _database.query('nguoi_lao_dong');
    return List.generate(maps.length, (i) {
      return NguoiLaoDongModel.fromMap(maps[i]);
    });
  }

  @override
  Future<NguoiLaoDongModel?> getNguoiLaoDongById(String id) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'nguoi_lao_dong',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return NguoiLaoDongModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<String> saveNguoiLaoDong(NguoiLaoDongModel nguoiLaoDongModel) async {
    final existing = await getNguoiLaoDongById(nguoiLaoDongModel.id);
    if (existing != null) {
      await updateNguoiLaoDong(nguoiLaoDongModel);
      return existing.id;
    } else {
      final id = await _database.insert(
        'nguoi_lao_dong',
        nguoiLaoDongModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id.toString();
    }
  }

  @override
  Future<void> updateNguoiLaoDong(NguoiLaoDongModel nguoiLaoDongModel) async {
    await _database.update(
      'nguoi_lao_dong',
      nguoiLaoDongModel.toMap(),
      where: 'id = ?',
      whereArgs: [nguoiLaoDongModel.id],
    );
  }

  @override
  Future<void> deleteNguoiLaoDong(String id) async {
    await _database.delete(
      'nguoi_lao_dong',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<NguoiLaoDongModel>> searchNguoiLaoDong(String query) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'nguoi_lao_dong',
      where: 'ma_nguoi_lao_dong LIKE ? OR ho_ten LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );
    return List.generate(maps.length, (i) {
      return NguoiLaoDongModel.fromMap(maps[i]);
    });
  }
}