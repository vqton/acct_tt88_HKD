// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - CT-05: Lập bảng thanh toán tiền lương
// ============================================================================

import 'package:sqflite/sqflite.dart';
import 'package:hkd_accounting/features/ct/domain/entities/bang_luong.dart';
import 'package:hkd_accounting/features/ct/data/models/bang_luong_model.dart';

abstract class BangLuongLocalDatasource {
  Future<List<BangLuongModel>> getList();
  Future<BangLuongModel?> getById(String id);
  Future<List<BangLuongModel>> getByKyKeToan(String kyKeToanId);
  Future<String> save(BangLuongModel model);
  Future<void> update(BangLuongModel model);
  Future<void> delete(String id);
  Future<List<ChiTietBangLuongModel>> getChiTietByBangLuongId(String bangLuongId);
  Future<String> saveChiTiet(ChiTietBangLuongModel model);
  Future<void> deleteChiTiet(String id);
}

class BangLuongLocalDatasourceImpl implements BangLuongLocalDatasource {
  final Database _database;

  BangLuongLocalDatasourceImpl(this._database);

  @override
  Future<List<BangLuongModel>> getList() async {
    final List<Map<String, dynamic>> maps =
        await _database.query('bang_luong', orderBy: 'ngay_lap DESC');
    return List.generate(maps.length, (i) => BangLuongModel.fromMap(maps[i]));
  }

  @override
  Future<BangLuongModel?> getById(String id) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'bang_luong',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return BangLuongModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<List<BangLuongModel>> getByKyKeToan(String kyKeToanId) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'bang_luong',
      where: 'ky_ke_toan_id = ?',
      whereArgs: [kyKeToanId],
      orderBy: 'ngay_lap DESC',
    );
    return List.generate(maps.length, (i) => BangLuongModel.fromMap(maps[i]));
  }

  @override
  Future<String> save(BangLuongModel model) async {
    final existing = await getById(model.id);
    if (existing != null) {
      await update(model);
      return existing.id;
    } else {
      final id = await _database.insert(
        'bang_luong',
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id.toString();
    }
  }

  @override
  Future<void> update(BangLuongModel model) async {
    await _database.update(
      'bang_luong',
      model.toMap(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  @override
  Future<void> delete(String id) async {
    await _database.delete(
      'bang_luong',
      where: 'id = ?',
      whereArgs: [id],
    );
    await _database.delete(
      'chi_tiet_bang_luong',
      where: 'bang_luong_id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<ChiTietBangLuongModel>> getChiTietByBangLuongId(
      String bangLuongId) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'chi_tiet_bang_luong',
      where: 'bang_luong_id = ?',
      whereArgs: [bangLuongId],
    );
    return List.generate(
        maps.length, (i) => ChiTietBangLuongModel.fromMap(maps[i]));
  }

  @override
  Future<String> saveChiTiet(ChiTietBangLuongModel model) async {
    final id = await _database.insert(
      'chi_tiet_bang_luong',
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id.toString();
  }

  @override
  Future<void> deleteChiTiet(String id) async {
    await _database.delete(
      'chi_tiet_bang_luong',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}