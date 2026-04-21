// ============================================================================
// Presentation Layer - Widget
// Based on UC_HKD_TT88_2021 - MD-02: Quản lý danh mục hàng hóa/dịch vụ
// ============================================================================

import 'package:flutter/material.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/hang_hoa.dart';

class HangHoaListItem extends StatelessWidget {
  final HangHoa hangHoa;

  const HangHoaListItem({
    Key? key,
    required this.hangHoa,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(hangHoa.tenHangHoa),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Mã: ${hangHoa.maHangHoa}'),
          if (hangHoa.donViTinh != null && hangHoa.donViTinh!.isNotEmpty)
            Text('ĐVT: ${hangHoa.donViTinh}'),
          if (hangHoa.giaVon != null)
            Text('Giá vốn: ${hangHoa.giaVon!.toStringAsFixed(0)}'),
          if (hangHoa.giaBan != null)
            Text('Giá bán: ${hangHoa.giaBan!.toStringAsFixed(0)}'),
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