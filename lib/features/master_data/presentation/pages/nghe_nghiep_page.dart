// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - MD-03: Quản lý danh mục ngành nghề & thuế suất
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/nghe_nghiep.dart';
import 'package:hkd_accounting/features/master_data/presentation/widgets/nghe_nghiep_form_dialog.dart';
import 'package:hkd_accounting/features/master_data/presentation/providers/nghe_nghiep_provider.dart';

class NgheNghiepPage extends ConsumerWidget {
  const NgheNghiepPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ngheNghieuState = ref.watch(ngheNghieuProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh mục ngành nghề & thuế suất'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showFormDialog(context, ref, null),
          ),
        ],
      ),
      body: ngheNghieuState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Lỗi: $error'),
              ElevatedButton(
                onPressed: () => ref.refresh(ngheNghieuProvider),
                child: const Text('Thử lại'),
              ),
            ],
          ),
        ),
        data: (ngheNghieuList) {
          if (ngheNghieuList.isEmpty) {
            return const Center(
              child: Text('Chưa có ngành nghề nào. Nhấn nút + để thêm.'),
            );
          }

          return ListView.builder(
            itemCount: ngheNghieuList.length,
            itemBuilder: (context, index) {
              final ngheNghieu = ngheNghieuList[index];
              return _NgheNghiepTile(
                ngheNghieu: ngheNghieu,
                onEdit: () => _showFormDialog(context, ref, ngheNghieu),
                onDelete: () => _deleteNgheNghiep(ref, ngheNghieu.id),
              );
            },
          );
        },
      ),
    );
  }

  void _showFormDialog(
      BuildContext context, WidgetRef ref, NgheNghiep? ngheNghieu) {
    showDialog(
      context: context,
      builder: (context) => NgheNghiepFormDialog(
        initialNgheNghiep: ngheNghieu,
        onSave: (ngheNghieu) {
          ref.read(ngheNghieuProvider.notifier).addOrUpdateNgheNghiep(ngheNghieu);
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Future<void> _deleteNgheNghiep(
      StateNotifierProvider<NgheNghiepNotifier, AsyncValue<List<NgheNghiep>>> provider,
      String id) async {
    final notifier = ref.read(provider.notifier);
    await notifier.deleteNgheNghiep(id);
  }
}

class _NgheNghiepTile extends ListTile {
  final NgheNghiep ngheNghieu;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _NgheNghiepTile({
    Key? key,
    required this.ngheNghieu,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(ngheNghieu.tenNhomNgheNghe),
      subtitle: Text(
        'Mã: ${ngheNghieu.maNhomNgheNghe} | GTGT: ${ngheNghieu.tyLeThueGTGT}% | TNCN: ${ngheNghieu.tyLeThueTNCN}%',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: onEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
      onTap: onEdit,
    );
  }
}