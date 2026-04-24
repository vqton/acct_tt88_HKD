// ============================================================================
// Presentation Layer - Widget
// Based on UC_HKD_TT88_2021 - CT-05: Lập bảng thanh toán tiền lương
// ============================================================================

import 'package:flutter/material.dart';
import 'package:hkd_accounting/features/ct/domain/entities/bang_luong.dart';

class BangLuongFormDialog extends StatefulWidget {
  final BangLuong? initialBangLuong;
  final Function(BangLuong) onSave;

  const BangLuongFormDialog({
    Key? key,
    required this.initialBangLuong,
    required this.onSave,
  }) : super(key: key);

  @override
  State<BangLuongFormDialog> createState() => _BangLuongFormDialogState();
}

class _BangLuongFormDialogState extends State<BangLuongFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _maBangLuong;
  late String _kyKeToanId;
  late String _thangNam;
  late double _tongLuongSanPham;
  late double _tongLuongThoiGian;
  late double _tongPhuCapQuyLuong;
  late double _tongPhuCapNgoaiQuy;
  late double _tongTienThuong;
  late double _tongBhxh;
  late double _tongBhyt;
  late double _tongBhtn;
  late double _tongThueTNCN;
  late String _trangThai;

  @override
  void initState() {
    super.initState();
    if (widget.initialBangLuong != null) {
      final bl = widget.initialBangLuong!;
      _maBangLuong = bl.maBangLuong;
      _kyKeToanId = bl.kyKeToanId;
      _thangNam = bl.thangNam;
      _tongLuongSanPham = bl.tongLuongSanPham;
      _tongLuongThoiGian = bl.tongLuongThoiGian;
      _tongPhuCapQuyLuong = bl.tongPhuCapQuyLuong;
      _tongPhuCapNgoaiQuy = bl.tongPhuCapNgoaiQuy;
      _tongTienThuong = bl.tongTienThuong;
      _tongBhxh = bl.tongBhxh;
      _tongBhyt = bl.tongBhyt;
      _tongBhtn = bl.tongBhtn;
      _tongThueTNCN = bl.tongThueTNCN;
      _trangThai = bl.trangThai;
    } else {
      _maBangLuong = 'BL${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
      _kyKeToanId = '';
      _thangNam = DateTime.now().month.toString().padLeft(2, '0') + '/' + DateTime.now().year.toString();
      _tongLuongSanPham = 0;
      _tongLuongThoiGian = 0;
      _tongPhuCapQuyLuong = 0;
      _tongPhuCapNgoaiQuy = 0;
      _tongTienThuong = 0;
      _tongBhxh = 0;
      _tongBhyt = 0;
      _tongBhtn = 0;
      _tongThueTNCN = 0;
      _trangThai = 'CHO_DUYET';
    }
  }

  String _formatCurrency(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialBangLuong == null
          ? 'Lập bảng lương'
          : 'Sửa bảng lương'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Mã bảng lương',
                  border: OutlineInputBorder(),
                ),
                initialValue: _maBangLuong,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mã bảng lương';
                  }
                  return null;
                },
                onSaved: (value) => _maBangLuong = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tháng/Năm (MM/yyyy)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _thangNam,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tháng/năm';
                  }
                  return null;
                },
                onSaved: (value) => _thangNam = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tổng lương sản phẩm',
                  border: OutlineInputBorder(),
                ),
                initialValue: _tongLuongSanPham.toString(),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _tongLuongSanPham = double.tryParse(value ?? '0') ?? 0;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tổng lương thời gian',
                  border: OutlineInputBorder(),
                ),
                initialValue: _tongLuongThoiGian.toString(),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _tongLuongThoiGian = double.tryParse(value ?? '0') ?? 0;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tổng phụ cấp quỹ lương',
                  border: OutlineInputBorder(),
                ),
                initialValue: _tongPhuCapQuyLuong.toString(),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _tongPhuCapQuyLuong = double.tryParse(value ?? '0') ?? 0;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tổng tiền thưởng',
                  border: OutlineInputBorder(),
                ),
                initialValue: _tongTienThuong.toString(),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _tongTienThuong = double.tryParse(value ?? '0') ?? 0;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tổng BHXH',
                  border: OutlineInputBorder(),
                ),
                initialValue: _tongBhxh.toString(),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _tongBhxh = double.tryParse(value ?? '0') ?? 0;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tổng BHYT',
                  border: OutlineInputBorder(),
                ),
                initialValue: _tongBhyt.toString(),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _tongBhyt = double.tryParse(value ?? '0') ?? 0;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tổng BHTN',
                  border: OutlineInputBorder(),
                ),
                initialValue: _tongBhtn.toString(),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _tongBhtn = double.tryParse(value ?? '0') ?? 0;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tổng thuế TNCN',
                  border: OutlineInputBorder(),
                ),
                initialValue: _tongThueTNCN.toString(),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _tongThueTNCN = double.tryParse(value ?? '0') ?? 0;
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
                    value: 'CHO_DUYET',
                    child: Text('Chờ duyệt'),
                  ),
                  DropdownMenuItem(
                    value: 'DA_DUYET',
                    child: Text('Đã duyệt'),
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
              
              final tongThuNhap = _tongLuongSanPham + _tongLuongThoiGian + 
                  _tongPhuCapQuyLuong + _tongPhuCapNgoaiQuy + _tongTienThuong;
              final tongKhauTru = _tongBhxh + _tongBhyt + _tongBhtn + _tongThueTNCN;
              final tongTraNhanVien = tongThuNhap - tongKhauTru;
              
              final bangLuong = BangLuong(
                id: widget.initialBangLuong?.id ?? '',
                maBangLuong: _maBangLuong,
                kyKeToanId: _kyKeToanId,
                thangNam: _thangNam,
                ngayLap: DateTime.now(),
                chiTietList: [],
                tongLuongSanPham: _tongLuongSanPham,
                tongLuongThoiGian: _tongLuongThoiGian,
                tongPhuCapQuyLuong: _tongPhuCapQuyLuong,
                tongPhuCapNgoaiQuy: _tongPhuCapNgoaiQuy,
                tongTienThuong: _tongTienThuong,
                tongThuNhap: tongThuNhap,
                tongBhxh: _tongBhxh,
                tongBhyt: _tongBhyt,
                tongBhtn: _tongBhtn,
                tongThueTNCN: _tongThueTNCN,
                tongKhauTru: tongKhauTru,
                tongTraNhanVien: tongTraNhanVien,
                trangThai: _trangThai,
              );
              widget.onSave(bangLuong);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}