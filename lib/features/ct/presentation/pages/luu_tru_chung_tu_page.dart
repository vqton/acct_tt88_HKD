// ============================================================================
// Presentation Layer - CT-07: Lưu trữ chứng từ kế toán Page
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/ct/presentation/providers/phieu_thu_provider.dart';
import 'package:hkd_accounting/features/ct/presentation/providers/phieu_chi_provider.dart';
import 'package:hkd_accounting/features/ct/presentation/providers/hoa_don_provider.dart';
import 'package:intl/intl.dart';

class LuuTruChungTuPage extends ConsumerWidget {
  const LuuTruChungTuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      title: 'Lưu trữ chứng từ kế toán',
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            const TabBar(isScrollable: true, tabs: [
              Tab(text: 'Phiếu thu'),
              Tab(text: 'Phiếu chi'),
              Tab(text: 'Hóa đơn'),
              Tab(text: 'NX kho'),
            ]),
            Expanded(
              child: TabBarView(children: [
                _buildPhieuThuList(ref),
                _buildVoucherList(ref.watch(phieuChiListProvider).whenOrNull(data: (s) => s) ?? []),
                _buildVoucherList(ref.watch(hoaDonProvider).whenOrNull(data: (s) => s) ?? []),
                const Center(child: Text('Nhập/Xuất kho')),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoucherList(List list) {
    if (list.isEmpty) {
      return const Center(child: Text('Không có chứng từ'));
    }
    return ListView.builder(itemCount: list.length, itemBuilder: (ctx, i) {
      final item = list[i];
      return ListTile(
        leading: CircleAvatar(child: Icon(_getIcon(item.runtimeType.toString()))),
        title: Text(item.soPhieu ?? item.soHoaDon ?? '...'),
        subtitle: Text(DateFormat('dd/MM/yyyy').format(item.ngayLap)),
        trailing: Chip(
          label: Text(_getStatusLabel(item.trangThai)),
          backgroundColor: _getStatusColor(item.trangThai),
        ),
      );
    });
  }

  Widget _buildPhieuThuList(WidgetRef ref) {
    return ref.watch(phieuThuListProvider).when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Lỗi: $e')),
      data: (list) => _buildVoucherList(list),
    );
  }

  IconData _getIcon(String type) {
    if (type.contains('PhieuThu')) return Icons.receipt_long;
    if (type.contains('PhieuChi')) return Icons.money_off;
    if (type.contains('HoaDon')) return Icons.description;
    return Icons.inventory;
  }

  String _getStatusLabel(String? status) {
    switch (status) {
      case 'DA_DUYET': return 'Đã lưu';
      case 'CHO_DUYET': return 'Chờ duyệt';
      default: return status ?? '';
    }
  }

  Color _getStatusColor(String? status) {
    if (status == 'DA_DUYET') return Colors.green.shade100;
    return Colors.orange.shade100;
  }
}