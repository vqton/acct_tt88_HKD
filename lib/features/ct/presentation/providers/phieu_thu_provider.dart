/// Provider for managing the state of receipt voucher (phiếu thu) creation.
/// 
/// This provider uses Riverpod's StateNotifier to handle the UI state for creating
/// receipt vouchers according to UC_HKD_TT88_2021 - CT-01: Lập phiếu thu.
/// 
/// It manages loading states, success/error messages, and the created voucher data.
///
/// Dependencies:
///   - CreatePhieuThu use case (injected via GetIt)
///   - Related entities for dropdown selections (KyKeToan, KhachHang, HkdInfo)
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_thu.dart';
import 'package:hkd_accounting/features/ct/domain/usecases/create_phieu_thu.dart';
import 'package:hkd_accounting/features/ct/domain/usecases/approve_phieu_thu.dart';
import 'package:hkd_accounting/features/kh/domain/entities/ky_ke_toan.dart'; // For ky ke toan selection
import 'package:hkd_accounting/features/master_data/domain/entities/khach_hang.dart'; // For khach hang selection
import 'package:hkd_accounting/features/master_data/domain/entities/hkd_info.dart'; // For hkd info

/// Represents the state of the receipt voucher creation form.
/// 
/// This class encapsulates all UI state needed for the phieu thu creation screen,
/// including loading states, success/error flags, messages, and the created voucher.
class PhieuThuFormState {
  /// Whether the form is currently submitting (showing loading indicator)
  final bool isLoading;
  
  /// Whether the last submission was successful
  final bool isSuccess;
  
  /// Whether the last submission resulted in an error
  final bool isError;
  
  /// Error message to display if isError is true
  final String? errorMessage;
  
  /// Success message to display if isSuccess is true
  final String? successMessage;
  
  /// The created receipt voucher if submission was successful
  final PhieuThu? phieuThu;

  /// Creates a new form state with the given values
  /// 
  /// All parameters are optional and default to false/null for a clean state
  const PhieuThuFormState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isError = false,
    this.errorMessage,
    this.successMessage,
    this.phieuThu,
  });

  /// Creates a copy of this state with the given fields replaced with new values
  PhieuThuFormState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    String? errorMessage,
    String? successMessage,
    PhieuThu? phieuThu,
  }) {
    return PhieuThuFormState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      phieuThu: phieuThu ?? this.phieuThu,
    );
  }
}

/// StateNotifier that manages the state of phieu thu creation.
/// 
/// This class handles the business logic for creating receipt vouchers,
/// coordinating between the UI and the CreatePhieuThu use case.
/// 
/// It exposes methods to create vouchers and notifies listeners of state changes
/// through the StateNotifier pattern.
class PhieuThuNotifier extends StateNotifier<PhieuThuFormState> {
  /// Use case responsible for creating receipt vouchers
  final CreatePhieuThu createPhieuThuUseCase;

  /// Creates a new notifier with the required use case dependencies
  /// 
  /// The use cases are obtained from the GetIt service locator
  PhieuThuNotifier()
      : createPhieuThuUseCase = GetIt.instance.get<CreatePhieuThu>(),
        approvePhieuThuUseCase = GetIt.instance.get<ApprovePhieuThu>(),
        super(const PhieuThuFormState());

  /// Creates a new receipt voucher using the provided data
  /// 
  /// This method handles the complete flow of creating a voucher:
  /// 1. Sets loading state to true
  /// 2. Calls the CreatePhieuThu use case
  /// 3. Updates state based on the result (success or error)
  /// 
  /// [phieuThu] The receipt voucher data to create
  Future<void> createPhieuThu(PhieuThu phieuThu) async {
    state = state.copyWith(isLoading: true, isError: false, isSuccess: false);
    final result = await createPhieuThuUseCase(phieuThu);
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: _mapFailureToMessage(failure),
      ),
      (success) => state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        successMessage: 'Phiếu thu đã được tạo thành công',
        phieuThu: success,
      ),
    );
  }

  /// Approves a receipt voucher by its ID
  /// 
  /// This method handles the complete flow of approving a voucher:
  /// 1. Sets loading state to true
  /// 2. Calls the ApprovePhieuThu use case
  /// 3. Updates state based on the result (success or error)
  /// 
  /// [id] The ID of the receipt voucher to approve
  Future<void> approvePhieuThu(String id) async {
    state = state.copyWith(isLoading: true, isError: false, isSuccess: false);
    final result = await approvePhieuThuUseCase(id);
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: _mapFailureToMessage(failure),
      ),
      (success) => state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        successMessage: 'Phiếu thu đã được duyệt thành công',
        phieuThu: success,
      ),
    );
  }

  /// Converts a Failure object to a human-readable error message
  /// 
  /// This method can be enhanced to provide more user-friendly messages
  /// based on the specific type of failure
  /// 
  /// [failure] The failure object to convert
  /// @return A string representation of the failure suitable for display to users
  String _mapFailureToMessage(Failure failure) {
    // Simple mapping, can be improved
    return failure.toString();
  }
}

/// Provider that exposes a PhieuThuNotifier instance for state management
/// 
/// This provider allows widgets to:
/// - Read the current state via ref.watch(phieuThuProvider)
/// - Modify the state via ref.read(phieuThuProvider.notifier)
/// 
/// It follows the Riverpod pattern for state management in Flutter applications.
final phieuThuProvider = StateNotifierProvider<PhieuThuNotifier, PhieuThuFormState>((ref) {
  return PhieuThuNotifier();
});