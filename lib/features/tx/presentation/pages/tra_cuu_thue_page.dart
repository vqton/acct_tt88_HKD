import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:hkd_accounting/features/tx/presentation/providers/tien_thue_provider.dart';
import 'package:hkd_accounting/features/tx/presentation/providers/phieu_nop_thue_provider.dart';
import 'package:hkd_accounting/features/tx/presentation/providers/so_thue_provider.dart';

class TraCuuThuePage extends ConsumerWidget {
  const TraCuuThuePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Thuế'),
          bottom: const TabBar(isScrollable: true, tabs: [
            Tab(text: 'TX-01 Doanh thu'),
            Tab(text: 'TX-02 GTGT'),
            Tab(text: 'TX-03 TNCN'),
            Tab(text: 'TX-04 Nộp thuế'),
          ]),
        ),
        body: TabBarView(children: [
          _buildDoanhThuChiuThueTab(context, ref),
          _buildGtgtTab(context, ref),
          _buildTncnTab(context, ref),
          _buildNopThueTab(context, ref),
        ]),
      ),
    );
  }

  Widget _buildDoanhThuChiuThueTab(BuildContext context, WidgetRef ref) {
    final currencyFormat = NumberFormat('#,###');

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: ListTile(
          leading: const CircleAvatar(child: Icon(Icons.analytics)),
          title: const Text('Xác định doanh thu chịu thuế (TX-01)'),
          subtitle: const Text('Tổng hợp doanh thu theo nhóm ngành nghề từ S1-HKD'),
          trailing: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Chọn kỳ kế toán để tính')),
              );
            },
            child: const Text('Tính'),
          ),
        ),
      ),
    );
  }

  Widget _buildGtgtTab(BuildContext context, WidgetRef ref) {
    final gtgtList = ref.watch(tienThueGtgtProvider);
    final currencyFormat = NumberFormat('#,###');

    return gtgtList.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Lỗi: $e')),
      data: (list) {
        if (list.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calculate, size: 48, color: Colors.grey),
                SizedBox(height: 8),
                Text('Chưa có dữ liệu thuế GTGT'),
                SizedBox(height: 4),
                Text('Vui lòng chạy TX-01 trước', style: TextStyle(color: Colors.grey)),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: list.length,
          itemBuilder: (ctx, i) {
            final item = list[i];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.tenNhomNghe,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Chip(
                          label: Text(
                            '${(item.tyLeThueGtgt * 100).toStringAsFixed(0)}%',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow('Doanh thu:', currencyFormat.format(item.doanhThu)),
                    _buildInfoRow(
                      'Thuế GTGT phải nộp:',
                      currencyFormat.format(item.thueGtgtPhaiNop),
                      valueColor: Colors.red,
                    ),
                    _buildInfoRow(
                      'Đã nộp:',
                      currencyFormat.format(item.thueGtgtDaNop),
                      valueColor: Colors.green,
                    ),
                    _buildInfoRow(
                      'Còn phải nộp:',
                      currencyFormat.format(item.thueGtgtConPhaiNop),
                      valueColor: item.thueGtgtConPhaiNop > 0
                          ? Colors.orange
                          : Colors.grey,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTncnTab(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 48, color: Colors.grey),
          SizedBox(height: 8),
          Text('Thuế TNCN (TX-03)'),
          Text('Cần dữ liệu từ CT-05 Bảng lương'),
        ],
      ),
    );
  }

  Widget _buildNopThueTab(BuildContext context, WidgetRef ref) {
    final phieuNopList = ref.watch(phieuNopThueProvider);
    final currencyFormat = NumberFormat('#,###');

    return Scaffold(
      body: phieuNopList.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Lỗi: $e')),
        data: (list) {
          if (list.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long, size: 48, color: Colors.grey),
                  SizedBox(height: 8),
                  Text('Chưa có phiếu nộp thuế nào'),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: list.length,
            itemBuilder: (ctx, i) {
              final p = list[i];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: p.loaiThue.name == 'gtgt'
                        ? Colors.blue
                        : Colors.orange,
                    child: const Icon(Icons.payments, color: Colors.white),
                  ),
                  title: Text(
                    DateFormat('dd/MM/yyyy').format(p.ngayNop),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(p.dienGiai.isNotEmpty
                      ? p.dienGiai
                      : 'Số giấy: ${p.soGiayNopTien}'),
                  trailing: Text(
                    '${currencyFormat.format(p.tongTien)} ₫',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNopThueDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showNopThueDialog(BuildContext context, WidgetRef ref) {
    final soTienController = TextEditingController();
    final giayNopController = TextEditingController();
    var loaiThue = 'gtgt';
    var hinhThucNop = 'CHUYEN_KHOAN';

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nộp thuế (TX-04)'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: loaiThue,
                decoration: const InputDecoration(labelText: 'Loại thuế'),
                items: const [
                  DropdownMenuItem(value: 'gtgt', child: Text('Thuế GTGT')),
                  DropdownMenuItem(value: 'tncn', child: Text('Thuế TNCN')),
                ],
                onChanged: (v) => loaiThue = v ?? 'gtgt',
              ),
              const SizedBox(height: 12),
              TextField(
                controller: soTienController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Số tiền',
                  prefixText: '₫ ',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: giayNopController,
                decoration: const InputDecoration(labelText: 'Số giấy nộp tiền'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: hinhThucNop,
                decoration: const InputDecoration(labelText: 'Hình thức nộp'),
                items: const [
                  DropdownMenuItem(value: 'CHUYEN_KHOAN', child: Text('Chuyển khoản')),
                  DropdownMenuItem(value: 'TIEN_MAT', child: Text('Tiền mặt')),
                ],
                onChanged: (v) => hinhThucNop = v ?? 'CHUYEN_KHOAN',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã ghi nhận nộp thuế')),
              );
            },
            child: const Text('Xác nhận'),
          ),
        ],
      ),
    );
  }
}