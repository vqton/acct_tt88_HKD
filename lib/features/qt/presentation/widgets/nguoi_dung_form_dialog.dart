// ============================================================================
// Presentation Layer - Widget
// Based on UC_HKD_TT88_2021 - QT-01: Quản lý tài khoản người dùng & phân quyền
// ============================================================================

import 'package:flutter/material.dart';
import 'package:hkd_accounting/features/qt/domain/entities/nguoi_dung.dart';

class NguoiDungFormDialog extends StatefulWidget {
  final NguoiDung? initialNguoiDung;
  final Function(NguoiDung) onSave;

  const NguoiDungFormDialog({
    Key? key,
    required this.initialNguoiDung,
    required this.onSave,
  }) : super(key: key);

  @override
  State<NguoiDungFormDialog> createState() => _NguoiDungFormDialogState();
}

class _NguoiDungFormDialogState extends State<NguoiDungFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _maNguoiDung;
  late String _hoTen;
  String? _email;
  String? _soDienThoai;
  late String _vaiTro;
  late String _trangThai;
  String? _matKhau;

  @override
  void initState() {
    super.initState();
    if (widget.initialNguoiDung != null) {
      final nguoiDung = widget.initialNguoiDung!;
      _maNguoiDung = nguoiDung.maNguoiDung;
      _hoTen = nguoiDung.hoTen;
      _email = nguoiDung.email;
      _soDienThoai = nguoiDung.soDienThoai;
      _vaiTro = nguoiDung.vaiTro;
      _trangThai = nguoiDung.trangThai;
      _matKhau = null;
    } else {
      _maNguoiDung = '';
      _hoTen = '';
      _email = null;
      _soDienThoai = null;
      _vaiTro = 'KE_TOAN_VIEN';
      _trangThai = 'HOAT_DONG';
      _matKhau = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialNguoiDung == null
          ? 'Thêm người dùng'
          : 'Sửa người dùng'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Mã người dùng',
                  border: OutlineInputBorder(),
                ),
                initialValue: _maNguoiDung,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mã người dùng';
                  }
                  return null;
                },
                onSaved: (value) => _maNguoiDung = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Họ tên',
                  border: OutlineInputBorder(),
                ),
                initialValue: _hoTen,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập họ tên';
                  }
                  return null;
                },
                onSaved: (value) => _hoTen = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                initialValue: _email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (!value.contains('@')) {
                      return 'Email không hợp lệ';
                    }
                  }
                  return null;
                },
                onSaved: (value) => _email = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Số điện thoại',
                  border: OutlineInputBorder(),
                ),
                initialValue: _soDienThoai,
                keyboardType: TextInputType.phone,
                onSaved: (value) => _soDienThoai = value,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Vai trò',
                  border: OutlineInputBorder(),
                ),
                value: _vaiTro,
                items: const [
                  DropdownMenuItem(
                    value: 'ADMIN',
                    child: Text('Quản trị viên'),
                  ),
                  DropdownMenuItem(
                    value: 'KE_TOAN_VIEN',
                    child: Text('Kế toán viên'),
                  ),
                  DropdownMenuItem(
                    value: 'THU_QUY',
                    child: Text('Thủ quỹ'),
                  ),
                  DropdownMenuItem(
                    value: 'THU_KHO',
                    child: Text('Thủ kho'),
                  ),
                  DropdownMenuItem(
                    value: 'NGUOI_DAI_DIEN',
                    child: Text('Người đại diện'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _vaiTro = value!;
                  });
                },
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
                    value: 'NGHI_VIEC',
                    child: Text('Nghỉ việc'),
                  ),
                  DropdownMenuItem(
                    value: 'KHOA',
                    child: Text('Khóa'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _trangThai = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              if (widget.initialNguoiDung == null)
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Mật khẩu',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mật khẩu';
                    }
                    if (value.length < 6) {
                      return 'Mật khẩu phải có ít nhất 6 ký tự';
                    }
                    return null;
                  },
                  onSaved: (value) => _matKhau = value,
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
              final nguoiDung = NguoiDung(
                id: widget.initialNguoiDung?.id ?? '',
                maNguoiDung: _maNguoiDung,
                hoTen: _hoTen,
                email: _email,
                soDienThoai: _soDienThoai,
                vaiTro: _vaiTro,
                trangThai: _trangThai,
                matKhauHash: _matKhau,
              );
              widget.onSave(nguoiDung);
            }
          },
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}