// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - MD-05: Quản lý danh mục khách hàng
// ============================================================================

import 'package:sqflite/sqflite.dart';
import 'package:hkd_accounting/features/master_data/data/models/khach_hang_model.dart';

abstract class KhachHangLocalDatasource {
  Future<List<KhachHangModel>> getKhachHangList();
  Future<KhachHangModel?> getKhachHangById(String id);
  Future<String> saveKhachHang(KhachHangModel khachHangModel);
  Future<void> updateKhachHang(KhachHangModel khachHangModel);
  Future<void> deleteKhachHang(String id);
  Future<List<KhachHangModel>> searchKhachHang(String query);
}

class KhachHangLocalDatasourceImpl implements KhachHangLocalDatasource {
  final Database _database;

  KhachHangLocalDatasourceImpl(this._database);

  @override
  Future<List<KhachHangModel>> getKhachHangList() async {
    final List<Map<String, dynamic>> maps = await _database.query('khach_hang');
    return List.generate(maps.length, (i) {
      return KhachHangModel.fromMap(maps[i]);
    });
  }

  @override
  Future<KhachHangModel?> getKhachHangById(String id) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'khach_hang',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return KhachHangModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<String> saveKhachHang(KhachHangModel khachHangModel) async {
    final existing = await getKhachHangById(khachHangModel.id);
    if (existing != null) {
      await updateKhachHang(khachHangModel);
      return existing.id;
    } else {
      final id = await _database.insert(
        'khach_hang',
        khachHangModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id.toString();
    }
  }

  @override
  Future<void> updateKhachHang(KhachHangModel khachHangModel) async {
    await _database.update(
      'khach_hang',
      khachHangModel.toMap(),
      where: 'id = ?',
      whereArgs: [khachHangModel.id],
    );
  }

  @override
  Future<void> deleteKhachHang(String id) async {
    await _database.delete(
      'khach_hang',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<KhachHangModel>> searchKhachHang(String query) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'khach_hang',
      where: 'ma_khach_hang LIKE ? OR ten_khach_hang LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );
    return List.generate(maps.length, (i) {
      return KhachHangModel.fromMap(maps[i]);
    });
  }
}
