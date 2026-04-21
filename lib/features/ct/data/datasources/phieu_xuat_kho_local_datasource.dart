// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - CT-04: Lập phiếu xuất kho
// ============================================================================

import 'package:sqflite/sqflite.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_xuat_kho.dart';
import 'package:hkd_accounting/features/ct/data/models/phieu_xuat_kho_model.dart';

abstract class PhieuXuatKhoLocalDatasource {
  Future<PhieuXuatKhoModel?> getPhieuXuatKhoById(String id);
  Future<List<PhieuXuatKhoModel>> getPhieuXuatKhoList();
  Future<String> savePhieuXuatKho(PhieuXuatKhoModel phieuXuatKhoModel);
  Future<void> updatePhieuXuatKho(PhieuXuatKhoModel phieuXuatKhoModel);
  Future<void> deletePhieuXuatKho(String id);
  Future<List<PhieuXuatKhoModel>> searchPhieuXuatKho(String query);
  Future<void> approvePhieuXuatKho(String id);
  Future<List<PhieuXuatKhoChiTietModel>> getChiTietByPhieuXuatKhoId(
      String phieuXuatKhoId);
  Future<void> saveChiTietList(
      List<PhieuXuatKhoChiTietModel> chiTietModelList);
  Future<void> deleteChiTietByPhieuXuatKhoId(String phieuXuatKhoId);
}

class PhieuXuatKhoLocalDatasourceImpl implements PhieuXuatKhoLocalDatasource {
  final Database _database;

  PhieuXuatKhoLocalDatasourceImpl(this._database);

  @override
  Future<PhieuXuatKhoModel?> getPhieuXuatKhoById(String id) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'phieu_xuat_kho',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isEmpty) return null;

    final chiTietList = await getChiTietByPhieuXuatKhoId(id);
    return PhieuXuatKhoModel.fromMap(maps.first, chiTietList: chiTietList);
  }

  @override
  Future<List<PhieuXuatKhoModel>> getPhieuXuatKhoList() async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'phieu_xuat_kho',
      orderBy: 'ngay_lap DESC, created_at DESC',
    );

    final List<PhieuXuatKhoModel> result = [];
    for (final map in maps) {
      final id = map['id']?.toString() ?? '';
      final chiTietList = await getChiTietByPhieuXuatKhoId(id);
      result.add(PhieuXuatKhoModel.fromMap(map, chiTietList: chiTietList));
    }
    return result;
  }

  @override
  Future<String> savePhieuXuatKho(PhieuXuatKhoModel phieuXuatKhoModel) async {
    final existing = await getPhieuXuatKhoById(phieuXuatKhoModel.id);
    if (existing != null) {
      await updatePhieuXuatKho(phieuXuatKhoModel);
      return existing.id;
    } else {
      final id = await _database.insert(
        'phieu_xuat_kho',
        phieuXuatKhoModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      if (phieuXuatKhoModel.chiTietList.isNotEmpty) {
        await saveChiTietList(phieuXuatKhoModel.chiTietList
            .map((e) => PhieuXuatKhoChiTietModel.fromEntity(e))
            .toList());
      }
      return id.toString();
    }
  }

  @override
  Future<void> updatePhieuXuatKho(PhieuXuatKhoModel phieuXuatKhoModel) async {
    await _database.update(
      'phieu_xuat_kho',
      phieuXuatKhoModel.toMap(),
      where: 'id = ?',
      whereArgs: [phieuXuatKhoModel.id],
    );
    await deleteChiTietByPhieuXuatKhoId(phieuXuatKhoModel.id);
    if (phieuXuatKhoModel.chiTietList.isNotEmpty) {
      await saveChiTietList(phieuXuatKhoModel.chiTietList
          .map((e) => PhieuXuatKhoChiTietModel.fromEntity(e))
          .toList());
    }
  }

  @override
  Future<void> deletePhieuXuatKho(String id) async {
    await deleteChiTietByPhieuXuatKhoId(id);
    await _database.delete(
      'phieu_xuat_kho',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<PhieuXuatKhoModel>> searchPhieuXuatKho(String query) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'phieu_xuat_kho',
      where: 'so_phieu LIKE ? OR ly_do_xuat LIKE ? OR ho_ten_nguoi_nhan LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
    );

    final List<PhieuXuatKhoModel> result = [];
    for (final map in maps) {
      final id = map['id']?.toString() ?? '';
      final chiTietList = await getChiTietByPhieuXuatKhoId(id);
      result.add(PhieuXuatKhoModel.fromMap(map, chiTietList: chiTietList));
    }
    return result;
  }

  @override
  Future<void> approvePhieuXuatKho(String id) async {
    await _database.update(
      'phieu_xuat_kho',
      {
        'trang_thai': 'DA_DUYET',
        'ngay_duyet': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<PhieuXuatKhoChiTietModel>> getChiTietByPhieuXuatKhoId(
      String phieuXuatKhoId) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'phieu_xuat_kho_chi_tiet',
      where: 'phieu_xuat_kho_id = ?',
      whereArgs: [phieuXuatKhoId],
    );
    return List.generate(
        maps.length, (i) => PhieuXuatKhoChiTietModel.fromMap(maps[i]));
  }

  @override
  Future<void> saveChiTietList(
      List<PhieuXuatKhoChiTietModel> chiTietModelList) async {
    for (final chiTiet in chiTietModelList) {
      await _database.insert(
        'phieu_xuat_kho_chi_tiet',
        chiTiet.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  @override
  Future<void> deleteChiTietByPhieuXuatKhoId(String phieuXuatKhoId) async {
    await _database.delete(
      'phieu_xuat_kho_chi_tiet',
      where: 'phieu_xuat_kho_id = ?',
      whereArgs: [phieuXuatKhoId],
    );
  }
}
