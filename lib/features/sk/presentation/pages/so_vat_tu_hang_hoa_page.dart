// ============================================================================
// Presentation Layer - SK-03: Sổ chi tiết vật tư hàng hóa (S2-HKD)
// Based on UC_HKD_TT88_2021 - SK-03
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/sk/presentation/providers/so_vat_tu_hang_hoa_provider.dart';
import 'package:hkd_accounting/features/kh/presentation/widgets/ton_kho_list_item.dart';

class SoVatTuHangHoaPage extends ConsumerWidget {
  const SoVatTuHangHoaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tonKhoList = ref.watch(soVatTuHangHoaProvider);

    return CustomScaffold(
      title: 'Sổ chi tiết vật tư hàng hóa (S2-HKD)',
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Tìm kiếm hàng hóa trong sổ',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (query) {
                // TODO: Implement search
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Row(
              children: [
                Expanded(child: _buildHeaderColumn(context, 'Tồn đầu')),
                Expanded(child: _buildHeaderColumn(context, 'Nhập')),
                Expanded(child: _buildHeaderColumn(context, 'Xuất')),
                Expanded(child: _buildHeaderColumn(context, 'Tồn cuối')),
              ],
            ),
          ),
          Expanded(
            child: tonKhoList.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Text('Lỗi: $error'),
              ),
              data: (list) {
                if (list.isEmpty) {
                  return const Center(
                    child: Text('Chưa có dữ liệu sổ S2-HKD'),
                  );
                }
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final tonKho = list[index];
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            'Mã: ${tonKho.hangHoaId}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Đơn giá xuất: ${tonKho.donGiaXuatKho.toStringAsFixed(0)} đ',
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: _buildDataColumn(context,
                                    '${tonKho.tonDauSoLuong}',
                                    '${tonKho.tonDauThanhTien}')),
                            Expanded(
                                child: _buildDataColumn(context,
                                    '${tonKho.nhapSoLuong}',
                                    '${tonKho.nhapThanhTien}')),
                            Expanded(
                                child: _buildDataColumn(context,
                                    '${tonKho.xuatSoLuong}',
                                    '${tonKho.xuatThanhTien}')),
                            Expanded(
                                child: _buildDataColumn(context,
                                    '${tonKho.tonCuoiSoLuong}',
                                    '${tonKho.tonCuoiThanhTien}')),
                          ],
                        ),
                        const Divider(),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderColumn(BuildContext context, String label) {
    return Text(
      label,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDataColumn(BuildContext context, String soLuong, String thanhTien) {
    return Column(
      children: [
        Text(thanhTien, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(
          soLuong,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}