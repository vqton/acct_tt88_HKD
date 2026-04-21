// ============================================================================
// TDD - Data Layer Tests
// Based on UC_HKD_TT88_2021 - CT-01: Lập phiếu thu
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hkd_accounting/features/ct/data/datasources/phieu_thu_local_datasource.dart';
import 'package:hkd_accounting/features/ct/data/models/phieu_thu_model.dart';
import 'package:hkd_accounting/features/ct/data/repositories/phieu_thu_repository_impl.dart';

// Mock datasource
class MockPhieuThuLocalDatasource extends Mock implements PhieuThuLocalDatasource {}

void main() {
  late PhieuThuRepositoryImpl repository;
  late MockPhieuThuLocalDatasource mockDatasource;
  
  setUp(() {
    mockDatasource = MockPhieuThuLocalDatasource();
    repository = PhieuThuRepositoryImpl(mockDatasource);
  });
  
  const tPhieuThuModel = PhieuThuModel(
    id: 'PT001',
    soPhieu: 'PT001',
    ngayLap: DateTime(2023, 1, 15),
    nguoiNop: 'Nguyen Van A',
    diaChiNguoiNop: '123 Street, District 1, HCMC',
    lyDoNop: 'Thanh toan hoa don ban hang',
    soTien: 1000000,
    soTienBangChu: 'Mot tram nghin dong',
    chungTuGocKemTheo: 'HD001',
    hkdInfoId: 'HKD001',
    khachHangId: 'KH001',
    kyKeToanId: 'KKT001',
    trangThai: 'CHO_DUYET',
    createdAt: DateTime(2023, 1, 15),
  );
  
  const tPhieuThu = PhieuThu(
    id: 'PT001',
    soPhieu: 'PT001',
    ngayLap: DateTime(2023, 1, 15),
    nguoiNop: 'Nguyen Van A',
    diaChiNguoiNop: '123 Street, District 1, HCMC',
    lyDoNop: 'Thanh toan hoa don ban hang',
    soTien: 1000000,
    soTienBangChu: 'Mot tram nghin dong',
    chungTuGocKemTheo: 'HD001',
    hkdInfoId: 'HKD001',
    khachHangId: 'KH001',
    kyKeToanId: 'KKT001',
    trangThai: 'CHO_DUYET',
    createdAt: DateTime(2023, 1, 15),
  );

  group('CreatePhieuThu Tests', () {
    test('should create phieu thu successfully', () async {
      // Arrange
      when(() => mockDatasource.createPhieuThu(any()))
          .thenAnswer((_) async => 'PT001');
       
      // Act
      final result = await repository.createPhieuThu(tPhieuThu);
       
      // Assert
      expect(result, equals(const Right<dynamic, String>('PT001')));
      verify(() => mockDatasource.createPhieuThu(tPhieuThuModel)).called(1);
      verifyNoMoreInteractions(mockDatasource);
    });
  });
  
  group('GetPhieuThuById Tests', () {
    test('should return phieu thu when call is successful', () async {
      // Arrange
      when(() => mockDatasource.getPhieuThuById(any()))
          .thenAnswer((_) async => tPhieuThuModel);
       
      // Act
      final result = await repository.getPhieuThuById('PT001');
       
      // Assert
      expect(result, equals(const Right<dynamic, PhieuThu?>(tPhieuThu)));
      verify(() => mockDatasource.getPhieuThuById('PT001')).called(1);
      verifyNoMoreInteractions(mockDatasource);
    });
    
    test('should return null when no phieu thu exists', () async {
      // Arrange
      when(() => mockDatasource.getPhieuThuById(any()))
          .thenAnswer((_) async => null);
       
      // Act
      final result = await repository.getPhieuThuById('PT001');
       
      // Assert
      expect(result, equals(const Right<dynamic, PhieuThu?>(null)));
      verify(() => mockDatasource.getPhieuThuById('PT001')).called(1);
      verifyNoMoreInteractions(mockDatasource);
    });
  });
  
  group('GetPhieuThuList Tests', () {
    test('should return list of phieu thus when call is successful', () async {
      // Arrange
      when(() => mockDatasource.getPhieuThuList())
          .thenAnswer((_) async => [tPhieuThuModel]);
       
      // Act
      final result = await repository.getPhieuThuList();
       
      // Assert
      expect(result, equals(const Right<dynamic, List<PhieuThu>>([tPhieuThu])));
      verify(() => mockDatasource.getPhieuThuList()).called(1);
      verifyNoMoreInteractions(mockDatasource);
    });
  });
  
  group('UpdatePhieuThu Tests', () {
    test('should update phieu thu successfully', () async {
      // Arrange
      when(() => mockDatasource.updatePhieuThu(any()))
          .thenAnswer((_) async => null);
       
      // Act
      final result = await repository.updatePhieuThu(tPhieuThu);
       
      // Assert
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(() => mockDatasource.updatePhieuThu(tPhieuThuModel)).called(1);
      verifyNoMoreInteractions(mockDatasource);
    });
  });
  
  group('DeletePhieuThu Tests', () {
    test('should delete phieu thu successfully', () async {
      // Arrange
      when(() => mockDatasource.deletePhieuThu(any()))
          .thenAnswer((_) async => null);
       
      // Act
      final result = await repository.deletePhieuThu('PT001');
       
      // Assert
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(() => mockDatasource.deletePhieuThu('PT001')).called(1);
      verifyNoMoreInteractions(mockDatasource);
    });
  });
}