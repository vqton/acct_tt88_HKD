// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - MD-03
// ============================================================================

import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/nghe_nghiep.dart';
import 'package:hkd_accounting/features/master_data/data/models/nghe_nghiep_model.dart';

abstract class NgheNghiepLocalDatasource {
  Future<List<NgheNghiepModel>> getNgheNghiepList();
  Future<NgheNghiepModel?> getNgheNghiepById(String id);
  Future<String> saveNgheNghiep(NgheNghiepModel ngheNghieuModel);
  Future<void> updateNgheNghiep(NgheNghiepModel ngheNghieuModel);
  Future<void> deleteNgheNghiep(String id);
  Future<NgheNghiepModel?> getApplicableNgheNghiep(DateTime date);
}

class NgheNghiepLocalDatasourceImpl implements NgheNghiepLocalDatasource {
  final Database _database;

  NgheNghiepLocalDatasourceImpl(this._database);

  @override
  Future<List<NgheNghiepModel>> getNgheNghiepList() async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'nghe_nghiep',
      orderBy: 'ma_nhom_nghe_nghe',
    );

    return List.generate(maps.length, (i) {
      return NgheNghiepModel.fromMap(maps[i]);
    });
  }

  @override
  Future<NgheNghiepModel?> getNgheNghiepById(String id) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'nghe_nghiep',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return NgheNghiepModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<String> saveNgheNghiep(NgheNghiepModel ngheNghieuModel) async {
    // Check if record already exists
    final existing = await getNgheNghiepById(ngheNghieuModel.id);
    if (existing != null) {
      await updateNgheNghiep(ngheNghieuModel);
      return existing.id;
    } else {
      final id = await _database.insert(
        'nghe_nghiep',
        ngheNghieuModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id.toString();
    }
  }

  @override
  Future<void> updateNgheNghiep(NgheNghiepModel ngheNghieuModel) async {
    await _database.update(
      'nghe_nghiep',
      ngheNghieuModel.toMap(),
      where: 'id = ?',
      whereArgs: [ngheNghieuModel.id],
    );
  }

  @override
  Future<void> deleteNgheNghiep(String id) async {
    await _database.delete(
      'nghe_nghiep',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<NgheNghiepModel?> getApplicableNgheNghiep(DateTime date) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'nghe_nghiep',
      where: 'ngay_hieu_luc <= ? AND (ngay_het_hieu_luc IS NULL OR ngay_het_hieu_luc >= ?)',
      whereArgs: [date.toIso8601String(), date.toIso8601String()],
      orderBy: 'ngay_hieu_luc DESC',
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return NgheNghiepModel.fromMap(maps.first);
    }
    return null;
  }
}

// Database Helper
class NgheNghiepDatabaseHelper {
  static final NgheNghiepDatabaseHelper _instance =
      NgheNghiepDatabaseHelper._internal();

  factory NgheNghiepDatabaseHelper() {
    return _instance;
  }

  NgheNghiepDatabaseHelper._internal();

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
      CREATE TABLE nghe_nghiep (
        id TEXT PRIMARY KEY,
        ma_nhom_nghe_nghe TEXT NOT NULL,
        ten_nhom_nghe_nghe TEXT NOT NULL,
        ty_le_thue_gtgt REAL NOT NULL,
        ty_le_thue_tncn REAL NOT NULL,
        ngay_hieu_luc TEXT NOT NULL,
        ngay_het_hieu_luc TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }
}