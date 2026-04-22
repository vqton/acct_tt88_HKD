// ============================================================================
// Presentation Layer - SK-04: Sổ chi phí (S3-HKD) Page
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/sk/presentation/providers/so_chi_phi_provider.dart';
import 'package:intl/intl.dart';

class SoChiPhiPage extends ConsumerWidget {
  const SoChiPhiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s3List = ref.watch(soChiPhiProvider);
    final currencyFormat = NumberFormat('#,###');

    return CustomScaffold(
      title: 'Sổ chi phí (S3-HKD)',
      floatingActionButton: FloatingActionButton(onPressed: () => _generate(context, ref), child: const Icon(Icons.sync)),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12), color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Row(children: [
              Expanded(flex: 1, child: Text('Ngày', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(flex: 1, child: Text('Số CT', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(flex: 2, child: Text('Diễn giải', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(flex: 1, child: Text('Tổng tiền', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.right)),
            ],),
          ),
          Expanded(child: s3List.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Lỗi: $e')),
            data: (list) => list.isEmpty 
              ? const Center(child: Text('Chưa có dữ liệu S3'))
              : ListView.builder(itemCount: list.length, itemBuilder: (ctx, i) {
                final s3 = list[i];
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                  child: Row(children: [
                    Expanded(flex: 1, child: Text(DateFormat('dd/MM').format(s3.ngayChungTu))),
                    Expanded(flex: 1, child: Text(s3.soHieuChungTu ?? '-', style: const TextStyle(fontWeight: FontWeight.bold))),
                    Expanded(flex: 2, child: Text(s3.dienGiai ?? '-', maxLines: 1, overflow: TextOverflow.ellipsis)),
                    Expanded(flex: 1, child: Text('${currencyFormat.format(s3.tongTien)}', textAlign: TextAlign.right)),
                  ]),
                );
              }),
          )),
        ],
      ),
    );
  }

  void _generate(BuildContext context, WidgetRef ref) {
    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: const Text('Tạo S3 từ phiếu chi'),
      content: const Text('Đọc dữ liệu từ phiếu chi (CT-02) để tạo S3?'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Hủy')),
        ElevatedButton(onPressed: () { ref.read(soChiPhiProvider.notifier).generateFromPhieuChi(''); Navigator.pop(ctx); }, child: const Text('Tạo')),
      ],
    ));
  }
}