// ============================================================================
// Domain Layer - Repository Interface
// Based on UC_HKD_TT88_2021 - CT-02: Lập phiếu chi
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_chi.dart';

abstract class PhieuChiRepository {
  /// Creates a new payment voucher in the data store
  /// 
  /// [phieuChi] The payment voucher to create
  /// @return A Future containing either a Failure or the created PhieuChi
  Future<Either<Failure, PhieuChi>> createPhieuChi(PhieuChi phieuChi);
   
  /// Retrieves a payment voucher by its ID
  /// 
  /// [id] The unique identifier of the payment voucher to retrieve
  /// @return A Future containing either a Failure or the PhieuChi if found (null if not found)
  Future<Either<Failure, PhieuChi?>> getPhieuChiById(String id);
   
  /// Retrieves all payment vouchers from the data store
  /// 
  /// @return A Future containing either a Failure or a List of all PhieuChi objects
  Future<Either<Failure, List<PhieuChi>>> getPhieuChiList();
   
  /// Updates an existing payment voucher in the data store
  /// 
  /// [phieuChi] The payment voucher with updated information
  /// @return A Future containing either a Failure or void on success
  Future<Either<Failure, void>> updatePhieuChi(PhieuChi phieuChi);
   
  /// Deletes a payment voucher from the data store by its ID
  /// 
  /// [id] The unique identifier of the payment voucher to delete
  /// @return A Future containing either a Failure or void on success
  Future<Either<Failure, void>> deletePhieuChi(String id);
}