import 'package:sqflite/sqflite.dart';
import 'package:hkd_accounting/features/tx/domain/entities/phieu_nop_thue.dart';

abstract class PhieuNopThueLocalDatasource {
  Future<List<Map<String, dynamic>>> getByKyKeToan(String kyKeToanId);
  Future<List<Map<String, dynamic>>> getAll();
  Future<void> save(Map<String, dynamic> row);
  Future<void> update(Map<String, dynamic> row);
  Future<void> delete(String id);
}

class PhieuNopThueLocalDatasourceImpl implements PhieuNopThueLocalDatasource {
  final Database _db;

  PhieuNopThueLocalDatasourceImpl(this._db);

  @override
  Future<List<Map<String, dynamic>>> getByKyKeToan(String kyKeToanId) async {
    return _db.query(
      'phieu_nop_thue',
      where: 'ky_ke_toan_id = ?',
      whereArgs: [kyKeToanId],
      orderBy: 'ngay_nop DESC',
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getAll() async {
    return _db.query('phieu_nop_thue', orderBy: 'ngay_nop DESC');
  }

  @override
  Future<void> save(Map<String, dynamic> row) async {
    await _db.insert('phieu_nop_thue', row, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> update(Map<String, dynamic> row) async {
    await _db.update('phieu_nop_thue', row, where: 'id = ?', whereArgs: [row['id']]);
  }

  @override
  Future<void> delete(String id) async {
    await _db.delete('phieu_nop_thue', where: 'id = ?', whereArgs: [id]);
  }
}