// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - MD-07
// ============================================================================

import 'package:sqflite/sqflite.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/tai_khoan_ngan_hang.dart';
import 'package:hkd_accounting/features/master_data/data/models/tai_khoan_ngan_hang_model.dart';

abstract class TaiKhoanNganHangLocalDatasource {
  Future<List<TaiKhoanNganHangModel>> getTaiKhoanNganHangList();
  Future<TaiKhoanNganHangModel?> getTaiKhoanNganHangById(String id);
  Future<String> saveTaiKhoanNganHang(TaiKhoanNganHangModel taiKhoanNganHangModel);
  Future<void> updateTaiKhoanNganHang(TaiKhoanNganHangModel taiKhoanNganHangModel);
  Future<void> deleteTaiKhoanNganHang(String id);
  Future<List<TaiKhoanNganHangModel>> searchTaiKhoanNganHang(String query);
}

class TaiKhoanNganHangLocalDatasourceImpl implements TaiKhoanNganHangLocalDatasource {
  final Database _database;

  TaiKhoanNganHangLocalDatasourceImpl(this._database);

  @override
  Future<List<TaiKhoanNganHangModel>> getTaiKhoanNganHangList() async {
    final List<Map<String, dynamic>> maps = await _database.query('tai_khoan_ngan_hang');
    return List.generate(maps.length, (i) {
      return TaiKhoanNganHangModel.fromMap(maps[i]);
    });
  }

  @override
  Future<TaiKhoanNganHangModel?> getTaiKhoanNganHangById(String id) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'tai_khoan_ngan_hang',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return TaiKhoanNganHangModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<String> saveTaiKhoanNganHang(TaiKhoanNganHangModel taiKhoanNganHangModel) async {
    final existing = await getTaiKhoanNganHangById(taiKhoanNganHangModel.id);
    if (existing != null) {
      await updateTaiKhoanNganHang(taiKhoanNganHangModel);
      return existing.id;
    } else {
      final id = await _database.insert(
        'tai_khoan_ngan_hang',
        taiKhoanNganHangModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id.toString();
    }
  }

  @override
  Future<void> updateTaiKhoanNganHang(TaiKhoanNganHangModel taiKhoanNganHangModel) async {
    await _database.update(
      'tai_khoan_ngan_hang',
      taiKhoanNganHangModel.toMap(),
      where: 'id = ?',
      whereArgs: [taiKhoanNganHangModel.id],
    );
  }

  @override
  Future<void> deleteTaiKhoanNganHang(String id) async {
    await _database.delete(
      'tai_khoan_ngan_hang',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<TaiKhoanNganHangModel>> searchTaiKhoanNganHang(String query) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'tai_khoan_ngan_hang',
      where: 'ma_tai_khoan LIKE ? OR ten_tai_khoan LIKE ? OR ten_ngan_hang LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
    );
    return List.generate(maps.length, (i) {
      return TaiKhoanNganHangModel.fromMap(maps[i]);
    });
  }
}