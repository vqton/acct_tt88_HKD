// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - CT-05: Lập bảng thanh toán tiền lương & thu nhập NLĐ
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/ct/presentation/providers/bang_luong_provider.dart';
import 'package:hkd_accounting/features/ct/presentation/widgets/bang_luong_list_item.dart';
import 'package:hkd_accounting/features/ct/presentation/widgets/bang_luong_form_dialog.dart';

class BangLuongPage extends ConsumerWidget {
  const BangLuongPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      title: 'Bảng lương & thu nhập',
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => BangLuongFormDialog(
              initialBangLuong: null,
              onSave: (bangLuong) {
                ref.read(bangLuongProvider.notifier).createBangLuong(bangLuong);
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Tìm kiếm bảng lương',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (query) {},
            ),
          ),
          Expanded(
            child: ref.watch(bangLuongProvider).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Lỗi: $error'),
                    ElevatedButton(
                      onPressed: () =>
                          ref.read(bangLuongProvider.notifier).loadList(),
                      child: const Text('Thử lại'),
                    ),
                  ],
                ),
              ),
              data: (list) {
                if (list.isEmpty) {
                  return const Center(
                    child: Text('Chưa có bảng lương nào. Nhấn nút + để lập.'),
                  );
                }
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final bangLuong = list[index];
                    return BangLuongListItem(
                      bangLuong: bangLuong,
                      onTap: () {
                        ref.read(selectedBangLuongProvider.notifier).state =
                            bangLuong;
                      },
                      onApprove: () {
                        ref
                            .read(bangLuongProvider.notifier)
                            .approveBangLuong(bangLuong.id, 'Admin');
                      },
                      onDelete: () {
                        ref
                            .read(bangLuongProvider.notifier)
                            .deleteBangLuong(bangLuong.id);
                      },
                    );
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