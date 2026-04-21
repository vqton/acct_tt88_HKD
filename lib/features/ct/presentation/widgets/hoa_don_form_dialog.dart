// ============================================================================
// Presentation Layer - Widget
// Based on UC_HKD_TT88_2021 - CT-06: Quản lý hóa đơn
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/features/ct/domain/entities/hoa_don.dart';
import 'package:intl/intl.dart';

class HoaDonFormDialog extends ConsumerStatefulWidget {
  final HoaDon? initialHoaDon;
  final Function(HoaDon) onSave;

  const HoaDonFormDialog({
    Key? key,
    this.initialHoaDon,
    required this.onSave,
  }) : super(key: key);

  @override
  ConsumerState<HoaDonFormDialog> createState() => _HoaDonFormDialogState();
}

class _HoaDonFormDialogState extends ConsumerState<HoaDonFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _soHoaDon;
  late DateTime _ngayLap;
  late String _loaiHoaDon;
  late String _kyKeToanId;
  String? _nhaCungCapId;
  String? _khachHangId;
  late int _tienHang;
  late int _tienThue;
  late String _trangThai;

  @override
  void initState() {
    super.initState();
    if (widget.initialHoaDon != null) {
      final hd = widget.initialHoaDon!;
      _soHoaDon = hd.soHoaDon;
      _ngayLap = hd.ngayLap;
      _loaiHoaDon = hd.loaiHoaDon;
      _kyKeToanId = hd.kyKeToanId;
      _nhaCungCapId = hd.nhaCungCapId;
      _khachHangId = hd.khachHangId;
      _tienHang = hd.tienHang;
      _tienThue = hd.tienThue;
      _trangThai = hd.trangThai;
    } else {
      _soHoaDon = '';
      _ngayLap = DateTime.now();
      _loaiHoaDon = 'DAU_RA';
      _kyKeToanId = '';
      _nhaCungCapId = null;
      _khachHangId = null;
      _tienHang = 0;
      _tienThue = 0;
      _trangThai = 'MOI';
    }
  }

  int get _tongTien => _tienHang + _tienThue;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.initialHoaDon == null ? 'Thêm hóa đơn' : 'Sửa hóa đơn',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Số hóa đơn *',
                          border: OutlineInputBorder(),
                        ),
                        initialValue: _soHoaDon,
                        validator: (v) => v?.isEmpty ?? true ? 'Nhập số HĐ' : null,
                        onSaved: (v) => _soHoaDon = v!,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ListTile(
                        title: const Text('Ngày lập'),
                        subtitle: Text(DateFormat('dd/MM/yyyy').format(_ngayLap)),
                        trailing: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: _ngayLap,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (date != null) setState(() => _ngayLap = date);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Loại hóa đơn *',
                    border: OutlineInputBorder(),
                  ),
                  value: _loaiHoaDon,
                  items: const [
                    DropdownMenuItem(value: 'DAU_RA', child: Text('Đầu ra (Bán hàng)')),
                    DropdownMenuItem(value: 'DAU_VAO', child: Text('Đầu vào (Mua hàng)')),
                  ],
                  onChanged: (v) => setState(() => _loaiHoaDon = v!),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Mã kỳ kế toán *',
                          border: OutlineInputBorder(),
                        ),
                        initialValue: _kyKeToanId,
                        validator: (v) => v?.isEmpty ?? true ? 'Nhập mã KKT' : null,
                        onSaved: (v) => _kyKeToanId = v!,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: _loaiHoaDon == 'DAU_RA' ? 'Mã khách hàng' : 'Mã NCC',
                          border: const OutlineInputBorder(),
                        ),
                        initialValue: _loaiHoaDon == 'DAU_RA' ? _khachHangId : _nhaCungCapId,
                        onSaved: (v) {
                          if (_loaiHoaDon == 'DAU_RA') {
                            _khachHangId = v;
                          } else {
                            _nhaCungCapId = v;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Tiền hàng',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        initialValue: _tienHang > 0 ? _tienHang.toString() : '',
                        onChanged: (v) => setState(() => _tienHang = int.tryParse(v) ?? 0),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Tiền thuế',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        initialValue: _tienThue > 0 ? _tienThue.toString() : '',
                        onChanged: (v) => setState(() => _tienThue = int.tryParse(v) ?? 0),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Tổng tiền: ${NumberFormat('#,###').format(_tongTien)} đ',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Hủy'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _saveForm,
                      child: const Text('Lưu'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final hoaDon = HoaDon(
        id: widget.initialHoaDon?.id ?? '',
        soHoaDon: _soHoaDon,
        ngayLap: _ngayLap,
        loaiHoaDon: _loaiHoaDon,
        kyKeToanId: _kyKeToanId,
        nhaCungCapId: _loaiHoaDon == 'DAU_VAO' ? _nhaCungCapId : null,
        khachHangId: _loaiHoaDon == 'DAU_RA' ? _khachHangId : null,
        tienHang: _tienHang,
        tienThue: _tienThue,
        tongTien: _tongTien,
        trangThai: _trangThai,
      );
      widget.onSave(hoaDon);
      Navigator.pop(context);
    }
  }
}