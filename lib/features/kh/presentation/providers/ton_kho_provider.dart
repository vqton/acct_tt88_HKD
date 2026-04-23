// ============================================================================
// Presentation Layer - Provider
// Based on UC_HKD_TT88_2021 - KH-04: Tính giá xuất kho
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/kh/domain/entities/ton_kho.dart';
import 'package:hkd_accounting/features/kh/domain/repositories/ton_kho_repository.dart';
import 'package:hkd_accounting/features/kh/domain/services/tinh_gia_xuat_kho_service.dart';

class TonKhoNotifier extends StateNotifier<AsyncValue<List<TonKho>>> {
  final TonKhoRepository repository;
  final TinhGiaXuatKhoService cogsService;

  TonKhoNotifier(this.repository, this.cogsService)
      : super(const AsyncValue.loading()) {
    loadTonKhoList();
  }

  Future<void> loadTonKhoList() async {
    state = const AsyncValue.loading();
    final result = await repository.getTonKhoList('');
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (tonKhoList) => AsyncValue.data(tonKhoList),
    );
  }

  Future<void> loadTonKhoForKyKeToan(String kyKeToanId) async {
    state = const AsyncValue.loading();
    final result = await repository.getTonKhoList(kyKeToanId);
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (tonKhoList) => AsyncValue.data(tonKhoList),
    );
  }

  int tinhGiaXuat({
    required double tonDauSoLuong,
    required int tonDauThanhTien,
    required double nhapSoLuong,
    required int nhapThanhTien,
    required double soLuongXuat,
  }) {
    return cogsService.tinhGiaXuatBinhQuan(
      tonDauSoLuong: tonDauSoLuong,
      tonDauThanhTien: tonDauThanhTien,
      nhapSoLuong: nhapSoLuong,
      nhapThanhTien: nhapThanhTien,
      soLuongXuat: soLuongXuat,
    );
  }

  Map<String, dynamic> tinhTonCuoi({
    required double tonDauSoLuong,
    required int tonDauThanhTien,
    required double nhapSoLuong,
    required int nhapThanhTien,
    required double xuatSoLuong,
    required int xuatThanhTien,
  }) {
    return cogsService.tinhTonCuoiKy(
      tonDauSoLuong: tonDauSoLuong,
      tonDauThanhTien: tonDauThanhTien,
      nhapSoLuong: nhapSoLuong,
      nhapThanhTien: nhapThanhTien,
      xuatSoLuong: xuatSoLuong,
      xuatThanhTien: xuatThanhTien,
    );
  }
}

final tonKhoProvider = StateNotifierProvider<TonKhoNotifier, AsyncValue<List<TonKho>>>((ref) {
  return TonKhoNotifier(
    GetIt.instance.get<TonKhoRepository>(),
    TinhGiaXuatKhoService(),
  );
});

final selectedKyKeToanIdProvider = StateProvider<String>((ref) => '');