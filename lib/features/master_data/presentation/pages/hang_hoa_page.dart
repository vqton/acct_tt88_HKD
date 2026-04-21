// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - MD-02: Quản lý danh mục hàng hóa/dịch vụ
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/master_data/presentation/widgets/hang_hoa_form_dialog.dart';
import 'package:hkd_accounting/features/master_data/presentation/widgets/hang_hoa_list_item.dart';

class HangHoaPage extends ConsumerWidget {
  const HangHoaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      title: 'Quản lý hàng hóa/dịch vụ',
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const HangHoaFormDialog(),
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
                labelText: 'Tìm kiếm hàng hóa',
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
          // List of hang hoa
          Expanded(
            child: ref.watch(hangHoaProvider).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Text('Lỗi: $error'),
              ),
              data: (hangHoaList) {
                if (hangHoaList.isEmpty) {
                  return const Center(
                    child: Text('Không có hàng hóa nào'),
                  );
                }
                return ListView.builder(
                  itemCount: hangHoaList.length,
                  itemBuilder: (context, index) {
                    final hangHoa = hangHoaList[index];
                    return HangHoaListItem(hangHoa: hangHoa);
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