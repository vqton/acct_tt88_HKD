/// Implementation của SoQuyTienMatLocalDatasource sử dụng SQLite database.
/// 
/// Class này xử lý việc lưu trữ dữ liệu sổ quỹ tiền mặt (S6-HKD) vào SQLite
/// theo UC_HKD_TT88_2021 - SK-07: Ghi sổ quỹ tiền mặt (S6-HKD).
class SoQuyTienMatLocalDatasourceImpl implements SoQuyTienMatLocalDatasource {
  /// Database instance
  final Database database;

  /// Tên bảng trong database
  static const String tableName = 'so_quy_tien_mat';

  /// Tạo instance với database
  SoQuyTienMatLocalDatasourceImpl(this.database);

  /// Tạo một dòng mới trong sổ quỹ tiền mặt
  /// 
  /// [soQuyTienMatModel] Model của dòng sổ cần tạo
  /// @return ID của dòng đã tạo
  @override
  Future<String> createSoQuyTienMat(SoQuyTienMatModel soQuyTienMatModel) async {
    final id = await database.insert(tableName, soQuyTienMatModel.toMap());
    return id.toString();
  }

  /// Lấy một dòng sổ theo ID
  /// 
  /// [id] ID duy nhất của dòng sổ cần lấy
  /// @return SoQuyTienMatModel nếu tìm thấy (null nếu không tìm thấy)
  @override
  Future<SoQuyTienMatModel?> getSoQuyTienMatById(String id) async {
    final maps = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) {
      return null;
    }
    return SoQuyTienMatModel.fromMap(maps.first);
  }

  /// Lấy tất cả các dòng sổ quỹ tiền mặt
  /// 
  /// @return List của SoQuyTienMatModel
  @override
  Future<List<SoQuyTienMatModel>> getSoQuyTienMatList() async {
    final maps = await database.query(tableName, orderBy: 'ngay_lap DESC');
    return maps.map((map) => SoQuyTienMatModel.fromMap(map)).toList();
  }

  /// Lấy các dòng sổ theo ID quỹ tiền mặt
  /// 
  /// [quyTienMatId] ID của quỹ tiền mặt
  /// @return List của SoQuyTienMatModel thuộc quỹ đó
  @override
  Future<List<SoQuyTienMatModel>> getSoQuyTienMatByQuyTienMatId(String quyTienMatId) async {
    final maps = await database.query(
      tableName,
      where: 'quy_tien_mat_id = ?',
      whereArgs: [quyTienMatId],
      orderBy: 'ngay_lap DESC',
    );
    return maps.map((map) => SoQuyTienMatModel.fromMap(map)).toList();
  }

  /// Lấy các dòng sổ theo ID kỳ kế toán
  /// 
  /// [kyKeToanId] ID của kỳ kế toán
  /// @return List của SoQuyTienMatModel thuộc kỳ đó
  @override
  Future<List<SoQuyTienMatModel>> getSoQuyTienMatByKyKeToanId(String kyKeToanId) async {
    final maps = await database.query(
      tableName,
      where: 'ky_ke_toan_id = ?',
      whereArgs: [kyKeToanId],
      orderBy: 'ngay_lap DESC',
    );
    return maps.map((map) => SoQuyTienMatModel.fromMap(map)).toList();
  }

  /// Cập nhật một dòng sổ đã tồn tại
  /// 
  /// [soQuyTienMatModel] Model của dòng sổ với thông tin đã cập nhật
  /// @return void nếu thành công
  @override
  Future<void> updateSoQuyTienMat(SoQuyTienMatModel soQuyTienMatModel) async {
    await database.update(
      tableName,
      soQuyTienMatModel.toMap(),
      where: 'id = ?',
      whereArgs: [soQuyTienMatModel.id],
    );
  }

  /// Xóa một dòng sổ theo ID
  /// 
  /// [id] ID duy nhất của dòng sổ cần xóa
  /// @return void nếu thành công
  @override
  Future<void> deleteSoQuyTienMat(String id) async {
    await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}