// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - QT-03: Đóng kỳ kế toán và khóa sổ
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/qt/domain/entities/dong_ky_ke_toan.dart';
import 'package:hkd_accounting/features/qt/presentation/providers/dong_ky_ke_toan_provider.dart';

class DongKyKeToanPage extends ConsumerWidget {
  const DongKyKeToanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dongKyKeToanProvider);

    return CustomScaffold(
      title: 'Đóng kỳ kế toán (QT-03)',
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Lỗi: $e')),
        data: (item) => item == null ? _buildEmptyState(context, ref) : _buildChecklist(context, ref, item),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_outline, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text('Chưa có kỳ kế toán nào đang mở', style: TextStyle(color: Colors.grey.shade600)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _showOpenPeriodDialog(context, ref),
              icon: const Icon(Icons.add),
              label: const Text('Mở kỳ kiểm tra'),
              style: ElevatedButton.styleFrom(minimumSize: const Size(200, 48)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChecklist(BuildContext context, WidgetRef ref, DongKyKeToan item) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Kỳ: ${item.thangNam}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Chip(
                        label: Text(_getStatusLabel(item.trangThai)),
                        backgroundColor: _getStatusColor(item.trangThai).withValues(alpha: 0.2),
                      ),
                      const Spacer(),
                      Text('Ngày đóng: ${item.ngayDong.toString().substring(0, 10)}'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('CHECKLIST KIỂM TRA CUỐI KỲ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          _buildCheckItem(
            context,
            ref,
            item,
            'Đối chiếu quỹ tiền mặt',
            'Kiểm tra số dư quỹ với thực tế (TT-01)',
            item.daDoiChieuQuyTienMat,
            () => _toggleCheck(ref, item, 'quy'),
          ),
          _buildCheckItem(
            context,
            ref,
            item,
            'Đối chiếu tiền gửi ngân hàng',
            'Đối chiếu số dư với sao kê ngân hàng (TT-02)',
            item.daDoiChieuTienGui,
            () => _toggleCheck(ref, item, 'gui'),
          ),
          _buildCheckItem(
            context,
            ref,
            item,
            'Kiểm kê hàng tồn kho',
            'Kiểm tra tồn kho thực tế (KH-03)',
            item.daKiemKeTonKho,
            () => _toggleCheck(ref, item, 'kho'),
          ),
          _buildCheckItem(
            context,
            ref,
            item,
            'Xác nhận số thuế',
            'Đối chiếu thuế phải nộp và đã nộp (TX-04)',
            item.daXacNhanThue,
            () => _toggleCheck(ref, item, 'thue'),
          ),
          const SizedBox(height: 24),
          Center(
            child: item.daHoanThanhKiemTra
                ? _buildCloseButton(context, ref, item)
                : Text('Hoàn thành tất cả checklist để đóng kỳ', style: TextStyle(color: Colors.grey.shade600)),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckItem(
    BuildContext context,
    WidgetRef ref,
    DongKyKeToan item,
    String title,
    String subtitle,
    bool isChecked,
    VoidCallback onToggle,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Checkbox(
          value: isChecked,
          onChanged: (_) => onToggle(),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        trailing: isChecked ? const Icon(Icons.check_circle, color: Colors.green) : const Icon(Icons.radio_button_unchecked),
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context, WidgetRef ref, DongKyKeToan item) {
    return Column(
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 48),
        const SizedBox(height: 8),
        const Text('Đã hoàn thành kiểm tra!', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () => _showConfirmCloseDialog(context, ref, item),
          icon: const Icon(Icons.lock),
          label: const Text('ĐÓNG KỲ & KHÓA SỔ'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(200, 48),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'DANG_KIEM_TRA':
        return Colors.orange;
      case 'DA_KHOA_SO':
        return Colors.red;
      case 'DA_DONG':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'DANG_KIEM_TRA':
        return 'Đang kiểm tra';
      case 'DA_KHOA_SO':
        return 'Đã khóa sổ';
      case 'DA_DONG':
        return 'Đã đóng';
      default:
        return status;
    }
  }

  void _showOpenPeriodDialog(BuildContext context, WidgetRef ref) {
    final thangNamController = TextEditingController(text: DateTime.now().toString().substring(0, 7));
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Mở kỳ kiểm tra'),
        content: TextField(
          controller: thangNamController,
          decoration: const InputDecoration(labelText: 'Tháng/Năm (yyyy-MM)'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Hủy')),
          ElevatedButton(
            onPressed: () {
              ref.read(dongKyKeToanProvider.notifier).createNew(DateTime.now().toString(), thangNamController.text);
              Navigator.pop(ctx);
            },
            child: const Text('Mở'),
          ),
        ],
      ),
    );
  }

  void _toggleCheck(WidgetRef ref, DongKyKeToan item, String type) {
    switch (type) {
      case 'quy':
        ref.read(dongKyKeToanProvider.notifier).toggleQuyTienMat(item);
        break;
      case 'gui':
        ref.read(dongKyKeToanProvider.notifier).toggleTienGui(item);
        break;
      case 'kho':
        ref.read(dongKyKeToanProvider.notifier).toggleKiemKeTonKho(item);
        break;
      case 'thue':
        ref.read(dongKyKeToanProvider.notifier).toggleXacNhanThue(item);
        break;
    }
  }

  void _showConfirmCloseDialog(BuildContext context, WidgetRef ref, DongKyKeToan item) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xác nhận đóng kỳ'),
        content: const Text('Sau khi đóng kỳ, mọi giao dịch trong kỳ sẽ chỉ ở chế độ đọc. Tiếp tục?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Hủy')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            onPressed: () {
              ref.read(dongKyKeToanProvider.notifier).closePeriod(item);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã đóng kỳ và khóa sổ!')));
            },
            child: const Text('Đóng kỳ'),
          ),
        ],
      ),
    );
  }
}