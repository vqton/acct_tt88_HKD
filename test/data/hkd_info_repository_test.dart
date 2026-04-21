// ============================================================================
// TDD - Master Data Repository Test
// Test Naming: [Feature]RepositoryTest.dart
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hkd_accounting/features/master_data/data/datasources/hkd_info_local_datasource.dart';
import 'package:hkd_accounting/features/master_data/data/models/hkd_info_model.dart';
import 'package:hkd_accounting/features/master_data/data/repositories/hkd_info_repository_impl.dart';

class MockHkdInfoLocalDatasource extends Mock implements HkdInfoLocalDatasource {}

void main() {
  late HkdInfoRepositoryImpl repository;
  late MockHkdInfoLocalDatasource mockDatasource;
  
  setUp(() {
    mockDatasource = MockHkdInfoLocalDatasource();
    repository = HkdInfoRepositoryImpl(mockDatasource);
  });
  
  group('GetHkdInfo Tests', () {
    final testModel = HkdInfoModel(
      id: '1',
      tenHkd: 'Cửa hàng tạp hóa Minh',
      diaChiTruSo: '123 Nguyễn Trãi',
      maSoThue: '0123456789',
      phuongPhapTinhGiaXuatKho: 'BINH_QUAN',
    );
    
    test('should return HKD info when call is successful', () async {
      // Arrange
      when(() => mockDatasource.getHkdInfo())
          .thenAnswer((_) async => testModel);
      
      // Act
      final result = await repository.getHkdInfo();
      
      // Assert
      expect(result, testModel);
      verify(() => mockDatasource.getHkdInfo()).called(1);
    });
    
    test('should return null when no HKD info exists', () async {
      // Arrange
      when(() => mockDatasource.getHkdInfo())
          .thenAnswer((_) async => null);
      
      // Act
      final result = await repository.getHkdInfo();
      
      // Assert
      expect(result, null);
    });
  });
  
  group('SaveHkdInfo Tests', () {
    test('should save HKD info successfully', () async {
      // Arrange
      when(() => mockDatasource.saveHkdInfo(any()))
          .thenAnswer((_) async => '1');
      
      // Act
      final result = await repository.saveHkdInfo(testModel);
      
      // Assert
      expect(result, '1');
      verify(() => mockDatasource.saveHkdInfo(testModel)).called(1);
    });
  });
}
