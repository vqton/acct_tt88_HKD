// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - QT-02: Sửa chữa / điều chỉnh sổ kế toán
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/qt/domain/entities/dieu_chinh_so.dart';
import 'package:hkd_accounting/features/qt/presentation/providers/dieu_chinh_so_provider.dart';

class DieuChinhSoPage extends ConsumerWidget {
  const DieuChinhSoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dieuChinhSoProvider);

    return CustomScaffold(
      title: 'Điều chỉnh sổ kế toán (QT-02)',
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Lỗi: $e')),
        data: (list) => list.isEmpty ? _buildEmptyState(context, ref) : _buildListView(context, ref, list),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context, ref),
        child: const Icon(Icons.edit_note),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.auto_fix_high, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text('Chưa có điều chỉnh sổ nào', style: TextStyle(color: Colors.grey.shade600)),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _showAddDialog(context, ref),
            icon: const Icon(Icons.add),
            label: const Text('Tạo điều chỉnh mới'),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(BuildContext context, WidgetRef ref, List<DieuChinhSo> list) {
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
              child: Icon(Icons.edit, color: _getStatusColor(item.trangThai)),
            ),
            title: Text('Sổ ${item.soKeToanLoai}', style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(DateFormat('dd/MM/yyyy').format(item.ngayDieuChinh)),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('Phương pháp', item.phuongPhapLabel),
                    _buildInfoRow('Nội dung sai', item.noiDungSai),
                    _buildInfoRow('Nội dung đúng', item.noiDungDung),
                    _buildInfoRow('Giá trị trước', _formatCurrency(item.giaTriTruoc)),
                    _buildInfoRow('Giá trị sau', _formatCurrency(item.giaTriSau), highlight: true),
                    _buildInfoRow('Lý do', item.lyDo),
                    _buildInfoRow('Người thực hiện', item.nguoiThucHien),
                    if (item.nguoiXacNhan != null)
                      _buildInfoRow('Người xác nhận', item.nguoiXacNhan!),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (item.trangThai == 'CHO_XAC_NHAN')
                          ElevatedButton(
                            onPressed: () => ref.read(dieuChinhSoProvider.notifier).approve(item.id),
                            child: const Text('Xác nhận'),
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

  Widget _buildInfoRow(String label, String value, {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text('$label:', style: TextStyle(color: Colors.grey.shade600)),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontWeight: highlight ? FontWeight.bold : FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'DA_XAC_NHAN':
        return Colors.green;
      case 'CHO_XAC_NHAN':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _formatCurrency(double value) {
    return '${value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}đ';
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    final soLoaiController = TextEditingController(text: 'S1-HKD');
    final noiDungSaiController = TextEditingController();
    final noiDungDungController = TextEditingController();
    final giaTriTruocController = TextEditingController();
    final giaTriSauController = TextEditingController();
    final lyDoController = TextEditingController();
    PhuongPhapSuaChua selectedMethod = PhuongPhapSuaChua.ghiBu;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Tạo điều chỉnh sổ'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: soLoaiController, decoration: const InputDecoration(labelText: 'Sổ (S1-S7)')),
                const SizedBox(height: 8),
                DropdownButtonFormField<PhuongPhapSuaChua>(
                  value: selectedMethod,
                  decoration: const InputDecoration(labelText: 'Phương pháp'),
                  items: PhuongPhapSuaChua.values.map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e == PhuongPhapSuaChua.gapDon ? 'Gạch đơn' : e == PhuongPhapSuaChua.ghiSoDu ? 'Ghi số dư' : 'Ghi bổ sung'),
                  )).toList(),
                  onChanged: (value) => setState(() => selectedMethod = value!),
                ),
                const SizedBox(height: 8),
                TextField(controller: noiDungSaiController, decoration: const InputDecoration(labelText: 'Nội dung sai')),
                const SizedBox(height: 8),
                TextField(controller: noiDungDungController, decoration: const InputDecoration(labelText: 'Nội dung đúng')),
                const SizedBox(height: 8),
                TextField(controller: giaTriTruocController, decoration: const InputDecoration(labelText: 'Giá trị trước'), keyboardType: TextInputType.number),
                const SizedBox(height: 8),
                TextField(controller: giaTriSauController, decoration: const InputDecoration(labelText: 'Giá trị sau'), keyboardType: TextInputType.number),
                const SizedBox(height: 8),
                TextField(controller: lyDoController, decoration: const InputDecoration(labelText: 'Lý do')),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Hủy')),
            ElevatedButton(
              onPressed: () {
                ref.read(dieuChinhSoProvider.notifier).createDieuChinh(
                  soLoaiController.text,
                  selectedMethod,
                  noiDungSaiController.text,
                  noiDungDungController.text,
                  double.tryParse(giaTriTruocController.text) ?? 0,
                  double.tryParse(giaTriSauController.text) ?? 0,
                  lyDoController.text,
                );
                Navigator.pop(ctx);
              },
              child: const Text('Tạo'),
            ),
          ],
        ),
      ),
    );
  }
}