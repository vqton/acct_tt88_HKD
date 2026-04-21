// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - MD-04
// ============================================================================

import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/nha_cung_cap.dart';
import 'package:hkd_accounting/features/master_data/data/models/nha_cung_cap_model.dart';

abstract class NhaCungCapLocalDatasource {
  Future<List<NhaCungCapModel>> getNhaCungCapList();
  Future<NhaCungCapModel?> getNhaCungCapById(String id);
  Future<String> saveNhaCungCap(NhaCungCapModel nhaCungCapModel);
  Future<void> updateNhaCungCap(NhaCungCapModel nhaCungCapModel);
  Future<void> deleteNhaCungCap(String id);
  Future<List<NhaCungCapModel>> searchNhaCungCap(String query);
}

class NhaCungCapLocalDatasourceImpl implements NhaCungCapLocalDatasource {
  final Database _database;

  NhaCungCapLocalDatasourceImpl(this._database);

  @override
  Future<List<NhaCungCapModel>> getNhaCungCapList() async {
    final List<Map<String, dynamic>> maps = await _database.query('nha_cung_cap');
    return List.generate(maps.length, (i) {
      return NhaCungCapModel.fromMap(maps[i]);
    });
  }

  @override
  Future<NhaCungCapModel?> getNhaCungCapById(String id) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'nha_cung_cap',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return NhaCungCapModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<String> saveNhaCungCap(NhaCungCapModel nhaCungCapModel) async {
    // Check if record already exists
    final existing = await getNhaCungCapById(nhaCungCapModel.id);
    if (existing != null) {
      await updateNhaCungCap(nhaCungCapModel);
      return existing.id;
    } else {
      final id = await _database.insert(
        'nha_cung_cap',
        nhaCungCapModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id.toString();
    }
  }

  @override
  Future<void> updateNhaCungCap(NhaCungCapModel nhaCungCapModel) async {
    await _database.update(
      'nha_cung_cap',
      nhaCungCapModel.toMap(),
      where: 'id = ?',
      whereArgs: [nhaCungCapModel.id],
    );
  }

  @override
  Future<void> deleteNhaCungCap(String id) async {
    await _database.delete(
      'nha_cung_cap',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<NhaCungCapModel>> searchNhaCungCap(String query) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'nha_cung_cap',
      where: 'ma_nha_cung_cap LIKE ? OR ten_nha_cung_cap LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );
    return List.generate(maps.length, (i) {
      return NhaCungCapModel.fromMap(maps[i]);
    });
  }
}

// Database Helper
class NhaCungCapDatabaseHelper {
  static final NhaCungCapDatabaseHelper _instance =
      NhaCungCapDatabaseHelper._internal();

  factory NhaCungCapDatabaseHelper() {
    return _instance;
  }

  NhaCungCapDatabaseHelper._internal();

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
      CREATE TABLE nha_cung_cap (
        id TEXT PRIMARY KEY,
        ma_nha_cung_cap TEXT NOT NULL,
        ten_nha_cung_cap TEXT NOT NULL,
        dia_chi TEXT,
        ma_so_thue TEXT,
        so_dien_thoai TEXT,
        email TEXT,
        nguoi_dai_dien TEXT,
        ngay_sinh_nguoi_dai_dien TEXT,
        so_cccd_nguoi_dai_dien TEXT,
        tai_khoan_ngan_hang TEXT,
        ten_ngan_hang TEXT,
        chi_nhanh_ngan_hang TEXT,
        trang_thai TEXT NOT NULL DEFAULT 'HOAT_DONG',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }
}