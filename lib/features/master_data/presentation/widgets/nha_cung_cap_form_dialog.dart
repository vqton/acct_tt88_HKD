// ============================================================================
// Presentation Layer - Widget
// Based on UC_HKD_TT88_2021 - MD-04: Quản lý danh mục nhà cung cấp
// ============================================================================

import 'package:flutter/material.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/nha_cung_cap.dart';

class NhaCungCapFormDialog extends StatefulWidget {
  final NhaCungCap? initialNhaCungCap;
  final Function(NhaCungCap) onSave;

  const NhaCungCapFormDialog({
    Key? key,
    required this.initialNhaCungCap,
    required this.onSave,
  }) : super(key: key);

  @override
  State<NhaCungCapFormDialog> createState() => _NhaCungCapFormDialogState();
}

class _NhaCungCapFormDialogState extends State<NhaCungCapFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _maNhaCungCap;
  late String _tenNhaCungCap;
  String? _diaChi;
  String? _maSoThue;
  String? _soDienThoai;
  String? _email;
  String? _nguoiDaiDien;
  DateTime? _ngaySinhNguoiDaiDien;
  String? _soCccdNguoiDaiDien;
  String? _taiKhoanNganHang;
  String? _tenNganHang;
  String? _chiNhanhNganHang;
  String _trangThai = 'HOAT_DONG'; // HOAT_DONG / NGUNG_KINH_DOANH

  @override
  void initState() {
    super.initState();
    if (widget.initialNhaCungCap != null) {
      final nhaCungCap = widget.initialNhaCungCap!;
      _maNhaCungCap = nhaCungCap.maNhaCungCap;
      _tenNhaCungCap = nhaCungCap.tenNhaCungCap;
      _diaChi = nhaCungCap.diaChi;
      _maSoThue = nhaCungCap.maSoThue;
      _soDienThoai = nhaCungCap.soDienThoai;
      _email = nhaCungCap.email;
      _nguoiDaiDien = nhaCungCap.nguoiDaiDien;
      _ngaySinhNguoiDaiDien = nhaCungCap.ngaySinhNguoiDaiDien;
      _soCccdNguoiDaiDien = nhaCungCap.soCccdNguoiDaiDien;
      _taiKhoanNganHang = nhaCungCap.taiKhoanNganHang;
      _tenNganHang = nhaCungCap.tenNganHang;
      _chiNhanhNganHang = nhaCungCap.chiNhanhNganHang;
      _trangThai = nhaCungCap.trangThai;
    } else {
      _maNhaCungCap = '';
      _tenNhaCungCap = '';
      _diaChi = null;
      _maSoThue = null;
      _soDienThoai = null;
      _email = null;
      _nguoiDaiDien = null;
      _ngaySinhNguoiDaiDien = null;
      _soCccdNguoiDaiDien = null;
      _taiKhoanNganHang = null;
      _tenNganHang = null;
      _chiNhanhNganHang = null;
      _trangThai = 'HOAT_DONG';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialNhaCungCap == null
          ? 'Thêm nhà cung cấp'
          : 'Sửa nhà cung cấp'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Mã nhà cung cấp',
                  border: OutlineInputBorder(),
                ),
                initialValue: _maNhaCungCap,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mã nhà cung cấp';
                  }
                  return null;
                },
                onSaved: (value) => _maNhaCungCap = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tên nhà cung cấp',
                  border: OutlineInputBorder(),
                ),
                initialValue: _tenNhaCungCap,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên nhà cung cấp';
                  }
                  return null;
                },
                onSaved: (value) => _tenNhaCungCap = value!,
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
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email (tùy chọn)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _email,
                onSaved: (value) => _email = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Người đại diện (tùy chọn)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _nguoiDaiDien,
                onSaved: (value) => _nguoiDaiDien = value,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Ngày sinh người đại diện (tùy chọn)'),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _ngaySinhNguoiDaiDien ?? DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (date != null && mounted) {
                      setState(() {
                        _ngaySinhNguoiDaiDien = date;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 8),
              if (_ngaySinhNguoiDaiDien != null)
                Text(
                  'Ngày sinh: ${_ngaySinhNguoiDaiDien!.day}/${_ngaySinhNguoiDaiDien!.month}/${_ngaySinhNguoiDaiDien!.year}',
                  style: const FontStyle(),
                ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Số CCCD người đại diện (tùy chọn)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _soCccdNguoiDaiDien,
                onSaved: (value) => _soCccdNguoiDaiDien = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tài khoản ngân hàng (tùy chọn)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _taiKhoanNganHang,
                onSaved: (value) => _taiKhoanNganHang = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tên ngân hàng (tùy chọn)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _tenNganHang,
                onSaved: (value) => _tenNganHang = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Chi nhánh ngân hàng (tùy chọn)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _chiNhanhNganHang,
                onSaved: (value) => _chiNhanhNganHang = value,
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
                    value: 'HOAT_DONG',
                    child: Text('Hoạt động'),
                  ),
                  DropdownMenuItem(
                    value: 'NGUNG_KINH_DOANH',
                    child: Text('Ngừng kinh doanh'),
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
              final nhaCungCap = NhaCungCap(
                id: widget.initialNhaCungCap?.id ?? '',
                maNhaCungCap: _maNhaCungCap,
                tenNhaCungCap: _tenNhaCungCap,
                diaChi: _diaChi,
                maSoThue: _maSoThue,
                soDienThoai: _soDienThoai,
                email: _email,
                nguoiDaiDien: _nguoiDaiDien,
                ngaySinhNguoiDaiDien: _ngaySinhNguoiDaiDien,
                soCccdNguoiDaiDien: _soCccdNguoiDaiDien,
                taiKhoanNganHang: _taiKhoanNganHang,
                tenNganHang: _tenNganHang,
                chiNhanhNganHang: _chiNhanhNganHang,
                trangThai: _trangThai,
              );
              widget.onSave(nhaCungCap);
            }
          },
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}