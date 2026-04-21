/// Test file for the ApprovePhieuThu use case
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hkd_accounting/core/errors/failures.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_thu.dart';
import 'package:hkd_accounting/features/ct/domain/repositories/phieu_thu_repository.dart';
import 'package:hkd_accounting/features/ct/domain/usecases/approve_phieu_thu.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'approve_phieu_thu_test.mocks.dart';

@GenerateMocks([PhieuThuRepository])
void main() {
  late ApprovePhieuThu usecase;
  late MockPhieuThuRepository mockRepository;

  setUp(() {
    mockRepository = MockPhieuThuRepository();
    usecase = ApprovePhieuThu(mockRepository);
  });

  const tId = 'PT001';
  const tSoPhieu = 'PT001';
  const tNgayLap = DateTime(2023, 1, 15);
  const tNguoiNop = 'Nguyen Van A';
  const tDiaChiNguoiNop = '123 Street, District 1, HCMC';
  const tLyDoNop = 'Thanh toan hoa don ban hang';
  const tSoTien = 1000000;
  const tSoTienBangChu = 'Mot tram nghin dong';
  const tChungTuGocKemTheo = 'HD001';
  const tHkdInfoId = 'HKD001';
  const tKhachHangId = 'KH001';
  const tKyKeToanId = 'KKT001';

  group('ApprovePhieuThu Use Case Tests', () {
    test('should approve a phieu thu successfully', () async {
      // Arrange
      final phieuThu = PhieuThu(
        id: tId,
        soPhieu: tSoPhieu,
        ngayLap: tNgayLap,
        nguoiNop: tNguoiNop,
        diaChiNguoiNop: tDiaChiNguoiNop,
        lyDoNop: tLyDoNop,
        soTien: tSoTien,
        soTienBangChu: tSoTienBangChu,
        chungTuGocKemTheo: tChungTuGocKemTheo,
        hkdInfoId: tHkdInfoId,
        khachHangId: tKhachHangId,
        kyKeToanId: tKyKeToanId,
        trangThai: 'CHO_DUYET',
      );

      final approvedPhieuThu = phieuThu.copyWith(trangThai: 'DA_DUYET');

      when(mockRepository.getPhieuThuById(tId))
          .thenAnswer((_) async => Right(phieuThu));
      when(mockRepository.updatePhieuThu(any))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await usecase(tId);

      // Assert
      expect(result, Right(approvedPhieuThu));
      verify(mockRepository.getPhieuThuById(tId));
      verify(mockRepository.updatePhieuThu(argThat(
          (pt) => pt.trangThai == 'DA_DUYET' && pt.id == tId)));
    });

    test('should return failure when phieu thu not found', () async {
      // Arrange
      when(mockRepository.getPhieuThuById(tId))
          .thenAnswer((_) async => Left(EmptyFailure()));

      // Act
      final result = await usecase(tId);

      // Assert
      expect(result, Left(EmptyFailure()));
      verify(mockRepository.getPhieuThuById(tId));
      verifyNever(mockRepository.updatePhieuThu(any));
    });

    test('should return failure when update fails', () async {
      // Arrange
      final phieuThu = PhieuThu(
        id: tId,
        soPhieu: tSoPhieu,
        ngayLap: tNgayLap,
        nguoiNop: tNguoiNop,
        diaChiNguoiNop: tDiaChiNguoiNop,
        lyDoNop: tLyDoNop,
        soTien: tSoTien,
        soTienBangChu: tSoTienBangChu,
        chungTuGocKemTheo: tChungTuGocKemTheo,
        hkdInfoId: tHkdInfoId,
        khachHangId: tKhachHangId,
        kyKeToanId: tKyKeToanId,
        trangThai: 'CHO_DUYET',
      );

      when(mockRepository.getPhieuThuById(tId))
          .thenAnswer((_) async => Right(phieuThu));
      when(mockRepository.updatePhieuThu(any))
          .thenAnswer((_) async => Left(DatabaseFailure()));

      // Act
      final result = await usecase(tId);

      // Assert
      expect(result, Left(DatabaseFailure()));
      verify(mockRepository.getPhieuThuById(tId));
      verify(mockRepository.updatePhieuThu(any));
    });
  });
}