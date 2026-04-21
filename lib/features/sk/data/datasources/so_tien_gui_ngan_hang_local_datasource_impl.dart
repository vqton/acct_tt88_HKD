import 'package:sqflite/sqflite.dart';

/// Implementation của SoTienGuiNganHangLocalDatasource sử dụng SQLite database.
/// 
/// Class này xử lý việc lưu trữ dữ liệu sổ tiền gửi ngân hàng (S7-HKD) vào SQLite
/// theo UC_HKD_TT88_2021 - SK-08: Ghi sổ tiền gửi ngân hàng (S7-HKD).
class SoTienGuiNganHangLocalDatasourceImpl implements SoTienGuiNganHangLocalDatasource {
  /// Database instance
  final Database database;

  /// Tên bảng trong database
  static const String tableName = 'so_tien_gui_ngan_hang';

  /// Tạo instance với database
  SoTienGuiNganHangLocalDatasourceImpl(this.database);

  /// Tạo một dòng mới trong sổ tiền gửi ngân hàng
  @override
  Future<String> createSoTienGuiNganHang(SoTienGuiNganHangModel soTienGuiNganHangModel) async {
    final id = await database.insert(tableName, soTienGuiNganHangModel.toMap());
    return id.toString();
  }

  /// Lấy một dòng sổ theo ID
  @override
  Future<SoTienGuiNganHangModel?> getSoTienGuiNganHangById(String id) async {
    final maps = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) {
      return null;
    }
    return SoTienGuiNganHangModel.fromMap(maps.first);
  }

  /// Lấy tất cả các dòng sổ tiền gửi ngân hàng
  @override
  Future<List<SoTienGuiNganHangModel>> getSoTienGuiNganHangList() async {
    final maps = await database.query(tableName, orderBy: 'ngay_lap DESC');
    return maps.map((map) => SoTienGuiNganHangModel.fromMap(map)).toList();
  }

  /// Lấy các dòng sổ theo ID tài khoản ngân hàng
  @override
  Future<List<SoTienGuiNganHangModel>> getSoTienGuiNganHangByTaiKhoanNganHangId(String taiKhoanNganHangId) async {
    final maps = await database.query(
      tableName,
      where: 'tai_khoan_ngan_hang_id = ?',
      whereArgs: [taiKhoanNganHangId],
      orderBy: 'ngay_lap DESC',
    );
    return maps.map((map) => SoTienGuiNganHangModel.fromMap(map)).toList();
  }

  /// Lấy các dòng sổ theo ID kỳ kế toán
  @override
  Future<List<SoTienGuiNganHangModel>> getSoTienGuiNganHangByKyKeToanId(String kyKeToanId) async {
    final maps = await database.query(
      tableName,
      where: 'ky_ke_toan_id = ?',
      whereArgs: [kyKeToanId],
      orderBy: 'ngay_lap DESC',
    );
    return maps.map((map) => SoTienGuiNganHangModel.fromMap(map)).toList();
  }

  /// Cập nhật một dòng sổ đã tồn tại
  @override
  Future<void> updateSoTienGuiNganHang(SoTienGuiNganHangModel soTienGuiNganHangModel) async {
    await database.update(
      tableName,
      soTienGuiNganHangModel.toMap(),
      where: 'id = ?',
      whereArgs: [soTienGuiNganHangModel.id],
    );
  }

  /// Xóa một dòng sổ theo ID
  @override
  Future<void> deleteSoTienGuiNganHang(String id) async {
    await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}