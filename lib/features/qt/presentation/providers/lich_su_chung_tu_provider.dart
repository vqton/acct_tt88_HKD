// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - QT-05: Tra cứu lịch sử chứng từ
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hkd_accounting/features/qt/domain/entities/lich_su_chung_tu.dart';
import 'package:hkd_accounting/features/qt/domain/repositories/lich_su_chung_tu_repository.dart';

class LichSuChungTuSearchState {
  final List<LichSuChungTu> results;
  final String? query;
  final LoaiChungTu? loaiChungTu;
  final DateTime? tuNgay;
  final DateTime? denNgay;
  final String? trangThai;
  final bool isLoading;
  final String? errorMessage;

  const LichSuChungTuSearchState({
    this.results = const [],
    this.query,
    this.loaiChungTu,
    this.tuNgay,
    this.denNgay,
    this.trangThai,
    this.isLoading = false,
    this.errorMessage,
  });

  LichSuChungTuSearchState copyWith({
    List<LichSuChungTu>? results,
    String? query,
    LoaiChungTu? loaiChungTu,
    bool clearLoaiChungTu = false,
    DateTime? tuNgay,
    bool clearTuNgay = false,
    DateTime? denNgay,
    bool clearDenNgay = false,
    String? trangThai,
    bool clearTrangThai = false,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return LichSuChungTuSearchState(
      results: results ?? this.results,
      query: query ?? this.query,
      loaiChungTu: clearLoaiChungTu ? null : (loaiChungTu ?? this.loaiChungTu),
      tuNgay: clearTuNgay ? null : (tuNgay ?? this.tuNgay),
      denNgay: clearDenNgay ? null : (denNgay ?? this.denNgay),
      trangThai: clearTrangThai ? null : (trangThai ?? this.trangThai),
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class LichSuChungTuNotifier extends StateNotifier<LichSuChungTuSearchState> {
  final LichSuChungTuRepository _repository;

  LichSuChungTuNotifier()
      : _repository = GetIt.instance.get<LichSuChungTuRepository>(),
        super(const LichSuChungTuSearchState()) {
    search();
  }

  Future<void> search() async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _repository.search(
      query: state.query,
      loaiChungTu: state.loaiChungTu,
      tuNgay: state.tuNgay,
      denNgay: state.denNgay,
      trangThai: state.trangThai,
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
      },
      (results) {
        state = state.copyWith(
          isLoading: false,
          results: results,
        );
      },
    );
  }

  void setQuery(String? query) {
    state = state.copyWith(query: query);
    search();
  }

  void setLoaiChungTu(LoaiChungTu? loaiChungTu) {
    if (loaiChungTu == null) {
      state = state.copyWith(clearLoaiChungTu: true);
    } else {
      state = state.copyWith(loaiChungTu: loaiChungTu);
    }
    search();
  }

  void setTuNgay(DateTime? tuNgay) {
    if (tuNgay == null) {
      state = state.copyWith(clearTuNgay: true);
    } else {
      state = state.copyWith(tuNgay: tuNgay);
    }
    search();
  }

  void setDenNgay(DateTime? denNgay) {
    if (denNgay == null) {
      state = state.copyWith(clearDenNgay: true);
    } else {
      state = state.copyWith(denNgay: denNgay);
    }
    search();
  }

  void setTrangThai(String? trangThai) {
    if (trangThai == null || trangThai.isEmpty) {
      state = state.copyWith(clearTrangThai: true);
    } else {
      state = state.copyWith(trangThai: trangThai);
    }
    search();
  }

  void clearFilters() {
    state = const LichSuChungTuSearchState();
    search();
  }
}

final lichSuChungTuProvider =
    StateNotifierProvider<LichSuChungTuNotifier, LichSuChungTuSearchState>(
        (ref) {
  return LichSuChungTuNotifier();
});