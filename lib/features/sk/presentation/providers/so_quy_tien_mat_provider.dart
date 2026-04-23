// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - SK-07: Ghi sổ quỹ tiền mặt (S6-HKD)
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/sk/domain/entities/so_quy_tien_mat.dart';
import 'package:hkd_accounting/features/sk/domain/repositories/so_quy_tien_mat_repository.dart';

/// Provider quản lý trạng thái của Sổ quỹ tiền mặt (S6-HKD).
/// 
/// Provider này sử dụng Riverpod's StateNotifier để xử lý trạng thái UI
/// cho việc ghi sổ quỹ tiền mặt theo UC_HKD_TT88_2021 - SK-07: Ghi sổ quỹ tiền mặt (S6-HKD).
/// 
/// Nó quản lý các trạng thái loading, success/error messages, và dữ liệu sổ.
///
/// Dependencies:
///   - SoQuyTienMatRepository (được tiêm qua GetIt)

/// State đại diện cho việc tạo/ghi sổ quỹ tiền mặt.
class SoQuyTienMatFormState {
  /// Form đang submit (hiển thị loading indicator)
  final bool isLoading;
  
  /// Submit cuối cùng thành công
  final bool isSuccess;
  
  /// Submit cuối cùng có lỗi
  final bool isError;
  
  /// Thông báo lỗi nếu isError là true
  final String? errorMessage;
  
  /// Thông báo thành công nếu isSuccess là true
  final String? successMessage;
  
  /// Dòng sổ đã tạo nếu thành công
  final SoQuyTienMat? soQuyTienMat;

  /// Tạo state mới với các giá trị đã cho
  const SoQuyTienMatFormState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isError = false,
    this.errorMessage,
    this.successMessage,
    this.soQuyTienMat,
  });

  /// Tạo bản sao của state với các trường được thay thế
  SoQuyTienMatFormState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    String? errorMessage,
    String? successMessage,
    SoQuyTienMat? soQuyTienMat,
  }) {
    return SoQuyTienMatFormState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      soQuyTienMat: soQuyTienMat ?? this.soQuyTienMat,
    );
  }
}

/// StateNotifier quản lý trạng thái ghi sổ quỹ tiền mặt.
class SoQuyTienMatNotifier extends StateNotifier<SoQuyTienMatFormState> {
  /// Repository chịu trách nhiệm lưu trữ dữ liệu
  final SoQuyTienMatRepository repository;

  /// Tạo một notifier với repository đã tiêm
  SoQuyTienMatNotifier()
      : repository = GetIt.instance.get<SoQuyTienMatRepository>(),
        super(const SoQuyTienMatFormState());

  /// Ghi một dòng mới vào sổ quỹ tiền mặt
  /// 
  /// [soQuyTienMat] Dòng sổ cần tạo
  Future<void> createSoQuyTienMat(SoQuyTienMat soQuyTienMat) async {
    state = state.copyWith(isLoading: true, isError: false, isSuccess: false);
    final result = await repository.createSoQuyTienMat(soQuyTienMat);
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: _mapFailureToMessage(failure),
      ),
      (created) => state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        successMessage: 'Đã ghi sổ quỹ tiền mặt thành công',
        soQuyTienMat: created,
      ),
    );
  }

  /// Lấy danh sách tất cả các dòng sổ
  Future<List<SoQuyTienMat>> getSoQuyTienMatList() async {
    final result = await repository.getSoQuyTienMatList();
    return result.fold(
      (failure) => [],
      (list) => list,
    );
  }

  /// Lấy các dòng sổ theo ID quỹ tiền mặt
  Future<List<SoQuyTienMat>> getSoQuyTienMatByQuyTienMatId(String quyTienMatId) async {
    final result = await repository.getSoQuyTienMatByQuyTienMatId(quyTienMatId);
    return result.fold(
      (failure) => [],
      (list) => list,
    );
  }

  /// Chuyển Failure thành thông báo lỗi
  String _mapFailureToMessage(Failure failure) {
    return failure.toString();
  }
}

/// Provider expose SoQuyTienMatNotifier cho state management
final soQuyTienMatProvider = StateNotifierProvider<SoQuyTienMatNotifier, SoQuyTienMatFormState>((ref) {
  return SoQuyTienMatNotifier();
});

/// Provider cho danh sách các dòng sổ
final soQuyTienMatListProvider = FutureProvider<List<SoQuyTienMat>>((ref) async {
  final notifier = ref.read(soQuyTienMatProvider.notifier);
  return notifier.getSoQuyTienMatList();
});