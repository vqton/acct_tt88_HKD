// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - MD-03
// ============================================================================

import 'package:sqflite/sqflite.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/nghe_nghiep.dart';
import 'package:hkd_accounting/features/master_data/data/models/nghe_nghiep_model.dart';

abstract class NgheNghiepLocalDatasource {
  Future<List<NgheNghiepModel>> getNgheNghiepList();
  Future<NgheNghiepModel?> getNgheNghiepById(String id);
  Future<String> saveNgheNghiep(NgheNghiepModel ngheNghieuModel);
  Future<void> updateNgheNghiep(NgheNghiepModel ngheNghieuModel);
  Future<void> deleteNgheNghiep(String id);
  Future<NgheNghiepModel?> getApplicableNgheNghiep(DateTime date);
}

class NgheNghiepLocalDatasourceImpl implements NgheNghiepLocalDatasource {
  final Database _database;

  NgheNghiepLocalDatasourceImpl(this._database);

  @override
  Future<List<NgheNghiepModel>> getNgheNghiepList() async {
    final List<Map<String, dynamic>> maps = await _database.query('nghe_nghiep');
    return List.generate(maps.length, (i) => NgheNghiepModel.fromMap(maps[i]));
  }

  @override
  Future<NgheNghiepModel?> getNgheNghiepById(String id) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'nghe_nghiep',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return NgheNghiepModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<String> saveNgheNghiep(NgheNghiepModel ngheNghieuModel) async {
    await _database.insert(
      'nghe_nghiep',
      ngheNghieuModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return ngheNghieuModel.id;
  }

  @override
  Future<void> updateNgheNghiep(NgheNghiepModel ngheNghieuModel) async {
    await _database.update(
      'nghe_nghiep',
      ngheNghieuModel.toMap(),
      where: 'id = ?',
      whereArgs: [ngheNghieuModel.id],
    );
  }

  @override
  Future<void> deleteNgheNghiep(String id) async {
    await _database.delete(
      'nghe_nghiep',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<NgheNghiepModel?> getApplicableNgheNghiep(DateTime date) async {
    final dateStr = date.toIso8601String();
    final List<Map<String, dynamic>> maps = await _database.query(
      'nghe_nghiep',
      where: 'ngay_hieu_luc <= ? AND (ngay_het_hieu_luc IS NULL OR ngay_het_hieu_luc >= ?)',
      whereArgs: [dateStr, dateStr],
      orderBy: 'ngay_hieu_luc DESC',
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return NgheNghiepModel.fromMap(maps.first);
    }
    return null;
  }
}