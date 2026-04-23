// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - MD-01
// ============================================================================

import 'package:sqflite/sqflite.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/hkd_info.dart';
import 'package:hkd_accounting/features/master_data/data/models/hkd_info_model.dart';

abstract class HkdInfoLocalDatasource {
  Future<HkdInfoModel?> getHkdInfo();
  Future<String> saveHkdInfo(HkdInfoModel hkdInfoModel);
  Future<void> updateHkdInfo(HkdInfoModel hkdInfoModel);
  Future<void> deleteHkdInfo(String id);
}

class HkdInfoLocalDatasourceImpl implements HkdInfoLocalDatasource {
  final Database _database;

  HkdInfoLocalDatasourceImpl(this._database);

  @override
  Future<HkdInfoModel?> getHkdInfo() async {
    final List<Map<String, dynamic>> maps = await _database.query('hkd_info', limit: 1);
    if (maps.isNotEmpty) {
      return HkdInfoModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<String> saveHkdInfo(HkdInfoModel hkdInfoModel) async {
    final existing = await getHkdInfo();
    if (existing != null) {
      await updateHkdInfo(hkdInfoModel);
      return existing.id;
    } else {
      await _database.insert('hkd_info', hkdInfoModel.toMap());
      return hkdInfoModel.id;
    }
  }

  @override
  Future<void> updateHkdInfo(HkdInfoModel hkdInfoModel) async {
    await _database.update(
      'hkd_info',
      hkdInfoModel.toMap(),
      where: 'id = ?',
      whereArgs: [hkdInfoModel.id],
    );
  }

  @override
  Future<void> deleteHkdInfo(String id) async {
    await _database.delete(
      'hkd_info',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}