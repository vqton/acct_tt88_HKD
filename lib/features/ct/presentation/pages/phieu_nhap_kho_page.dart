// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - CT-03: Lập phiếu nhập kho
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/ct/presentation/providers/phieu_nhap_kho_provider.dart';
import 'package:hkd_accounting/features/ct/presentation/widgets/phieu_nhap_kho_form_dialog.dart';
import 'package:hkd_accounting/features/ct/presentation/widgets/phieu_nhap_kho_list_item.dart';

class PhieuNhapKhoPage extends ConsumerWidget {
  const PhieuNhapKhoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      title: 'Lập phiếu nhập kho',
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => PhieuNhapKhoFormDialog(
              onSave: (phieuNhapKho) {
                ref.read(phieuNhapKhoProvider.notifier).savePhieuNhapKho(phieuNhapKho);
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
                labelText: 'Tìm kiếm phiếu nhập kho',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (query) {
                ref.read(phieuNhapKhoProvider.notifier).searchPhieuNhapKho(query);
              },
            ),
          ),
          Expanded(
            child: ref.watch(phieuNhapKhoProvider).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Text('Lỗi: $error'),
              ),
              data: (phieuNhapKhoList) {
                if (phieuNhapKhoList.isEmpty) {
                  return const Center(
                    child: Text('Không có phiếu nhập kho nào'),
                  );
                }
                return ListView.builder(
                  itemCount: phieuNhapKhoList.length,
                  itemBuilder: (context, index) {
                    final phieuNhapKho = phieuNhapKhoList[index];
                    return PhieuNhapKhoListItem(
                      phieuNhapKho: phieuNhapKho,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => PhieuNhapKhoFormDialog(
                            initialPhieuNhapKho: phieuNhapKho,
                            onSave: (updated) {
                              ref.read(phieuNhapKhoProvider.notifier)
                                  .updatePhieuNhapKho(updated);
                            },
                          ),
                        );
                      },
                      onDelete: () {
                        _showDeleteConfirmation(context, ref, phieuNhapKho.id);
                      },
                      onApprove: () {
                        ref.read(phieuNhapKhoProvider.notifier)
                            .approvePhieuNhapKho(phieuNhapKho.id);
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
        content: const Text('Bạn có chắc chắn muốn xóa phiếu nhập kho này?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(phieuNhapKhoProvider.notifier).deletePhieuNhapKho(id);
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
