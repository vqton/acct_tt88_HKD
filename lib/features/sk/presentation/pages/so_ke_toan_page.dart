// ============================================================================
// Presentation Layer - SK-01: Mở sổ kế toán đầu kỳ Page
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';

class SoKeToanPage extends ConsumerWidget {
  const SoKeToanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      title: 'Mở sổ kế toán đầu kỳ (S1-S7)',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSoCard(context, 'S1-HKD', 'Sổ doanh thu bán hàng/dịch vụ', Icons.trending_up),
          const SizedBox(height: 12),
          _buildSoCard(context, 'S2-HKD', 'Sổ chi tiết vật tư hàng hóa', Icons.inventory_2),
          const SizedBox(height: 12),
          _buildSoCard(context, 'S3-HKD', 'Sổ chi phí sản xuất kinh doanh', Icons.money_off),
          const SizedBox(height: 12),
          _buildSoCard(context, 'S4-HKD', 'Sổ theo dõi nghĩa vụ thuế với NSNN', Icons.account_balance),
          const SizedBox(height: 12),
          _buildSoCard(context, 'S5-HKD', 'Sổ theo dõi thanh toán tiền lương', Icons.people),
          const SizedBox(height: 12),
          _buildSoCard(context, 'S6-HKD', 'Sổ quỹ tiền mặt', Icons.payments),
          const SizedBox(height: 12),
          _buildSoCard(context, 'S7-HKD', 'Sổ tiền gửi ngân hàng', Icons.account_balance),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _showOpenBooksDialog(context),
            icon: const Icon(Icons.lock_open),
            label: const Text('Mở sổ kỳ mới'),
            style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
          ),
        ],
      ),
    );
  }

  Widget _buildSoCard(BuildContext context, String maSo, String tenSo, IconData icon) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(maSo, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(tenSo),
        trailing: Chip(label: const Text('Sẵn sàng'), backgroundColor: Colors.green.shade100),
      ),
    );
  }

  void _showOpenBooksDialog(BuildContext context) {
    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: const Text('Mở sổ kỳ mới'),
      content: const Text('Tạo số dư đầu kỳ cho tất cả sổ S1-S7?'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Hủy')),
        ElevatedButton(onPressed: () { Navigator.pop(ctx); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã mở sổ kỳ mới'))); }, child: const Text('Mở sổ')),
      ],
    ));
  }
}