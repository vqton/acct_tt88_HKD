import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hkd_accounting/features/master_data/data/datasources/nghe_nghiep_local_datasource.dart';
import 'package:hkd_accounting/features/master_data/data/repositories/nghe_nghiep_repository_impl.dart';
import 'package:hkd_accounting/features/master_data/domain/repositories/nghe_nghiep_repository.dart';
import 'package:hkd_accounting/features/master_data/data/datasources/hkd_info_local_datasource.dart';
import 'package:hkd_accounting/features/master_data/data/repositories/hkd_info_repository_impl.dart';
import 'package:hkd_accounting/features/master_data/domain/repositories/hkd_info_repository.dart';
import 'package:hkd_accounting/features/master_data/data/models/hkd_info_model.dart';
import 'package:hkd_accounting/features/master_data/data/datasources/ky_ke_toan_local_datasource.dart';
import 'package:hkd_accounting/features/master_data/data/repositories/ky_ke_toan_repository_impl.dart';
import 'package:hkd_accounting/features/master_data/domain/repositories/ky_ke_toan_repository.dart';
import 'package:hkd_accounting/features/master_data/data/models/ky_ke_toan_model.dart';
import 'package:hkd_accounting/lib/main_page.dart';
import 'dart:io' show Directory;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> _initializeDatabase() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Directory documentsDirectory = await getApplicationDocumentsDirectory();
  final String path = join(documentsDirectory.path, 'hkd_accounting.db');
  
  return await openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      // Create HKD info table
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
      
      // Create nghe nghieu table
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
      
      // Create ky ke toan table
      await db.execute('''
        CREATE TABLE ky_ke_toan (
          id TEXT PRIMARY KEY,
          nam_tai_chinh INTEGER NOT NULL,
          ngay_bat_dau_ky TEXT NOT NULL,
          ngay_ket_thuc_ky TEXT NOT NULL,
          trang_thai_ky TEXT NOT NULL,
          ngay_khoa_so_thuc_te TEXT,
          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
      ''');
    },
  );
}

void setupDependencies(Database database) {
  // Register datasources
  getIt.registerLazySingleton<HkdInfoLocalDatasource>(() => HkdInfoLocalDatasourceImpl(database));
  getIt.registerLazySingleton<NgheNghiepLocalDatasource>(() => NgheNghiepLocalDatasourceImpl(database));
  getIt.registerLazySingleton<KyKeToanLocalDatasource>(() => KyKeToanLocalDatasourceImpl(database));
  
  // Register repositories
  getIt.registerLazySingleton<HkdInfoRepository>(() => HkdInfoRepositoryImpl(getIt.get<HkdInfoLocalDatasource>()));
  getIt.registerLazySingleton<NgheNghiepRepository>(() => NgheNghiepRepositoryImpl(getIt.get<NgheNghiepLocalDatasource>()));
  getIt.registerLazySingleton<KyKeToanRepository>(() => KyKeToanRepositoryImpl(getIt.get<KyKeToanLocalDatasource>()));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize database
  final database = await _initializeDatabase();
  
  // Setup dependencies
  setupDependencies(database);
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Hệ thống Kế toán HKD/CNKD',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}