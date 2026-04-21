// ============================================================================
// Presentation Layer - Widget
// Based on UC_HKD_TT88_2021 - MD-04: Quản lý danh mục nhà cung cấp
// ============================================================================

import 'package:flutter/material.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/nha_cung_cap.dart';

class NhaCungCapListItem extends StatelessWidget {
  final NhaCungCap nhaCungCap;

  const NhaCungCapListItem({
    Key? key,
    required this.nhaCungCap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(nhaCungCap.tenNhaCungCap),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Mã: ${nhaCungCap.maNhaCungCap}'),
          if (nhaCungCap.diaChi != null && nhaCungCap.diaChi!.isNotEmpty)
            Text('Địa chỉ: ${nhaCungCap.diaChi}'),
          if (nhaCungCap.soDienThoai != null && nhaCungCap.soDienThoai!.isNotEmpty)
            Text('SĐT: ${nhaCungCap.soDienThoai}'),
          if (nhaCungCap.email != null && nhaCungCap.email!.isNotEmpty)
            Text('Email: ${nhaCungCap.email}'),
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