// ============================================================================
// Presentation Layer - Page
// Based on UC_HKD_TT88_2021 - SK-07: Ghi sổ quỹ tiền mặt (S6-HKD)
// ============================================================================

/// Page hiển thị Sổ quỹ tiền mặt (S6-HKD).
/// 
/// Page này hiển thị danh sách các nghiệp vụ thu/chi tiền mặt
/// theo UC_HKD_TT88_2021 - SK-07: Ghi sổ quỹ tiền mặt (S6-HKD).
class SoQuyTienMatPage extends ConsumerStatefulWidget {
  const SoQuyTienMatPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SoQuyTienMatPage> createState() => _SoQuyTienMatPageState();
}

class _SoQuyTienMatPageState extends ConsumerState<SoQuyTienMatPage> {
  final _formKey = GlobalKey<FormState>();
  final _soChungTuController = TextEditingController();
  final _ngayLapController = TextEditingController();
  final _loaiChungTuController = TextEditingController(text: 'PHIEU_THU');
  final _lyDoController = TextEditingController();
  final _soTienController = TextEditingController();
  final _quyTienMatIdController = TextEditingController();
  final _kyKeToanIdController = TextEditingController();

  @override
  void dispose() {
    _soChungTuController.dispose();
    _ngayLapController.dispose();
    _loaiChungTuController.dispose();
    _lyDoController.dispose();
    _soTienController.dispose();
    _quyTienMatIdController.dispose();
    _kyKeToanIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final soQuyState = ref.watch(soQuyTienMatProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sổ quỹ tiền mặt (S6-HKD)'),
      ),
      body: soQuyState.isLoading
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
                          value: 'PHIEU_THU',
                          child: Text('Phiếu thu'),
                        ),
                        DropdownMenuItem(
                          value: 'PHIEU_CHI',
                          child: Text('Phiếu chi'),
                        ),
                      ],
                      onChanged: (value) {
                        _loaiChungTuController.text = value ?? 'PHIEU_THU';
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
                      controller: _quyTienMatIdController,
                      decoration: const InputDecoration(labelText: 'Mã quỹ tiền mặt'),
                    ),
                    TextFormField(
                      controller: _kyKeToanIdController,
                      decoration: const InputDecoration(labelText: 'Mã kỳ kế toán'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: soQuyState.isLoading ? null : _submitForm,
                      child: soQuyState.isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Ghi sổ'),
                    ),
                    if (soQuyState.isError)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          soQuyState.errorMessage ?? 'Đã xảy ra lỗi',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    if (soQuyState.isSuccess)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          soQuyState.successMessage ?? 'Thành công',
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
      final soQuy = SoQuyTienMat(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        soChungTu: _soChungTuController.text,
        ngayLap: DateTime.parse(_ngayLapController.text),
        loaiChungTu: _loaiChungTuController.text,
        lyDo: _lyDoController.text,
        soTien: int.parse(_soTienController.text),
        quyTienMatId: _quyTienMatIdController.text,
        kyKeToanId: _kyKeToanIdController.text,
        createdAt: DateTime.now(),
      );

      ref.read(soQuyTienMatProvider.notifier).createSoQuyTienMat(soQuy);
    }
  }
}