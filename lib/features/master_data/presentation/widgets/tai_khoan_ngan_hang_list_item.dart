// ============================================================================
// Presentation Layer - Widget
// Based on UC_HKD_TT88_2021 - MD-07: Quản lý danh mục tài khoản ngân hàng
// ============================================================================

import 'package:flutter/material.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/tai_khoan_ngan_hang.dart';

class TaiKhoanNganHangListItem extends StatelessWidget {
  final TaiKhoanNganHang taiKhoanNganHang;

  const TaiKhoanNganHangListItem({
    Key? key,
    required this.taiKhoanNganHang,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(taiKhoanNganHang.tenTaiKhoan),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Mã: ${taiKhoanNganHang.maTaiKhoan}'),
          if (taiKhoanNganHang.tenNganHang != null && taiKhoanNganHang.tenNganHang!.isNotEmpty)
            Text('Ngân hàng: ${taiKhoanNganHang.tenNganHang}'),
          if (taiKhoanNganHang.soTaiKhoan != null && taiKhoanNganHang.soTaiKhoan!.isNotEmpty)
            Text('Số TK: ${taiKhoanNganHang.soTaiKhoan}'),
          if (taiKhoanNganHang.loaiTaiKhoan != null && taiKhoanNganHang.loaiTaiKhoan!.isNotEmpty)
            Text('Loại: ${taiKhoanNganHang.loaiTaiKhoan}'),
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