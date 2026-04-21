// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - MD-06
// ============================================================================

import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/nguoi_lao_dong.dart';
import 'package:hkd_accounting/features/master_data/data/models/nguoi_lao_dong_model.dart';

abstract class NguoiLaoDongLocalDatasource {
  Future<List<NguoiLaoDongModel>> getNguoiLaoDongList();
  Future<NguoiLaoDongModel?> getNguoiLaoDongById(String id);
  Future<String> saveNguoiLaoDong(NguoiLaoDongModel nguoiLaoDongModel);
  Future<void> updateNguoiLaoDong(NguoiLaoDongModel nguoiLaoDongModel);
  Future<void> deleteNguoiLaoDong(String id);
  Future<List<NguoiLaoDongModel>> searchNguoiLaoDong(String query);
}

class NguoiLaoDongLocalDatasourceImpl implements NguoiLaoDongLocalDatasource {
  final Database _database;

  NguoiLaoDongLocalDatasourceImpl(this._database);

  @override
  Future<List<NguoiLaoDongModel>> getNguoiLaoDongList() async {
    final List<Map<String, dynamic>> maps = await _database.query('nguoi_lao_dong');
    return List.generate(maps.length, (i) {
      return NguoiLaoDongModel.fromMap(maps[i]);
    });
  }

  @override
  Future<NguoiLaoDongModel?> getNguoiLaoDongById(String id) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'nguoi_lao_dong',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return NguoiLaoDongModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<String> saveNguoiLaoDong(NguoiLaoDongModel nguoiLaoDongModel) async {
    // Check if record already exists
    final existing = await getNguoiLaoDongById(nguoiLaoDongModel.id);
    if (existing != null) {
      await updateNguoiLaoDong(nguoiLaoDongModel);
      return existing.id;
    } else {
      final id = await _database.insert(
        'nguoi_lao_dong',
        nguoiLaoDongModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id.toString();
    }
  }

  @override
  Future<void> updateNguoiLaoDong(NguoiLaoDongModel nguoiLaoDongModel) async {
    await _database.update(
      'nguoi_lao_dong',
      nguoiLaoDongModel.toMap(),
      where: 'id = ?',
      whereArgs: [nguoiLaoDongModel.id],
    );
  }

  @override
  Future<void> deleteNguoiLaoDong(String id) async {
    await _database.delete(
      'nguoi_lao_dong',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<NguoiLaoDongModel>> searchNguoiLaoDong(String query) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'nguoi_lao_dong',
      where: 'ma_nguoi_lao_dong LIKE ? OR ho_ten LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );
    return List.generate(maps.length, (i) {
      return NguoiLaoDongModel.fromMap(maps[i]);
    });
  }
}

// Database Helper
class NguoiLaoDongDatabaseHelper {
  static final NguoiLaoDongDatabaseHelper _instance =
      NguoiLaoDongDatabaseHelper._internal();

  factory NguoiLaoDongDatabaseHelper() {
    return _instance;
  }

  NguoiLaoDongDatabaseHelper._internal();

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
      CREATE TABLE nguoi_lao_dong (
        id TEXT PRIMARY KEY,
        ma_nguoi_lao_dong TEXT NOT NULL,
        ho_ten TEXT NOT NULL,
        ngay_sinh TIMESTAMP,
        gioi_tinh TEXT,
        so_cccd TEXT,
        so_bhxh TEXT,
        chuc_vu TEXT,
        bo_phan TEXT,
        dia_chi TEXT,
        so_dien_thoai TEXT,
        email TEXT,
        ngay_vao_lam TIMESTAMP,
        ngay_ngung_hop_dong TIMESTAMP,
        he_so_luong REAL,
        luong_co_ban REAL,
        trang_thai TEXT NOT NULL DEFAULT 'DANG_LAM_VIEC',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }
}