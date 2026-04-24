// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - QT-06: Nhật ký hệ thống và Audit Trail
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/qt/domain/entities/nhat_ky_he_thong.dart';
import 'package:hkd_accounting/features/qt/presentation/providers/nhat_ky_he_thong_provider.dart';

class NhatKyHeThongPage extends ConsumerStatefulWidget {
  const NhatKyHeThongPage({Key? key}) : super(key: key);

  @override
  ConsumerState<NhatKyHeThongPage> createState() => _NhatKyHeThongPageState();
}

class _NhatKyHeThongPageState extends ConsumerState<NhatKyHeThongPage> {
  HanhDong? _selectedHanhDong;
  DateTimeRange? _selectedDateRange;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(nhatKyHeThongListProvider);

    return CustomScaffold(
      title: 'Nhật ký hệ thống (QT-06)',
      body: Column(
        children: [
          _buildFilters(),
          Expanded(
            child: state.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Lỗi: $e')),
              data: (list) => list.isEmpty
                  ? _buildEmptyState()
                  : _buildListView(list),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showExportDialog(context),
        child: const Icon(Icons.download),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.grey.shade100,
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<HanhDong?>(
              value: _selectedHanhDong,
              decoration: const InputDecoration(
                labelText: 'Hành động',
                isDense: true,
              ),
              items: [
                const DropdownMenuItem(value: null, child: Text('Tất cả')),
                ...HanhDong.values.map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(_getHanhDongLabel(e)),
                )),
              ],
              onChanged: (value) {
                setState(() => _selectedHanhDong = value);
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: InkWell(
              onTap: _selectDateRange,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Khoảng ngày',
                  isDense: true,
                ),
                child: Text(
                  _selectedDateRange == null
                      ? 'Chọn khoảng ngày'
                      : '${DateFormat('dd/MM').format(_selectedDateRange!.start)} - ${DateFormat('dd/MM').format(_selectedDateRange!.end)}',
                  style: TextStyle(color: _selectedDateRange == null ? Colors.grey : null),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list_off),
            onPressed: () {
              setState(() {
                _selectedHanhDong = null;
                _selectedDateRange = null;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text('Chưa có nhật ký hệ thống', style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }

  Widget _buildListView(List<NhatKyHeThong> list) {
    final filteredList = list.where((item) {
      if (_selectedHanhDong != null && item.hanhDong != _selectedHanhDong) return false;
      if (_selectedDateRange != null) {
        if (item.timestamp.isBefore(_selectedDateRange!.start) ||
            item.timestamp.isAfter(_selectedDateRange!.end.add(const Duration(days: 1)))) return false;
      }
      return true;
    }).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final item = filteredList[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _getActionColor(item.hanhDong).withValues(alpha: 0.2),
              child: Icon(_getActionIcon(item.hanhDong), color: _getActionColor(item.hanhDong), size: 20),
            ),
            title: Text(item.doiTuongMoTa, style: const TextStyle(fontSize: 14)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${item.hanhDongLabel} bởi ${item.userName}',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
                Text(
                  DateFormat('dd/MM/yyyy HH:mm:ss').format(item.timestamp),
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 11),
                ),
              ],
            ),
            trailing: Chip(
              label: Text(_getHanhDongLabel(item.hanhDong), style: const TextStyle(fontSize: 10)),
              backgroundColor: _getActionColor(item.hanhDong).withValues(alpha: 0.1),
              padding: EdgeInsets.zero,
            ),
            onTap: () => _showDetailDialog(context, item),
          ),
        );
      },
    );
  }

  Color _getActionColor(HanhDong action) {
    switch (action) {
      case HanhDong.create:
        return Colors.green;
      case HanhDong.update:
      case HanhDong.adjust:
        return Colors.blue;
      case HanhDong.delete:
        return Colors.red;
      case HanhDong.approve:
        return Colors.teal;
      case HanhDong.reject:
        return Colors.orange;
      case HanhDong.login:
      case HanhDong.logout:
        return Colors.purple;
      case HanhDong.openBook:
      case HanhDong.closeBook:
        return Colors.brown;
    }
  }

  IconData _getActionIcon(HanhDong action) {
    switch (action) {
      case HanhDong.create:
        return Icons.add;
      case HanhDong.update:
        return Icons.edit;
      case HanhDong.delete:
        return Icons.delete;
      case HanhDong.approve:
        return Icons.check;
      case HanhDong.reject:
        return Icons.close;
      case HanhDong.login:
        return Icons.login;
      case HanhDong.logout:
        return Icons.logout;
      case HanhDong.openBook:
        return Icons.lock_open;
      case HanhDong.closeBook:
        return Icons.lock;
      case HanhDong.adjust:
        return Icons.sync_alt;
    }
  }

  String _getHanhDongLabel(HanhDong action) {
    switch (action) {
      case HanhDong.create:
        return 'Tạo mới';
      case HanhDong.update:
        return 'Cập nhật';
      case HanhDong.delete:
        return 'Xóa';
      case HanhDong.approve:
        return 'Phê duyệt';
      case HanhDong.reject:
        return 'Từ chối';
      case HanhDong.login:
        return 'Đăng nhập';
      case HanhDong.logout:
        return 'Đăng xuất';
      case HanhDong.openBook:
        return 'Mở sổ';
      case HanhDong.closeBook:
        return 'Đóng sổ';
      case HanhDong.adjust:
        return 'Điều chỉnh';
    }
  }

  Future<void> _selectDateRange() async {
    final result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: _selectedDateRange,
    );
    if (result != null) {
      setState(() => _selectedDateRange = result);
    }
  }

  void _showDetailDialog(BuildContext context, NhatKyHeThong item) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(item.doiTuongMoTa),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Hành động', item.hanhDongLabel),
              _buildDetailRow('Người thực hiện', item.userName),
              _buildDetailRow('Chức danh', item.userRole),
              _buildDetailRow('Thời gian', DateFormat('dd/MM/yyyy HH:mm:ss').format(item.timestamp)),
              _buildDetailRow('Đối tượng', '${item.doiTuongLoai} #${item.doiTuongId}'),
              if (item.ipAddress != null) _buildDetailRow('IP', item.ipAddress!),
              if (item.ghiChu != null) _buildDetailRow('Ghi chú', item.ghiChu!),
              if (item.giaTriCu != null) ...[
                const SizedBox(height: 8),
                const Text('Giá trị trước:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(item.giaTriCu.toString(), style: const TextStyle(fontSize: 12)),
              ],
              if (item.giaTriMoi != null) ...[
                const SizedBox(height: 8),
                const Text('Giá trị sau:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(item.giaTriMoi.toString(), style: const TextStyle(fontSize: 12)),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Đóng')),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 100, child: Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _showExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xuất nhật ký'),
        content: const Text('Xuất toàn bộ nhật ký ra file CSV?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Hủy')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã xuất file nhật ký')),
              );
            },
            child: const Text('Xuất'),
          ),
        ],
      ),
    );
  }
}