// ============================================================================
// Data Layer - Local Datasource Implementation
// Based on UC_HKD_TT88_2021 - NS-03: Theo dõi và thanh toán lương
// ============================================================================

import 'package:sqflite/sqflite.dart';
import 'package:hkd_accounting/features/ns/data/models/thanh_toan_luong_model.dart';
import 'package:hkd_accounting/features/ns/data/datasources/thanh_toan_luong_local_datasource.dart';

class ThanhToanLuongLocalDatasourceImpl implements ThanhToanLuongLocalDatasource {
  final Database database;

  ThanhToanLuongLocalDatasourceImpl(this.database);

  @override
  Future<String> save(ThanhToanLuongModel model) async {
    await database.insert('thanh_toan_luong', model.toMap());
    return model.id;
  }

  @override
  Future<ThanhToanLuongModel?> getById(String id) async {
    final result = await database.query(
      'thanh_toan_luong',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isEmpty) return null;
    return ThanhToanLuongModel.fromMap(result.first);
  }

  @override
  Future<List<ThanhToanLuongModel>> getList() async {
    final result = await database.query('thanh_toan_luong', orderBy: 'thang_nam DESC');
    return result.map((e) => ThanhToanLuongModel.fromMap(e)).toList();
  }

  @override
  Future<List<ThanhToanLuongModel>> getByBangLuongId(String bangLuongId) async {
    final result = await database.query(
      'thanh_toan_luong',
      where: 'bang_luong_id = ?',
      whereArgs: [bangLuongId],
    );
    return result.map((e) => ThanhToanLuongModel.fromMap(e)).toList();
  }

  @override
  Future<void> update(ThanhToanLuongModel model) async {
    await database.update(
      'thanh_toan_luong',
      model.toMap(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  @override
  Future<void> delete(String id) async {
    await database.delete(
      'thanh_toan_luong',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> updateThanhToan(String id, double soTienChuyenKhoan, double soTienMat) async {
    final record = await getById(id);
    if (record != null) {
      final newDaTraCk = record.daTraBangChuyenKhoan + soTienChuyenKhoan;
      final newDaTraMat = record.daTraTienMat + soTienMat;
      final newConPhai = record.tongLuongPhaiTra - newDaTraCk - newDaTraMat;
      final trangThai = newConPhai <= 0 ? 'DA_THANH_TOAN' : 'DANG_THANH_TOAN';
      await database.update(
        'thanh_toan_luong',
        {
          'da_tra_chuyen_khoan': newDaTraCk,
          'da_tra_tien_mat': newDaTraMat,
          'con_phai_tra': newConPhai > 0 ? newConPhai : 0,
          'trang_thai': trangThai,
          'ngay_thanh_toan': newConPhai <= 0 ? DateTime.now().toIso8601String() : null,
        },
        where: 'id = ?',
        whereArgs: [id],
      );
    }
  }
}