// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - MD-06: Quản lý danh mục người lao động
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/master_data/presentation/widgets/nguoi_lao_dong_form_dialog.dart';
import 'package:hkd_accounting/features/master_data/presentation/widgets/nguoi_lao_dong_list_item.dart';
import 'package:hkd_accounting/features/master_data/presentation/providers/nguoi_lao_dong_provider.dart';

class NguoiLaoDongPage extends ConsumerWidget {
  const NguoiLaoDongPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nguoiLaoDongNotifier = ref.read(nguoiLaoDongProvider.notifier);
    return CustomScaffold(
      title: 'Quản lý danh mục người lao động',
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => NguoiLaoDongFormDialog(
              initialNguoiLaoDong: null,
              onSave: (nld) {
                nguoiLaoDongNotifier.saveNguoiLaoDong(nld);
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Tìm kiếm người lao động',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (query) {
                // TODO: Implement search functionality
              },
            ),
          ),
          // List of nguoi lao dong
          Expanded(
            child: ref.watch(nguoiLaoDongProvider).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Text('Lỗi: $error'),
              ),
              data: (nguoiLaoDongList) {
                if (nguoiLaoDongList.isEmpty) {
                  return const Center(
                    child: Text('Không có người lao động nào'),
                  );
                }
                return ListView.builder(
                  itemCount: nguoiLaoDongList.length,
                  itemBuilder: (context, index) {
                    final nguoiLaoDong = nguoiLaoDongList[index];
                    return NguoiLaoDongListItem(nguoiLaoDong: nguoiLaoDong);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}