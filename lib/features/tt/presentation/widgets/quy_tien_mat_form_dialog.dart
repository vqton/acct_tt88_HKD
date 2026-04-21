// ============================================================================
// Presentation Layer - Widget
// Based on UC_HKD_TT88_2021 - TT-01: Quản lý quỹ tiền mặt
// ============================================================================

import 'package:flutter/material.dart';
import 'package:hkd_accounting/features/tt/domain/entities/quy_tien_mat.dart';

class QuyTienMatFormDialog extends StatefulWidget {
  final QuyTienMat? initialQuyTienMat;
  final Function(QuyTienMat) onSave;

  const QuyTienMatFormDialog({
    Key? key,
    required this.initialQuyTienMat,
    required this.onSave,
  }) : super(key: key);

  @override
  State<QuyTienMatFormDialog> createState() => _QuyTienMatFormDialogState();
}

class _QuyTienMatFormDialogState extends State<QuyTienMatFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _maQuy;
  late String _tenQuy;
  late double _soDuDauKy;
  late double _tongThu;
  late double _tongChi;
  late double _soDuCuoiKy;
  late String _kyKeToanId;
  late String _trangThai;

  @override
  void initState() {
    super.initState();
    if (widget.initialQuyTienMat != null) {
      final quyTienMat = widget.initialQuyTienMat!;
      _maQuy = quyTienMat.maQuy;
      _tenQuy = quyTienMat.tenQuy;
      _soDuDauKy = quyTienMat.soDuDauKy;
      _tongThu = quyTienMat.tongThu;
      _tongChi = quyTienMat.tongChi;
      _soDuCuoiKy = quyTienMat.soDuCuoiKy;
      _kyKeToanId = quyTienMat.kyKeToanId;
      _trangThai = quyTienMat.trangThai;
    } else {
      _maQuy = '';
      _tenQuy = '';
      _soDuDauKy = 0;
      _tongThu = 0;
      _tongChi = 0;
      _soDuCuoiKy = 0;
      _kyKeToanId = '';
      _trangThai = 'DANG_SU_DUNG';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialQuyTienMat == null
          ? 'Thêm quỹ tiền mặt'
          : 'Sửa quỹ tiền mặt'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Mã quỹ',
                  border: OutlineInputBorder(),
                ),
                initialValue: _maQuy,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mã quỹ';
                  }
                  return null;
                },
                onSaved: (value) => _maQuy = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tên quỹ',
                  border: OutlineInputBorder(),
                ),
                initialValue: _tenQuy,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên quỹ';
                  }
                  return null;
                },
                onSaved: (value) => _tenQuy = value!,
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
                    value: 'DANG_SU_DUNG',
                    child: Text('Đang sử dụng'),
                  ),
                  DropdownMenuItem(
                    value: 'NGUNG_SU_DUNG',
                    child: Text('Ngừng sử dụng'),
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
              final quyTienMat = QuyTienMat(
                id: widget.initialQuyTienMat?.id ?? '',
                maQuy: _maQuy,
                tenQuy: _tenQuy,
                soDuDauKy: _soDuDauKy,
                tongThu: _tongThu,
                tongChi: _tongChi,
                soDuCuoiKy: _soDuCuoiKy,
                kyKeToanId: _kyKeToanId,
                trangThai: _trangThai,
              );
              widget.onSave(quyTienMat);
            }
          },
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}