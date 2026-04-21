// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - MD-02
// ============================================================================

import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/hang_hoa.dart';
import 'package:hkd_accounting/features/master_data/data/models/hang_hoa_model.dart';

abstract class HangHoaLocalDatasource {
  Future<List<HangHoaModel>> getHangHoaList();
  Future<HangHoaModel?> getHangHoaById(String id);
  Future<String> saveHangHoa(HangHoaModel hangHoaModel);
  Future<void> updateHangHoa(HangHoaModel hangHoaModel);
  Future<void> deleteHangHoa(String id);
  Future<List<HangHoaModel>> searchHangHoa(String query);
}

class HangHoaLocalDatasourceImpl implements HangHoaLocalDatasource {
  final Database _database;

  HangHoaLocalDatasourceImpl(this._database);

  @override
  Future<List<HangHoaModel>> getHangHoaList() async {
    final List<Map<String, dynamic>> maps = await _database.query('hang_hoa');
    return List.generate(maps.length, (i) {
      return HangHoaModel.fromMap(maps[i]);
    });
  }

  @override
  Future<HangHoaModel?> getHangHoaById(String id) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'hang_hoa',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return HangHoaModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<String> saveHangHoa(HangHoaModel hangHoaModel) async {
    // Check if record already exists
    final existing = await getHangHoaById(hangHoaModel.id);
    if (existing != null) {
      await updateHangHoa(hangHoaModel);
      return existing.id;
    } else {
      final id = await _database.insert(
        'hang_hoa',
        hangHoaModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id.toString();
    }
  }

  @override
  Future<void> updateHangHoa(HangHoaModel hangHoaModel) async {
    await _database.update(
      'hang_hoa',
      hangHoaModel.toMap(),
      where: 'id = ?',
      whereArgs: [hangHoaModel.id],
    );
  }

  @override
  Future<void> deleteHangHoa(String id) async {
    await _database.delete(
      'hang_hoa',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<HangHoaModel>> searchHangHoa(String query) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'hang_hoa',
      where: 'ma_hang_hoa LIKE ? OR ten_hang_hoa LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );
    return List.generate(maps.length, (i) {
      return HangHoaModel.fromMap(maps[i]);
    });
  }
}

// Database Helper
class HangHoaDatabaseHelper {
  static final HangHoaDatabaseHelper _instance =
      HangHoaDatabaseHelper._internal();

  factory HangHoaDatabaseHelper() {
    return _instance;
  }

  HangHoaDatabaseHelper._internal();

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
      CREATE TABLE hang_hoa (
        id TEXT PRIMARY KEY,
        ma_hang_hoa TEXT NOT NULL,
        ten_hang_hoa TEXT NOT NULL,
        don_vi_tinh TEXT,
        loai_hang_hoa TEXT,
        gia_von REAL,
        gia_ban REAL,
        mo_ta TEXT,
        trang_thai TEXT NOT NULL DEFAULT 'HOAT_DONG',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }
}