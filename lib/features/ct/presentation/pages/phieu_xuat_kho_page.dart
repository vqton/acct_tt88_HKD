// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - CT-04: Lập phiếu xuất kho
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/ct/presentation/providers/phieu_xuat_kho_provider.dart';
import 'package:hkd_accounting/features/ct/presentation/widgets/phieu_xuat_kho_form_dialog.dart';
import 'package:hkd_accounting/features/ct/presentation/widgets/phieu_xuat_kho_list_item.dart';

class PhieuXuatKhoPage extends ConsumerWidget {
  const PhieuXuatKhoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      title: 'Lập phiếu xuất kho',
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => PhieuXuatKhoFormDialog(
              onSave: (phieuXuatKho) {
                ref.read(phieuXuatKhoProvider.notifier).savePhieuXuatKho(phieuXuatKho);
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Tìm kiếm phiếu xuất kho',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (query) {
                ref.read(phieuXuatKhoProvider.notifier).searchPhieuXuatKho(query);
              },
            ),
          ),
          Expanded(
            child: ref.watch(phieuXuatKhoProvider).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Text('Lỗi: $error'),
              ),
              data: (phieuXuatKhoList) {
                if (phieuXuatKhoList.isEmpty) {
                  return const Center(
                    child: Text('Không có phiếu xuất kho nào'),
                  );
                }
                return ListView.builder(
                  itemCount: phieuXuatKhoList.length,
                  itemBuilder: (context, index) {
                    final phieuXuatKho = phieuXuatKhoList[index];
                    return PhieuXuatKhoListItem(
                      phieuXuatKho: phieuXuatKho,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => PhieuXuatKhoFormDialog(
                            initialPhieuXuatKho: phieuXuatKho,
                            onSave: (updated) {
                              ref.read(phieuXuatKhoProvider.notifier)
                                  .updatePhieuXuatKho(updated);
                            },
                          ),
                        );
                      },
                      onDelete: () {
                        _showDeleteConfirmation(context, ref, phieuXuatKho.id);
                      },
                      onApprove: () {
                        ref.read(phieuXuatKhoProvider.notifier)
                            .approvePhieuXuatKho(phieuXuatKho.id);
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

  void _showDeleteConfirmation(
      BuildContext context, WidgetRef ref, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: const Text('Bạn có chắc chắn muốn xóa phiếu xuất kho này?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(phieuXuatKhoProvider.notifier).deletePhieuXuatKho(id);
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }
}
