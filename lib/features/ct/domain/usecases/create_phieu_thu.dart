/// Use case for creating a new receipt voucher (phiếu thu).
/// 
/// This use case encapsulates the business logic for creating a receipt voucher
/// according to UC_HKD_TT88_2021 - CT-01: Lập phiếu thu.
/// 
/// The use case follows the Single Responsibility Principle - it only handles
/// the creation of receipt vouchers and delegates data persistence to the repository.
class CreatePhieuThu extends UseCase<PhieuThu, PhieuThu> {
  /// Repository responsible for persisting receipt voucher data
  final PhieuThuRepository repository;

  /// Creates a new instance of the CreatePhieuThu use case
  /// 
  /// [repository] The repository used to persist receipt voucher data
  CreatePhieuThu(this.repository);

  /// Executes the use case to create a receipt voucher
  /// 
  /// [params] The receipt voucher to create
  /// @return A Future containing either a Failure or the created PhieuThu with its ID
  @override
  Future<Either<Failure, PhieuThu>> call(PhieuThu params) async {
    return await repository.createPhieuThu(params);
  }
}