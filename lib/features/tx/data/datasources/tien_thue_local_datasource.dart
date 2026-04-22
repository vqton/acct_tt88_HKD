import 'package:sqflite/sqflite.dart';
import 'package:hkd_accounting/features/sk/data/models/so_doanh_thu_model.dart';

abstract class TienThueLocalDatasource {
  Future<List<SoDoanhThuModel>> getDoanhThuByKyKeToan(String kyKeToanId);
  Future<Map<String, dynamic>> getNgheNgheById(String id);
  Future<void> saveTienThueGtgt(Map<String, dynamic> row);
  Future<void> saveTienThueTncn(Map<String, dynamic> row);
  Future<List<Map<String, dynamic>>> getTienThueGtgtByKy(String kyKeToanId);
  Future<List<Map<String, dynamic>>> getTienThueTncnByKy(String kyKeToanId);
  Future<void> updateTienThueGtgtDaNop(String id, int soTien);
  Future<void> updateTienThueTncnDaNop(String id, int soTien);
}

class TienThueLocalDatasourceImpl implements TienThueLocalDatasource {
  final Database _db;

  TienThueLocalDatasourceImpl(this._db);

  @override
  Future<List<SoDoanhThuModel>> getDoanhThuByKyKeToan(String kyKeToanId) async {
    final maps = await _db.query(
      'so_doanh_thu',
      where: 'ky_ke_toan_id = ?',
      whereArgs: [kyKeToanId],
      orderBy: 'ngay_chung_tu DESC',
    );
    return List.generate(maps.length, (i) => SoDoanhThuModel.fromMap(maps[i]));
  }

  @override
  Future<Map<String, dynamic>> getNgheNgheById(String id) async {
    final maps = await _db.query('nghe_nghiep', where: 'id = ?', whereArgs: [id], limit: 1);
    if (maps.isEmpty) {
      return {};
    }
    return maps.first;
  }

  @override
  Future<void> saveTienThueGtgt(Map<String, dynamic> row) async {
    await _db.insert(
      'tien_thue_gtgt',
      row,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> saveTienThueTncn(Map<String, dynamic> row) async {
    await _db.insert(
      'tien_thue_tncn',
      row,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getTienThueGtgtByKy(String kyKeToanId) async {
    return _db.query(
      'tien_thue_gtgt',
      where: 'ky_ke_toan_id = ?',
      whereArgs: [kyKeToanId],
      orderBy: 'created_at DESC',
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getTienThueTncnByKy(String kyKeToanId) async {
    return _db.query(
      'tien_thue_tncn',
      where: 'ky_ke_toan_id = ?',
      whereArgs: [kyKeToanId],
      orderBy: 'created_at DESC',
    );
  }

  @override
  Future<void> updateTienThueGtgtDaNop(String id, int soTien) async {
    await _db.rawUpdate(
      'UPDATE tien_thue_gtgt SET thue_gtgt_da_nop = thue_gtgt_da_nop + ? WHERE id = ?',
      [soTien, id],
    );
  }

  @override
  Future<void> updateTienThueTncnDaNop(String id, int soTien) async {
    await _db.rawUpdate(
      'UPDATE tien_thue_tncn SET thue_tncn_da_nop = thue_tncn_da_nop + ? WHERE id = ?',
      [soTien, id],
    );
  }
}