// ============================================================================
// Presentation Layer - Widget
// Based on UC_HKD_TT88_2021 - MD-05: Quản lý danh mục khách hàng
// ============================================================================

import 'package:flutter/material.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/khach_hang.dart';

class KhachHangListItem extends StatelessWidget {
  final KhachHang khachHang;
  final Function(String)? onEdit;
  final Function(String)? onDelete;

  const KhachHangListItem({
    Key? key,
    required this.khachHang,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  String _getLoaiKhachHangLabel(String loai) {
    switch (loai) {
      case 'TO_CHUC':
        return 'Tổ chức';
      case 'CA_NHAN':
        return 'Cá nhân';
      case 'BAN_LE':
        return 'Bán lẻ';
      default:
        return loai;
    }
  }

  String _getTrangThaiLabel(String trangThai) {
    switch (trangThai) {
      case 'DANG_GIAO_DICH':
        return 'Đang giao dịch';
      case 'NGUNG':
        return 'Ngừng';
      default:
        return trangThai;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(khachHang.tenKhachHang),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Mã: ${khachHang.maKhachHang}'),
          Text('Loại: ${_getLoaiKhachHangLabel(khachHang.loaiKhachHang)}'),
          if (khachHang.diaChi != null && khachHang.diaChi!.isNotEmpty)
            Text('Địa chỉ: ${khachHang.diaChi}'),
          if (khachHang.soDienThoai != null && khachHang.soDienThoai!.isNotEmpty)
            Text('SĐT: ${khachHang.soDienThoai}'),
          if (khachHang.maSoThue != null && khachHang.maSoThue!.isNotEmpty)
            Text('MST: ${khachHang.maSoThue}'),
        ],
      ),
      trailing: PopupMenuButton<String>(
        onSelected: (value) {
          if (value == 'edit' && onEdit != null) {
            onEdit!(khachHang.id);
          } else if (value == 'delete' && onDelete != null) {
            onDelete!(khachHang.id);
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
