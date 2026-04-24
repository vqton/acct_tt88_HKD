// ============================================================================
// Presentation Layer - Widget
// Based on UC_HKD_TT88_2021 - CT-05: Lập bảng thanh toán tiền lương
// ============================================================================

import 'package:flutter/material.dart';
import 'package:hkd_accounting/features/ct/domain/entities/bang_luong.dart';

class BangLuongListItem extends StatelessWidget {
  final BangLuong bangLuong;
  final VoidCallback? onTap;
  final VoidCallback? onApprove;
  final VoidCallback? onDelete;

  const BangLuongListItem({
    Key? key,
    required this.bangLuong,
    this.onTap,
    this.onApprove,
    this.onDelete,
  }) : super(key: key);

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          bangLuong.maBangLuong,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tháng: ${bangLuong.thangNam}'),
            Text('NLĐ: ${bangLuong.chiTietList.length} người'),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tổng thu nhập:'),
                Text(
                  '${_formatCurrency(bangLuong.tongThuNhap)} đ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Thực lĩnh:'),
                Text(
                  '${_formatCurrency(bangLuong.tongTraNhanVien)} đ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Chip(
              label: Text(
                bangLuong.trangThai == 'DA_DUYET' ? 'Đã duyệt' : 'Chờ duyệt',
                style: TextStyle(
                  color: bangLuong.trangThai == 'DA_DUYET'
                      ? Colors.white
                      : Colors.black,
                  fontSize: 12,
                ),
              ),
              backgroundColor: bangLuong.trangThai == 'DA_DUYET'
                  ? Colors.green
                  : Colors.orange[100],
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') {
                  onTap?.call();
                } else if (value == 'approve') {
                  onApprove?.call();
                } else if (value == 'delete') {
                  onDelete?.call();
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 20),
                      SizedBox(width: 8),
                      Text('Sửa'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'approve',
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, size: 20),
                      SizedBox(width: 8),
                      Text('Duyệt'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, size: 20),
                      SizedBox(width: 8),
                      Text('Xóa'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}