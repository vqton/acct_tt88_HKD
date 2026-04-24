// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - NS-03: Theo dõi và thanh toán lương
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/ns/domain/entities/thanh_toan_luong.dart';
import 'package:hkd_accounting/features/ns/presentation/providers/thanh_toan_luong_provider.dart';

class ThanhToanLuongPage extends ConsumerWidget {
  const ThanhToanLuongPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(thanhToanLuongListProvider);

    return CustomScaffold(
      title: 'Thanh toán lương (NS-03)',
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
          Icon(Icons.payments, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text('Chưa có dữ liệu thanh toán lương', style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }

  Widget _buildListView(BuildContext context, WidgetRef ref, List<ThanhToanLuong> list) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _getStatusColor(item.trangThai).withValues(alpha: 0.2),
              child: Icon(Icons.payments, color: _getStatusColor(item.trangThai)),
            ),
            title: Text('Tháng ${item.thangNam}', style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tổng: ${_formatCurrency(item.tongLuongPhaiTra)}'),
                Text(
                  'Còn phải trả: ${_formatCurrency(item.conPhaiTra)}',
                  style: TextStyle(color: item.conPhaiTra > 0 ? Colors.red : Colors.green),
                ),
              ],
            ),
            trailing: Chip(
              label: Text(_getStatusText(item.trangThai)),
              backgroundColor: _getStatusColor(item.trangThai).withValues(alpha: 0.2),
            ),
            onTap: () => _showPaymentDialog(context, ref, item),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'DA_THANH_TOAN':
        return Colors.green;
      case 'DANG_THANH_TOAN':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'DA_THANH_TOAN':
        return 'Đã thanh toán';
      case 'DANG_THANH_TOAN':
        return 'Đang thanh toán';
      default:
        return 'Chưa thanh toán';
    }
  }

  String _formatCurrency(double value) {
    return '${value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}đ';
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    final thangNamController = TextEditingController(text: DateTime.now().toString().substring(0, 7));
    final tongLuongController = TextEditingController();
    final bangLuongIdController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Tạo thanh toán lương mới'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: thangNamController, decoration: const InputDecoration(labelText: 'Tháng/Năm (yyyy-MM)')),
              const SizedBox(height: 8),
              TextField(controller: bangLuongIdController, decoration: const InputDecoration(labelText: 'ID Bảng lương')),
              const SizedBox(height: 8),
              TextField(controller: tongLuongController, decoration: const InputDecoration(labelText: 'Tổng lương phải trả'), keyboardType: TextInputType.number),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Hủy')),
          ElevatedButton(
            onPressed: () async {
              final entity = ThanhToanLuong.fromBangLuong(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                bangLuongId: bangLuongIdController.text,
                thangNam: thangNamController.text,
                tongTraNhanVien: double.tryParse(tongLuongController.text) ?? 0,
              );
              await ref.read(thanhToanLuongListProvider.notifier).create(entity);
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Tạo'),
          ),
        ],
      ),
    );
  }

  void _showPaymentDialog(BuildContext context, WidgetRef ref, ThanhToanLuong item) {
    final ckController = TextEditingController();
    final matController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Thanh toán lương tháng ${item.thangNam}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Còn phải trả: ${_formatCurrency(item.conPhaiTra)}', style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextField(controller: ckController, decoration: const InputDecoration(labelText: 'Chuyển khoản'), keyboardType: TextInputType.number),
              const SizedBox(height: 8),
              TextField(controller: matController, decoration: const InputDecoration(labelText: 'Tiền mặt'), keyboardType: TextInputType.number),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Hủy')),
          ElevatedButton(
            onPressed: () async {
              await ref.read(thanhToanLuongListProvider.notifier).updateThanhToan(
                item.id,
                double.tryParse(ckController.text) ?? 0,
                double.tryParse(matController.text) ?? 0,
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