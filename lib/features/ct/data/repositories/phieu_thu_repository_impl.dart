/// Implementation of the PhieuThuRepository using a local data source.
/// 
/// This class handles the persistence of receipt voucher (phiếu thu) data
/// according to UC_HKD_TT88_2021 - CT-01: Lập phiếu thu.
/// 
/// It converts between domain entities and data models, and handles
/// error cases by wrapping exceptions in Failure objects.
class PhieuThuRepositoryImpl implements PhieuThuRepository {
  /// Local data source responsible for the actual data persistence
  final PhieuThuLocalDatasource localDatasource;

  /// Creates a new repository implementation with the given data source
  /// 
  /// [localDatasource] The data source used for persistence operations
  PhieuThuRepositoryImpl(this.localDatasource);

  /// Creates a new receipt voucher in the local data store
  /// 
  /// [phieuThu] The receipt voucher to create
  /// @return A Future containing either a Failure or the ID of the created voucher
  @override
  Future<Either<Failure, PhieuThu>> createPhieuThu(PhieuThu phieuThu) async {
    try {
      final id = await localDatasource.createPhieuThu(
        PhieuThuModel.fromEntity(phieuThu),
      );
      return Right(id);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  /// Retrieves a receipt voucher by its ID from the local data store
  /// 
  /// [id] The unique identifier of the receipt voucher to retrieve
  /// @return A Future containing either a Failure or the PhieuThu if found (null if not found)
  @override
  Future<Either<Failure, PhieuThu?>> getPhieuThuById(String id) async {
    try {
      final phieuThu = await localDatasource.getPhieuThuById(id);
      return Right(phieuThu?.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  /// Retrieves all receipt vouchers from the local data store
  /// 
  /// @return A Future containing either a Failure or a List of all PhieuThu objects
  @override
  Future<Either<Failure, List<PhieuThu>>> getPhieuThuList() async {
    try {
      final phieuThus = await localDatasource.getPhieuThuList();
      return Right(phieuThus.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  /// Updates an existing receipt voucher in the local data store
  /// 
  /// [phieuThu] The receipt voucher with updated information
  /// @return A Future containing either a Failure or void on success
  @override
  Future<Either<Failure, void>> updatePhieuThu(PhieuThu phieuThu) async {
    try {
      await localDatasource.updatePhieuThu(
        PhieuThuModel.fromEntity(phieuThu),
      );
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  /// Deletes a receipt voucher from the local data store by its ID
  /// 
  /// [id] The unique identifier of the receipt voucher to delete
  /// @return A Future containing either a Failure or void on success
  @override
  Future<Either<Failure, void>> deletePhieuThu(String id) async {
    try {
      await localDatasource.deletePhieuThu(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}