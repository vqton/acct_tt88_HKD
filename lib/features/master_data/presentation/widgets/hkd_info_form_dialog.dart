// ============================================================================
// Presentation Layer - Widget
// Based on UC_HKD_TT88_2021 - MD-01: Quản lý thông tin HKD/CNKD
// ============================================================================

import 'package:flutter/material.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/hkd_info.dart';

class HkdInfoFormDialog extends StatefulWidget {
  final HkdInfo? initialHkdInfo;
  final Function(HkdInfo) onSave;

  const HkdInfoFormDialog({
    Key? key,
    required this.initialHkdInfo,
    required this.onSave,
  }) : super(key: key);

  @override
  State<HkdInfoFormDialog> createState() => _HkdInfoFormDialogState();
}

class _HkdInfoFormDialogState extends State<HkdInfoFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _maHkd;
  late String _tenHkd;
  late String _diaChi;
  late String _maSoThue;
  String? _soDienThoai;
  String? _email;
  late String _loaiHkd; // HKD, CNKD
  late String _nguoiDaiDien;
  late String _dienGiai;

  @override
  void initState() {
    super.initState();
    if (widget.initialHkdInfo != null) {
      final hkd = widget.initialHkdInfo!;
      _maHkd = hkd.maHkd;
      _tenHkd = hkd.tenHkd;
      _diaChi = hkd.diaChi;
      _maSoThue = hkd.maSoThue;
      _soDienThoai = hkd.soDienThoai;
      _email = hkd.email;
      _loaiHkd = hkd.loaiHkd;
      _nguoiDaiDien = hkd.nguoiDaiDien;
      _dienGiai = hkd.dienGiai;
    } else {
      _maHkd = '';
      _tenHkd = '';
      _diaChi = '';
      _maSoThue = '';
      _soDienThoai = null;
      _email = null;
      _loaiHkd = 'HKD';
      _nguoiDaiDien = '';
      _dienGiai = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialHkdInfo == null ? 'Thêm HKD/CNKD' : 'Sửa HKD/CNKD'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: _maHkd,
                decoration: const InputDecoration(labelText: 'Mã HKD'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
                onSaved: (value) => _maHkd = value!,
              ),
              TextFormField(
                initialValue: _tenHkd,
                decoration: const InputDecoration(labelText: 'Tên HKD'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
                onSaved: (value) => _tenHkd = value!,
              ),
              TextFormField(
                initialValue: _diaChi,
                decoration: const InputDecoration(labelText: 'Địa chỉ'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
                onSaved: (value) => _diaChi = value!,
              ),
              TextFormField(
                initialValue: _maSoThue,
                decoration: const InputDecoration(labelText: 'Mã số thuế'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
                onSaved: (value) => _maSoThue = value!,
              ),
              TextFormField(
                initialValue: _soDienThoai,
                decoration: const InputDecoration(labelText: 'Số điện thoại'),
                onSaved: (value) => _soDienThoai = value,
              ),
              TextFormField(
                initialValue: _email,
                decoration: const InputDecoration(labelText: 'Email'),
                onSaved: (value) => _email = value,
              ),
              DropdownButtonFormField<String>(
                value: _loaiHkd,
                decoration: const InputDecoration(labelText: 'Loại HKD'),
                items: const [
                  DropdownMenuItem(value: 'HKD', child: Text('Hộ kinh doanh')),
                  DropdownMenuItem(value: 'CNKD', child: Text('Cá nhân kinh doanh')),
                ],
                onChanged: (value) => setState(() => _loaiHkd = value!),
                onSaved: (value) => _loaiHkd = value!,
              ),
              TextFormField(
                initialValue: _nguoiDaiDien,
                decoration: const InputDecoration(labelText: 'Người đại diện'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
                onSaved: (value) => _nguoiDaiDien = value!,
              ),
              TextFormField(
                initialValue: _dienGiai,
                decoration: const InputDecoration(labelText: 'Diễn giải'),
                onSaved: (value) => _dienGiai = value!,
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
              final hkdInfo = widget.initialHkdInfo != null
                  ? widget.initialHkdInfo!.copyWith(
                      maHkd: _maHkd,
                      tenHkd: _tenHkd,
                      diaChi: _diaChi,
                      maSoThue: _maSoThue,
                      soDienThoai: _soDienThoai,
                      email: _email,
                      loaiHkd: _loaiHkd,
                      nguoiDaiDien: _nguoiDaiDien,
                      dienGiai: _dienGiai,
                    )
                  : HkdInfo(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      maHkd: _maHkd,
                      tenHkd: _tenHkd,
                      diaChi: _diaChi,
                      maSoThue: _maSoThue,
                      soDienThoai: _soDienThoai,
                      email: _email,
                      loaiHkd: _loaiHkd,
                      nguoiDaiDien: _nguoiDaiDien,
                      dienGiai: _dienGiai,
                    );
              widget.onSave(hkdInfo);
            }
          },
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}