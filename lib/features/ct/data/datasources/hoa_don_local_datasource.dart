// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - CT-06: Quản lý hóa đơn
// ============================================================================

import 'package:sqflite/sqflite.dart';
import 'package:hkd_accounting/features/ct/data/models/hoa_don_model.dart';

abstract class HoaDonLocalDatasource {
  Future<HoaDonModel?> getHoaDonById(String id);
  Future<List<HoaDonModel>> getHoaDonList();
  Future<List<HoaDonModel>> getHoaDonByLoai(String loaiHoaDon);
  Future<String> saveHoaDon(HoaDonModel hoaDonModel);
  Future<void> updateHoaDon(HoaDonModel hoaDonModel);
  Future<void> deleteHoaDon(String id);
  Future<List<HoaDonModel>> searchHoaDon(String query);
}

class HoaDonLocalDatasourceImpl implements HoaDonLocalDatasource {
  final Database _database;

  HoaDonLocalDatasourceImpl(this._database);

  @override
  Future<HoaDonModel?> getHoaDonById(String id) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'hoa_don',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return HoaDonModel.fromMap(maps.first);
  }

  @override
  Future<List<HoaDonModel>> getHoaDonList() async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'hoa_don',
      orderBy: 'ngay_lap DESC, created_at DESC',
    );
    return List.generate(maps.length, (i) => HoaDonModel.fromMap(maps[i]));
  }

  @override
  Future<List<HoaDonModel>> getHoaDonByLoai(String loaiHoaDon) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'hoa_don',
      where: 'loai_hoa_don = ?',
      whereArgs: [loaiHoaDon],
      orderBy: 'ngay_lap DESC',
    );
    return List.generate(maps.length, (i) => HoaDonModel.fromMap(maps[i]));
  }

  @override
  Future<String> saveHoaDon(HoaDonModel hoaDonModel) async {
    final existing = await getHoaDonById(hoaDonModel.id);
    if (existing != null) {
      await updateHoaDon(hoaDonModel);
      return existing.id;
    } else {
      final id = await _database.insert(
        'hoa_don',
        hoaDonModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id.toString();
    }
  }

  @override
  Future<void> updateHoaDon(HoaDonModel hoaDonModel) async {
    await _database.update(
      'hoa_don',
      hoaDonModel.toMap(),
      where: 'id = ?',
      whereArgs: [hoaDonModel.id],
    );
  }

  @override
  Future<void> deleteHoaDon(String id) async {
    await _database.delete(
      'hoa_don',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<HoaDonModel>> searchHoaDon(String query) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'hoa_don',
      where: 'so_hoa_don LIKE ?',
      whereArgs: ['%$query%'],
    );
    return List.generate(maps.length, (i) => HoaDonModel.fromMap(maps[i]));
  }
}