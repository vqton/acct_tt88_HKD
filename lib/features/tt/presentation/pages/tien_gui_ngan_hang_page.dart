// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - TT-02: Quản lý tiền gửi ngân hàng
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/tt/presentation/providers/tien_gui_ngan_hang_provider.dart';
import 'package:hkd_accounting/features/tt/presentation/widgets/tien_gui_ngan_hang_form_dialog.dart';
import 'package:hkd_accounting/features/tt/presentation/widgets/tien_gui_ngan_hang_list_item.dart';

class TienGuiNganHangPage extends ConsumerWidget {
  const TienGuiNganHangPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      title: 'Quản lý tiền gửi ngân hàng',
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => TienGuiNganHangFormDialog(
              initialTienGuiNganHang: null,
              onSave: (tienGuiNganHang) {
                ref.read(tienGuiNganHangProvider.notifier).saveTienGuiNganHang(tienGuiNganHang);
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
                labelText: 'Tìm kiếm tiền gửi ngân hàng',
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
          // List of tien gui ngan hang
          Expanded(
            child: ref.watch(tienGuiNganHangProvider).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Text('Lỗi: $error'),
              ),
              data: (tienGuiNganHangList) {
                if (tienGuiNganHangList.isEmpty) {
                  return const Center(
                    child: Text('Không có tiền gửi ngân hàng nào'),
                  );
                }
                return ListView.builder(
                  itemCount: tienGuiNganHangList.length,
                  itemBuilder: (context, index) {
                    final tienGuiNganHang = tienGuiNganHangList[index];
                    return TienGuiNganHangListItem(tienGuiNganHang: tienGuiNganHang);
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