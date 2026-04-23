// ============================================================================
// Presentation Layer - Widget
// Based on UC_HKD_TT88_2021 - MD-08: Cấu hình kỳ kế toán
// ============================================================================

import 'package:flutter/material.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/ky_ke_toan.dart';

class KyKeToanFormDialog extends StatefulWidget {
  final KyKeToan? initialKyKeToan;
  final Function(KyKeToan) onSave;

  const KyKeToanFormDialog({
    Key? key,
    required this.initialKyKeToan,
    required this.onSave,
  }) : super(key: key);

  @override
  State<KyKeToanFormDialog> createState() => _KyKeToanFormDialogState();
}

class _KyKeToanFormDialogState extends State<KyKeToanFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late int _namTaiChinh;
  late DateTime _ngayBatDauKy;
  late DateTime _ngayKetThucKy;
  late String _trangThaiKy;
  DateTime? _ngayKhoaSoThucTe;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _namTaiChinh = now.year;
    _ngayBatDauKy = DateTime(now.year, 1, 1);
    _ngayKetThucKy = DateTime(now.year, 12, 31);
    _trangThaiKy = 'mo';

    if (widget.initialKyKeToan != null) {
      final kyketoan = widget.initialKyKeToan!;
      _namTaiChinh = kyketoan.namTaiChinh;
      _ngayBatDauKy = kyketoan.ngayBatDauKy;
      _ngayKetThucKy = kyketoan.ngayKetThucKy;
      _trangThaiKy = kyketoan.trangThaiKy;
      _ngayKhoaSoThucTe = kyketoan.ngayKhoaSoThucTe;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialKyKeToan == null ? 'Thêm kỳ kế toán' : 'Sửa kỳ kế toán'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: _namTaiChinh.toString(),
                decoration: const InputDecoration(labelText: 'Năm tài chính'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return 'Required';
                  if (int.tryParse(value) == null) return 'Invalid year';
                  return null;
                },
                onSaved: (value) => _namTaiChinh = int.parse(value!),
              ),
              ListTile(
                title: const Text('Ngày bắt đầu kỳ'),
                subtitle: Text('${_ngayBatDauKy.day}/${_ngayBatDauKy.month}/${_ngayBatDauKy.year}'),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _ngayBatDauKy,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (date != null) {
                    setState(() => _ngayBatDauKy = date);
                  }
                },
              ),
              ListTile(
                title: const Text('Ngày kết thúc kỳ'),
                subtitle: Text('${_ngayKetThucKy.day}/${_ngayKetThucKy.month}/${_ngayKetThucKy.year}'),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _ngayKetThucKy,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (date != null) {
                    setState(() => _ngayKetThucKy = date);
                  }
                },
              ),
              DropdownButtonFormField<String>(
                value: _trangThaiKy,
                decoration: const InputDecoration(labelText: 'Trạng thái kỳ'),
                items: const [
                  DropdownMenuItem(value: 'mo', child: Text('Mở')),
                  DropdownMenuItem(value: 'dong', child: Text('Đóng')),
                  DropdownMenuItem(value: 'khoa_so', child: Text('Khóa sổ')),
                ],
                onChanged: (value) => setState(() => _trangThaiKy = value!),
                onSaved: (value) => _trangThaiKy = value!,
              ),
              ListTile(
                title: const Text('Ngày khóa sổ thực tế'),
                subtitle: Text(_ngayKhoaSoThucTe != null
                    ? '${_ngayKhoaSoThucTe!.day}/${_ngayKhoaSoThucTe!.month}/${_ngayKhoaSoThucTe!.year}'
                    : 'Chưa khóa'),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _ngayKhoaSoThucTe ?? DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (date != null) {
                    setState(() => _ngayKhoaSoThucTe = date);
                  }
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
              final kyKeToan = widget.initialKyKeToan != null
                  ? widget.initialKyKeToan!.copyWith(
                      namTaiChinh: _namTaiChinh,
                      ngayBatDauKy: _ngayBatDauKy,
                      ngayKetThucKy: _ngayKetThucKy,
                      trangThaiKy: _trangThaiKy,
                      ngayKhoaSoThucTe: _ngayKhoaSoThucTe,
                    )
                  : KyKeToan(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      namTaiChinh: _namTaiChinh,
                      ngayBatDauKy: _ngayBatDauKy,
                      ngayKetThucKy: _ngayKetThucKy,
                      trangThaiKy: _trangThaiKy,
                      ngayKhoaSoThucTe: _ngayKhoaSoThucTe,
                    );
              widget.onSave(kyKeToan);
            }
          },
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}