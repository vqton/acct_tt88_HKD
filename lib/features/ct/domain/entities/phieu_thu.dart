/// Represents a receipt voucher (Phiếu thu) in the accounting system.
/// This entity corresponds to UC_HKD_TT88_2021 - CT-01: Lập phiếu thu.
///
/// A receipt voucher is used to record cash inflows into the cash fund,
/// such as payments received from customers, debt collections, or other income.
///
/// The voucher must be approved by the company representative and confirmed
/// by the payer before the cashier can process the transaction.
///
/// Properties follow the official form Mẫu số 01-TT as defined in Thông tư 88/2021/TT-BTC.
class PhieuThu extends Equatable {
  /// Unique identifier for the receipt voucher
  final String id;
  
  /// Voucher number (so phieu), generated sequentially within the accounting period
  final String soPhieu;
  
  /// Date when the voucher was created
  final DateTime ngayLap;
  
  /// Name of the payer (nguoi nop tien)
  final String nguoiNop;
  
  /// Address of the payer
  final String diaChiNguoiNop;
  
  /// Reason for payment (ly do nop)
  final String lyDoNop;
  
  /// Amount in numbers (so tien)
  /// Must be greater than 0
  final int soTien;
  
  /// Amount in words (so tien bang chu)
  final String soTienBangChu;
  
  /// Reference to original supporting documents (chung tu goc kem theo)
  final String chungTuGocKemTheo;
  
  /// Reference to company information (HKD/CNKD)
  final String hkdInfoId;
  
  /// Reference to customer (if applicable)
  final String khachHangId;
  
  /// Reference to accounting period
  final String kyKeToanId;
  
  /// Current status of the voucher (CHO_DUYET, DA_DUYET, etc.)
  final String trangThai;
  
  /// Timestamp when the record was created
  final DateTime? createdAt;
  
  /// Timestamp when the record was last updated
  final DateTime? updatedAt;

  /// Creates a new receipt voucher instance
  ///
  /// All parameters are required except createdAt and updatedAt which are set automatically
  /// [soTien] must be greater than 0
  /// [id], [soPhieu], [nguoiNop], and [lyDoNop] must not be empty
  const PhieuThu({
    required this.id,
    required this.soPhieu,
    required this.ngayLap,
    required this.nguoiNop,
    required this.diaChiNguoiNop,
    required this.lyDoNop,
    required this.soTien,
    required this.soTienBangChu,
    required this.chungTuGocKemTheo,
    required this.hkdInfoId,
    required this.khachHangId,
    required this.kyKeToanId,
    required this.trangThai,
    this.createdAt,
    this.updatedAt,
  }) : assert(soTien > 0, 'So tien phai lon hon 0'),
       assert(id.isNotEmpty, 'Id khong duoc de trong'),
       assert(soPhieu.isNotEmpty, 'So phieu khong duoc de trong'),
       assert(nguoiNop.isNotEmpty, 'Nguoi nop khong duoc de trong'),
       assert(lyDoNop.isNotEmpty, 'Ly do nop khong duoc de trong');

  /// Creates a copy of this receipt voucher with the given fields replaced with new values
  PhieuThu copyWith({
    String? id,
    String? soPhieu,
    DateTime? ngayLap,
    String? nguoiNop,
    String? diaChiNguoiNop,
    String? lyDoNop,
    int? soTien,
    String? soTienBangChu,
    String? chungTuGocKemTheo,
    String? hkdInfoId,
    String? khachHangId,
    String? kyKeToanId,
    String? trangThai,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PhieuThu(
      id: id ?? this.id,
      soPhieu: soPhieu ?? this.soPhieu,
      ngayLap: ngayLap ?? this.ngayLap,
      nguoiNop: nguoiNop ?? this.nguoiNop,
      diaChiNguoiNop: diaChiNguoiNop ?? this.diaChiNguoiNop,
      lyDoNop: lyDoNop ?? this.lyDoNop,
      soTien: soTien ?? this.soTien,
      soTienBangChu: soTienBangChu ?? this.soTienBangChu,
      chungTuGocKemTheo: chungTuGocKemTheo ?? this.chungTuGocKemTheo,
      hkdInfoId: hkdInfoId ?? this.hkdInfoId,
      khachHangId: khachHangId ?? this.khachHangId,
      kyKeToanId: kyKeToanId ?? this.kyKeToanId,
      trangThai: trangThai ?? this.trangThai,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    soPhieu,
    ngayLap,
    nguoiNop,
    diaChiNguoiNop,
    lyDoNop,
    soTien,
    soTienBangChu,
    chungTuGocKemTheo,
    hkdInfoId,
    khachHangId,
    kyKeToanId,
    trangThai,
    createdAt,
    updatedAt,
  ];
}