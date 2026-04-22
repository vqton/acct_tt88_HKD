// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - QT-01: Quản lý tài khoản người dùng & phân quyền
// ============================================================================

import 'package:sqflite/sqflite.dart';
import 'package:hkd_accounting/features/qt/data/models/nguoi_dung_model.dart';

abstract class NguoiDungLocalDatasource {
  Future<List<NguoiDungModel>> getNguoiDungList();
  Future<NguoiDungModel?> getNguoiDungById(String id);
  Future<NguoiDungModel?> getNguoiDungByEmail(String email);
  Future<String> saveNguoiDung(NguoiDungModel nguoiDungModel);
  Future<void> updateNguoiDung(NguoiDungModel nguoiDungModel);
  Future<void> deleteNguoiDung(String id);
  Future<List<NguoiDungModel>> searchNguoiDung(String query);
  Future<NguoiDungModel?> login(String email, String password);
}

class NguoiDungLocalDatasourceImpl implements NguoiDungLocalDatasource {
  final Database _database;

  NguoiDungLocalDatasourceImpl(this._database);

  @override
  Future<List<NguoiDungModel>> getNguoiDungList() async {
    final List<Map<String, dynamic>> maps = await _database.query('nguoi_dung');
    return List.generate(maps.length, (i) {
      return NguoiDungModel.fromMap(maps[i]);
    });
  }

  @override
  Future<NguoiDungModel?> getNguoiDungById(String id) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'nguoi_dung',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return NguoiDungModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<NguoiDungModel?> getNguoiDungByEmail(String email) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'nguoi_dung',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return NguoiDungModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<String> saveNguoiDung(NguoiDungModel nguoiDungModel) async {
    final existing = await getNguoiDungById(nguoiDungModel.id);
    if (existing != null) {
      await updateNguoiDung(nguoiDungModel);
      return existing.id;
    } else {
      final id = await _database.insert(
        'nguoi_dung',
        nguoiDungModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id.toString();
    }
  }

  @override
  Future<void> updateNguoiDung(NguoiDungModel nguoiDungModel) async {
    await _database.update(
      'nguoi_dung',
      nguoiDungModel.toMap(),
      where: 'id = ?',
      whereArgs: [nguoiDungModel.id],
    );
  }

  @override
  Future<void> deleteNguoiDung(String id) async {
    await _database.delete(
      'nguoi_dung',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<NguoiDungModel>> searchNguoiDung(String query) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'nguoi_dung',
      where: 'ma_nguoi_dung LIKE ? OR ho_ten LIKE ? OR email LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
    );
    return List.generate(maps.length, (i) {
      return NguoiDungModel.fromMap(maps[i]);
    });
  }

  @override
  Future<NguoiDungModel?> login(String email, String password) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'nguoi_dung',
      where: 'email = ? AND mat_khau_hash = ? AND trang_thai = ?',
      whereArgs: [email, password, 'HOAT_DONG'],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return NguoiDungModel.fromMap(maps.first);
    }
    return null;
  }
}