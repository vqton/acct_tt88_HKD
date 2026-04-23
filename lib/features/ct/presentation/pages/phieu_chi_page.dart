// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - CT-02: Lập phiếu chi
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_chi.dart';
import 'package:hkd_accounting/features/ct/presentation/providers/phieu_chi_provider.dart';

class PhieuChiPage extends ConsumerStatefulWidget {
  const PhieuChiPage({Key? key}) : super(key: key);

  @override
  ConsumerState<PhieuChiPage> createState() => _PhieuChiPageState();
}

class _PhieuChiPageState extends ConsumerState<PhieuChiPage> {
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
  final _nhaCungCapIdController = TextEditingController();
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
    _nhaCungCapIdController.dispose();
    _kyKeToanIdController.dispose();
    _trangThaiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final phieuChiState = ref.watch(phieuChiProvider);

    return CustomScaffold(
      title: 'Lập phiếu chi',
      body: phieuChiState.isLoading
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
                      decoration: const InputDecoration(labelText: 'Người nhận tiền'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập người nhận tiền';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _diaChiNguoiNopController,
                      decoration: const InputDecoration(labelText: 'Địa chỉ người nhận'),
                    ),
                    TextFormField(
                      controller: _lyDoNopController,
                      decoration: const InputDecoration(labelText: 'Lý do chi'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập lý do chi';
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
                          return 'Số tiền phải là số';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _soTienBangChuController,
                      decoration: const InputDecoration(labelText: 'Số tiền bằng chữ'),
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
                      controller: _nhaCungCapIdController,
                      decoration: const InputDecoration(labelText: 'Mã nhà cung cấp (nếu có)'),
                    ),
                    TextFormField(
                      controller: _kyKeToanIdController,
                      decoration: const InputDecoration(labelText: 'Mã kỳ kế toán'),
                    ),
                    TextFormField(
                      controller: _trangThaiController,
                      decoration: const InputDecoration(labelText: 'Trạng thái'),
                      enabled: false,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: phieuChiState.isLoading ? null : _submitForm,
                      child: phieuChiState.isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Tạo phiếu chi'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: phieuChiState.isLoading ? null : _submitAndApprove,
                      child: const Text('Tạo và duyệt phiếu chi'),
                    ),
                    if (phieuChiState.isError)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          phieuChiState.errorMessage ?? 'Có lỗi xảy ra',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    if (phieuChiState.isSuccess)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          phieuChiState.successMessage ?? 'Thành công',
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
      final phieuChi = PhieuChi(
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
        nhaCungCapId: _nhaCungCapIdController.text.isNotEmpty ? _nhaCungCapIdController.text : null,
        kyKeToanId: _kyKeToanIdController.text,
        trangThai: _trangThaiController.text,
        createdAt: DateTime.now(),
      );
      ref.read(phieuChiProvider.notifier).createPhieuChi(phieuChi);
    }
  }

  void _submitAndApprove() {
    if (_formKey.currentState?.validate() ?? false) {
      final phieuChiId = DateTime.now().millisecondsSinceEpoch.toString();
      final phieuChi = PhieuChi(
        id: phieuChiId,
        soPhieu: _soPhieuController.text,
        ngayLap: DateTime.parse(_ngayLapController.text),
        nguoiNop: _nguoiNopController.text,
        diaChiNguoiNop: _diaChiNguoiNopController.text,
        lyDoNop: _lyDoNopController.text,
        soTien: int.parse(_soTienController.text),
        soTienBangChu: _soTienBangChuController.text,
        chungTuGocKemTheo: _chungTuGocKemTheoController.text,
        hkdInfoId: _hkdInfoIdController.text,
        nhaCungCapId: _nhaCungCapIdController.text.isNotEmpty ? _nhaCungCapIdController.text : null,
        kyKeToanId: _kyKeToanIdController.text,
        trangThai: 'CHO_DUYET',
        createdAt: DateTime.now(),
      );
      ref.read(phieuChiProvider.notifier).createPhieuChi(phieuChi);
      ref.read(phieuChiProvider.notifier).approvePhieuChi(phieuChiId);
    }
  }
}