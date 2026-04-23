// ============================================================================
// Presentation Layer - SK-04: Sổ chi phí (S3-HKD) Provider
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hkd_accounting/features/sk/domain/entities/so_chi_phi.dart';
import 'package:hkd_accounting/features/sk/data/repositories/so_chi_phi_repository_impl.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_chi.dart';
import 'package:hkd_accounting/features/ct/domain/repositories/phieu_chi_repository.dart';

class SoChiPhiNotifier extends StateNotifier<AsyncValue<List<SoChiPhi>>> {
  final SoChiPhiRepositoryImpl repository;
  final PhieuChiRepository phieuChiRepository;

  SoChiPhiNotifier(this.repository, this.phieuChiRepository) : super(const AsyncValue.loading()) { loadS3(); }

  Future<void> loadS3() async {
    state = const AsyncValue.loading();
    final result = await repository.getAll();
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (data) => AsyncValue.data(data),
    );
  }

  Future<void> generateFromPhieuChi(String kyKeToanId) async {
    final pcResult = await phieuChiRepository.getPhieuChiList();
    await pcResult.fold((f) async {}, (list) async {
      for (final pc in list) {
        final cp = SoChiPhi(id: '${kyKeToanId}_${pc.id}', kyKeToanId: kyKeToanId, ngayChungTu: pc.ngayLap, soHieuChungTu: pc.soPhieu, dienGiai: pc.lyDoNop, tongTien: pc.soTien);
        await repository.save(cp);
      }
    });
    await loadS3();
  }
}

final soChiPhiProvider = StateNotifierProvider<SoChiPhiNotifier, AsyncValue<List<SoChiPhi>>>((ref) {
  return SoChiPhiNotifier(GetIt.instance.get<SoChiPhiRepositoryImpl>(), GetIt.instance.get<PhieuChiRepository>());
});