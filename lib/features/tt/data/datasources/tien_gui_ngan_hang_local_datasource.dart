// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - TT-02
// ============================================================================

import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hkd_accounting/features/tt/domain/entities/tien_gui_ngan_hang.dart';
import 'package:hkd_accounting/features/tt/data/models/tien_gui_ngan_hang_model.dart';

abstract class TienGuiNganHangLocalDatasource {
  Future<List<TienGuiNganHangModel>> getTienGuiNganHangList();
  Future<TienGuiNganHangModel?> getTienGuiNganHangById(String id);
  Future<String> saveTienGuiNganHang(TienGuiNganHangModel tienGuiNganHangModel);
  Future<void> updateTienGuiNganHang(TienGuiNganHangModel tienGuiNganHangModel);
  Future<void> deleteTienGuiNganHang(String id);
  Future<List<TienGuiNganHangModel>> searchTienGuiNganHang(String query);
}

class TienGuiNganHangLocalDatasourceImpl implements TienGuiNganHangLocalDatasource {
  final Database _database;

  TienGuiNganHangLocalDatasourceImpl(this._database);

  @override
  Future<List<TienGuiNganHangModel>> getTienGuiNganHangList() async {
    final List<Map<String, dynamic>> maps = await _database.query('tien_gui_ngan_hang');
    return List.generate(maps.length, (i) {
      return TienGuiNganHangModel.fromMap(maps[i]);
    });
  }

  @override
  Future<TienGuiNganHangModel?> getTienGuiNganHangById(String id) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'tien_gui_ngan_hang',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return TienGuiNganHangModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<String> saveTienGuiNganHang(TienGuiNganHangModel tienGuiNganHangModel) async {
    // Check if record already exists
    final existing = await getTienGuiNganHangById(tienGuiNganHangModel.id);
    if (existing != null) {
      await updateTienGuiNganHang(tienGuiNganHangModel);
      return existing.id;
    } else {
      final id = await _database.insert(
        'tien_gui_ngan_hang',
        tienGuiNganHangModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id.toString();
    }
  }

  @override
  Future<void> updateTienGuiNganHang(TienGuiNganHangModel tienGuiNganHangModel) async {
    await _database.update(
      'tien_gui_ngan_hang',
      tienGuiNganHangModel.toMap(),
      where: 'id = ?',
      whereArgs: [tienGuiNganHangModel.id],
    );
  }

  @override
  Future<void> deleteTienGuiNganHang(String id) async {
    await _database.delete(
      'tien_gui_ngan_hang',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<TienGuiNganHangModel>> searchTienGuiNganHang(String query) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'tien_gui_ngan_hang',
      where: 'ma_tai_khoan LIKE ? OR ten_tai_khoan LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );
    return List.generate(maps.length, (i) {
      return TienGuiNganHangModel.fromMap(maps[i]);
    });
  }
}

// Database Helper
class TienGuiNganHangDatabaseHelper {
  static final TienGuiNganHangDatabaseHelper _instance =
      TienGuiNganHangDatabaseHelper._internal();

  factory TienGuiNganHangDatabaseHelper() {
    return _instance;
  }

  TienGuiNganHangDatabaseHelper._internal();

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
      CREATE TABLE tien_gui_ngan_hang (
        id TEXT PRIMARY KEY,
        ma_tai_khoan TEXT NOT NULL,
        ten_tai_khoan TEXT NOT NULL,
        so_du_dau_ky REAL NOT NULL DEFAULT 0,
        tong_thu REAL NOT NULL DEFAULT 0,
        tong_chi REAL NOT NULL DEFAULT 0,
        so_du_cuoi_ky REAL NOT NULL DEFAULT 0,
        ky_ke_toan_id TEXT NOT NULL,
        trang_thai TEXT NOT NULL DEFAULT 'HOAT_DONG',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }
}