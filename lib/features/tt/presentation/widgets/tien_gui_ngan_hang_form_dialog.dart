// ============================================================================
// Presentation Layer - Widget
// Based on UC_HKD_TT88_2021 - TT-02: Quản lý tiền gửi ngân hàng
// ============================================================================

import 'package:flutter/material.dart';
import 'package:hkd_accounting/features/tt/domain/entities/tien_gui_ngan_hang.dart';

class TienGuiNganHangFormDialog extends StatefulWidget {
  final TienGuiNganHang? initialTienGuiNganHang;
  final Function(TienGuiNganHang) onSave;

  const TienGuiNganHangFormDialog({
    Key? key,
    required this.initialTienGuiNganHang,
    required this.onSave,
  }) : super(key: key);

  @override
  State<TienGuiNganHangFormDialog> createState() => _TienGuiNganHangFormDialogState();
}

class _TienGuiNganHangFormDialogState extends State<TienGuiNganHangFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _maTaiKhoan;
  late String _tenTaiKhoan;
  late double _soDuDauKy;
  late double _tongThu;
  late double _tongChi;
  late double _soDuCuoiKy;
  late String _kyKeToanId;
  late String _trangThai;

  @override
  void initState() {
    super.initState();
    if (widget.initialTienGuiNganHang != null) {
      final tienGuiNganHang = widget.initialTienGuiNganHang!;
      _maTaiKhoan = tienGuiNganHang.maTaiKhoan;
      _tenTaiKhoan = tienGuiNganHang.tenTaiKhoan;
      _soDuDauKy = tienGuiNganHang.soDuDauKy;
      _tongThu = tienGuiNganHang.tongThu;
      _tongChi = tienGuiNganHang.tongChi;
      _soDuCuoiKy = tienGuiNganHang.soDuCuoiKy;
      _kyKeToanId = tienGuiNganHang.kyKeToanId;
      _trangThai = tienGuiNganHang.trangThai;
    } else {
      _maTaiKhoan = '';
      _tenTaiKhoan = '';
      _soDuDauKy = 0;
      _tongThu = 0;
      _tongChi = 0;
      _soDuCuoiKy = 0;
      _kyKeToanId = '';
      _trangThai = 'HOAT_DONG';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialTienGuiNganHang == null
          ? 'Thêm tiền gửi ngân hàng'
          : 'Sửa tiền gửi ngân hàng'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Mã tài khoản',
                  border: OutlineInputBorder(),
                ),
                initialValue: _maTaiKhoan,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mã tài khoản';
                  }
                  return null;
                },
                onSaved: (value) => _maTaiKhoan = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tên tài khoản',
                  border: OutlineInputBorder(),
                ),
                initialValue: _tenTaiKhoan,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên tài khoản';
                  }
                  return null;
                },
                onSaved: (value) => _tenTaiKhoan = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Số dư đầu kỳ',
                  border: OutlineInputBorder(),
                ),
                initialValue: _soDuDauKy != 0 ? _soDuDauKy.toString() : '',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số dư đầu kỳ';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Vui lòng nhập số hợp lệ';
                  }
                  if (double.parse(value) < 0) {
                    return 'Số dư đầu kỳ không được âm';
                  }
                  return null;
                },
                onSaved: (value) {
                  _soDuDauKy = double.parse(value!);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tổng thu',
                  border: OutlineInputBorder(),
                ),
                initialValue: _tongThu != 0 ? _tongThu.toString() : '',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tổng thu';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Vui lòng nhập số hợp lệ';
                  }
                  if (double.parse(value) < 0) {
                    return 'Tổng thu không được âm';
                  }
                  return null;
                },
                onSaved: (value) {
                  _tongThu = double.parse(value!);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tổng chi',
                  border: OutlineInputBorder(),
                ),
                initialValue: _tongChi != 0 ? _tongChi.toString() : '',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tổng chi';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Vui lòng nhập số hợp lệ';
                  }
                  if (double.parse(value) < 0) {
                    return 'Tổng chi không được âm';
                  }
                  return null;
                },
                onSaved: (value) {
                  _tongChi = double.parse(value!);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Số dư cuối kỳ',
                  border: OutlineInputBorder(),
                ),
                initialValue: _soDuCuoiKy != 0 ? _soDuCuoiKy.toString() : '',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số dư cuối kỳ';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Vui lòng nhập số hợp lệ';
                  }
                  if (double.parse(value) < 0) {
                    return 'Số dư cuối kỳ không được âm';
                  }
                  return null;
                },
                onSaved: (value) {
                  _soDuCuoiKy = double.parse(value!);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Mã kỳ kế toán',
                  border: OutlineInputBorder(),
                ),
                initialValue: _kyKeToanId,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mã kỳ kế toán';
                  }
                  return null;
                },
                onSaved: (value) => _kyKeToanId = value!,
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
                    value: 'DONG',
                    child: Text('Đóng'),
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
              final tienGuiNganHang = TienGuiNganHang(
                id: widget.initialTienGuiNganHang?.id ?? '',
                maTaiKhoan: _maTaiKhoan,
                tenTaiKhoan: _tenTaiKhoan,
                soDuDauKy: _soDuDauKy,
                tongThu: _tongThu,
                tongChi: _tongChi,
                soDuCuoiKy: _soDuCuoiKy,
                kyKeToanId: _kyKeToanId,
                trangThai: _trangThai,
              );
              widget.onSave(tienGuiNganHang);
            }
          },
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}