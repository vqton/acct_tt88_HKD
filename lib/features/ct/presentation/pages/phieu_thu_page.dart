// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - CT-01: Lập phiếu thu
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_thu.dart';
import 'package:hkd_accounting/features/ct/presentation/providers/phieu_thu_provider.dart';
import 'package:hkd_accounting/features/kh/domain/entities/ky_ke_toan.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/khach_hang.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/hkd_info.dart';

class PhieuThuPage extends ConsumerStatefulWidget {
  const PhieuThuPage({Key? key}) : super(key: key);

  @override
  ConsumerState<PhieuThuPage> createState() => _PhieuThuPageState();
}

class _PhieuThuPageState extends ConsumerState<PhieuThuPage> {
  final _formKey = GlobalKey<FormState>();
  final _soPhieuController = TextEditingController();
  final _ngayLapController = TextEditingController();
  final _nguoiNopController = TextEditingController();
  final _diaChiNguoiNopController = TextEditingController();
  final _lyDoNopController = TextEditingController();
  final _soTienController = TextEditingController();
  final _soTienBangChuController = TextEditingController();
  final _chungTuGocKemTheoController = TextEditingController();
  final _hkdInfoIdController = TextEditingController();
  final _khachHangIdController = TextEditingController();
  final _kyKeToanIdController = TextEditingController();
  final _trangThaiController = TextEditingController(text: 'CHO_DUYET');

  @override
  void dispose() {
    _soPhieuController.dispose();
    _ngayLapController.dispose();
    _nguoiNopController.dispose();
    _diaChiNguoiNopController.dispose();
    _lyDoNopController.dispose();
    _soTienController.dispose();
    _soTienBangChuController.dispose();
    _chungTuGocKemTheoController.dispose();
    _hkdInfoIdController.dispose();
    _khachHangIdController.dispose();
    _kyKeToanIdController.dispose();
    _trangThaiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final phieuThuState = ref.watch(phieuThuProvider);
    final phieuThuNotifier = ref.read(phieuThuProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lập phiếu thu'),
      ),
      body: phieuThuState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _soPhieuController,
                      decoration: const InputDecoration(labelText: 'Số phiếu'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập số phiếu';
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
                    TextFormField(
                      controller: _nguoiNopController,
                      decoration: const InputDecoration(labelText: 'Người nộp'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập người nộp';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _diaChiNguoiNopController,
                      decoration: const InputDecoration(labelText: 'Địa chỉ người nộp'),
                    ),
                    TextFormField(
                      controller: _lyDoNopController,
                      decoration: const InputDecoration(labelText: 'Lý do nộp'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập lý do nộp';
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
                      controller: _soTienBangChuController,
                      decoration: const InputDecoration(labelText: 'Số tiền bằng chữ'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập số tiền bằng chữ';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _chungTuGocKemTheoController,
                      decoration: const InputDecoration(labelText: 'Chứng từ gốc kèm theo'),
                    ),
                    TextFormField(
                      controller: _hkdInfoIdController,
                      decoration: const InputDecoration(labelText: 'Mã HKD'),
                    ),
                    TextFormField(
                      controller: _khachHangIdController,
                      decoration: const InputDecoration(labelText: 'Mã khách hàng'),
                    ),
                    TextFormField(
                      controller: _kyKeToanIdController,
                      decoration: const InputDecoration(labelText: 'Mã kỳ kế toán'),
                    ),
                    TextFormField(
                      controller: _trangThaiController,
                      decoration: const InputDecoration(labelText: 'Trạng thái'),
                    ),
const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: phieuThuState.isLoading ? null : _submitForm,
                      child: phieuThuState.isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Tạo phiếu thu'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: phieuThuState.isLoading ? null : _approvePhieuThu,
                      child: const Text('Tạo và duyệt phiếu thu'),
                    ),
                    if (phieuThuState.isError)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          phieuThuState.errorMessage ?? 'Có lỗi xảy ra',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    if (phieuThuState.isSuccess)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          phieuThuState.successMessage ?? 'Thành công',
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
      final phieuThu = PhieuThu(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        soPhieu: _soPhieuController.text,
        ngayLap: DateTime.parse(_ngayLapController.text),
        nguoiNop: _nguoiNopController.text,
        diaChiNguoiNop: _diaChiNguoiNopController.text,
        lyDoNop: _lyDoNopController.text,
        soTien: int.parse(_soTienController.text),
        soTienBangChu: _soTienBangChuController.text,
        chungTuGocKemTheo: _chungTuGocKemTheoController.text,
        hkdInfoId: _hkdInfoIdController.text,
        khachHangId: _khachHangIdController.text,
        kyKeToanId: _kyKeToanIdController.text,
        trangThai: _trangThaiController.text,
        createdAt: DateTime.now(),
      );
      ref.read(phieuThuProvider.notifier).createPhieuThu(phieuThu);
    }
  }

  void _approvePhieuThu() {
    if (_formKey.currentState?.validate() ?? false) {
      final phieuThuId = DateTime.now().millisecondsSinceEpoch.toString();
      final phieuThu = PhieuThu(
        id: phieuThuId,
        soPhieu: _soPhieuController.text,
        ngayLap: DateTime.parse(_ngayLapController.text),
        nguoiNop: _nguoiNopController.text,
        diaChiNguoiNop: _diaChiNguoiNopController.text,
        lyDoNop: _lyDoNopController.text,
        soTien: int.parse(_soTienController.text),
        soTienBangChu: _soTienBangChuController.text,
        chungTuGocKemTheo: _chungTuGocKemTheoController.text,
        hkdInfoId: _hkdInfoIdController.text,
        khachHangId: _khachHangIdController.text,
        kyKeToanId: _kyKeToanIdController.text,
        trangThai: 'CHO_DUYET',
        createdAt: DateTime.now(),
      );
      ref.read(phieuThuProvider.notifier).createPhieuThu(phieuThu);
      ref.read(phieuThuProvider.notifier).approvePhieuThu(phieuThuId);
    }
  }
}