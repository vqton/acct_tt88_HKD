// ============================================================================
// Data Layer - Local Datasource Implementation
// Based on UC_HKD_TT88_2021 - QT-06: Nhật ký hệ thống và Audit Trail
// ============================================================================

import 'package:sqflite/sqflite.dart';
import 'package:hkd_accounting/features/qt/data/models/nhat_ky_he_thong_model.dart';
import 'package:hkd_accounting/features/qt/data/datasources/nhat_ky_he_thong_local_datasource.dart';

class NhatKyHeThongLocalDatasourceImpl implements NhatKyHeThongLocalDatasource {
  final Database database;

  NhatKyHeThongLocalDatasourceImpl(this.database);

  @override
  Future<String> save(NhatKyHeThongModel model) async {
    await database.insert('nhat_ky_he_thong', model.toMap());
    return model.id;
  }

  @override
  Future<List<NhatKyHeThongModel>> getList({int? limit, int? offset}) async {
    final result = await database.query(
      'nhat_ky_he_thong',
      orderBy: 'timestamp DESC',
      limit: limit,
      offset: offset,
    );
    return result.map((e) => NhatKyHeThongModel.fromMap(e)).toList();
  }

  @override
  Future<List<NhatKyHeThongModel>> getByUserId(String userId) async {
    final result = await database.query(
      'nhat_ky_he_thong',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'timestamp DESC',
    );
    return result.map((e) => NhatKyHeThongModel.fromMap(e)).toList();
  }

  @override
  Future<List<NhatKyHeThongModel>> getByDoiTuong(String doiTuongLoai, String doiTuongId) async {
    final result = await database.query(
      'nhat_ky_he_thong',
      where: 'doi_tuong_loai = ? AND doi_tuong_id = ?',
      whereArgs: [doiTuongLoai, doiTuongId],
      orderBy: 'timestamp DESC',
    );
    return result.map((e) => NhatKyHeThongModel.fromMap(e)).toList();
  }

  @override
  Future<List<NhatKyHeThongModel>> getByDateRange(DateTime from, DateTime to) async {
    final result = await database.query(
      'nhat_ky_he_thong',
      where: 'timestamp >= ? AND timestamp <= ?',
      whereArgs: [from.toIso8601String(), to.toIso8601String()],
      orderBy: 'timestamp DESC',
    );
    return result.map((e) => NhatKyHeThongModel.fromMap(e)).toList();
  }

  @override
  Future<List<NhatKyHeThongModel>> getByHanhDong(String hanhDong) async {
    final result = await database.query(
      'nhat_ky_he_thong',
      where: 'hanh_dong = ?',
      whereArgs: [hanhDong],
      orderBy: 'timestamp DESC',
    );
    return result.map((e) => NhatKyHeThongModel.fromMap(e)).toList();
  }

  @override
  Future<NhatKyHeThongModel?> getById(String id) async {
    final result = await database.query(
      'nhat_ky_he_thong',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isEmpty) return null;
    return NhatKyHeThongModel.fromMap(result.first);
  }

  @override
  Future<int> getCount() async {
    final result = await database.rawQuery('SELECT COUNT(*) as count FROM nhat_ky_he_thong');
    return Sqflite.firstIntValue(result) ?? 0;
  }
}