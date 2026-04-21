// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - KH-04: Tính giá xuất kho
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/kh/presentation/providers/ton_kho_provider.dart';
import 'package:hkd_accounting/features/kh/presentation/widgets/ton_kho_list_item.dart';

class TonKhoPage extends ConsumerWidget {
  const TonKhoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      title: 'Tồn kho hàng hóa',
      body: Column(
        children: [
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
                // TODO: Implement search
              },
            ),
          ),
          Expanded(
            child: ref.watch(tonKhoProvider).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Text('Lỗi: $error'),
              ),
              data: (tonKhoList) {
                if (tonKhoList.isEmpty) {
                  return const Center(
                    child: Text('Chưa có dữ liệu tồn kho'),
                  );
                }
                return ListView.builder(
                  itemCount: tonKhoList.length,
                  itemBuilder: (context, index) {
                    final tonKho = tonKhoList[index];
                    return TonKhoListItem(
                      tonKho: tonKho,
                      tenHangHoa: tonKho.hangHoaId,
                      onTap: () {
                        // Show detail dialog
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