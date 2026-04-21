// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - CT-06: Quản lý hóa đơn
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/ct/presentation/providers/hoa_don_provider.dart';
import 'package:hkd_accounting/features/ct/presentation/widgets/hoa_don_form_dialog.dart';
import 'package:hkd_accounting/features/ct/presentation/widgets/hoa_don_list_item.dart';

class HoaDonPage extends ConsumerWidget {
  const HoaDonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hoaDonList = ref.watch(hoaDonProvider);
    final filter = ref.watch(hoaDonFilterProvider);

    return CustomScaffold(
      title: 'Quản lý hóa đơn',
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (ctx) => HoaDonFormDialog(
            onSave: (hd) => ref.read(hoaDonProvider.notifier).saveHoaDon(hd),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text('Lọc: '),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Tất cả'),
                  selected: filter == 'ALL',
                  onSelected: (_) {
                    ref.read(hoaDonFilterProvider.notifier).state = 'ALL';
                    ref.read(hoaDonProvider.notifier).loadHoaDonList();
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Đầu ra'),
                  selected: filter == 'DAU_RA',
                  onSelected: (_) {
                    ref.read(hoaDonFilterProvider.notifier).state = 'DAU_RA';
                    ref.read(hoaDonProvider.notifier).loadByLoai('DAU_RA');
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Đầu vào'),
                  selected: filter == 'DAU_VAO',
                  onSelected: (_) {
                    ref.read(hoaDonFilterProvider.notifier).state = 'DAU_VAO';
                    ref.read(hoaDonProvider.notifier).loadByLoai('DAU_VAO');
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: hoaDonList.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Lỗi: $e')),
              data: (list) {
                if (list.isEmpty) {
                  return const Center(child: Text('Chưa có hóa đơn nào'));
                }
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (ctx, i) => HoaDonListItem(
                    hoaDon: list[i],
                    onTap: () => showDialog(
                      context: ctx,
                      builder: (_) => HoaDonFormDialog(
                        initialHoaDon: list[i],
                        onSave: (hd) => ref.read(hoaDonProvider.notifier).updateHoaDon(hd),
                      ),
                    ),
                    onDelete: () => _confirmDelete(context, ref, list[i].id),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: const Text('Xóa hóa đơn này?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Hủy')),
          ElevatedButton(
            onPressed: () {
              ref.read(hoaDonProvider.notifier).deleteHoaDon(id);
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }
}