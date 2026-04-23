// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - MD-07: Quản lý danh mục tài khoản ngân hàng
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/master_data/presentation/widgets/tai_khoan_ngan_hang_form_dialog.dart';
import 'package:hkd_accounting/features/master_data/presentation/widgets/tai_khoan_ngan_hang_list_item.dart';
import 'package:hkd_accounting/features/master_data/presentation/providers/tai_khoan_ngan_hang_provider.dart';

class TaiKhoanNganHangPage extends ConsumerWidget {
  const TaiKhoanNganHangPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taiKhoanNganHangNotifier = ref.read(taiKhoanNganHangProvider.notifier);
    return CustomScaffold(
      title: 'Quản lý danh mục tài khoản ngân hàng',
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => TaiKhoanNganHangFormDialog(
              initialTaiKhoanNganHang: null,
              onSave: (tk) {
                taiKhoanNganHangNotifier.saveTaiKhoanNganHang(tk);
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
                labelText: 'Tìm kiếm tài khoản ngân hàng',
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
          // List of tai khoan ngan hang
          Expanded(
            child: ref.watch(taiKhoanNganHangProvider).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Text('Lỗi: $error'),
              ),
              data: (taiKhoanNganHangList) {
                if (taiKhoanNganHangList.isEmpty) {
                  return const Center(
                    child: Text('Không có tài khoản ngân hàng nào'),
                  );
                }
                return ListView.builder(
                  itemCount: taiKhoanNganHangList.length,
                  itemBuilder: (context, index) {
                    final taiKhoanNganHang = taiKhoanNganHangList[index];
                    return TaiKhoanNganHangListItem(taiKhoanNganHang: taiKhoanNganHang);
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