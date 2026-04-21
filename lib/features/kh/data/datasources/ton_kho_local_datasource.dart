// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - KH-04: Tính giá xuất kho
// ============================================================================

import 'package:sqflite/sqflite.dart';
import 'package:hkd_accounting/features/kh/domain/entities/ton_kho.dart';
import 'package:hkd_accounting/features/kh/data/models/ton_kho_model.dart';

abstract class TonKhoLocalDatasource {
  Future<TonKhoModel?> getTonKho(String kyKeToanId, String hangHoaId);
  Future<List<TonKhoModel>> getTonKhoList(String kyKeToanId);
  Future<void> saveTonKho(TonKhoModel tonKhoModel);
  Future<List<PhieuNhapKhoLotModel>> getPhieuNhapKhoLots(String hangHoaId);
}

class TonKhoLocalDatasourceImpl implements TonKhoLocalDatasource {
  final Database _database;

  TonKhoLocalDatasourceImpl(this._database);

  @override
  Future<TonKhoModel?> getTonKho(String kyKeToanId, String hangHoaId) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'ton_kho',
      where: 'ky_ke_toan_id = ? AND hang_hoa_id = ?',
      whereArgs: [kyKeToanId, hangHoaId],
      limit: 1,
    );

    if (maps.isEmpty) return null;
    return TonKhoModel.fromMap(maps.first);
  }

  @override
  Future<List<TonKhoModel>> getTonKhoList(String kyKeToanId) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'ton_kho',
      where: 'ky_ke_toan_id = ?',
      whereArgs: [kyKeToanId],
    );

    return List.generate(maps.length, (i) => TonKhoModel.fromMap(maps[i]));
  }

  @override
  Future<void> saveTonKho(TonKhoModel tonKhoModel) async {
    final existing = await getTonKho(tonKhoModel.kyKeToanId, tonKhoModel.hangHoaId);
    if (existing != null) {
      await _database.update(
        'ton_kho',
        tonKhoModel.toMap(),
        where: 'ky_ke_toan_id = ? AND hang_hoa_id = ?',
        whereArgs: [tonKhoModel.kyKeToanId, tonKhoModel.hangHoaId],
      );
    } else {
      await _database.insert(
        'ton_kho',
        tonKhoModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  @override
  Future<List<PhieuNhapKhoLotModel>> getPhieuNhapKhoLots(String hangHoaId) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      '''
      SELECT pnk.id, pnkct.phieu_nhap_kho_id, pnkct.hang_hoa_id, 
             pnkct.so_luong_thuc_nhan as so_luong, pnkct.don_gia, pnkct.thanh_tien, pnk.ngay_lap
      FROM phieu_nhap_kho pnk
      JOIN phieu_nhap_kho_chi_tiet pnkct ON pnk.id = pnkct.phieu_nhap_kho_id
      WHERE pnkct.hang_hoa_id = ? AND pnk.trang_thai = 'DA_DUYET'
      ORDER BY pnk.ngay_lap ASC
      ''',
      whereArgs: [hangHoaId],
    );

    return List.generate(
        maps.length, (i) => PhieuNhapKhoLotModel.fromMap(maps[i]));
  }
}