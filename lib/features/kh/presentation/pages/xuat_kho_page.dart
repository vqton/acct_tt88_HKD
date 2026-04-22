// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - KH-02: Xuất kho hàng hóa
// Triggers: Phiếu xuất kho đã được phê duyệt
// Depends: CT-04 (Phiếu xuất kho), MD-02, SK-03
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/ct/presentation/providers/phieu_xuat_kho_provider.dart';
import 'package:hkd_accounting/features/ct/presentation/pages/phieu_xuat_kho_page.dart';

class XuatKhoPage extends ConsumerWidget {
  const XuatKhoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      title: 'Xuất kho hàng hóa',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const PhieuXuatKhoPage(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Tạo phiếu xuất kho'),
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
                      'Quy trình xuất kho (KH-02)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('1. Nhận phiếu xuất kho đã ký duyệt'),
                    const Text('2. Kiểm tra tồn kho đủ đáp ứng yêu cầu'),
                    const Text('3. Xuất hàng, ghi số lượng thực xuất vào phiếu'),
                    const Text('4. Người nhận hàng ký xác nhận'),
                    const Text('5. Cập nhật sổ chi tiết vật tư hàng hóa (SK-03)'),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.orange.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.warning_amber, color: Colors.orange.shade700),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              'Lưu ý: Tồn kho không đủ → thông báo cho bộ phận yêu cầu, không xuất kho',
                              style: TextStyle(color: Colors.orange),
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
            child: ref.watch(phieuXuatKhoProvider).when(
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
                        const Icon(Icons.output, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        const Text('Chưa có phiếu xuất kho nào'),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const PhieuXuatKhoPage(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Tạo phiếu xuất kho'),
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
                            Text('Ngày: ${phieu.ngayLap}'),
                            if (phieu.hoTenNguoiNhan != null)
                              Text('Người nhận: ${phieu.hoTenNguoiNhan}'),
                            if (phieu.lyDoXuat != null)
                              Text('Lý do: ${phieu.lyDoXuat}'),
                          ],
                        ),
                        trailing: Chip(
                          label: Text(_getStatusLabel(phieu.trangThai)),
                          backgroundColor: _getStatusColor(phieu.trangThai).withOpacity(0.2),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const PhieuXuatKhoPage(),
                            ),
                          );
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

  Color _getStatusColor(String trangThai) {
    switch (trangThai) {
      case 'DA_DUYET':
        return Colors.green;
      case 'CHO_DUYET':
        return Colors.orange;
      case 'TU_CHOI':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String trangThai) {
    switch (trangThai) {
      case 'DA_DUYET':
        return Icons.check;
      case 'CHO_DUYET':
        return Icons.hourglass_empty;
      case 'TU_CHOI':
        return Icons.close;
      default:
        return Icons.help;
    }
  }

  String _getStatusLabel(String trangThai) {
    switch (trangThai) {
      case 'DA_DUYET':
        return 'Đã duyệt';
      case 'CHO_DUYET':
        return 'Chờ duyệt';
      case 'TU_CHOI':
        return 'Từ chối';
      default:
        return trangThai;
    }
  }
}
