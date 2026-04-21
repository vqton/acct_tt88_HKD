// ============================================================================
// Data Layer - Local Datasource
// Based on UC_HKD_TT88_2021 - TT-01
// ============================================================================

import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hkd_accounting/features/tt/domain/entities/quy_tien_mat.dart';
import 'package:hkd_accounting/features/tt/data/models/quy_tien_mat_model.dart';

abstract class QuyTienMatLocalDatasource {
  Future<List<QuyTienMatModel>> getQuyTienMatList();
  Future<QuyTienMatModel?> getQuyTienMatById(String id);
  Future<String> saveQuyTienMat(QuyTienMatModel quyTienMatModel);
  Future<void> updateQuyTienMat(QuyTienMatModel quyTienMatModel);
  Future<void> deleteQuyTienMat(String id);
  Future<List<QuyTienMatModel>> searchQuyTienMat(String query);
}

class QuyTienMatLocalDatasourceImpl implements QuyTienMatLocalDatasource {
  final Database _database;

  QuyTienMatLocalDatasourceImpl(this._database);

  @override
  Future<List<QuyTienMatModel>> getQuyTienMatList() async {
    final List<Map<String, dynamic>> maps = await _database.query('quy_tien_mat');
    return List.generate(maps.length, (i) {
      return QuyTienMatModel.fromMap(maps[i]);
    });
  }

  @override
  Future<QuyTienMatModel?> getQuyTienMatById(String id) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'quy_tien_mat',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return QuyTienMatModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<String> saveQuyTienMat(QuyTienMatModel quyTienMatModel) async {
    // Check if record already exists
    final existing = await getQuyTienMatById(quyTienMatModel.id);
    if (existing != null) {
      await updateQuyTienMat(quyTienMatModel);
      return existing.id;
    } else {
      final id = await _database.insert(
        'quy_tien_mat',
        quyTienMatModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return id.toString();
    }
  }

  @override
  Future<void> updateQuyTienMat(QuyTienMatModel quyTienMatModel) async {
    await _database.update(
      'quy_tien_mat',
      quyTienMatModel.toMap(),
      where: 'id = ?',
      whereArgs: [quyTienMatModel.id],
    );
  }

  @override
  Future<void> deleteQuyTienMat(String id) async {
    await _database.delete(
      'quy_tien_mat',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<QuyTienMatModel>> searchQuyTienMat(String query) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'quy_tien_mat',
      where: 'ma_quy LIKE ? OR ten_quy LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );
    return List.generate(maps.length, (i) {
      return QuyTienMatModel.fromMap(maps[i]);
    });
  }
}

// Database Helper
class QuyTienMatDatabaseHelper {
  static final QuyTienMatDatabaseHelper _instance =
      QuyTienMatDatabaseHelper._internal();

  factory QuyTienMatDatabaseHelper() {
    return _instance;
  }

  QuyTienMatDatabaseHelper._internal();

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
      CREATE TABLE quy_tien_mat (
        id TEXT PRIMARY KEY,
        ma_quy TEXT NOT NULL,
        ten_quy TEXT NOT NULL,
        so_du_dau_ky REAL NOT NULL DEFAULT 0,
        tong_thu REAL NOT NULL DEFAULT 0,
        tong_chi REAL NOT NULL DEFAULT 0,
        so_du_cuoi_ky REAL NOT NULL DEFAULT 0,
        ky_ke_toan_id TEXT NOT NULL,
        trang_thai TEXT NOT NULL DEFAULT 'DANG_SU_DUNG',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }
}