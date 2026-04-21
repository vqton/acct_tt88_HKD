// ============================================================================
// TDD - Domain Layer Tests - Use Cases
// Based on UC_HKD_TT88_2021 - CT-01: Lập phiếu thu
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_thu.dart';
import 'package:hkd_accounting/features/ct/domain/repositories/phieu_thu_repository.dart';
import 'package:hkd_accounting/features/ct/domain/usecases/create_phieu_thu.dart';
import 'package:mocktail/mocktail.dart';

// Mock repository
class MockPhieuThuRepository extends Mock implements PhieuThuRepository {}

void main() {
  late CreatePhieuThu usecase;
  late MockPhieuThuRepository mockRepository;

  setUp(() {
    mockRepository = MockPhieuThuRepository();
    usecase = CreatePhieuThu(mockRepository);
  });

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

  group('CreatePhieuThu', () {
    test('should get phieu thu from repository', () async {
      // arrange
      when(() => mockRepository.createPhieuThu(any()))
          .thenAnswer((_) async => const Right(tPhieuThu));

      // act
      final result = await usecase(tPhieuThu);

      // assert
      expect(result, equals(const Right<Failure, PhieuThu>(tPhieuThu)));
      verify(() => mockRepository.createPhieuThu(tPhieuThu));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return database failure when repository fails', () async {
      // arrange
      when(() => mockRepository.createPhieuThu(any()))
          .thenAnswer((_) async => Left(DatabaseFailure('Database error')));

      // act
      final result = await usecase(tPhieuThu);

      // assert
      expect(result, equals(Left<Failure, PhieuThu>(DatabaseFailure('Database error'))));
      verify(() => mockRepository.createPhieuThu(tPhieuThu));
    });
  });
}