// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - MD-08: Cấu hình kỳ kế toán
// ============================================================================

import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/ky_ke_toan.dart';
import 'package:hkd_accounting/features/master_data/data/models/ky_ke_toan_model.dart';

abstract class KyKeToanLocalDatasource {
  Future<KyKeToanModel?> getKyKeToan();
  Future<String> saveKyKeToan(KyKeToanModel kyKeToanModel);
  Future<void> updateKyKeToan(KyKeToanModel kyKeToanModel);
  Future<void> deleteKyKeToan(String id);
}

class KyKeToanLocalDatasourceImpl implements KyKeToanLocalDatasource {
  final Database _database;

  KyKeToanLocalDatasourceImpl(this._database);

  @override
  Future<KyKeToanModel?> getKyKeToan() async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'ky_ke_toan',
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return KyKeToanModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<String> saveKyKeToan(KyKeToanModel kyKeToanModel) async {
    // Check if record already exists
    final existing = await getKyKeToan();
    if (existing != null) {
      await updateKyKeToan(kyKeToanModel);
      return existing.id;
    } else {
      final id = await _database.insert(
        'ky_ke_toan',
        kyKeToanModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id.toString();
    }
  }

  @override
  Future<void> updateKyKeToan(KyKeToanModel kyKeToanModel) async {
    await _database.update(
      'ky_ke_toan',
      kyKeToanModel.toMap(),
      where: 'id = ?',
      whereArgs: [kyKeToanModel.id],
    );
  }

  @override
  Future<void> deleteKyKeToan(String id) async {
    await _database.delete(
      'ky_ke_toan',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}