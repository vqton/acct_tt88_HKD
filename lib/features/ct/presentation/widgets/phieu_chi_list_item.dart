// ============================================================================
// Presentation Layer - Widget
// Based on UC_HKD_TT88_2021 - CT-02: Lập phiếu chi
// ============================================================================

import 'package:flutter/material.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_chi.dart';

class PhieuChiListItem extends StatelessWidget {
  final PhieuChi phieuChi;

  const PhieuChiListItem({
    Key? key,
    required this.phieuChi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Số phiếu: ${phieuChi.soPhieu}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Người nhận: ${phieuChi.nguoiNop}'),
          Text('Lý do: ${phieuChi.lyDoNop}'),
          Text('Số tiền: ${phieuChi.soTien.toString()}'),
          Text('Ngày: ${phieuChi.ngayLap.day}/${phieuChi.ngayLap.month}/${phieuChi.ngayLap.year}'),
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