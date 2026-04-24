// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - TT-02
// ============================================================================

import 'package:sqflite/sqflite.dart';
import 'package:hkd_accounting/features/tt/domain/entities/tien_gui_ngan_hang.dart';
import 'package:hkd_accounting/features/tt/data/models/tien_gui_ngan_hang_model.dart';

abstract class TienGuiNganHangLocalDatasource {
  Future<List<TienGuiNganHangModel>> getTienGuiNganHangList();
  Future<TienGuiNganHangModel?> getTienGuiNganHangById(String id);
  Future<String> saveTienGuiNganHang(TienGuiNganHangModel tienGuiNganHangModel);
  Future<void> updateTienGuiNganHang(TienGuiNganHangModel tienGuiNganHangModel);
  Future<void> deleteTienGuiNganHang(String id);
  Future<List<TienGuiNganHangModel>> searchTienGuiNganHang(String query);
}

class TienGuiNganHangLocalDatasourceImpl implements TienGuiNganHangLocalDatasource {
  final Database _database;

  TienGuiNganHangLocalDatasourceImpl(this._database);

  @override
  Future<List<TienGuiNganHangModel>> getTienGuiNganHangList() async {
    final List<Map<String, dynamic>> maps = await _database.query('tien_gui_ngan_hang');
    return List.generate(maps.length, (i) {
      return TienGuiNganHangModel.fromMap(maps[i]);
    });
  }

  @override
  Future<TienGuiNganHangModel?> getTienGuiNganHangById(String id) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'tien_gui_ngan_hang',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return TienGuiNganHangModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<String> saveTienGuiNganHang(TienGuiNganHangModel tienGuiNganHangModel) async {
    // Check if record already exists
    final existing = await getTienGuiNganHangById(tienGuiNganHangModel.id);
    if (existing != null) {
      await updateTienGuiNganHang(tienGuiNganHangModel);
      return existing.id;
    } else {
      final id = await _database.insert(
        'tien_gui_ngan_hang',
        tienGuiNganHangModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id.toString();
    }
  }

  @override
  Future<void> updateTienGuiNganHang(TienGuiNganHangModel tienGuiNganHangModel) async {
    await _database.update(
      'tien_gui_ngan_hang',
      tienGuiNganHangModel.toMap(),
      where: 'id = ?',
      whereArgs: [tienGuiNganHangModel.id],
    );
  }

  @override
  Future<void> deleteTienGuiNganHang(String id) async {
    await _database.delete(
      'tien_gui_ngan_hang',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<TienGuiNganHangModel>> searchTienGuiNganHang(String query) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'tien_gui_ngan_hang',
      where: 'ma_tai_khoan LIKE ? OR ten_tai_khoan LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );
    return List.generate(maps.length, (i) {
      return TienGuiNganHangModel.fromMap(maps[i]);
    });
  }
}