// ============================================================================
// Domain Layer - Repository Interface
// Based on UC_HKD_TT88_2021 - TT-01: Quản lý quỹ tiền mặt
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/tt/domain/entities/quy_tien_mat.dart';

abstract class QuyTienMatRepository {
  /// Creates a new cash fund in the data store
  /// 
  /// [quyTienMat] The cash fund to create
  /// @return A Future containing either a Failure or the created QuyTienMat
  Future<Either<Failure, QuyTienMat>> createQuyTienMat(QuyTienMat quyTienMat);
   
  /// Retrieves a cash fund by its ID
  /// 
  /// [id] The unique identifier of the cash fund to retrieve
  /// @return A Future containing either a Failure or the QuyTienMat if found (null if not found)
  Future<Either<Failure, QuyTienMat?>> getQuyTienMatById(String id);
   
  /// Retrieves all cash funds from the data store
  /// 
  /// @return A Future containing either a Failure or a List of all QuyTienMat objects
  Future<Either<Failure, List<QuyTienMat>>> getQuyTienMatList();
   
  /// Updates an existing cash fund in the data store
  /// 
  /// [quyTienMat] The cash fund with updated information
  /// @return A Future containing either a Failure or void on success
  Future<Either<Failure, void>> updateQuyTienMat(QuyTienMat quyTienMat);
   
  /// Deletes a cash fund from the data store by its ID
  /// 
  /// [id] The unique identifier of the cash fund to delete
  /// @return A Future containing either a Failure or void on success
  Future<Either<Failure, void>> deleteQuyTienMat(String id);
}