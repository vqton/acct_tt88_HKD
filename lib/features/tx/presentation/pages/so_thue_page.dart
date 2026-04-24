// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - SK-05: Ghi sổ theo dõi nghĩa vụ thuế (S4-HKD)
// ============================================================================
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:hkd_accounting/features/tx/presentation/providers/so_thue_provider.dart';

class SoThuePage extends ConsumerWidget {
  const SoThuePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final soS4List = ref.watch(soThueProvider);
    final currencyFormat = NumberFormat('#,###');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sổ theo dõi nghĩa vụ thuế (S4-HKD)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () => ref.read(soThueProvider.notifier).loadAll(),
          ),
        ],
      ),
      body: soS4List.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Lỗi: $e')),
        data: (list) {
          if (list.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.book, size: 48, color: Colors.grey),
                  const SizedBox(height: 8),
                  Text('Chưa có dữ liệu S4-HKD'),
                  const SizedBox(height: 4),
                  Text(
                    'Cần chạy TX-01, TX-02, TX-03 trước',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: list.length,
            itemBuilder: (ctx, i) {
              final s4 = list[i];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            DateFormat('dd/MM/yyyy').format(s4.ngayChungTu),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Chip(
                            label: Text(s4.trangThai),
                            backgroundColor: s4.tongThueConPhaiNop > 0
                                ? Colors.orange.shade100
                                : Colors.green.shade100,
                          ),
                        ],
                      ),
                      if (s4.dienGiai.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(s4.dienGiai),
                      ],
                      const Divider(),
                      _buildSection('Thuế GTGT', s4.thueGtgtPhaiNop, s4.thueGtgtDaNop, s4.thueGtgtConPhaiNop, currencyFormat),
                      const Divider(),
                      _buildSection('Thuế TNCN', s4.thueTncnPhaiNop, s4.thueTncnDaNop, s4.thueTncnConPhaiNop, currencyFormat),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Tổng còn phải nộp:', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(
                            '${currencyFormat.format(s4.tongThueConPhaiNop)} ₫',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: s4.tongThueConPhaiNop > 0
                                  ? Colors.red
                                  : Colors.green,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSection(String label, int phaiNop, int daNop, int conPhaiNop, NumberFormat fmt) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$label phải nộp:', style: const TextStyle(fontSize: 13)),
            Text('${fmt.format(phaiNop)} ₫', style: const TextStyle(fontSize: 13)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$label đã nộp:', style: const TextStyle(fontSize: 13)),
            Text('${fmt.format(daNop)} ₫', style: const TextStyle(fontSize: 13, color: Colors.green)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$label còn phải nộp:', style: const TextStyle(fontSize: 13)),
            Text(
              '${fmt.format(conPhaiNop)} ₫',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: conPhaiNop > 0 ? Colors.red : Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }
}