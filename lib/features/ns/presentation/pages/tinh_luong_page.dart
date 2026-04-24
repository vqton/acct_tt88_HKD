// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - NS-01: Tính lương người lao động
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/ns/domain/services/tinh_luong_service.dart';
import 'package:hkd_accounting/features/ns/presentation/providers/tinh_luong_provider.dart';

class TinhLuongPage extends ConsumerStatefulWidget {
  const TinhLuongPage({Key? key}) : super(key: key);

  @override
  ConsumerState<TinhLuongPage> createState() => _TinhLuongPageState();
}

class _TinhLuongPageState extends ConsumerState<TinhLuongPage> {
  final _thangNamController = TextEditingController(text: DateTime.now().toString().substring(0, 7));
  final List<_NhanVienInput> _nhanVienList = [];

  @override
  void dispose() {
    _thangNamController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tinhLuongListProvider);

    return CustomScaffold(
      title: 'Tính lương (NS-01)',
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _thangNamController,
                  decoration: const InputDecoration(
                    labelText: 'Tháng/Năm',
                    hintText: 'yyyy-MM',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _addNhanVien,
                        icon: const Icon(Icons.person_add),
                        label: const Text('Thêm NLĐ'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _calculateAll,
                        icon: const Icon(Icons.calculate),
                        label: const Text('Tính lương'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_nhanVienList.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.people, size: 64, color: Colors.grey.shade400),
                    const SizedBox(height: 16),
                    Text('Chưa có nhân viên nào', style: TextStyle(color: Colors.grey.shade600)),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _nhanVienList.length,
                itemBuilder: (context, index) {
                  final nv = _nhanVienList[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(nv.hoTen, style: const TextStyle(fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => setState(() => _nhanVienList.removeAt(index)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: _buildSmallField('Số công', nv.soCongController)),
                              const SizedBox(width: 8),
                              Expanded(child: _buildSmallField('Số SP', nv.soSpController)),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: _buildSmallField('Đ.Giá SP', nv.donGiaSpController)),
                              const SizedBox(width: 8),
                              Expanded(child: _buildSmallField('Đ.Giá TG', nv.donGiaTgController)),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: _buildSmallField('Hệ số', nv.heSoController)),
                              const SizedBox(width: 8),
                              Expanded(child: _buildSmallField('PC Quỹ', nv.pcQuyController)),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: _buildSmallField('PC Ngoài', nv.pcNgoaiController)),
                              const SizedBox(width: 8),
                              Expanded(child: _buildSmallField('Thưởng', nv.thuongController)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          if (state.hasValue && state.value!.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey.shade100,
              child: Column(
                children: [
                  Text(
                    'Kết quả tính lương tháng ${_thangNamController.text}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSummaryItem('Số NLĐ', state.value!.length.toString()),
                      _buildSummaryItem('Tổng Lương SP', _formatCurrency(state.value!.fold(0, (sum, e) => sum + e.luongSanPham))),
                      _buildSummaryItem('Tổng Lương TG', _formatCurrency(state.value!.fold(0, (sum, e) => sum + e.luongThoiGian))),
                      _buildSummaryItem('Tổng Thu Nhập', _formatCurrency(state.valueOrNull?.fold<double>(0, (sum, e) => sum + e.tongThuNhap) ?? 0), highlight: true),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSmallField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label, isDense: true),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildSummaryItem(String label, String value, {bool highlight = false}) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
            color: highlight ? Colors.green : null,
          ),
        ),
      ],
    );
  }

  String _formatCurrency(double value) {
    return '${value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}đ';
  }

  void _addNhanVien() {
    showDialog(
      context: context,
      builder: (ctx) {
        final hoTenController = TextEditingController();
        final maNldController = TextEditingController();
        return AlertDialog(
          title: const Text('Thêm người lao động'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: maNldController, decoration: const InputDecoration(labelText: 'Mã NLĐ')),
              const SizedBox(height: 8),
              TextField(controller: hoTenController, decoration: const InputDecoration(labelText: 'Họ tên')),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Hủy')),
            ElevatedButton(
              onPressed: () {
                if (hoTenController.text.isNotEmpty) {
                  setState(() {
                    _nhanVienList.add(_NhanVienInput(
                      nguoiLaoDongId: maNldController.text.isEmpty ? DateTime.now().millisecondsSinceEpoch.toString() : maNldController.text,
                      hoTen: hoTenController.text,
                    ));
                  });
                }
                Navigator.pop(ctx);
              },
              child: const Text('Thêm'),
            ),
          ],
        );
      },
    );
  }

  void _calculateAll() {
    if (_nhanVienList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng thêm ít nhất 1 nhân viên')),
      );
      return;
    }

    final inputs = _nhanVienList.map((nv) => TinhLuongInput(
      nguoiLaoDongId: nv.nguoiLaoDongId,
      soCong: double.tryParse(nv.soCongController.text) ?? 0,
      soSanPham: double.tryParse(nv.soSpController.text) ?? 0,
      donGiaLuongSp: double.tryParse(nv.donGiaSpController.text) ?? 0,
      donGiaLuongTg: double.tryParse(nv.donGiaTgController.text) ?? 0,
      heSoLuong: double.tryParse(nv.heSoController.text) ?? 1.0,
      phuCapQuyLuong: double.tryParse(nv.pcQuyController.text) ?? 0,
      phuCapNgoaiQuy: double.tryParse(nv.pcNgoaiController.text) ?? 0,
      tienThuong: double.tryParse(nv.thuongController.text) ?? 0,
    )).toList();

    ref.read(tinhLuongListProvider.notifier).calculateForList(inputs: inputs, thangNam: _thangNamController.text);
  }
}

class _NhanVienInput {
  final String nguoiLaoDongId;
  final String hoTen;
  final TextEditingController soCongController = TextEditingController();
  final TextEditingController soSpController = TextEditingController();
  final TextEditingController donGiaSpController = TextEditingController();
  final TextEditingController donGiaTgController = TextEditingController();
  final TextEditingController heSoController = TextEditingController(text: '1.0');
  final TextEditingController pcQuyController = TextEditingController();
  final TextEditingController pcNgoaiController = TextEditingController();
  final TextEditingController thuongController = TextEditingController();

  _NhanVienInput({required this.nguoiLaoDongId, required this.hoTen});
}