// ============================================================================
// Presentation Layer - Widget
// Based on UC_HKD_TT88_2021 - QT-01: Quản lý tài khoản người dùng & phân quyền
// ============================================================================

import 'package:flutter/material.dart';
import 'package:hkd_accounting/features/qt/domain/entities/nguoi_dung.dart';

class NguoiDungListItem extends StatelessWidget {
  final NguoiDung nguoiDung;
  final Function(String)? onEdit;
  final Function(String)? onDelete;

  const NguoiDungListItem({
    Key? key,
    required this.nguoiDung,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  String _getTrangThaiLabel(String trangThai) {
    switch (trangThai) {
      case 'HOAT_DONG':
        return 'Hoạt động';
      case 'NGHI_VIEC':
        return 'Nghỉ việc';
      case 'KHOA':
        return 'Khóa';
      default:
        return trangThai;
    }
  }

  Color _getTrangThaiColor(String trangThai) {
    switch (trangThai) {
      case 'HOAT_DONG':
        return Colors.green;
      case 'NGHI_VIEC':
        return Colors.orange;
      case 'KHOA':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(nguoiDung.hoTen),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Mã: ${nguoiDung.maNguoiDung}'),
          Text('Vai trò: ${nguoiDung.vaiTroLabel}'),
          if (nguoiDung.email != null && nguoiDung.email!.isNotEmpty)
            Text('Email: ${nguoiDung.email}'),
          Row(
            children: [
              const Text('Trạng thái: '),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _getTrangThaiColor(nguoiDung.trangThai).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _getTrangThaiLabel(nguoiDung.trangThai),
                  style: TextStyle(
                    color: _getTrangThaiColor(nguoiDung.trangThai),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: PopupMenuButton<String>(
        onSelected: (value) {
          if (value == 'edit' && onEdit != null) {
            onEdit!(nguoiDung.id);
          } else if (value == 'delete' && onDelete != null) {
            onDelete!(nguoiDung.id);
          }
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