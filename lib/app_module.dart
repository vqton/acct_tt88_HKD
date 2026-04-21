// ============================================================================
// Dependency Injection Module
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  
  // Register the datasource
  // getIt.registerLazySingleton<NgheNghiepLocalDatasource>(() {
  //   // We would need to get the database instance here
  //   // For now, returning null as placeholder
  //   return null;
  // });
  
  // Register the repository
  // getIt.registerLazySingleton<NgheNghiepRepository>(() {
  //   final datasource = getIt.get<NgheNghiepLocalDatasource>();
  //   return NgheNghiepRepositoryImpl(datasource);
  // });
  
  // For now, we'll comment out the DI setup since we need to properly
  // set up the database first. In a real implementation, this would be done.
  
  // TODO: Properly set up database dependency injection
}