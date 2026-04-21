// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - CT-02: Lập phiếu chi
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/ct/presentation/widgets/phieu_chi_form_dialog.dart';
import 'package:hkd_accounting/features/ct/presentation/widgets/phieu_chi_list_item.dart';

class PhieuChiPage extends ConsumerWidget {
  const PhieuChiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      title: 'Lập phiếu chi',
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const PhieuChiFormDialog(),
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
                labelText: 'Tìm kiếm phiếu chi',
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
          // List of phieu chi
          Expanded(
            child: ref.watch(phieuChiProvider).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Text('Lỗi: $error'),
              ),
              data: (phieuChiList) {
                if (phieuChiList.isEmpty) {
                  return const Center(
                    child: Text('Không có phiếu chi nào'),
                  );
                }
                return ListView.builder(
                  itemCount: phieuChiList.length,
                  itemBuilder: (context, index) {
                    final phieuChi = phieuChiList[index];
                    return PhieuChiListItem(phieuChi: phieuChi);
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