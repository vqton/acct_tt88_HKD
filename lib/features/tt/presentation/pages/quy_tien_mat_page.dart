// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - TT-01: Quản lý quỹ tiền mặt
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/tt/presentation/widgets/quy_tien_mat_form_dialog.dart';
import 'package:hkd_accounting/features/tt/presentation/widgets/quy_tien_mat_list_item.dart';

class QuyTienMatPage extends ConsumerWidget {
  const QuyTienMatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      title: 'Quản lý quỹ tiền mặt',
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const QuyTienMatFormDialog(),
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
                labelText: 'Tìm kiếm quỹ tiền mặt',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (query) {
                // TODO: Implement search functionality
                // We'll use the provider's search method when implemented
              },
            ),
          ),
          // List of quy tien mat
          Expanded(
            child: ref.watch(quyTienMatProvider).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Text('Lỗi: $error'),
              ),
              data: (quyTienMatList) {
                if (quyTienMatList.isEmpty) {
                  return const Center(
                    child: Text('Không có quỹ tiền mặt nào'),
                  );
                }
                return ListView.builder(
                  itemCount: quyTienMatList.length,
                  itemBuilder: (context, index) {
                    final quyTienMat = quyTienMatList[index];
                    return QuyTienMatListItem(quyTienMat: quyTienMat);
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