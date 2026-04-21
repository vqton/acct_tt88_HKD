// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - MD-04: Quản lý danh mục nhà cung cấp
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/master_data/presentation/widgets/nha_cung_cap_form_dialog.dart';
import 'package:hkd_accounting/features/master_data/presentation/widgets/nha_cung_cap_list_item.dart';

class NhaCungCapPage extends ConsumerWidget {
  const NhaCungCapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      title: 'Quản lý danh mục nhà cung cấp',
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const NhaCungCapFormDialog(),
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
                labelText: 'Tìm kiếm nhà cung cấp',
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
          // List of nha cung cap
          Expanded(
            child: ref.watch(nhaCungCapProvider).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Text('Lỗi: $error'),
              ),
              data: (nhaCungCapList) {
                if (nhaCungCapList.isEmpty) {
                  return const Center(
                    child: Text('Không có nhà cung cấp nào'),
                  );
                }
                return ListView.builder(
                  itemCount: nhaCungCapList.length,
                  itemBuilder: (context, index) {
                    final nhaCungCap = nhaCungCapList[index];
                    return NhaCungCapListItem(nhaCungCap: nhaCungCap);
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