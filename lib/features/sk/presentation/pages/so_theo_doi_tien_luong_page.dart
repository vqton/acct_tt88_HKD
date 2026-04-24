// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - SK-06: Ghi sổ theo dõi thanh toán tiền lương (S5-HKD)
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/sk/domain/entities/so_theo_doi_tien_luong.dart';
import 'package:hkd_accounting/features/sk/presentation/providers/so_theo_doi_tien_luong_provider.dart';

class SoTheoDoiTienLuongPage extends ConsumerWidget {
  const SoTheoDoiTienLuongPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(soTheoDoiTienLuongListProvider);

    return CustomScaffold(
      title: 'Sổ theo dõi tiền lương (S5-HKD)',
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Lỗi: $e')),
        data: (list) => list.isEmpty
            ? _buildEmptyState(context)
            : _buildListView(context, ref, list),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.account_balance_wallet, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text('Chưa có dữ liệu sổ tiền lương', style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }

  Widget _buildListView(BuildContext context, WidgetRef ref, List<SoTheoDoiTienLuong> list) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ExpansionTile(
            leading: CircleAvatar(
              backgroundColor: _getStatusColor(item.trangThai).withValues(alpha: 0.2),
              child: Icon(Icons.people, color: _getStatusColor(item.trangThai)),
            ),
            title: Text(item.thangNam, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(_formatCurrency(item.phaiTraLuong)),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('Phải trả lương', item.phaiTraLuong),
                    _buildInfoRow('Đã trả lương', item.daTraLuong),
                    _buildInfoRow('Còn phải trả', item.conPhaiTraLuong, highlight: true),
                    const Divider(),
                    const Text('BHXH', style: TextStyle(fontWeight: FontWeight.bold)),
                    _buildInfoRow('Phải nộp', item.bhxhPhaiNop),
                    _buildInfoRow('Đã nộp', item.bhxhDaNop),
                    _buildInfoRow('Còn phải nộp', item.bhxhConPhaiNop),
                    const Divider(),
                    const Text('BHYT', style: TextStyle(fontWeight: FontWeight.bold)),
                    _buildInfoRow('Phải nộp', item.bhytPhaiNop),
                    _buildInfoRow('Đã nộp', item.bhytDaNop),
                    _buildInfoRow('Còn phải nộp', item.bhytConPhaiNop),
                    const Divider(),
                    const Text('BHTN', style: TextStyle(fontWeight: FontWeight.bold)),
                    _buildInfoRow('Phải nộp', item.bhtnPhaiNop),
                    _buildInfoRow('Đã nộp', item.bhtnDaNop),
                    _buildInfoRow('Còn phải nộp', item.bhtnConPhaiNop),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: () => _showThanhToanDialog(context, ref, item),
                          icon: const Icon(Icons.payment),
                          label: const Text('Thanh toán'),
                        ),
                        TextButton.icon(
                          onPressed: () => _showBhxhNopDialog(context, ref, item),
                          icon: const Icon(Icons.account_balance),
                          label: const Text('Nộp BHXH'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, double value, {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            _formatCurrency(value),
            style: TextStyle(
              fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
              color: highlight ? Colors.red : null,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'DA_CHUYEN_KHOAN':
        return Colors.green;
      case 'CHUA_CHUYEN_KHOAN':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _formatCurrency(double value) {
    return '${value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}đ';
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    final thangNamController = TextEditingController();
    final phaiTraLuongController = TextEditingController();
    final bhxhController = TextEditingController();
    final bhytController = TextEditingController();
    final bhtnController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Tạo dòng sổ tiền lương mới'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: thangNamController,
                decoration: const InputDecoration(labelText: 'Tháng/Năm (yyyy-MM)'),
              ),
              TextField(
                controller: phaiTraLuongController,
                decoration: const InputDecoration(labelText: 'Phải trả lương'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: bhxhController,
                decoration: const InputDecoration(labelText: 'BHXH phải nộp'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: bhytController,
                decoration: const InputDecoration(labelText: 'BHYT phải nộp'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: bhtnController,
                decoration: const InputDecoration(labelText: 'BHTN phải nộp'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Hủy')),
          ElevatedButton(
            onPressed: () async {
              final entity = SoTheoDoiTienLuong(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                kyKeToanId: '1',
                bangLuongId: '1',
                thangNam: thangNamController.text,
                ngayLap: DateTime.now(),
                phaiTraLuong: double.tryParse(phaiTraLuongController.text) ?? 0,
                daTraLuong: 0,
                conPhaiTraLuong: double.tryParse(phaiTraLuongController.text) ?? 0,
                bhxhPhaiNop: double.tryParse(bhxhController.text) ?? 0,
                bhxhDaNop: 0,
                bhxhConPhaiNop: double.tryParse(bhxhController.text) ?? 0,
                bhytPhaiNop: double.tryParse(bhytController.text) ?? 0,
                bhytDaNop: 0,
                bhytConPhaiNop: double.tryParse(bhytController.text) ?? 0,
                bhtnPhaiNop: double.tryParse(bhtnController.text) ?? 0,
                bhtnDaNop: 0,
                bhtnConPhaiNop: double.tryParse(bhtnController.text) ?? 0,
                trangThai: 'CHUA_CHUYEN_KHOAN',
                createdAt: DateTime.now(),
              );
              await ref.read(soTheoDoiTienLuongListProvider.notifier).create(entity);
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Tạo'),
          ),
        ],
      ),
    );
  }

  void _showThanhToanDialog(BuildContext context, WidgetRef ref, SoTheoDoiTienLuong item) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Thanh toán lương'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Số tiền thanh toán'),
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Hủy')),
          ElevatedButton(
            onPressed: () async {
              final soTien = double.tryParse(controller.text) ?? 0;
              await ref.read(soTheoDoiTienLuongListProvider.notifier).updateThanhToan(item.id, soTien);
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Xác nhận'),
          ),
        ],
      ),
    );
  }

  void _showBhxhNopDialog(BuildContext context, WidgetRef ref, SoTheoDoiTienLuong item) {
    final bhxhController = TextEditingController(text: item.bhxhPhaiNop.toString());
    final bhytController = TextEditingController(text: item.bhytPhaiNop.toString());
    final bhtnController = TextEditingController(text: item.bhtnPhaiNop.toString());

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nộp BHXH'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: bhxhController,
                decoration: const InputDecoration(labelText: 'BHXH đã nộp'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: bhytController,
                decoration: const InputDecoration(labelText: 'BHYT đã nộp'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: bhtnController,
                decoration: const InputDecoration(labelText: 'BHTN đã nộp'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Hủy')),
          ElevatedButton(
            onPressed: () async {
              await ref.read(soTheoDoiTienLuongListProvider.notifier).updateBhxhNop(
                item.id,
                double.tryParse(bhxhController.text) ?? 0,
                double.tryParse(bhytController.text) ?? 0,
                double.tryParse(bhtnController.text) ?? 0,
              );
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Xác nhận'),
          ),
        ],
      ),
    );
  }
}