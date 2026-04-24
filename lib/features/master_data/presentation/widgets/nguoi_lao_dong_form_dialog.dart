// ============================================================================
// Presentation Layer - Widget
// Based on UC_HKD_TT88_2021 - MD-06: Quản lý danh mục người lao động
// ============================================================================

import 'package:flutter/material.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/nguoi_lao_dong.dart';

class NguoiLaoDongFormDialog extends StatefulWidget {
  final NguoiLaoDong? initialNguoiLaoDong;
  final Function(NguoiLaoDong) onSave;

  const NguoiLaoDongFormDialog({
    Key? key,
    required this.initialNguoiLaoDong,
    required this.onSave,
  }) : super(key: key);

  @override
  State<NguoiLaoDongFormDialog> createState() => _NguoiLaoDongFormDialogState();
}

class _NguoiLaoDongFormDialogState extends State<NguoiLaoDongFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _maNguoiLaoDong;
  late String _hoTen;
  DateTime? _ngaySinh;
  String? _gioiTinh; // NAM / NU / KHAC
  String? _soCccd;
  String? _soBhxh;
  String? _chucVu;
  String? _boPhan;
  String? _diaChi;
  String? _soDienThoai;
  String? _email;
  DateTime? _ngayVaoLam;
  DateTime? _ngayNgungHopDong;
  double? _heSoLuong;
  double? _luongCoBan;
  String _trangThai = 'DANG_LAM_VIEC'; // DANG_LAM_VIEC / NGHI_VIEC / NGHI_PHEP

  @override
  void initState() {
    super.initState();
    if (widget.initialNguoiLaoDong != null) {
      final nguoiLaoDong = widget.initialNguoiLaoDong!;
      _maNguoiLaoDong = nguoiLaoDong.maNguoiLaoDong;
      _hoTen = nguoiLaoDong.hoTen;
      _ngaySinh = nguoiLaoDong.ngaySinh;
      _gioiTinh = nguoiLaoDong.gioiTinh;
      _soCccd = nguoiLaoDong.soCccd;
      _soBhxh = nguoiLaoDong.soBhxh;
      _chucVu = nguoiLaoDong.chucVu;
      _boPhan = nguoiLaoDong.boPhan;
      _diaChi = nguoiLaoDong.diaChi;
      _soDienThoai = nguoiLaoDong.soDienThoai;
      _email = nguoiLaoDong.email;
      _ngayVaoLam = nguoiLaoDong.ngayVaoLam;
      _ngayNgungHopDong = nguoiLaoDong.ngayNgungHopDong;
      _heSoLuong = nguoiLaoDong.heSoLuong;
      _luongCoBan = nguoiLaoDong.luongCoBan;
      _trangThai = nguoiLaoDong.trangThai;
    } else {
      _maNguoiLaoDong = '';
      _hoTen = '';
      _ngaySinh = null;
      _gioiTinh = null;
      _soCccd = null;
      _soBhxh = null;
      _chucVu = null;
      _boPhan = null;
      _diaChi = null;
      _soDienThoai = null;
      _email = null;
      _ngayVaoLam = null;
      _ngayNgungHopDong = null;
      _heSoLuong = null;
      _luongCoBan = null;
      _trangThai = 'DANG_LAM_VIEC';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialNguoiLaoDong == null
          ? 'Thêm người lao động'
          : 'Sửa người lao động'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Mã người lao động',
                  border: OutlineInputBorder(),
                ),
                initialValue: _maNguoiLaoDong,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mã người lao động';
                  }
                  return null;
                },
                onSaved: (value) => _maNguoiLaoDong = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Họ tên',
                  border: OutlineInputBorder(),
                ),
                initialValue: _hoTen,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập họ tên';
                  }
                  return null;
                },
                onSaved: (value) => _hoTen = value!,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Ngày sinh (tùy chọn)'),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _ngaySinh ?? DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (date != null && mounted) {
                      setState(() {
                        _ngaySinh = date;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 8),
              if (_ngaySinh != null)
                Text(
                  'Ngày sinh: ${_ngaySinh!.day}/${_ngaySinh!.month}/${_ngaySinh!.year}',
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Giới tính',
                  border: OutlineInputBorder(),
                ),
                value: _gioiTinh,
                items: const [
                  DropdownMenuItem(
                    value: null,
                    child: Text('Chọn giới tính'),
                  ),
                  DropdownMenuItem(
                    value: 'NAM',
                    child: Text('Nam'),
                  ),
                  DropdownMenuItem(
                    value: 'NU',
                    child: Text('Nữ'),
                  ),
                  DropdownMenuItem(
                    value: 'KHAC',
                    child: Text('Khác'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _gioiTinh = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Số CCCD (tùy chọn)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _soCccd,
                onSaved: (value) => _soCccd = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Số BHXH (tùy chọn)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _soBhxh,
                onSaved: (value) => _soBhxh = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Chức vụ (tùy chọn)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _chucVu,
                onSaved: (value) => _chucVu = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Bộ phận (tùy chọn)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _boPhan,
                onSaved: (value) => _boPhan = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Địa chỉ (tùy chọn)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _diaChi,
                onSaved: (value) => _diaChi = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Số điện thoại (tùy chọn)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _soDienThoai,
                onSaved: (value) => _soDienThoai = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email (tùy chọn)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _email,
                onSaved: (value) => _email = value,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Ngày vào làm (tùy chọn)'),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _ngayVaoLam ?? DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (date != null && mounted) {
                      setState(() {
                        _ngayVaoLam = date;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 8),
              if (_ngayVaoLam != null)
                Text(
                  'Ngày vào làm: ${_ngayVaoLam!.day}/${_ngayVaoLam!.month}/${_ngayVaoLam!.year}',
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Ngày ngừng hợp đồng (tùy chọn)'),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _ngayNgungHopDong ?? DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (date != null && mounted) {
                      setState(() {
                        _ngayNgungHopDong = date;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 8),
              if (_ngayNgungHopDong != null)
                Text(
                  'Ngày ngừng hợp đồng: ${_ngayNgungHopDong!.day}/${_ngayNgungHopDong!.month}/${_ngayNgungHopDong!.year}',
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Hệ số lương (tùy chọn)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _heSoLuong != null ? _heSoLuong.toString() : '',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSaved: (value) {
                  _heSoLuong = value != null && value.isNotEmpty
                      ? double.tryParse(value)
                      : null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Lương cơ bản (tùy chọn)',
                  border: OutlineInputBorder(),
                ),
                initialValue: _luongCoBan != null ? _luongCoBan.toString() : '',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSaved: (value) {
                  _luongCoBan = value != null && value.isNotEmpty
                      ? double.tryParse(value)
                      : null;
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
                    value: 'DANG_LAM_VIEC',
                    child: Text('Đang làm việc'),
                  ),
                  DropdownMenuItem(
                    value: 'NGHI_VIEC',
                    child: Text('Nghỉ việc'),
                  ),
                  DropdownMenuItem(
                    value: 'NGHI_PHEP',
                    child: Text('Nghỉ phép'),
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
              final nguoiLaoDong = NguoiLaoDong(
                id: widget.initialNguoiLaoDong?.id ?? '',
                maNguoiLaoDong: _maNguoiLaoDong,
                hoTen: _hoTen,
                ngaySinh: _ngaySinh,
                gioiTinh: _gioiTinh,
                soCccd: _soCccd,
                soBhxh: _soBhxh,
                chucVu: _chucVu,
                boPhan: _boPhan,
                diaChi: _diaChi,
                soDienThoai: _soDienThoai,
                email: _email,
                ngayVaoLam: _ngayVaoLam,
                ngayNgungHopDong: _ngayNgungHopDong,
                heSoLuong: _heSoLuong,
                luongCoBan: _luongCoBan,
                trangThai: _trangThai,
              );
              widget.onSave(nguoiLaoDong);
            }
          },
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}