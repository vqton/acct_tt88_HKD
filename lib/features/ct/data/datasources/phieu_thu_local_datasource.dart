/// Data source interface for local persistence of receipt voucher (phiếu thu) data.
/// 
/// This interface defines the contract for accessing receipt voucher data from local storage
/// (e.g., SQLite database) according to UC_HKD_TT88_2021 - CT-01: Lập phiếu thu.
/// 
/// Implementations should handle the technical details of data access while returning
/// appropriate data types for use by the repository layer.
abstract class PhieuThuLocalDatasource {
  /// Creates a new receipt voucher in the local data store
  /// 
  /// [phieuThuModel] The receipt voucher model to create
  /// @return A Future containing the ID of the created voucher
  Future<String> createPhieuThu(PhieuThuModel phieuThuModel);
  
  /// Retrieves a receipt voucher by its ID from the local data store
  /// 
  /// [id] The unique identifier of the receipt voucher to retrieve
  /// @return A Future containing the PhieuThuModel if found (null if not found)
  Future<PhieuThuModel?> getPhieuThuById(String id);
  
  /// Retrieves all receipt vouchers from the local data store
  /// 
  /// @return A Future containing a List of all PhieuThuModel objects
  Future<List<PhieuThuModel>> getPhieuThuList();
  
  /// Updates an existing receipt voucher in the local data store
  /// 
  /// [phieuThuModel] The receipt voucher model with updated information
  /// @return A Future void on success
  Future<void> updatePhieuThu(PhieuThuModel phieuThuModel);
  
  /// Deletes a receipt voucher from the local data store by its ID
  /// 
  /// [id] The unique identifier of the receipt voucher to delete
  /// @return A Future void on success
  Future<void> deletePhieuThu(String id);
}