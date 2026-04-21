// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - MD-08: Cấu hình kỳ kế toán
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/ky_ke_toan.dart';
import 'package:hkd_accounting/features/master_data/presentation/widgets/ky_ke_toan_form_dialog.dart';
import 'package:hkd_accounting/features/master_data/presentation/providers/ky_ke_toan_provider.dart';

class KyKeToanPage extends ConsumerWidget {
  const KyKeToanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kyKeToanState = ref.watch(kyKeToanProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cấu hình kỳ kế toán'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showFormDialog(context, ref, null),
          ),
        ],
      ),
      body: kyKeToanState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Lỗi: $error'),
              ElevatedButton(
                onPressed: () => ref.refresh(kyKeToanProvider),
                child: const Text('Thử lại'),
              ),
            ],
          ),
        ),
        data: (kyKeToan) {
          if (kyKeToan == null) {
            return const Center(
              child: Text('Chưa cấu hình kỳ kế toán. Nhấn nút + để thêm.'),
            );
          }

          return Center(
            child: Card(
              margin: const EdgeInsets.all(24),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text('Năm tài chính: ${kyKeToan.namTaiChinh}'),
                      subtitle: Text(
                        'Từ ${kyKeToan.ngayBatDauKy.day}/${kyKeToan.ngayBatDauKy.month}/${kyKeToan.ngayBatDauKy.year} '
                            'đến ${kyKeToan.ngayKetThucKy.day}/${kyKeToan.ngayKetThucKy.month}/${kyKeToan.ngayKetThucKy.year}',
                      ),
                    ),
                    ListTile(
                      title: Text('Trạng thái: ${kyKeToan.trangThaiKy}'),
                      subtitle: kyKeToan.ngayKhoaSoThucTe != null
                          ? Text(
                              'Ngày khóa sổ: ${kyKeToan.ngayKhoaSoThucTe.day}/${kyKeToan.ngayKhoaSoThucTe.month}/${kyKeToan.ngayKhoaSoThucTe.year}',
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFormDialog(context, ref, null),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showFormDialog(
      BuildContext context, WidgetRef ref, KyKeToan? kyKeToan) {
    showDialog(
      context: context,
      builder: (context) => KyKeToanFormDialog(
        initialKyKeToan: kyKeToan,
        onSave: (kyKeToan) {
          ref.read(kyKeToanProvider.notifier).saveKyKeToan(kyKeToan);
          Navigator.of(context).pop();
        },
      ),
    );
  }
}