// ============================================================================
// Presentation Layer - SK-02: Sổ doanh thu (S1-HKD) Page
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/sk/presentation/providers/so_doanh_thu_provider.dart';
import 'package:intl/intl.dart';

class SoDoanhThuPage extends ConsumerWidget {
  const SoDoanhThuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final soS1List = ref.watch(soDoanhThuProvider);
    final currencyFormat = NumberFormat('#,###');

    return CustomScaffold(
      title: 'Sổ doanh thu (S1-HKD)',
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showGenerateDialog(context, ref),
        child: const Icon(Icons.sync),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Row(
              children: [
                Expanded(flex: 1, child: _buildHeader(context, 'Ngày')),
                Expanded(flex: 2, child: _buildHeader(context, 'Số CT')),
                Expanded(flex: 3, child: _buildHeader(context, 'Diễn giải')),
                Expanded(flex: 2, child: _buildHeader(context, 'Doanh thu')),
              ],
            ),
          ),
          Expanded(
            child: soS1List.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Lỗi: $e')),
              data: (list) {
                if (list.isEmpty) {
                  return const Center(child: Text('Chưa có dữ liệu S1'));
                }
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (ctx, i) {
                    final s1 = list[i];
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                      ),
                      child: Row(
                        children: [
                          Expanded(flex: 1, child: Text(DateFormat('dd/MM').format(s1.ngayChungTu))),
                          Expanded(flex: 2, child: Text(s1.soHieuChungTu ?? '-', style: const TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(flex: 3, child: Text(s1.dienGiai ?? '-', maxLines: 1, overflow: TextOverflow.ellipsis)),
                          Expanded(flex: 2, child: Text('${currencyFormat.format(s1.doanhThu)}', textAlign: TextAlign.right)),
                        ],
                      ),
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

  Widget _buildHeader(BuildContext context, String label) {
    return Text(label, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold));
  }

  void _showGenerateDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Tạo S1 từ hóa đơn'),
        content: const Text('Đọc dữ liệu từ hóa đơn đầu ra (CT-06) để tạo S1?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Hủy')),
          ElevatedButton(
            onPressed: () {
              ref.read(soDoanhThuProvider.notifier).generateFromHoaDon('');
              Navigator.pop(ctx);
            },
            child: const Text('Tạo'),
          ),
        ],
      ),
    );
  }
}