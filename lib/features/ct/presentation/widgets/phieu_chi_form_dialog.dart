// ============================================================================
// Presentation Layer - Widget
// Based on UC_HKD_TT88_2021 - CT-02: Lập phiếu chi
// ============================================================================

import 'package:flutter/material.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_chi.dart';

class PhieuChiFormDialog extends StatefulWidget {
  final PhieuChi? initialPhieuChi;
  final Function(PhieuChi) onSave;

  const PhieuChiFormDialog({
    Key? key,
    required this.initialPhieuChi,
    required this.onSave,
  }) : super(key: key);

  @override
  State<PhieuChiFormDialog> createState() => _PhieuChiFormDialogState();
}

class _PhieuChiFormDialogState extends State<PhieuChiFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _soPhieu;
  late DateTime _ngayLap;
  late String _nguoiNop;
  late String _diaChiNguoiNop;
  late String _lyDoNop;
  late int _soTien;
  late String _soTienBangChu;
  late String _chungTuGocKemTheo;
  late String _hkdInfoId;
  String? _nhaCungCapId;
  late String _kyKeToanId;
  late String _trangThai;

  @override
  void initState() {
    super.initState();
    if (widget.initialPhieuChi != null) {
      final phieuChi = widget.initialPhieuChi!;
      _soPhieu = phieuChi.soPhieu;
      _ngayLap = phieuChi.ngayLap;
      _nguoiNop = phieuChi.nguoiNop;
      _diaChiNguoiNop = phieuChi.diaChiNguoiNop;
      _lyDoNop = phieuChi.lyDoNop;
      _soTien = phieuChi.soTien;
      _soTienBangChu = phieuChi.soTienBangChu;
      _chungTuGocKemTheo = phieuChi.chungTuGocKemTheo;
      _hkdInfoId = phieuChi.hkdInfoId;
      _nhaCungCapId = phieuChi.nhaCungCapId;
      _kyKeToanId = phieuChi.kyKeToanId;
      _trangThai = phieuChi.trangThai;
    } else {
      _soPhieu = '';
      _ngayLap = DateTime.now();
      _nguoiNop = '';
      _diaChiNguoiNop = '';
      _lyDoNop = '';
      _soTien = 0;
      _soTienBangChu = '';
      _chungTuGocKemTheo = '';
      _hkdInfoId = '';
      _nhaCungCapId = null;
      _kyKeToanId = '';
      _trangThai = 'CHO_DUYET';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialPhieuChi == null
          ? 'Thêm phiếu chi'
          : 'Sửa phiếu chi'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Số phiếu',
                  border: OutlineInputBorder(),
                ),
                initialValue: _soPhieu,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số phiếu';
                  }
                  return null;
                },
                onSaved: (value) => _soPhieu = value!,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Ngày lập'),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _ngayLap,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (date != null && mounted) {
                      setState(() {
                        _ngayLap = date;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 8),
              if (_ngayLap != null)
                Text(
                  'Ngày lập: ${_ngayLap.day}/${_ngayLap.month}/${_ngayLap.year}',
                ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Người nhận tiền',
                  border: OutlineInputBorder(),
                ),
                initialValue: _nguoiNop,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập người nhận tiền';
                  }
                  return null;
                },
                onSaved: (value) => _nguoiNop = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Địa chỉ người nhận tiền',
                  border: OutlineInputBorder(),
                ),
                initialValue: _diaChiNguoiNop,
                onSaved: (value) => _diaChiNguoiNop = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Lý do chi',
                  border: OutlineInputBorder(),
                ),
                initialValue: _lyDoNop,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập lý do chi';
                  }
                  return null;
                },
                onSaved: (value) => _lyDoNop = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Số tiền',
                  border: OutlineInputBorder(),
                ),
                initialValue: _soTien != 0 ? _soTien.toString() : '',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số tiền';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Vui lòng nhập số nguyên';
                  }
                  if (int.parse(value) <= 0) {
                    return 'Số tiền phải lớn hơn 0';
                  }
                  return null;
                },
                onSaved: (value) {
                  _soTien = int.parse(value!);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Số tiền bằng chữ',
                  border: OutlineInputBorder(),
                ),
                initialValue: _soTienBangChu,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số tiền bằng chữ';
                  }
                  return null;
                },
                onSaved: (value) => _soTienBangChu = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Chứng từ gốc kèm theo',
                  border: OutlineInputBorder(),
                ),
                initialValue: _chungTuGocKemTheo,
                onSaved: (value) => _chungTuGocKemTheo = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Mã HKD/CNKD',
                  border: OutlineInputBorder(),
                ),
                initialValue: _hkdInfoId,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mã HKD/CNKD';
                  }
                  return null;
                },
                onSaved: (value) => _hkdInfoId = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Mã nhà cung cấp (tùy chọn)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _nhaCungCapId,
                onSaved: (value) => _nhaCungCapId = value,
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
                    value: 'CHO_DUYET',
                    child: Text('Chờ duyệt'),
                  ),
                  DropdownMenuItem(
                    value: 'DA_DUYET',
                    child: Text('Đã duyệt'),
                  ),
                  DropdownMenuItem(
                    value: 'DA_THU_HOI',
                    child: Text('Đã thu hồi'),
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
              final phieuChi = PhieuChi(
                id: widget.initialPhieuChi?.id ?? '',
                soPhieu: _soPhieu,
                ngayLap: _ngayLap,
                nguoiNop: _nguoiNop,
                diaChiNguoiNop: _diaChiNguoiNop,
                lyDoNop: _lyDoNop,
                soTien: _soTien,
                soTienBangChu: _soTienBangChu,
                chungTuGocKemTheo: _chungTuGocKemTheo,
                hkdInfoId: _hkdInfoId,
                nhaCungCapId: _nhaCungCapId,
                kyKeToanId: _kyKeToanId,
                trangThai: _trangThai,
              );
              widget.onSave(phieuChi);
            }
          },
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}