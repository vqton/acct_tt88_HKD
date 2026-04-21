// ============================================================================
// Presentation Layer - Widget
// Based on UC_HKD_TT88_2021 - MD-06: Quản lý danh mục người lao động
// ============================================================================

import 'package:flutter/material.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/nguoi_lao_dong.dart';

class NguoiLaoDongListItem extends StatelessWidget {
  final NguoiLaoDong nguoiLaoDong;

  const NguoiLaoDongListItem({
    Key? key,
    required this.nguoiLaoDong,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(nguoiLaoDong.hoTen),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Mã: ${nguoiLaoDong.maNguoiLaoDong}'),
          if (nguoiLaoDong.chucVu != null && nguoiLaoDong.chucVu!.isNotEmpty)
            Text('Chức vụ: ${nguoiLaoDong.chucVu}'),
          if (nguoiLaoDong.boPhan != null && nguoiLaoDong.boPhan!.isNotEmpty)
            Text('Bộ phận: ${nguoiLaoDong.boPhan}'),
          if (nguoiLaoDong.soDienThoai != null && nguoiLaoDong.soDienThoai!.isNotEmpty)
            Text('SĐT: ${nguoiLaoDong.soDienThoai}'),
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