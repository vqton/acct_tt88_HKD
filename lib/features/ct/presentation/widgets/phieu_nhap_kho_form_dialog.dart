// ============================================================================
// Presentation Layer - Widget
// Based on UC_HKD_TT88_2021 - CT-03: Lập phiếu nhập kho
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_nhap_kho.dart';
import 'package:hkd_accounting/features/master_data/presentation/providers/hang_hoa_provider.dart';
import 'package:hkd_accounting/features/master_data/domain/entities/hang_hoa.dart';
import 'package:intl/intl.dart';

class PhieuNhapKhoFormDialog extends ConsumerStatefulWidget {
  final PhieuNhapKho? initialPhieuNhapKho;
  final Function(PhieuNhapKho) onSave;

  const PhieuNhapKhoFormDialog({
    Key? key,
    this.initialPhieuNhapKho,
    required this.onSave,
  }) : super(key: key);

  @override
  ConsumerState<PhieuNhapKhoFormDialog> createState() =>
      _PhieuNhapKhoFormDialogState();
}

class _PhieuNhapKhoFormDialogState
    extends ConsumerState<PhieuNhapKhoFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _soPhieu;
  late DateTime _ngayLap;
  late String _kyKeToanId;
  String? _nhaCungCapId;
  String? _soHoaDon;
  String? _diaDiemNhap;
  String? _lyDoNhap;
  String? _nguoiGiaoHang;
  late String _trangThai;
  final List<ChiTietItem> _chiTietList = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialPhieuNhapKho != null) {
      final phieu = widget.initialPhieuNhapKho!;
      _soPhieu = phieu.soPhieu;
      _ngayLap = phieu.ngayLap;
      _kyKeToanId = phieu.kyKeToanId;
      _nhaCungCapId = phieu.nhaCungCapId;
      _soHoaDon = phieu.soHoaDon;
      _diaDiemNhap = phieu.diaDiemNhap;
      _lyDoNhap = phieu.lyDoNhap;
      _nguoiGiaoHang = phieu.nguoiGiaoHang;
      _trangThai = phieu.trangThai;
      for (final ct in phieu.chiTietList) {
        _chiTietList.add(ChiTietItem(
          hangHoaId: ct.hangHoaId,
          soLuongTheoChungTu: ct.soLuongTheoChungTu,
          soLuongThucNhan: ct.soLuongThucNhan,
          donGia: ct.donGia,
        ));
      }
    } else {
      _soPhieu = '';
      _ngayLap = DateTime.now();
      _kyKeToanId = '';
      _nhaCungCapId = null;
      _soHoaDon = '';
      _diaDiemNhap = '';
      _lyDoNhap = '';
      _nguoiGiaoHang = '';
      _trangThai = 'CHO_DUYET';
    }
  }

  int get _tongTien {
    return _chiTietList.fold(0, (sum, item) => sum + item.thanhTien);
  }

  @override
  Widget build(BuildContext context) {
    final hangHoaList = ref.watch(hangHoaProvider);

    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.9,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.initialPhieuNhapKho == null
                    ? 'Thêm phiếu nhập kho'
                    : 'Sửa phiếu nhập kho',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Số phiếu *',
                                border: OutlineInputBorder(),
                              ),
                              initialValue: _soPhieu,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập số phiếu';
                                }
                                return null;
                              },
                              onSaved: (value) => _soPhieu = value!,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ListTile(
                              title: const Text('Ngày lập *'),
                              subtitle: Text(
                                DateFormat('dd/MM/yyyy').format(_ngayLap),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.calendar_today),
                                onPressed: () async {
                                  final date = await showDatePicker(
                                    context: context,
                                    initialDate: _ngayLap,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );
                                  if (date != null && mounted) {
                                    setState(() => _ngayLap = date);
                                  }
                                },
                              ),
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
                                labelText: 'Số hóa đơn',
                                border: OutlineInputBorder(),
                              ),
                              initialValue: _soHoaDon,
                              onSaved: (value) => _soHoaDon = value,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Địa điểm nhập kho',
                                border: OutlineInputBorder(),
                              ),
                              initialValue: _diaDiemNhap,
                              onSaved: (value) => _diaDiemNhap = value,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Người giao hàng',
                          border: OutlineInputBorder(),
                        ),
                        initialValue: _nguoiGiaoHang,
                        onSaved: (value) => _nguoiGiaoHang = value,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Lý do nhập',
                          border: OutlineInputBorder(),
                        ),
                        initialValue: _lyDoNhap,
                        onSaved: (value) => _lyDoNhap = value,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Mã kỳ kế toán *',
                          border: OutlineInputBorder(),
                        ),
                        initialValue: _kyKeToanId,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập mã kỳ kế toán';
                          }
                          return null;
                        },
                        onSaved: (value) => _kyKeToanId = value!,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Chi tiết hàng hóa',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          ElevatedButton.icon(
                            onPressed: () => _addChiTiet(hangHoaList),
                            icon: const Icon(Icons.add),
                            label: const Text('Thêm hàng'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (_chiTietList.isEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text('Chưa có hàng hóa nào'),
                          ),
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _chiTietList.length,
                          itemBuilder: (context, index) {
                            return _buildChiTietItem(
                                context, _chiTietList[index], index);
                          },
                        ),
                      const SizedBox(height: 16),
                      if (_chiTietList.isNotEmpty)
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Tổng tiền: ${NumberFormat('#,###').format(_tongTien)} đ',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
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
    );
  }

  Widget _buildChiTietItem(
      BuildContext context, ChiTietItem item, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.selectedHangHoa?.tenHangHoa ?? 'Chọn hàng hóa',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    item.selectedHangHoa?.maHangHoa ?? '',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'SL CT',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
                controller:
                    TextEditingController(text: item.soLuongTheoChungTu.toString()),
                onChanged: (value) {
                  item.soLuongTheoChungTu = double.tryParse(value) ?? 0;
                  setState(() {});
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'SL thực',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
                controller:
                    TextEditingController(text: item.soLuongThucNhan.toString()),
                onChanged: (value) {
                  item.soLuongThucNhan = double.tryParse(value) ?? 0;
                  setState(() {});
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Đơn giá',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: item.donGia.toString()),
                onChanged: (value) {
                  item.donGia = double.tryParse(value) ?? 0;
                  setState(() {});
                },
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${NumberFormat('#,###').format(item.thanhTien)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                setState(() => _chiTietList.removeAt(index));
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addChiTiet(AsyncValue<List<HangHoa>> hangHoaList) {
    showDialog(
      context: context,
      builder: (context) => _HangHoaSelectDialog(
        hangHoaList: hangHoaList,
        onSelect: (hangHoa) {
          setState(() {
            _chiTietList.add(ChiTietItem(
              hangHoaId: hangHoa.id,
              selectedHangHoa: hangHoa,
              soLuongTheoChungTu: 0,
              soLuongThucNhan: 0,
              donGia: hangHoa.giaVon ?? 0,
            ));
          });
        },
      ),
    );
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final chiTietEntities = _chiTietList
          .asMap()
          .entries
          .map((e) => PhieuNhapKhoChiTiet(
                id: '${widget.initialPhieuNhapKho?.id ?? ''}_${e.key}',
                phieuNhapKhoId: widget.initialPhieuNhapKho?.id ?? '',
                hangHoaId: e.value.hangHoaId,
                soLuongTheoChungTu: e.value.soLuongTheoChungTu,
                soLuongThucNhan: e.value.soLuongThucNhan,
                donGia: e.value.donGia,
                thanhTien: e.value.thanhTien,
              ))
          .toList();

      final phieuNhapKho = PhieuNhapKho(
        id: widget.initialPhieuNhapKho?.id ?? '',
        soPhieu: _soPhieu,
        ngayLap: _ngayLap,
        kyKeToanId: _kyKeToanId,
        nhaCungCapId: _nhaCungCapId,
        soHoaDon: _soHoaDon,
        diaDiemNhap: _diaDiemNhap,
        lyDoNhap: _lyDoNhap,
        nguoiGiaoHang: _nguoiGiaoHang,
        trangThai: _trangThai,
        chiTietList: chiTietEntities,
      );

      widget.onSave(phieuNhapKho);
      Navigator.of(context).pop();
    }
  }
}

class ChiTietItem {
  String hangHoaId;
  HangHoa? selectedHangHoa;
  double soLuongTheoChungTu;
  double soLuongThucNhan;
  double donGia;

  ChiTietItem({
    required this.hangHoaId,
    this.selectedHangHoa,
    this.soLuongTheoChungTu = 0,
    this.soLuongThucNhan = 0,
    this.donGia = 0,
  });

  int get thanhTien => (soLuongThucNhan * donGia).round();
}

class _HangHoaSelectDialog extends StatelessWidget {
  final AsyncValue<List<HangHoa>> hangHoaList;
  final Function(HangHoa) onSelect;

  const _HangHoaSelectDialog({
    required this.hangHoaList,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Chọn hàng hóa'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.6,
        child: hangHoaList.when(
          data: (list) => ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final hangHoa = list[index];
              return ListTile(
                title: Text(hangHoa.tenHangHoa),
                subtitle: Text(
                    '${hangHoa.maHangHoa} - Đơn vị: ${hangHoa.donViTinh ?? "..."}'),
                trailing: Text(
                    '${NumberFormat('#,###').format(hangHoa.giaVon ?? 0)} đ'),
                onTap: () {
                  onSelect(hangHoa);
                  Navigator.of(context).pop();
                },
              );
            },
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Lỗi: $e')),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Hủy'),
        ),
      ],
    );
  }
}
