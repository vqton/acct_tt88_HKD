// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - SK-08: Ghi sổ tiền gửi ngân hàng (S7-HKD)
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/features/sk/domain/entities/so_tien_gui_ngan_hang.dart';
import 'package:hkd_accounting/features/sk/presentation/providers/so_tien_gui_ngan_hang_provider.dart';

class SoTienGuiNganHangPage extends ConsumerStatefulWidget {
  const SoTienGuiNganHangPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SoTienGuiNganHangPage> createState() => _SoTienGuiNganHangPageState();
}

class _SoTienGuiNganHangPageState extends ConsumerState<SoTienGuiNganHangPage> {
  final _formKey = GlobalKey<FormState>();
  final _soChungTuController = TextEditingController();
  final _ngayLapController = TextEditingController();
  final _loaiChungTuController = TextEditingController(text: 'GUI_TIEN');
  final _lyDoController = TextEditingController();
  final _soTienController = TextEditingController();
  final _taiKhoanNganHangIdController = TextEditingController();
  final _kyKeToanIdController = TextEditingController();

  @override
  void dispose() {
    _soChungTuController.dispose();
    _ngayLapController.dispose();
    _loaiChungTuController.dispose();
    _lyDoController.dispose();
    _soTienController.dispose();
    _taiKhoanNganHangIdController.dispose();
    _kyKeToanIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final soTienState = ref.watch(soTienGuiNganHangProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sổ tiền gửi ngân hàng (S7-HKD)'),
      ),
      body: soTienState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _soChungTuController,
                      decoration: const InputDecoration(labelText: 'Số chứng từ'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập số chứng từ';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _ngayLapController,
                      decoration: const InputDecoration(labelText: 'Ngày lập (yyyy-mm-dd)'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập ngày lập';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      value: _loaiChungTuController.text,
                      decoration: const InputDecoration(labelText: 'Loại chứng từ'),
                      items: const [
                        DropdownMenuItem(
                          value: 'GUI_TIEN',
                          child: Text('Gửi tiền'),
                        ),
                        DropdownMenuItem(
                          value: 'RUT_TIEN',
                          child: Text('Rút tiền'),
                        ),
                      ],
                      onChanged: (value) {
                        _loaiChungTuController.text = value ?? 'GUI_TIEN';
                      },
                    ),
                    TextFormField(
                      controller: _lyDoController,
                      decoration: const InputDecoration(labelText: 'Lý do'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập lý do';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _soTienController,
                      decoration: const InputDecoration(labelText: 'Số tiền'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập số tiền';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Vui lòng nhập số tiền hợp lệ';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _taiKhoanNganHangIdController,
                      decoration: const InputDecoration(labelText: 'Mã tài khoản ngân hàng'),
                    ),
                    TextFormField(
                      controller: _kyKeToanIdController,
                      decoration: const InputDecoration(labelText: 'Mã kỳ kế toán'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: soTienState.isLoading ? null : _submitForm,
                      child: soTienState.isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Ghi sổ'),
                    ),
                    if (soTienState.isError)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          soTienState.errorMessage ?? 'Đã xảy ra lỗi',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    if (soTienState.isSuccess)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          soTienState.successMessage ?? 'Thành công',
                          style: const TextStyle(color: Colors.green),
                        ),
                      ),
                  ],
                ),
              ),
            ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final soTien = SoTienGuiNganHang(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        soChungTu: _soChungTuController.text,
        ngayLap: DateTime.parse(_ngayLapController.text),
        loaiChungTu: _loaiChungTuController.text,
        lyDo: _lyDoController.text,
        soTien: int.parse(_soTienController.text),
        taiKhoanNganHangId: _taiKhoanNganHangIdController.text,
        kyKeToanId: _kyKeToanIdController.text,
        createdAt: DateTime.now(),
      );

      ref.read(soTienGuiNganHangProvider.notifier).createSoTienGuiNganHang(soTien);
    }
  }
}