// ============================================================================
// Dependency Injection Module
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hkd_accounting/features/ct/data/datasources/phieu_thu_local_datasource.dart';
import 'package:hkd_accounting/features/ct/data/repositories/phieu_thu_repository_impl.dart';
import 'package:hkd_accounting/features/ct/domain/repositories/phieu_thu_repository.dart';
import 'package:hkd_accounting/features/ct/domain/usecases/create_phieu_thu.dart';
import 'package:hkd_accounting/features/master_data/data/datasources/nghe_nghiep_local_datasource.dart';
import 'package:hkd_accounting/features/master_data/data/repositories/nghe_nghiep_repository_impl.dart';
import 'package:hkd_accounting/features/master_data/domain/repositories/nghe_nghiep_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  // Set up Hive for local storage if needed
  // final dir = await getApplicationDocumentsDirectory();
  // Hive.init(dir.path);

  // Set up Sqflite database (shared with other modules)
  // For simplicity, we'll initialize the database here
  // In a real app, you might want a separate database helper
  // For now, we'll assume the database is initialized elsewhere
  
  // For this example, we'll create a simple implementation
  // In practice, you would inject the actual database instance
  
  // Register the datasources
  getIt.registerLazySingleton<NgheNghiepLocalDatasource>(() {
    // We would need to get the database instance here
    // For now, returning null as placeholder
    return null;
  });
  
  getIt.registerLazySingleton<PhieuThuLocalDatasource>(() {
    // We would need to get the database instance here
    // For now, returning null as placeholder
    return null;
  });
  
  // Register the repositories
  getIt.registerLazySingleton<NgheNghiepRepository>(() {
    final datasource = getIt.get<NgheNghiepLocalDatasource>();
    return NgheNghiepRepositoryImpl(datasource);
  });
  
  getIt.registerLazySingleton<PhieuThuRepository>(() {
    final datasource = getIt.get<PhieuThuLocalDatasource>();
    return PhieuThuRepositoryImpl(datasource);
  });
  
  // Register the use cases
  getIt.registerLazySingleton<CreatePhieuThu>(() {
    final repository = getIt.get<PhieuThuRepository>();
    return CreatePhieuThu(repository);
  });
}