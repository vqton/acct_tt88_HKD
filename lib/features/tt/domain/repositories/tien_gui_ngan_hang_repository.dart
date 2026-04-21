// ============================================================================
// Domain Layer - Repository Interface
// Based on UC_HKD_TT88_2021 - TT-02: Quản lý tiền gửi ngân hàng
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/tt/domain/entities/tien_gui_ngan_hang.dart';

abstract class TienGuiNganHangRepository {
  /// Creates a new bank fund in the data store
  /// 
  /// [tienGuiNganHang] The bank fund to create
  /// @return A Future containing either a Failure or the created TienGuiNganHang
  Future<Either<Failure, TienGuiNganHang>> createTienGuiNganHang(TienGuiNganHang tienGuiNganHang);
   
  /// Retrieves a bank fund by its ID
  /// 
  /// [id] The unique identifier of the bank fund to retrieve
  /// @return A Future containing either a Failure or the TienGuiNganHang if found (null if not found)
  Future<Either<Failure, TienGuiNganHang?>> getTienGuiNganHangById(String id);
   
  /// Retrieves all bank funds from the data store
  /// 
  /// @return A Future containing either a Failure or a List of all TienGuiNganHang objects
  Future<Either<Failure, List<TienGuiNganHang>>> getTienGuiNganHangList();
   
  /// Updates an existing bank fund in the data store
  /// 
  /// [tienGuiNganHang] The bank fund with updated information
  /// @return A Future containing either a Failure or void on success
  Future<Either<Failure, void>> updateTienGuiNganHang(TienGuiNganHang tienGuiNganHang);
   
  /// Deletes a bank fund from the data store by its ID
  /// 
  /// [id] The unique identifier of the bank fund to delete
  /// @return A Future containing either a Failure or void on success
  Future<Either<Failure, void>> deleteTienGuiNganHang(String id);
}