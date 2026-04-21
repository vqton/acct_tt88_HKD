// ============================================================================
// Presentation Layer - Widgets
// Based on UC_HKD_TT88_2021 - KH-04: Tính giá xuất kho
// ============================================================================

import 'package:flutter/material.dart';
import 'package:hkd_accounting/features/kh/domain/entities/ton_kho.dart';
import 'package:intl/intl.dart';

class TonKhoListItem extends StatelessWidget {
  final TonKho tonKho;
  final String tenHangHoa;
  final VoidCallback? onTap;

  const TonKhoListItem({
    super.key,
    required this.tonKho,
    required this.tenHangHoa,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat('#,###');
    final numberFormat = NumberFormat('#,##0.####');

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
              Text(
                tenHangHoa,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildColumn(
                      context,
                      'Tồn đầu',
                      '${currencyFormat.format(tonKho.tonDauThanhTien)} đ',
                      '${numberFormat.format(tonKho.tonDauSoLuong)}',
                    ),
                  ),
                  Expanded(
                    child: _buildColumn(
                      context,
                      'Nhập',
                      '${currencyFormat.format(tonKho.nhapThanhTien)} đ',
                      '${numberFormat.format(tonKho.nhapSoLuong)}',
                    ),
                  ),
                  Expanded(
                    child: _buildColumn(
                      context,
                      'Xuất',
                      '${currencyFormat.format(tonKho.xuatThanhTien)} đ',
                      '${numberFormat.format(tonKho.xuatSoLuong)}',
                    ),
                  ),
                  Expanded(
                    child: _buildColumn(
                      context,
                      'Tồn cuối',
                      '${currencyFormat.format(tonKho.tonCuoiThanhTien)} đ',
                      '${numberFormat.format(tonKho.tonCuoiSoLuong)}',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Đơn giá xuất kho:',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    '${NumberFormat('#,##0').format(tonKho.donGiaXuatKho)} đ',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColumn(
      BuildContext context, String label, String thanhTien, String soLuong) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          thanhTien,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          soLuong,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}