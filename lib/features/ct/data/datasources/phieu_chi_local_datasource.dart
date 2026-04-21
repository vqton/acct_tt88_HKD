// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - CT-02
// ============================================================================

import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_chi.dart';
import 'package:hkd_accounting/features/ct/data/models/phieu_chi_model.dart';

abstract class PhieuChiLocalDatasource {
  Future<PhieuChiModel?> getPhieuChiById(String id);
  Future<List<PhieuChiModel>> getPhieuChiList();
  Future<String> savePhieuChi(PhieuChiModel phieuChiModel);
  Future<void> updatePhieuChi(PhieuChiModel phieuChiModel);
  Future<void> deletePhieuChi(String id);
  Future<List<PhieuChiModel>> searchPhieuChi(String query);
}

class PhieuChiLocalDatasourceImpl implements PhieuChiLocalDatasource {
  final Database _database;

  PhieuChiLocalDatasourceImpl(this._database);

  @override
  Future<PhieuChiModel?> getPhieuChiById(String id) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'phieu_chi',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return PhieuChiModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<List<PhieuChiModel>> getPhieuChiList() async {
    final List<Map<String, dynamic>> maps = await _database.query('phieu_chi');
    return List.generate(maps.length, (i) {
      return PhieuChiModel.fromMap(maps[i]);
    });
  }

  @override
  Future<String> savePhieuChi(PhieuChiModel phieuChiModel) async {
    // Check if record already exists
    final existing = await getPhieuChiById(phieuChiModel.id);
    if (existing != null) {
      await updatePhieuChi(phieuChiModel);
      return existing.id;
    } else {
      final id = await _database.insert(
        'phieu_chi',
        phieuChiModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id.toString();
    }
  }

  @override
  Future<void> updatePhieuChi(PhieuChiModel phieuChiModel) async {
    await _database.update(
      'phieu_chi',
      phieuChiModel.toMap(),
      where: 'id = ?',
      whereArgs: [phieuChiModel.id],
    );
  }

  @override
  Future<void> deletePhieuChi(String id) async {
    await _database.delete(
      'phieu_chi',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<PhieuChiModel>> searchPhieuChi(String query) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'phieu_chi',
      where: 'so_phieu LIKE ? OR nguoi_nop LIKE ? OR ly_do_nop LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
    );
    return List.generate(maps.length, (i) {
      return PhieuChiModel.fromMap(maps[i]);
    });
  }
}

// Database Helper
class PhieuChiDatabaseHelper {
  static final PhieuChiDatabaseHelper _instance =
      PhieuChiDatabaseHelper._internal();

  factory PhieuChiDatabaseHelper() {
    return _instance;
  }

  PhieuChiDatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'hkd_accounting.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE phieu_chi (
        id TEXT PRIMARY KEY,
        so_phieu TEXT NOT NULL,
        ngay_lap TEXT NOT NULL,
        nguoi_nop TEXT NOT NULL,
        dia_chi_nguoi_nop TEXT NOT NULL,
        ly_do_nop TEXT NOT NULL,
        so_tien INTEGER NOT NULL,
        so_tien_bang_chu TEXT NOT NULL,
        chung_tu_goc_kem_theo TEXT NOT NULL,
        hkd_info_id TEXT NOT NULL,
        nha_cung_cap_id TEXT,
        ky_ke_toan_id TEXT NOT NULL,
        trang_thai TEXT NOT NULL DEFAULT 'CHO_DUYET',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }
}