// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - MD-01
// ============================================================================

import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/hkd_info.dart';
import 'package:hkd_accounting/features/master_data/data/models/hkd_info_model.dart';

abstract class HkdInfoLocalDatasource {
  Future<HkdInfoModel?> getHkdInfo();
  Future<String> saveHkdInfo(HkdInfoModel hkdInfoModel);
  Future<void> updateHkdInfo(HkdInfoModel hkdInfoModel);
  Future<void> deleteHkdInfo(String id);
}

class HkdInfoLocalDatasourceImpl implements HkdInfoLocalDatasource {
  final Database _database;

  HkdInfoLocalDatasourceImpl(this._database);

  @override
  Future<HkdInfoModel?> getHkdInfo() async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'hkd_info',
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return HkdInfoModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<String> saveHkdInfo(HkdInfoModel hkdInfoModel) async {
    // Check if record already exists
    final existing = await getHkdInfo();
    if (existing != null) {
      await updateHkdInfo(hkdInfoModel);
      return existing.id;
    } else {
      final id = await _database.insert(
        'hkd_info',
        hkdInfoModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id.toString();
    }
  }

  @override
  Future<void> updateHkdInfo(HkdInfoModel hkdInfoModel) async {
    await _database.update(
      'hkd_info',
      hkdInfoModel.toMap(),
      where: 'id = ?',
      whereArgs: [hkdInfoModel.id],
    );
  }

  @override
  Future<void> deleteHkdInfo(String id) async {
    await _database.delete(
      'hkd_info',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

// Database Helper
class HkdInfoDatabaseHelper {
  static final HkdInfoDatabaseHelper _instance =
      HkdInfoDatabaseHelper._internal();

  factory HkdInfoDatabaseHelper() {
    return _instance;
  }

  HkdInfoDatabaseHelper._internal();

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
      CREATE TABLE hkd_info (
        id TEXT PRIMARY KEY,
        ten_hkd TEXT NOT NULL,
        dia_chi_tru_so TEXT,
        ma_so_thue TEXT NOT NULL,
        so_cccd_nguoi_dai_dien TEXT,
        ho_ten_nguoi_dai_dien TEXT,
        phuong_phap_tinh_gia_xuat_kho TEXT NOT NULL DEFAULT 'BINH_QUAN',
        trang_thai TEXT NOT NULL DEFAULT 'HOAT_DONG',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }
}
