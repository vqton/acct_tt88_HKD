// ============================================================================
// Presentation Layer - Widget
// Based on UC_HKD_TT88_2021 - MD-07: Quản lý danh mục tài khoản ngân hàng
// ============================================================================

import 'package:flutter/material.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/tai_khoan_ngan_hang.dart';

class TaiKhoanNganHangFormDialog extends StatefulWidget {
  final TaiKhoanNganHang? initialTaiKhoanNganHang;
  final Function(TaiKhoanNganHang) onSave;

  const TaiKhoanNganHangFormDialog({
    Key? key,
    required this.initialTaiKhoanNganHang,
    required this.onSave,
  }) : super(key: key);

  @override
  State<TaiKhoanNganHangFormDialog> createState() => _TaiKhoanNganHangFormDialogState();
}

class _TaiKhoanNganHangFormDialogState extends State<TaiKhoanNganHangFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _maTaiKhoan;
  late String _tenTaiKhoan;
  String? _tenNganHang;
  String? _chiNhanh;
  String? _soTaiKhoan;
  String? _loaiTaiKhoan; // TIET_KIEM / THANH_TOAN / PHAT_TRIEN
  String? _diaChiNganHang;
  String? _soDienThoaiNganHang;
  String? _emailNganHang;
  String _trangThai = 'HOAT_DONG'; // HOAT_DONG / DONG

  @override
  void initState() {
    super.initState();
    if (widget.initialTaiKhoanNganHang != null) {
      final taiKhoanNganHang = widget.initialTaiKhoanNganHang!;
      _maTaiKhoan = taiKhoanNganHang.maTaiKhoan;
      _tenTaiKhoan = taiKhoanNganHang.tenTaiKhoan;
      _tenNganHang = taiKhoanNganHang.tenNganHang;
      _chiNhanh = taiKhoanNganHang.chiNhanh;
      _soTaiKhoan = taiKhoanNganHang.soTaiKhoan;
      _loaiTaiKhoan = taiKhoanNganHang.loaiTaiKhoan;
      _diaChiNganHang = taiKhoanNganHang.diaChiNganHang;
      _soDienThoaiNganHang = taiKhoanNganHang.soDienThoaiNganHang;
      _emailNganHang = taiKhoanNganHang.emailNganHang;
      _trangThai = taiKhoanNganHang.trangThai;
    } else {
      _maTaiKhoan = '';
      _tenTaiKhoan = '';
      _tenNganHang = null;
      _chiNhanh = null;
      _soTaiKhoan = null;
      _loaiTaiKhoan = null;
      _diaChiNganHang = null;
      _soDienThoaiNganHang = null;
      _emailNganHang = null;
      _trangThai = 'HOAT_DONG';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialTaiKhoanNganHang == null
          ? 'Thêm tài khoản ngân hàng'
          : 'Sửa tài khoản ngân hàng'),
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
                  labelText: 'Tên ngân hàng (tùy chọn)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _tenNganHang,
                onSaved: (value) => _tenNganHang = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Chi nhánh (tùy chọn)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _chiNhanh,
                onSaved: (value) => _chiNhanh = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Số tài khoản (tùy chọn)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _soTaiKhoan,
                onSaved: (value) => _soTaiKhoan = value,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Loại tài khoản',
                  border: OutlineInputBorder(),
                ),
                value: _loaiTaiKhoan,
                items: const [
                  DropdownMenuItem(
                    value: null,
                    child: Text('Chọn loại tài khoản'),
                  ),
                  DropdownMenuItem(
                    value: 'TIET_KIEM',
                    child: Text('Tiết kiệm'),
                  ),
                  DropdownMenuItem(
                    value: 'THANH_TOAN',
                    child: Text('Thanh toán'),
                  ),
                  DropdownMenuItem(
                    value: 'PHAT_TRIEN',
                    child: Text('Phát triển'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _loaiTaiKhoan = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Địa chỉ ngân hàng (tùy chọn)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _diaChiNganHang,
                onSaved: (value) => _diaChiNganHang = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Số điện thoại ngân hàng (tùy chọn)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _soDienThoaiNganHang,
                onSaved: (value) => _soDienThoaiNganHang = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email ngân hàng (tùy chọn)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _emailNganHang,
                onSaved: (value) => _emailNganHang = value,
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
              final taiKhoanNganHang = TaiKhoanNganHang(
                id: widget.initialTaiKhoanNganHang?.id ?? '',
                maTaiKhoan: _maTaiKhoan,
                tenTaiKhoan: _tenTaiKhoan,
                tenNganHang: _tenNganHang,
                chiNhanh: _chiNhanh,
                soTaiKhoan: _soTaiKhoan,
                loaiTaiKhoan: _loaiTaiKhoan,
                diaChiNganHang: _diaChiNganHang,
                soDienThoaiNganHang: _soDienThoaiNganHang,
                emailNganHang: _emailNganHang,
                trangThai: _trangThai,
              );
              widget.onSave(taiKhoanNganHang);
            }
          },
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}