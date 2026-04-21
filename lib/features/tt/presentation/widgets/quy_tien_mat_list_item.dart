// ============================================================================
// Presentation Layer - Widget
// Based on UC_HKD_TT88_2021 - TT-01: Quản lý quỹ tiền mặt
// ============================================================================

import 'package:flutter/material.dart';
import 'package:hkd_accounting/features/tt/domain/entities/quy_tien_mat.dart';

class QuyTienMatListItem extends StatelessWidget {
  final QuyTienMat quyTienMat;

  const QuyTienMatListItem({
    Key? key,
    required this.quyTienMat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(quyTienMat.tenQuy),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Mã quỹ: ${quyTienMat.maQuy}'),
          Text('Số dư đầu kỳ: ${quyTienMat.soDuDauKy.toStringAsFixed(0)}'),
          Text('Số dư cuối kỳ: ${quyTienMat.soDuCuoiKy.toStringAsFixed(0)}'),
        ],
      ),
      trailing: PopupMenuButton<String>(
        onSelected: (value) {
          // Handle menu actions
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'edit',
            child: Text('Sửa'),
          ),
          const PopupMenuItem(
            value: 'delete',
            child: Text('Xóa'),
          ),
        ],
      ),
    );
  }
}