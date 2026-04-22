import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:hkd_accounting/features/qt/domain/entities/lich_su_chung_tu.dart';
import 'package:hkd_accounting/features/qt/presentation/providers/lich_su_chung_tu_provider.dart';

class TraCuuChungTuPage extends ConsumerStatefulWidget {
  const TraCuuChungTuPage({Key? key}) : super(key: key);

  @override
  ConsumerState<TraCuuChungTuPage> createState() => _TraCuuChungTuPageState();
}

class _TraCuuChungTuPageState extends ConsumerState<TraCuuChungTuPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(lichSuChungTuProvider);
    final notifier = ref.read(lichSuChungTuProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tra cứu chứng từ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => notifier.search(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(notifier),
          _buildFilters(state, notifier),
          Expanded(
            child: _buildResults(state),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(LichSuChungTuNotifier notifier) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Tìm theo số phiếu, diễn giải...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    notifier.setQuery(null);
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
        onChanged: (value) {
          notifier.setQuery(value.isEmpty ? null : value);
        },
      ),
    );
  }

  Widget _buildFilters(LichSuChungTuSearchState state, LichSuChungTuNotifier notifier) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildLoaiChungTuDropdown(state, notifier),
          const SizedBox(width: 8),
          _buildDatePicker('Từ ngày', state.tuNgay, (date) => notifier.setTuNgay(date)),
          const SizedBox(width: 8),
          _buildDatePicker('Đến ngày', state.denNgay, (date) => notifier.setDenNgay(date)),
          const SizedBox(width: 8),
          _buildTrangThaiDropdown(state, notifier),
          const SizedBox(width: 8),
          TextButton.icon(
            icon: const Icon(Icons.clear_all, size: 18),
            label: const Text('Xóa lọc'),
            onPressed: () {
              _searchController.clear();
              notifier.clearFilters();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoaiChungTuDropdown(LichSuChungTuSearchState state, LichSuChungTuNotifier notifier) {
    return DropdownButton<LoaiChungTu?>(
      value: state.loaiChungTu,
      hint: const Text('Loại chứng từ'),
      items: [
        const DropdownMenuItem<LoaiChungTu?>(
          value: null,
          child: Text('Tất cả'),
        ),
        ...LoaiChungTu.values.map((loai) => DropdownMenuItem(
              value: loai,
              child: Text(_getLoaiChungTuLabel(loai)),
            )),
      ],
      onChanged: (value) => notifier.setLoaiChungTu(value),
    );
  }

  Widget _buildDatePicker(String label, DateTime? currentValue, Function(DateTime?) onChanged) {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: currentValue ?? DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
        );
        onChanged(date);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.calendar_today, size: 16),
            const SizedBox(width: 4),
            Text(
              currentValue != null ? DateFormat('dd/MM/yyyy').format(currentValue) : label,
              style: TextStyle(
                color: currentValue != null ? Colors.black : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrangThaiDropdown(LichSuChungTuSearchState state, LichSuChungTuNotifier notifier) {
    return DropdownButton<String?>(
      value: state.trangThai,
      hint: const Text('Trạng thái'),
      items: const [
        DropdownMenuItem<String?>(
          value: null,
          child: Text('Tất cả'),
        ),
        DropdownMenuItem<String?>(
          value: 'CHO_DUYET',
          child: Text('Chờ duyệt'),
        ),
        DropdownMenuItem<String?>(
          value: 'DA_DUYET',
          child: Text('Đã duyệt'),
        ),
        DropdownMenuItem<String?>(
          value: 'HUY_DUYET',
          child: Text('Hủy duyệt'),
        ),
      ],
      onChanged: (value) => notifier.setTrangThai(value),
    );
  }

  Widget _buildResults(LichSuChungTuSearchState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red.shade400),
            const SizedBox(height: 8),
            Text('Lỗi: ${state.errorMessage}'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => ref.read(lichSuChungTuProvider.notifier).search(),
              child: const Text('Thử lại'),
            ),
          ],
        ),
      );
    }

    if (state.results.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 48, color: Colors.grey),
            SizedBox(height: 8),
            Text('Không tìm thấy chứng từ nào'),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: state.results.length,
      itemBuilder: (context, index) {
        final item = state.results[index];
        return _buildChungTuCard(item);
      },
    );
  }

  Widget _buildChungTuCard(LichSuChungTu item) {
    final currencyFormat = NumberFormat('#,###', 'vi_VN');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getLoaiChungTuColor(item.loaiChungTu),
          child: Icon(
            _getLoaiChungTuIcon(item.loaiChungTu),
            color: Colors.white,
            size: 20,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                item.soPhieu.isNotEmpty ? item.soPhieu : '(Chưa có số)',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Chip(
              label: Text(
                _getTrangThaiLabel(item.trangThai),
                style: TextStyle(
                  fontSize: 12,
                  color: _getTrangThaiColor(item.trangThai),
                ),
              ),
              backgroundColor: _getTrangThaiColor(item.trangThai).withOpacity(0.1),
              padding: EdgeInsets.zero,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.loaiChungTuLabel,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 12, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  DateFormat('dd/MM/yyyy').format(item.ngayLap),
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            if (item.dienGiai.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(
                item.dienGiai,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${currencyFormat.format(item.soTien)} ₫',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }

  String _getLoaiChungTuLabel(LoaiChungTu loai) {
    switch (loai) {
      case LoaiChungTu.phieuThu:
        return 'Phiếu thu';
      case LoaiChungTu.phieuChi:
        return 'Phiếu chi';
      case LoaiChungTu.hoaDon:
        return 'Hóa đơn';
      case LoaiChungTu.phieuNhapKho:
        return 'Phiếu nhập kho';
      case LoaiChungTu.phieuXuatKho:
        return 'Phiếu xuất kho';
    }
  }

  IconData _getLoaiChungTuIcon(LoaiChungTu loai) {
    switch (loai) {
      case LoaiChungTu.phieuThu:
        return Icons.receipt_long;
      case LoaiChungTu.phieuChi:
        return Icons.money_off;
      case LoaiChungTu.hoaDon:
        return Icons.description;
      case LoaiChungTu.phieuNhapKho:
        return Icons.move_to_inbox;
      case LoaiChungTu.phieuXuatKho:
        return Icons.outbox;
    }
  }

  Color _getLoaiChungTuColor(LoaiChungTu loai) {
    switch (loai) {
      case LoaiChungTu.phieuThu:
        return Colors.green;
      case LoaiChungTu.phieuChi:
        return Colors.red;
      case LoaiChungTu.hoaDon:
        return Colors.blue;
      case LoaiChungTu.phieuNhapKho:
        return Colors.orange;
      case LoaiChungTu.phieuXuatKho:
        return Colors.purple;
    }
  }

  String _getTrangThaiLabel(String? trangThai) {
    switch (trangThai) {
      case 'CHO_DUYET':
        return 'Chờ duyệt';
      case 'DA_DUYET':
        return 'Đã duyệt';
      case 'HUY_DUYET':
        return 'Hủy duyệt';
      default:
        return trangThai ?? 'Không xác định';
    }
  }

  Color _getTrangThaiColor(String? trangThai) {
    switch (trangThai) {
      case 'CHO_DUYET':
        return Colors.orange;
      case 'DA_DUYET':
        return Colors.green;
      case 'HUY_DUYET':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}