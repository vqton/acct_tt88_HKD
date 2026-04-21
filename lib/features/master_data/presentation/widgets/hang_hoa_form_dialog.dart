// ============================================================================
// Presentation Layer - Widget
// Based on UC_HKD_TT88_2021 - MD-02: Quản lý danh mục hàng hóa/dịch vụ
// ============================================================================

import 'package:flutter/material.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/hang_hoa.dart';

class HangHoaFormDialog extends StatefulWidget {
  final HangHoa? initialHangHoa;
  final Function(HangHoa) onSave;

  const HangHoaFormDialog({
    Key? key,
    required this.initialHangHoa,
    required this.onSave,
  }) : super(key: key);

  @override
  State<HangHoaFormDialog> createState() => _HangHoaFormDialogState();
}

class _HangHoaFormDialogState extends State<HangHoaFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _maHangHoa;
  late String _tenHangHoa;
  String? _donViTinh;
  String? _loaiHangHoa; // HANG_HOA / DICH_VU
  double? _giaVon;
  double? _giaBan;
  String? _moTa;
  String _trangThai = 'HOAT_DONG'; // HOAT_DONG / NGUNG_KINH_DOANH

  @override
  void initState() {
    super.initState();
    if (widget.initialHangHoa != null) {
      final hangHoa = widget.initialHangHoa!;
      _maHangHoa = hangHoa.maHangHoa;
      _tenHangHoa = hangHoa.tenHangHoa;
      _donViTinh = hangHoa.donViTinh;
      _loaiHangHoa = hangHoa.loaiHangHoa;
      _giaVon = hangHoa.giaVon;
      _giaBan = hangHoa.giaBan;
      _moTa = hangHoa.moTa;
      _trangThai = hangHoa.trangThai;
    } else {
      _maHangHoa = '';
      _tenHangHoa = '';
      _donViTinh = null;
      _loaiHangHoa = null;
      _giaVon = null;
      _giaBan = null;
      _moTa = null;
      _trangThai = 'HOAT_DONG';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialHangHoa == null
          ? 'Thêm hàng hóa/dịch vụ'
          : 'Sửa hàng hóa/dịch vụ'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Mã hàng hóa',
                  border: OutlineInputBorder(),
                ),
                initialValue: _maHangHoa,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mã hàng hóa';
                  }
                  return null;
                },
                onSaved: (value) => _maHangHoa = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tên hàng hóa',
                  border: OutlineInputBorder(),
                ),
                initialValue: _tenHangHoa,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên hàng hóa';
                  }
                  return null;
                },
                onSaved: (value) => _tenHangHoa = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Đơn vị tính (tùy chọn)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _donViTinh,
                onSaved: (value) => _donViTinh = value,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Loại hàng hóa',
                  border: OutlineInputBorder(),
                ),
                value: _loaiHangHoa,
                items: const [
                  DropdownMenuItem(
                    value: null,
                    child: Text('Chọn loại hàng hóa'),
                  ),
                  DropdownMenuItem(
                    value: 'HANG_HOA',
                    child: Text('Hàng hóa'),
                  ),
                  DropdownMenuItem(
                    value: 'DICH_VU',
                    child: Text('Dịch vụ'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _loaiHangHoa = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Giá vốn (tùy chọn)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _giaVon != null ? _giaVon.toString() : '',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSaved: (value) {
                  _giaVon = value != null && value.isNotEmpty
                      ? double.tryParse(value)
                      : null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Giá bán (tùy chọn)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _giaBan != null ? _giaBan.toString() : '',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSaved: (value) {
                  _giaBan = value != null && value.isNotEmpty
                      ? double.tryParse(value)
                      : null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Mô tả (tùy chọn)',
                  border: OutlineInputBorder(),
                  maxLines: 3,
                ),
                initialValue: _moTa,
                maxLines: 3,
                onSaved: (value) => _moTa = value,
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
              final hangHoa = HangHoa(
                id: widget.initialHangHoa?.id ?? '',
                maHangHoa: _maHangHoa,
                tenHangHoa: _tenHangHoa,
                donViTinh: _donViTinh,
                loaiHangHoa: _loaiHangHoa,
                giaVon: _giaVon,
                giaBan: _giaBan,
                moTa: _moTa,
                trangThai: _trangThai,
              );
              widget.onSave(hangHoa);
            }
          },
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}