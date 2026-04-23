// ============================================================================
// Presentation Layer - Widget
// Based on UC_HKD_TT88_2021 - MD-03: Quản lý danh mục ngành nghề & thuế suất
// ============================================================================

import 'package:flutter/material.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/nghe_nghiep.dart';

class NgheNghiepFormDialog extends StatefulWidget {
  final NgheNghiep? initialNgheNghiep;
  final Function(NgheNghiep) onSave;

  const NgheNghiepFormDialog({
    Key? key,
    required this.initialNgheNghiep,
    required this.onSave,
  }) : super(key: key);

  @override
  State<NgheNghiepFormDialog> createState() => _NgheNghiepFormDialogState();
}

class _NgheNghiepFormDialogState extends State<NgheNghiepFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _maNhomNgheNghe;
  late String _tenNhomNgheNghe;
  late double _tyLeThueGTGT;
  late double _tyLeThueTNCN;
  late DateTime _ngayHieuLuc;
  DateTime? _ngayHetHieuLuc;

  @override
  void initState() {
    super.initState();
    if (widget.initialNgheNghiep != null) {
      final ngheNghieu = widget.initialNgheNghiep!;
      _maNhomNgheNghe = ngheNghieu.maNhomNgheNghe;
      _tenNhomNgheNghe = ngheNghieu.tenNhomNgheNghe;
      _tyLeThueGTGT = ngheNghieu.tyLeThueGTGT;
      _tyLeThueTNCN = ngheNghieu.tyLeThueTNCN;
      _ngayHieuLuc = ngheNghieu.ngayHieuLuc;
      _ngayHetHieuLuc = ngheNghieu.ngayHetHieuLuc;
    } else {
      _maNhomNgheNghe = '';
      _tenNhomNgheNghe = '';
      _tyLeThueGTGT = 0.0;
      _tyLeThueTNCN = 0.0;
      _ngayHieuLuc = DateTime.now();
      _ngayHetHieuLuc = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialNgheNghiep == null
          ? 'Thêm ngành nghề'
          : 'Sửa ngành nghề'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Mã ngành nghề',
                  border: OutlineInputBorder(),
                ),
                initialValue: _maNhomNgheNghe,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mã ngành nghề';
                  }
                  return null;
                },
                onSaved: (value) => _maNhomNgheNghe = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tên ngành nghề',
                  border: OutlineInputBorder(),
                ),
                initialValue: _tenNhomNgheNghe,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên ngành nghề';
                  }
                  return null;
                },
                onSaved: (value) => _tenNhomNgheNghe = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Thuế GTGT (%)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _tyLeThueGTGT.toString(),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập thuế GTGT';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Vui lòng nhập số hợp lệ';
                  }
                  return null;
                },
                onSaved: (value) => _tyLeThueGTGT = double.parse(value!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Thuế TNCN (%)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _tyLeThueTNCN.toString(),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập thuế TNCN';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Vui lòng nhập số hợp lệ';
                  }
                  return null;
                },
                onSaved: (value) => _tyLeThueTNCN = double.parse(value!),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Ngày hiệu lực'),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _ngayHieuLuc,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null && mounted) {
                      setState(() {
                        _ngayHieuLuc = date;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 8),
                Text(
                  'Ngày hiệu lực: ${_ngayHieuLuc.day}/${_ngayHieuLuc.month}/${_ngayHieuLuc.year}',
                  style: TextStyle(),
                ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Ngày hết hiệu lực (tùy chọn)'),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _ngayHetHieuLuc ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null && mounted) {
                      setState(() {
                        _ngayHetHieuLuc = date;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 8),
              if (_ngayHetHieuLuc != null)
                Text(
                  'Ngày hết hiệu lực: ${_ngayHetHieuLuc!.day}/${_ngayHetHieuLuc!.month}/${_ngayHetHieuLuc!.year}',
                  style: const FontStyle(),
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
              final ngheNghieu = NgheNghiep(
                id: widget.initialNgheNghiep?.id ?? '',
                maNhomNgheNghe: _maNhomNgheNghe,
                tenNhomNgheNghe: _tenNhomNgheNghe,
                tyLeThueGTGT: _tyLeThueGTGT,
                tyLeThueTNCN: _tyLeThueTNCN,
                ngayHieuLuc: _ngayHieuLuc,
                ngayHetHieuLuc: _ngayHetHieuLuc,
              );
              widget.onSave(ngheNghieu);
            }
          },
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}