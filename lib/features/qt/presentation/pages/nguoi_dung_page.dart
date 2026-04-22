// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - QT-01: Quản lý tài khoản người dùng & phân quyền
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/qt/domain/entities/nguoi_dung.dart';
import 'package:hkd_accounting/features/qt/presentation/providers/nguoi_dung_provider.dart';
import 'package:hkd_accounting/features/qt/presentation/widgets/nguoi_dung_form_dialog.dart';
import 'package:hkd_accounting/features/qt/presentation/widgets/nguoi_dung_list_item.dart';

class NguoiDungPage extends ConsumerWidget {
  const NguoiDungPage({Key? key}) : super(key: key);

  void _showFormDialog(BuildContext context, WidgetRef ref, {NguoiDung? nguoiDung}) {
    showDialog(
      context: context,
      builder: (context) => NguoiDungFormDialog(
        initialNguoiDung: nguoiDung,
        onSave: (newNguoiDung) async {
          if (nguoiDung != null) {
            await ref.read(nguoiDungProvider.notifier).updateNguoiDung(newNguoiDung);
          } else {
            await ref.read(nguoiDungProvider.notifier).saveNguoiDung(newNguoiDung);
          }
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }

  void _deleteNguoiDung(BuildContext context, WidgetRef ref, NguoiDung nguoiDung) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa người dùng'),
        content: Text('Bạn có chắc chắn muốn xóa người dùng "${nguoiDung.hoTen}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () async {
              await ref.read(nguoiDungProvider.notifier).deleteNguoiDung(nguoiDung.id);
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
      title: 'Quản lý người dùng',
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
                labelText: 'Tìm kiếm người dùng',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (query) {},
            ),
          ),
          Expanded(
            child: ref.watch(nguoiDungProvider).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Text('Lỗi: $error'),
              ),
              data: (nguoiDungList) {
                if (nguoiDungList.isEmpty) {
                  return const Center(
                    child: Text('Không có người dùng nào'),
                  );
                }
                return ListView.builder(
                  itemCount: nguoiDungList.length,
                  itemBuilder: (context, index) {
                    final nguoiDung = nguoiDungList[index];
                    return NguoiDungListItem(
                      nguoiDung: nguoiDung,
                      onEdit: (id) {
                        final existing = nguoiDungList.firstWhere((n) => n.id == id);
                        _showFormDialog(context, ref, nguoiDung: existing);
                      },
                      onDelete: (id) {
                        final existing = nguoiDungList.firstWhere((n) => n.id == id);
                        _deleteNguoiDung(context, ref, existing);
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
