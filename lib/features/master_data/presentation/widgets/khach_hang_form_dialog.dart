// ============================================================================
// Presentation Layer - Widget
// Based on UC_HKD_TT88_2021 - MD-05: Quản lý danh mục khách hàng
// ============================================================================

import 'package:flutter/material.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/khach_hang.dart';

class KhachHangFormDialog extends StatefulWidget {
  final KhachHang? initialKhachHang;
  final Function(KhachHang) onSave;

  const KhachHangFormDialog({
    Key? key,
    required this.initialKhachHang,
    required this.onSave,
  }) : super(key: key);

  @override
  State<KhachHangFormDialog> createState() => _KhachHangFormDialogState();
}

class _KhachHangFormDialogState extends State<KhachHangFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _maKhachHang;
  late String _tenKhachHang;
  String? _diaChi;
  String? _maSoThue;
  String? _soDienThoai;
  late String _loaiKhachHang;
  late String _trangThai;

  @override
  void initState() {
    super.initState();
    if (widget.initialKhachHang != null) {
      final khachHang = widget.initialKhachHang!;
      _maKhachHang = khachHang.maKhachHang;
      _tenKhachHang = khachHang.tenKhachHang;
      _diaChi = khachHang.diaChi;
      _maSoThue = khachHang.maSoThue;
      _soDienThoai = khachHang.soDienThoai;
      _loaiKhachHang = khachHang.loaiKhachHang;
      _trangThai = khachHang.trangThai;
    } else {
      _maKhachHang = '';
      _tenKhachHang = '';
      _diaChi = null;
      _maSoThue = null;
      _soDienThoai = null;
      _loaiKhachHang = 'CA_NHAN';
      _trangThai = 'DANG_GIAO_DICH';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialKhachHang == null
          ? 'Thêm khách hàng'
          : 'Sửa khách hàng'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Mã khách hàng',
                  border: OutlineInputBorder(),
                ),
                initialValue: _maKhachHang,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mã khách hàng';
                  }
                  return null;
                },
                onSaved: (value) => _maKhachHang = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tên khách hàng',
                  border: OutlineInputBorder(),
                ),
                initialValue: _tenKhachHang,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên khách hàng';
                  }
                  return null;
                },
                onSaved: (value) => _tenKhachHang = value!,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Loại khách hàng',
                  border: OutlineInputBorder(),
                ),
                value: _loaiKhachHang,
                items: const [
                  DropdownMenuItem(
                    value: 'CA_NHAN',
                    child: Text('Cá nhân'),
                  ),
                  DropdownMenuItem(
                    value: 'TO_CHUC',
                    child: Text('Tổ chức'),
                  ),
                  DropdownMenuItem(
                    value: 'BAN_LE',
                    child: Text('Bán lẻ'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _loaiKhachHang = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Địa chỉ (tùy chọn)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _diaChi,
                onSaved: (value) => _diaChi = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Mã số thuế (tùy chọn)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _maSoThue,
                onSaved: (value) => _maSoThue = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Số điện thoại (tùy chọn)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _soDienThoai,
                onSaved: (value) => _soDienThoai = value,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Trạng thái',
                  border: OutlineInputBorder(),
                ),
                value: _trangThai,
                items: const [
                  DropdownMenuItem(
                    value: 'DANG_GIAO_DICH',
                    child: Text('Đang giao dịch'),
                  ),
                  DropdownMenuItem(
                    value: 'NGUNG',
                    child: Text('Ngừng'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _trangThai = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final khachHang = KhachHang(
                id: widget.initialKhachHang?.id ?? '',
                maKhachHang: _maKhachHang,
                tenKhachHang: _tenKhachHang,
                diaChi: _diaChi,
                maSoThue: _maSoThue,
                soDienThoai: _soDienThoai,
                loaiKhachHang: _loaiKhachHang,
                trangThai: _trangThai,
              );
              widget.onSave(khachHang);
            }
          },
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}
