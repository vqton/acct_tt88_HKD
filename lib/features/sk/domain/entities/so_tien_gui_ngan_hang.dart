/// Entity đại diện cho một dòng trong Sổ tiền gửi ngân hàng (S7-HKD).
/// 
/// Entity này tương ứng với UC_HKD_TT88_2021 - SK-08: Ghi sổ tiền gửi ngân hàng (S7-HKD).
/// 
/// Sổ tiền gửi ngân hàng theo dõi các nghiệp vụ gửi và rút tiền từ tài khoản ngân hàng.
/// Mỗi dòng trong sổ ghi nhận một nghiệp vụ với số tiền tương ứng.
/// Loại chứng từ xác định đây là nghiệp vụ gửi tiền (GUI_TIEN) hay rút tiền (RUT_TIEN).
/// 
/// Số dư tài khoản được tính tự động sau mỗi nghiệp vụ.
class SoTienGuiNganHang extends Equatable {
  /// ID duy nhất cho dòng sổ
  final String id;
  
  /// Ngày lập chứng từ
  final DateTime ngayLap;
  
  /// Số chứng từ (số giấy báo có/nợ)
  final String soChungTu;
  
  /// Loại chứng từ: GUI_TIEN (gửi tiền) hoặc RUT_TIEN (rút tiền)
  final String loaiChungTu;
  
  /// Lý do nghiệp vụ
  final String lyDo;
  
  /// Số tiền của nghiệp vụ
  /// Phải lớn hơn 0
  final int soTien;
  
  /// ID của tài khoản ngân hàng
  final String taiKhoanNganHangId;
  
  /// ID của kỳ kế toán
  final String kyKeToanId;
  
  /// Thời điểm tạo bản ghi
  final DateTime? createdAt;
  
  /// Thời điểm cập nhật cuối cùng
  final DateTime? updatedAt;

  /// Tạo một instance mới của SoTienGuiNganHang
  /// 
  /// [soTien] phải lớn hơn 0
  /// [id], [soChungTu], [loaiChungTu], [lyDo], [taiKhoanNganHangId], [kyKeToanId] không được để trống
  /// [loaiChungTu] phải là 'GUI_TIEN' hoặc 'RUT_TIEN'
  const SoTienGuiNganHang({
    required this.id,
    required this.ngayLap,
    required this.soChungTu,
    required this.loaiChungTu,
    required this.lyDo,
    required this.soTien,
    required this.taiKhoanNganHangId,
    required this.kyKeToanId,
    this.createdAt,
    this.updatedAt,
  }) : assert(soTien > 0, 'So tien phai lon hon 0'),
       assert(id.isNotEmpty, 'Id khong duoc de trong'),
       assert(soChungTu.isNotEmpty, 'So chung tu khong duoc de trong'),
       assert(loaiChungTu == 'GUI_TIEN' || loaiChungTu == 'RUT_TIEN', 
              'Loai chung tu phai la GUI_TIEN hoac RUT_TIEN'),
       assert(lyDo.isNotEmpty, 'Ly do khong duoc de trong'),
       assert(taiKhoanNganHangId.isNotEmpty, 'Tai khoan ngan hang id khong duoc de trong'),
       assert(kyKeToanId.isNotEmpty, 'Ky ke toan id khong duoc de trong');

  /// Kiểm tra đây có phải là nghiệp vụ gửi tiền không
  /// @return true nếu loaiChungTu là GUI_TIEN
  bool get isGui => loaiChungTu == 'GUI_TIEN';
  
  /// Kiểm tra đây có phải là nghiệp vụ rút tiền không
  /// @return true nếu loaiChungTu là RUT_TIEN
  bool get isRut => loaiChungTu == 'RUT_TIEN';

  /// Tạo bản sao của entity với các trường được thay thế
  SoTienGuiNganHang copyWith({
    String? id,
    DateTime? ngayLap,
    String? soChungTu,
    String? loaiChungTu,
    String? lyDo,
    int? soTien,
    String? taiKhoanNganHangId,
    String? kyKeToanId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SoTienGuiNganHang(
      id: id ?? this.id,
      ngayLap: ngayLap ?? this.ngayLap,
      soChungTu: soChungTu ?? this.soChungTu,
      loaiChungTu: loaiChungTu ?? this.loaiChungTu,
      lyDo: lyDo ?? this.lyDo,
      soTien: soTien ?? this.soTien,
      taiKhoanNganHangId: taiKhoanNganHangId ?? this.taiKhoanNganHangId,
      kyKeToanId: kyKeToanId ?? this.kyKeToanId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    ngayLap,
    soChungTu,
    loaiChungTu,
    lyDo,
    soTien,
    taiKhoanNganHangId,
    kyKeToanId,
    createdAt,
    updatedAt,
  ];
}