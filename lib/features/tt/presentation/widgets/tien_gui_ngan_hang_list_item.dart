// ============================================================================
// Presentation Layer - Widget
// Based on UC_HKD_TT88_2021 - TT-02: Quản lý tiền gửi ngân hàng
// ============================================================================

import 'package:flutter/material.dart';
import 'package:hkd_accounting/features/tt/domain/entities/tien_gui_ngan_hang.dart';

class TienGuiNganHangListItem extends StatelessWidget {
  final TienGuiNganHang tienGuiNganHang;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const TienGuiNganHangListItem({
    Key? key,
    required this.tienGuiNganHang,
    this.onTap,
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
          tienGuiNganHang.maTaiKhoan,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tienGuiNganHang.tenTaiKhoan),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Số dư cuối:',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  '${_formatCurrency(tienGuiNganHang.soDuCuoiKy)} đ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') {
              onTap?.call();
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
        onTap: onTap,
      ),
    );
  }
}