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
  late String _tenHkd;
  late String _diaChiTruSo;
  late String _maSoThue;
  String? _soDienThoai;
  String? _email;
  late String _phuongPhapTinhGiaXuatKho;
  late String _trangThai;

  @override
  void initState() {
    super.initState();
    if (widget.initialHkdInfo != null) {
      final hkd = widget.initialHkdInfo!;
      _tenHkd = hkd.tenHkd;
      _diaChiTruSo = hkd.diaChiTruSo ?? '';
      _maSoThue = hkd.maSoThue;
      _soDienThoai = hkd.hoTenNguoiDaiDien;
      _email = null;
      _phuongPhapTinhGiaXuatKho = hkd.phuongPhapTinhGiaXuatKho;
      _trangThai = hkd.trangThai;
    } else {
      _tenHkd = '';
      _diaChiTruSo = '';
      _maSoThue = '';
      _soDienThoai = null;
      _email = null;
      _phuongPhapTinhGiaXuatKho = 'BINH_QUAN';
      _trangThai = 'HOAT_DONG';
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
                initialValue: _tenHkd,
                decoration: const InputDecoration(labelText: 'Tên HKD'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
                onSaved: (value) => _tenHkd = value!,
              ),
              TextFormField(
                initialValue: _diaChiTruSo,
                decoration: const InputDecoration(labelText: 'Địa chỉ trụ sở'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
                onSaved: (value) => _diaChiTruSo = value!,
              ),
              TextFormField(
                initialValue: _maSoThue,
                decoration: const InputDecoration(labelText: 'Mã số thuế'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
                onSaved: (value) => _maSoThue = value!,
              ),
              DropdownButtonFormField<String>(
                value: _phuongPhapTinhGiaXuatKho,
                decoration: const InputDecoration(labelText: 'Phương pháp tính giá xuất kho'),
                items: const [
                  DropdownMenuItem(value: 'BINH_QUAN', child: Text('Bình quân')),
                  DropdownMenuItem(value: 'FIFO', child: Text('FIFO')),
                ],
                onChanged: (value) => setState(() => _phuongPhapTinhGiaXuatKho = value!),
                onSaved: (value) => _phuongPhapTinhGiaXuatKho = value!,
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
              final hkdInfo = HkdInfo(
                id: widget.initialHkdInfo?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
                tenHkd: _tenHkd,
                diaChiTruSo: _diaChiTruSo,
                maSoThue: _maSoThue,
                phuongPhapTinhGiaXuatKho: _phuongPhapTinhGiaXuatKho,
                trangThai: _trangThai,
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