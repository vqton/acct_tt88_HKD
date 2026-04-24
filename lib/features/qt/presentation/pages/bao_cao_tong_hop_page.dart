// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - QT-04: Báo cáo tổng hợp cuối kỳ
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/qt/domain/entities/bao_cao_tong_hop.dart';
import 'package:hkd_accounting/features/qt/presentation/providers/bao_cao_tong_hop_provider.dart';

class BaoCaoTongHopPage extends ConsumerWidget {
  const BaoCaoTongHopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(baoCaoTongHopProvider);

    return CustomScaffold(
      title: 'Báo cáo tổng hợp cuối kỳ (QT-04)',
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Lỗi: $e')),
        data: (report) => report == null ? _buildEmptyState(context, ref) : _buildReport(context, ref, report),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(baoCaoTongHopProvider.notifier).generateReport(),
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assessment, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text('Chưa có báo cáo tổng hợp', style: TextStyle(color: Colors.grey.shade600)),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => ref.read(baoCaoTongHopProvider.notifier).generateReport(),
            icon: const Icon(Icons.add),
            label: const Text('Tạo báo cáo'),
          ),
        ],
      ),
    );
  }

  Widget _buildReport(BuildContext context, WidgetRef ref, BaoCaoTongHop report) {
    final currencyFormat = NumberFormat('#,### đ');

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Báo cáo tháng', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(report.thangNam, style: const TextStyle(fontSize: 20)),
                    ],
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy').format(report.ngayTao),
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('TÌNH HÌNH TÀI CHÍNH', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          _buildFinancialCard(
            'Doanh thu',
            currencyFormat.format(report.tongDoanhThu),
            Colors.green,
            Icons.trending_up,
          ),
          _buildFinancialCard(
            'Chi phí',
            currencyFormat.format(report.tongChiPhi),
            Colors.red,
            Icons.trending_down,
          ),
          _buildFinancialCard(
            'Lợi nhuận',
            currencyFormat.format(report.loiNhuan),
            report.loiNhuan >= 0 ? Colors.green : Colors.red,
            Icons.account_balance,
          ),
          const SizedBox(height: 16),
          const Text('TÌNH HÌNH QUỸ & TIỀN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildSmallCard('Quỹ tiền mặt', currencyFormat.format(report.tongQuyTienMat), Colors.blue)),
              const SizedBox(width: 8),
              Expanded(child: _buildSmallCard('Tiền gửi NH', currencyFormat.format(report.tongTienGui), Colors.teal)),
            ],
          ),
          Row(
            children: [
              Expanded(child: _buildSmallCard('Tồn kho', currencyFormat.format(report.tongTonKho), Colors.orange)),
              const SizedBox(width: 8),
              Expanded(child: _buildSmallCard('BHXH phải nộp', currencyFormat.format(report.tongBhxhPhaiNop), Colors.purple)),
            ],
          ),
          const SizedBox(height: 16),
          const Text('NGHĨA VỤ THUẾ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.receipt_long, color: Colors.red),
              title: const Text('Thuế phải nộp NSNN'),
              trailing: Text(
                currencyFormat.format(report.tongThuePhaiNop),
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton.icon(
              onPressed: () => _showExportDialog(context),
              icon: const Icon(Icons.download),
              label: const Text('Xuất báo cáo'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialCard(String title, String value, Color color, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: color.withValues(alpha: 0.2), child: Icon(icon, color: color)),
        title: Text(title),
        trailing: Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 16)),
      ),
    );
  }

  Widget _buildSmallCard(String title, String value, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
            const SizedBox(height: 4),
            Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }

  void _showExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xuất báo cáo'),
        content: const Text('Xuất báo cáo tổng hợp cuối kỳ ra file PDF?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Hủy')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã xuất báo cáo')));
            },
            child: const Text('Xuất'),
          ),
        ],
      ),
    );
  }
}