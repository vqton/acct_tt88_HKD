// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - MD-07
// ============================================================================

import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/tai_khoan_ngan_hang.dart';
import 'package:hkd_accounting/features/master_data/data/models/tai_khoan_ngan_hang_model.dart';

abstract class TaiKhoanNganHangLocalDatasource {
  Future<List<TaiKhoanNganHangModel>> getTaiKhoanNganHangList();
  Future<TaiKhoanNganHangModel?> getTaiKhoanNganHangById(String id);
  Future<String> saveTaiKhoanNganHang(TaiKhoanNganHangModel taiKhoanNganHangModel);
  Future<void> updateTaiKhoanNganHang(TaiKhoanNganHangModel taiKhoanNganHangModel);
  Future<void> deleteTaiKhoanNganHang(String id);
  Future<List<TaiKhoanNganHangModel>> searchTaiKhoanNganHang(String query);
}

class TaiKhoanNganHangLocalDatasourceImpl implements TaiKhoanNganHangLocalDatasource {
  final Database _database;

  TaiKhoanNganHangLocalDatasourceImpl(this._database);

  @override
  Future<List<TaiKhoanNganHangModel>> getTaiKhoanNganHangList() async {
    final List<Map<String, dynamic>> maps = await _database.query('tai_khoan_ngan_hang');
    return List.generate(maps.length, (i) {
      return TaiKhoanNganHangModel.fromMap(maps[i]);
    });
  }

  @override
  Future<TaiKhoanNganHangModel?> getTaiKhoanNganHangById(String id) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'tai_khoan_ngan_hang',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return TaiKhoanNganHangModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<String> saveTaiKhoanNganHang(TaiKhoanNganHangModel taiKhoanNganHangModel) async {
    // Check if record already exists
    final existing = await getTaiKhoanNganHangById(taiKhoanNganHangModel.id);
    if (existing != null) {
      await updateTaiKhoanNganHang(taiKhoanNganHangModel);
      return existing.id;
    } else {
      final id = await _database.insert(
        'tai_khoan_ngan_hang',
        taiKhoanNganHangModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id.toString();
    }
  }

  @override
  Future<void> updateTaiKhoanNganHang(TaiKhoanNganHangModel taiKhoanNganHangModel) async {
    await _database.update(
      'tai_khoan_ngan_hang',
      taiKhoanNganHangModel.toMap(),
      where: 'id = ?',
      whereArgs: [taiKhoanNganHangModel.id],
    );
  }

  @override
  Future<void> deleteTaiKhoanNganHang(String id) async {
    await _database.delete(
      'tai_khoan_ngan_hang',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<TaiKhoanNganHangModel>> searchTaiKhoanNganHang(String query) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'tai_khoan_ngan_hang',
      where: 'ma_tai_khoan LIKE ? OR ten_tai_khoan LIKE ? OR ten_ngan_hang LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
    );
    return List.generate(maps.length, (i) {
      return TaiKhoanNganHangModel.fromMap(maps[i]);
    });
  }
}

// Database Helper
class TaiKhoanNganHangDatabaseHelper {
  static final TaiKhoanNganHangDatabaseHelper _instance =
      TaiKhoanNganHangDatabaseHelper._internal();

  factory TaiKhoanNganHangDatabaseHelper() {
    return _instance;
  }

  TaiKhoanNganHangDatabaseHelper._internal();

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
      CREATE TABLE tai_khoan_ngan_hang (
        id TEXT PRIMARY KEY,
        ma_tai_khoan TEXT NOT NULL,
        ten_tai_khoan TEXT NOT NULL,
        ten_ngan_hang TEXT,
        chi_nhanh TEXT,
        so_tai_khoan TEXT,
        loai_tai_khoan TEXT,
        dia_chi_ngan_hang TEXT,
        so_dien_thoai_ngan_hang TEXT,
        email_ngan_hang TEXT,
        trang_thai TEXT NOT NULL DEFAULT 'HOAT_DONG',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }
}