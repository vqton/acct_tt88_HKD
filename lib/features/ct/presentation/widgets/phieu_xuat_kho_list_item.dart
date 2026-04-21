// ============================================================================
// Presentation Layer - Widgets
// Based on UC_HKD_TT88_2021 - CT-04: Lập phiếu xuất kho
// ============================================================================

import 'package:flutter/material.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_xuat_kho.dart';
import 'package:intl/intl.dart';

class PhieuXuatKhoListItem extends StatelessWidget {
  final PhieuXuatKho phieuXuatKho;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final VoidCallback? onApprove;

  const PhieuXuatKhoListItem({
    super.key,
    required this.phieuXuatKho,
    this.onTap,
    this.onDelete,
    this.onApprove,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final currencyFormat = NumberFormat('#,###');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Số phiếu: ${phieuXuatKho.soPhieu}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  _buildStatusChip(context),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_today,
                      size: 16, color: Theme.of(context).colorScheme.outline),
                  const SizedBox(width: 4),
                  Text(
                    dateFormat.format(phieuXuatKho.ngayLap),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              if (phieuXuatKho.lyDoXuat != null &&
                  phieuXuatKho.lyDoXuat!.isNotEmpty) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.description,
                        size: 16, color: Theme.of(context).colorScheme.outline),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        phieuXuatKho.lyDoXuat!,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
              if (phieuXuatKho.hoTenNguoiNhan != null &&
                  phieuXuatKho.hoTenNguoiNhan!.isNotEmpty) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.person,
                        size: 16, color: Theme.of(context).colorScheme.outline),
                    const SizedBox(width: 4),
                    Text(
                      'Người nhận: ${phieuXuatKho.hoTenNguoiNhan}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
              if (phieuXuatKho.boPhan != null &&
                  phieuXuatKho.boPhan!.isNotEmpty) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.business,
                        size: 16, color: Theme.of(context).colorScheme.outline),
                    const SizedBox(width: 4),
                    Text(
                      'Bộ phận: ${phieuXuatKho.boPhan}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tổng tiền: ${currencyFormat.format(phieuXuatKho.tongTien)} đ',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (phieuXuatKho.trangThai == 'CHO_DUYET') ...[
                        IconButton(
                          icon: const Icon(Icons.check_circle_outline),
                          onPressed: onApprove,
                          tooltip: 'Phê duyệt',
                          color: Colors.green,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: onDelete,
                          tooltip: 'Xóa',
                          color: Colors.red,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    String label;

    switch (phieuXuatKho.trangThai) {
      case 'DA_DUYET':
        backgroundColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        label = 'Đã duyệt';
        break;
      default:
        backgroundColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        label = 'Chờ duyệt';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
