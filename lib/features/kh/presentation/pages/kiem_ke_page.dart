// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - KH-03: Kiểm kê hàng tồn kho
// Triggers: Định kỳ (cuối kỳ kế toán) hoặc đột xuất
// Depends: SK-03
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/kh/presentation/providers/phieu_kiem_ke_provider.dart';

class KiemKePage extends ConsumerWidget {
  const KiemKePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      title: 'Kiểm kê hàng tồn kho',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showCreateDialog(context, ref);
        },
        icon: const Icon(Icons.add),
        label: const Text('Tạo phiếu kiểm kê'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Quy trình kiểm kê (KH-03)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('1. Kiểm đếm thực tế từng mặt hàng trong kho'),
                    const Text('2. Đối chiếu với sổ chi tiết vật tư hàng hóa (SK-03)'),
                    const Text('3. Xác định chênh lệch thừa/thiếu'),
                    const Text('4. Hàng thừa: lập phiếu nhập kho (CT-03)'),
                    const Text('5. Hàng thiếu: lập biên bản xác định nguyên nhân'),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.blue.shade700),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              'Kiểm kê định kỳ: cuối kỳ kế toán hoặc đột xuất theo yêu cầu',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ref.watch(phieuKiemKeProvider).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Text('Lỗi: $error'),
              ),
              data: (phieuList) {
                if (phieuList.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.fact_check, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        const Text('Chưa có phiếu kiểm kê nào'),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () => _showCreateDialog(context, ref),
                          icon: const Icon(Icons.add),
                          label: const Text('Tạo phiếu kiểm kê'),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: phieuList.length,
                  itemBuilder: (context, index) {
                    final phieu = phieuList[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: _getStatusColor(phieu.trangThai),
                          child: Icon(
                            _getStatusIcon(phieu.trangThai),
                            color: Colors.white,
                          ),
                        ),
                        title: Text('Phiếu: ${phieu.soPhieu}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ngày: ${phieu.ngayKiemKe}'),
                            Text('Kỳ KT: ${phieu.kyKeToanId}'),
                            if (phieu.ghiChu != null)
                              Text('Ghi chú: ${phieu.ghiChu}'),
                          ],
                        ),
                        trailing: Chip(
                          label: Text(phieu.trangThaiLabel),
                          backgroundColor: _getStatusColor(phieu.trangThai).withValues(alpha: 0.2),
                        ),
                        onTap: () {
                          ref.read(selectedPhieuKiemKeProvider.notifier).state = phieu;
                        },
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

  void _showCreateDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tạo phiếu kiểm kê'),
        content: const Text(
          'Chức năng tạo phiếu kiểm kê mới.\n\n'
          'Phiếu kiểm kê sẽ được tạo với trạng thái "Chờ kiểm kê" và có thể cập nhật số lượng thực tế sau khi kiểm đếm.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Tính năng đang được phát triển'),
                ),
              );
            },
            child: const Text('Tạo'),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String trangThai) {
    switch (trangThai) {
      case 'DA_HOAN_THANH':
        return Colors.green;
      case 'DANG_KIEM_KE':
        return Colors.blue;
      case 'CHO_KIEM_KE':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String trangThai) {
    switch (trangThai) {
      case 'DA_HOAN_THANH':
        return Icons.check_circle;
      case 'DANG_KIEM_KE':
        return Icons.pending;
      case 'CHO_KIEM_KE':
        return Icons.hourglass_empty;
      default:
        return Icons.help;
    }
  }
}