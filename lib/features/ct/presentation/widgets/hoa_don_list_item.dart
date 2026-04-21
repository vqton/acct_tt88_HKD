// ============================================================================
// Presentation Layer - Widgets
// Based on UC_HKD_TT88_2021 - CT-06: Quản lý hóa đơn
// ============================================================================

import 'package:flutter/material.dart';
import 'package:hkd_accounting/features/ct/domain/entities/hoa_don.dart';
import 'package:intl/intl.dart';

class HoaDonListItem extends StatelessWidget {
  final HoaDon hoaDon;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const HoaDonListItem({
    super.key,
    required this.hoaDon,
    this.onTap,
    this.onDelete,
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
                    'Số HĐ: ${hoaDon.soHoaDon}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Row(
                    children: [
                      _buildLoaiChip(context),
                      const SizedBox(width: 8),
                      _buildStatusChip(context),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_today,
                      size: 16, color: Theme.of(context).colorScheme.outline),
                  const SizedBox(width: 4),
                  Text(dateFormat.format(hoaDon.ngayLap),
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tiền hàng: ${currencyFormat.format(hoaDon.tienHang)} đ',
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text('Thuế: ${currencyFormat.format(hoaDon.tienThue)} đ',
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                  Text(
                    'Tổng: ${currencyFormat.format(hoaDon.tongTien)} đ',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
              if (hoaDon.trangThai == 'MOI')
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: onDelete,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoaiChip(BuildContext context) {
    final isDauRa = hoaDon.loaiHoaDon == 'DAU_RA';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isDauRa ? Colors.blue.shade100 : Colors.green.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        isDauRa ? 'Đầu ra' : 'Đầu vào',
        style: TextStyle(
          color: isDauRa ? Colors.blue.shade800 : Colors.green.shade800,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context) {
    Color bgColor;
    Color textColor;
    String label;

    switch (hoaDon.trangThai) {
      case 'DA_DUYET':
        bgColor = Colors.green.shade100;
        textColor = Colors.green.shade800;
        label = 'Đã duyệt';
        break;
      case 'HUY':
        bgColor = Colors.red.shade100;
        textColor = Colors.red.shade800;
        label = 'Hủy';
        break;
      default:
        bgColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        label = 'Mới';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}