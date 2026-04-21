/// Repository interface for receipt voucher (phiếu thu) data operations.
/// 
/// This interface defines the contract for persisting and retrieving receipt voucher data
/// according to UC_HKD_TT88_2021 - CT-01: Lập phiếu thu.
/// 
/// Implementations should handle data persistence (local/remote) and return results
/// wrapped in Either<Failure, Success> for proper error handling.
abstract class PhieuThuRepository {
  /// Creates a new receipt voucher in the data store
  /// 
  /// [phieuThu] The receipt voucher to create
  /// @return A Future containing either a Failure or the ID of the created voucher
  Future<Either<Failure, PhieuThu>> createPhieuThu(PhieuThu phieuThu);
  
  /// Retrieves a receipt voucher by its ID
  /// 
  /// [id] The unique identifier of the receipt voucher to retrieve
  /// @return A Future containing either a Failure or the PhieuThu if found (null if not found)
  Future<Either<Failure, PhieuThu?>> getPhieuThuById(String id);
  
  /// Retrieves all receipt vouchers from the data store
  /// 
  /// @return A Future containing either a Failure or a List of all PhieuThu objects
  Future<Either<Failure, List<PhieuThu>>> getPhieuThuList();
  
  /// Updates an existing receipt voucher in the data store
  /// 
  /// [phieuThu] The receipt voucher with updated information
  /// @return A Future containing either a Failure or void on success
  Future<Either<Failure, void>> updatePhieuThu(PhieuThu phieuThu);
  
  /// Deletes a receipt voucher from the data store by its ID
  /// 
  /// [id] The unique identifier of the receipt voucher to delete
  /// @return A Future containing either a Failure or void on success
  Future<Either<Failure, void>> deletePhieuThu(String id);
}