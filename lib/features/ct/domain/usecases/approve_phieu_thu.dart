/// Use case for approving a receipt voucher (phiếu thu).
/// 
/// This use case encapsulates the business logic for approving a receipt voucher
/// according to UC_HKD_TT88_2021 - CT-08: Phê duyệt chứng từ (ký duyệt).
/// 
/// The use case follows the Single Responsibility Principle - it only handles
/// the approval of receipt vouchers and delegates data persistence to the repository.
class ApprovePhieuThu extends UseCase<PhieuThu, String> {
  /// Repository responsible for persisting receipt voucher data
  final PhieuThuRepository repository;

  /// Creates a new instance of the ApprovePhieuThu use case
  /// 
  /// [repository] The repository used to persist receipt voucher data
  ApprovePhieuThu(this.repository);

  /// Executes the use case to approve a receipt voucher
  /// 
  /// [id] The ID of the receipt voucher to approve
  /// @return A Future containing either a Failure or the approved PhieuThu
  @override
  Future<Either<Failure, PhieuThu>> call(String id) async {
    // First, get the existing voucher
    final result = await repository.getPhieuThuById(id);
    
    return result.fold(
      // If failed to get voucher, return the failure
      (failure) => Left(failure),
      // If voucher not found, return EmptyFailure
      (phieuThu) async {
        if (phieuThu == null) {
          return Left(EmptyFailure());
        }
        
        // Check if voucher is already approved
        if (phieuThu.trangThai == 'DA_DUYET') {
          return Left(Failure('Phieu thu da duoc duyet roi'));
        }
        
        // Update the voucher status to approved
        final approvedPhieuThu = phieuThu.copyWith(trangThai: 'DA_DUYET');
        final updateResult = await repository.updatePhieuThu(approvedPhieuThu);
        
        return updateResult.fold(
          (failure) => Left(failure),
          (_) => Right(approvedPhieuThu),
        );
      },
    );
  }
}