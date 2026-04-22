// ============================================================================
// Domain Layer - Repository Interface
// Based on UC_HKD_TT88_2021 - QT-01: Quản lý tài khoản người dùng & phân quyền
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/qt/domain/entities/nguoi_dung.dart';

abstract class NguoiDungRepository {
  Future<Either<Failure, List<NguoiDung>>> getNguoiDungList();
  Future<Either<Failure, NguoiDung?>> getNguoiDungById(String id);
  Future<Either<Failure, NguoiDung?>> getNguoiDungByEmail(String email);
  Future<Either<Failure, String>> saveNguoiDung(NguoiDung nguoiDung);
  Future<Either<Failure, void>> updateNguoiDung(NguoiDung nguoiDung);
  Future<Either<Failure, void>> deleteNguoiDung(String id);
  Future<Either<Failure, List<NguoiDung>>> searchNguoiDung(String query);
  Future<Either<Failure, NguoiDung?>> login(String email, String password);
}