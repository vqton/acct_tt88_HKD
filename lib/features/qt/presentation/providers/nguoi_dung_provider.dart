// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - QT-01: Quản lý tài khoản người dùng & phân quyền
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/qt/domain/entities/nguoi_dung.dart';
import 'package:hkd_accounting/features/qt/domain/repositories/nguoi_dung_repository.dart';

class NguoiDungNotifier extends StateNotifier<AsyncValue<List<NguoiDung>>> {
  final NguoiDungRepository repository;

  NguoiDungNotifier()
      : repository = GetIt.instance.get<NguoiDungRepository>(),
        super(const AsyncValue.loading()) {
    loadNguoiDungList();
  }

  Future<void> loadNguoiDungList() async {
    state = const AsyncValue.loading();
    final result = await repository.getNguoiDungList();
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (nguoiDungList) => AsyncValue.data(nguoiDungList),
    );
  }

  Future<void> saveNguoiDung(NguoiDung nguoiDung) async {
    await repository.saveNguoiDung(nguoiDung);
    await loadNguoiDungList();
  }

  Future<void> updateNguoiDung(NguoiDung nguoiDung) async {
    await repository.updateNguoiDung(nguoiDung);
    await loadNguoiDungList();
  }

  Future<void> deleteNguoiDung(String id) async {
    await repository.deleteNguoiDung(id);
    await loadNguoiDungList();
  }

  Future<List<NguoiDung>> searchNguoiDung(String query) async {
    final result = await repository.searchNguoiDung(query);
    return result.fold(
      (failure) => [],
      (nguoiDungList) => nguoiDungList,
    );
  }
}

final nguoiDungProvider = StateNotifierProvider<NguoiDungNotifier, AsyncValue<List<NguoiDung>>>((ref) {
  return NguoiDungNotifier();
});

final selectedNguoiDungProvider = StateProvider<NguoiDung?>((ref) => null);

class AuthNotifier extends StateNotifier<AsyncValue<NguoiDung?>> {
  final NguoiDungRepository repository;

  AuthNotifier()
      : repository = GetIt.instance.get<NguoiDungRepository>(),
        super(const AsyncValue.data(null));

  Future<bool> login(String email, String password) async {
    state = const AsyncValue.loading();
    final result = await repository.login(email, password);
    return result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        return false;
      },
      (user) {
        if (user != null) {
          state = AsyncValue.data(user);
          return true;
        } else {
          state = const AsyncValue.data(null);
          return false;
        }
      },
    );
  }

  void logout() {
    state = const AsyncValue.data(null);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<NguoiDung?>>((ref) {
  return AuthNotifier();
});