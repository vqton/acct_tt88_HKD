// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - KH-01: Nhập kho hàng hóa
// Triggers: Hàng về đến kho
// Depends: CT-03 (Phiếu nhập kho), MD-02 (Danh mục hàng hóa)
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/ct/presentation/providers/phieu_nhap_kho_provider.dart';
import 'package:hkd_accounting/features/ct/presentation/pages/phieu_nhap_kho_page.dart';

class NhapKhoPage extends ConsumerWidget {
  const NhapKhoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      title: 'Nhập kho hàng hóa',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const PhieuNhapKhoPage(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Tạo phiếu nhập kho'),
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
                      'Quy trình nhập kho (KH-01)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('1. Kiểm nhận hàng về: đối chiếu số lượng thực nhận với hóa đơn/lệnh nhập'),
                    const Text('2. Lập phiếu nhập kho (CT-03)'),
                    const Text('3. Cập nhật sổ chi tiết vật tư hàng hóa (SK-03)'),
                    const Text('4. Lưu trữ chứng từ kèm theo (hóa đơn, biên bản giao nhận)'),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ref.watch(phieuNhapKhoProvider).when(
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
                        const Icon(Icons.inventory_2, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        const Text('Chưa có phiếu nhập kho nào'),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const PhieuNhapKhoPage(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Tạo phiếu nhập kho'),
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
                            if (phieu.nhaCungCapId != null)
                              Text('NCC: ${phieu.nhaCungCapId}'),
                            if (phieu.soHoaDon != null)
                              Text('Số HĐ: ${phieu.soHoaDon}'),
                          ],
                        ),
                        trailing: Chip(
                          label: Text(_getStatusLabel(phieu.trangThai)),
                          backgroundColor: _getStatusColor(phieu.trangThai).withValues(alpha: 0.2),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const PhieuNhapKhoPage(),
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