// ============================================================================
// Data Layer - Local Datasource Implementation
// Based on UC_HKD_TT88_2021 - QT-03: Đóng kỳ kế toán và khóa sổ
// ============================================================================

import 'package:sqflite/sqflite.dart';
import 'package:hkd_accounting/features/qt/data/models/dong_ky_ke_toan_model.dart';
import 'package:hkd_accounting/features/qt/data/datasources/dong_ky_ke_toan_local_datasource.dart';

class DongKyKeToanLocalDatasourceImpl implements DongKyKeToanLocalDatasource {
  final Database database;

  DongKyKeToanLocalDatasourceImpl(this.database);

  @override
  Future<String> save(DongKyKeToanModel model) async {
    await database.insert('dong_ky_ke_toan', model.toMap());
    return model.id;
  }

  @override
  Future<DongKyKeToanModel?> getCurrent() async {
    final result = await database.query(
      'dong_ky_ke_toan',
      orderBy: 'created_at DESC',
      limit: 1,
    );
    if (result.isEmpty) return null;
    return DongKyKeToanModel.fromMap(result.first);
  }

  @override
  Future<List<DongKyKeToanModel>> getList() async {
    final result = await database.query('dong_ky_ke_toan', orderBy: 'created_at DESC');
    return result.map((e) => DongKyKeToanModel.fromMap(e)).toList();
  }

  @override
  Future<void> update(DongKyKeToanModel model) async {
    await database.update(
      'dong_ky_ke_toan',
      model.toMap(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  @override
  Future<void> delete(String id) async {
    await database.delete('dong_ky_ke_toan', where: 'id = ?', whereArgs: [id]);
  }
}