// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - MD-05: Quản lý danh mục khách hàng
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/khach_hang.dart';
import 'package:hkd_accounting/features/master_data/presentation/providers/khach_hang_provider.dart';
import 'package:hkd_accounting/features/master_data/presentation/widgets/khach_hang_form_dialog.dart';
import 'package:hkd_accounting/features/master_data/presentation/widgets/khach_hang_list_item.dart';

class KhachHangPage extends ConsumerWidget {
  const KhachHangPage({Key? key}) : super(key: key);

  void _showFormDialog(BuildContext context, WidgetRef ref, {KhachHang? khachHang}) {
    showDialog(
      context: context,
      builder: (context) => KhachHangFormDialog(
        initialKhachHang: khachHang,
        onSave: (newKhachHang) async {
          if (khachHang != null) {
            await ref.read(khachHangProvider.notifier).updateKhachHang(newKhachHang);
          } else {
            await ref.read(khachHangProvider.notifier).saveKhachHang(newKhachHang);
          }
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }

  void _deleteKhachHang(BuildContext context, WidgetRef ref, KhachHang khachHang) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa khách hàng'),
        content: Text('Bạn có chắc chắn muốn xóa khách hàng "${khachHang.tenKhachHang}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () async {
              await ref.read(khachHangProvider.notifier).deleteKhachHang(khachHang.id);
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      title: 'Quản lý danh mục khách hàng',
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFormDialog(context, ref),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Tìm kiếm khách hàng',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (query) {},
            ),
          ),
          Expanded(
            child: ref.watch(khachHangProvider).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Text('Lỗi: $error'),
              ),
              data: (khachHangList) {
                if (khachHangList.isEmpty) {
                  return const Center(
                    child: Text('Không có khách hàng nào'),
                  );
                }
                return ListView.builder(
                  itemCount: khachHangList.length,
                  itemBuilder: (context, index) {
                    final khachHang = khachHangList[index];
                    return KhachHangListItem(
                      khachHang: khachHang,
                      onEdit: (id) {
                        final existing = khachHangList.firstWhere((k) => k.id == id);
                        _showFormDialog(context, ref, khachHang: existing);
                      },
                      onDelete: (id) {
                        final existing = khachHangList.firstWhere((k) => k.id == id);
                        _deleteKhachHang(context, ref, existing);
                      },
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
}
