// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - MD-01: Quản lý thông tin HKD/CNKD
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/hkd_info.dart';
import 'package:hkd_accounting/features/master_data/presentation/widgets/hkd_info_form_dialog.dart';
import 'package:hkd_accounting/features/master_data/presentation/providers/hkd_info_provider.dart';

class HkdInfoPage extends ConsumerWidget {
  const HkdInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hkdInfoState = ref.watch(hkdInfoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin HKD/CNKD'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _showFormDialog(context, ref),
          ),
        ],
      ),
      body: hkdInfoState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Lỗi: $error'),
              ElevatedButton(
                onPressed: () => ref.refresh(hkdInfoProvider),
                child: const Text('Thử lại'),
              ),
            ],
          ),
        ),
        data: (hkdInfo) {
          if (hkdInfo == null) {
            return const Center(
              child: Text('Chưa có thông tin HKD/CNKD. Nhấn nút sửa để thêm.'),
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
                      title: Text(hkdInfo.tenHkd),
                      subtitle: Text('Mã số thuế: ${hkdInfo.maSoThue}'),
                    ),
                    ListTile(
                      title: const Text('Địa chỉ trụ sở'),
                      subtitle: Text(hkdInfo.diaChiTruSo ?? 'Chưa cung cấp'),
                    ),
                    ListTile(
                      title: const Text('Người đại diện'),
                      subtitle: Text('${hkdInfo.hoTenNguoiDaiDien ?? 'Chưa cung cấp'} - ${hkdInfo.soCccdNguoiDaiDien ?? 'Chưa cung cấp'}'),
                    ),
                    ListTile(
                      title: const Text('Phương pháp tính giá xuất kho'),
                      subtitle: Text(hkdInfo.phuongPhapTinhGiaXuatKho),
                    ),
                    ListTile(
                      title: const Text('Trạng thái'),
                      subtitle: Text(hkdInfo.trangThai),
                    ),
                    if (hkdInfo.createdAt != null)
                      ListTile(
                        title: const Text('Ngày tạo'),
                        subtitle: Text('${hkdInfo.createdAt!.day}/${hkdInfo.createdAt!.month}/${hkdInfo.createdAt!.year}'),
                      ),
                    if (hkdInfo.updatedAt != null)
                      ListTile(
                        title: const Text('Ngày cập nhật'),
                        subtitle: Text('${hkdInfo.updatedAt!.day}/${hkdInfo.updatedAt!.month}/${hkdInfo.updatedAt!.year}'),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFormDialog(context, ref),
        child: const Icon(Icons.edit),
      ),
    );
  }

  void _showFormDialog(BuildContext context, WidgetRef ref) {
    final hkdInfoState = ref.watch(hkdInfoProvider);
    showDialog(
      context: context,
      builder: (context) => HkdInfoFormDialog(
        initialHkdInfo: hkdInfoState.whenOrNull(data: (data) => data),
        onSave: (hkdInfo) {
          ref.read(hkdInfoProvider.notifier).saveHkdInfo(hkdInfo);
          Navigator.of(context).pop();
        },
      ),
    );
  }
}