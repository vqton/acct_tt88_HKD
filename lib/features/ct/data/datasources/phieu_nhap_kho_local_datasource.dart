// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - CT-03: Lập phiếu nhập kho
// ============================================================================

import 'package:sqflite/sqflite.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_nhap_kho.dart';
import 'package:hkd_accounting/features/ct/data/models/phieu_nhap_kho_model.dart';

abstract class PhieuNhapKhoLocalDatasource {
  Future<PhieuNhapKhoModel?> getPhieuNhapKhoById(String id);
  Future<List<PhieuNhapKhoModel>> getPhieuNhapKhoList();
  Future<String> savePhieuNhapKho(PhieuNhapKhoModel phieuNhapKhoModel);
  Future<void> updatePhieuNhapKho(PhieuNhapKhoModel phieuNhapKhoModel);
  Future<void> deletePhieuNhapKho(String id);
  Future<List<PhieuNhapKhoModel>> searchPhieuNhapKho(String query);
  Future<void> approvePhieuNhapKho(String id);
  Future<List<PhieuNhapKhoChiTietModel>> getChiTietByPhieuNhapKhoId(
      String phieuNhapKhoId);
  Future<void> saveChiTietList(
      List<PhieuNhapKhoChiTietModel> chiTietModelList);
  Future<void> deleteChiTietByPhieuNhapKhoId(String phieuNhapKhoId);
}

class PhieuNhapKhoLocalDatasourceImpl implements PhieuNhapKhoLocalDatasource {
  final Database _database;

  PhieuNhapKhoLocalDatasourceImpl(this._database);

  @override
  Future<PhieuNhapKhoModel?> getPhieuNhapKhoById(String id) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'phieu_nhap_kho',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isEmpty) return null;

    final chiTietList = await getChiTietByPhieuNhapKhoId(id);
    return PhieuNhapKhoModel.fromMap(maps.first, chiTietList: chiTietList);
  }

  @override
  Future<List<PhieuNhapKhoModel>> getPhieuNhapKhoList() async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'phieu_nhap_kho',
      orderBy: 'ngay_lap DESC, created_at DESC',
    );

    final List<PhieuNhapKhoModel> result = [];
    for (final map in maps) {
      final id = map['id']?.toString() ?? '';
      final chiTietList = await getChiTietByPhieuNhapKhoId(id);
      result.add(PhieuNhapKhoModel.fromMap(map, chiTietList: chiTietList));
    }
    return result;
  }

  @override
  Future<String> savePhieuNhapKho(PhieuNhapKhoModel phieuNhapKhoModel) async {
    final existing = await getPhieuNhapKhoById(phieuNhapKhoModel.id);
    if (existing != null) {
      await updatePhieuNhapKho(phieuNhapKhoModel);
      return existing.id;
    } else {
      final id = await _database.insert(
        'phieu_nhap_kho',
        phieuNhapKhoModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      if (phieuNhapKhoModel.chiTietList.isNotEmpty) {
        await saveChiTietList(phieuNhapKhoModel.chiTietList
            .map((e) => PhieuNhapKhoChiTietModel.fromEntity(e))
            .toList());
      }
      return id.toString();
    }
  }

  @override
  Future<void> updatePhieuNhapKho(PhieuNhapKhoModel phieuNhapKhoModel) async {
    await _database.update(
      'phieu_nhap_kho',
      phieuNhapKhoModel.toMap(),
      where: 'id = ?',
      whereArgs: [phieuNhapKhoModel.id],
    );
    await deleteChiTietByPhieuNhapKhoId(phieuNhapKhoModel.id);
    if (phieuNhapKhoModel.chiTietList.isNotEmpty) {
      await saveChiTietList(phieuNhapKhoModel.chiTietList
          .map((e) => PhieuNhapKhoChiTietModel.fromEntity(e))
          .toList());
    }
  }

  @override
  Future<void> deletePhieuNhapKho(String id) async {
    await deleteChiTietByPhieuNhapKhoId(id);
    await _database.delete(
      'phieu_nhap_kho',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<PhieuNhapKhoModel>> searchPhieuNhapKho(String query) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'phieu_nhap_kho',
      where: 'so_phieu LIKE ? OR ly_do_nhap LIKE ? OR nguoi_giao_hang LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
    );

    final List<PhieuNhapKhoModel> result = [];
    for (final map in maps) {
      final id = map['id']?.toString() ?? '';
      final chiTietList = await getChiTietByPhieuNhapKhoId(id);
      result.add(PhieuNhapKhoModel.fromMap(map, chiTietList: chiTietList));
    }
    return result;
  }

  @override
  Future<void> approvePhieuNhapKho(String id) async {
    await _database.update(
      'phieu_nhap_kho',
      {
        'trang_thai': 'DA_DUYET',
        'ngay_duyet': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<PhieuNhapKhoChiTietModel>> getChiTietByPhieuNhapKhoId(
      String phieuNhapKhoId) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'phieu_nhap_kho_chi_tiet',
      where: 'phieu_nhap_kho_id = ?',
      whereArgs: [phieuNhapKhoId],
    );
    return List.generate(
        maps.length, (i) => PhieuNhapKhoChiTietModel.fromMap(maps[i]));
  }

  @override
  Future<void> saveChiTietList(
      List<PhieuNhapKhoChiTietModel> chiTietModelList) async {
    for (final chiTiet in chiTietModelList) {
      await _database.insert(
        'phieu_nhap_kho_chi_tiet',
        chiTiet.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  @override
  Future<void> deleteChiTietByPhieuNhapKhoId(String phieuNhapKhoId) async {
    await _database.delete(
      'phieu_nhap_kho_chi_tiet',
      where: 'phieu_nhap_kho_id = ?',
      whereArgs: [phieuNhapKhoId],
    );
  }
}