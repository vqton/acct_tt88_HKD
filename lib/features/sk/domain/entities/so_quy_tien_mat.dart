// ============================================================================
// Domain Layer - Entity
// Based on UC_HKD_TT88_2021 - SK-07: Ghi sổ quỹ tiền mặt (S6-HKD)
// ============================================================================

import 'package:equatable/equatable.dart';

/// Entity đại diện cho một dòng trong Sổ quỹ tiền mặt (S6-HKD).
/// 
/// Entity này tương ứng với UC_HKD_TT88_2021 - SK-07: Ghi sổ quỹ tiền mặt (S6-HKD).
/// 
/// Sổ quỹ tiền mặt theo dõi các nghiệp vụ thu và chi tiền mặt dựa trên phiếu thu và phiếu chi.
/// Mỗi dòng trong sổ ghi nhận một nghiệp vụ với số tiền tương ứng.
/// Loại chứng từ xác định đây là nghiệp vụ thu (PHIEU_THU) hay chi (PHIEU_CHI).
/// 
/// Số dư tồn quỹ được tính tự động sau mỗi nghiệp vụ.
class SoQuyTienMat extends Equatable {
  /// ID duy nhất cho dòng sổ
  final String id;
  
  /// Ngày lập chứng từ
  final DateTime ngayLap;
  
  /// Số chứng từ (số phiếu thu/chi)
  final String soChungTu;
  
  /// Loại chứng từ: PHIEU_THU (thu tiền) hoặc PHIEU_CHI (chi tiền)
  final String loaiChungTu;
  
  /// Lý do nghiệp vụ
  final String lyDo;
  
  /// Số tiền của nghiệp vụ
  /// Phải lớn hơn 0
  final int soTien;
  
  /// ID của quỹ tiền mặt
  final String quyTienMatId;
  
  /// ID của kỳ kế toán
  final String kyKeToanId;
  
  /// Thời điểm tạo bản ghi
  final DateTime? createdAt;
  
  /// Thời điểm cập nhật cuối cùng
  final DateTime? updatedAt;

  /// Tạo một instance mới của SoQuyTienMat
  /// 
  /// [soTien] phải lớn hơn 0
  /// [id], [soChungTu], [loaiChungTu], [lyDo], [quyTienMatId], [kyKeToanId] không được để trống
  /// [loaiChungTu] phải là 'PHIEU_THU' hoặc 'PHIEU_CHI'
  const SoQuyTienMat({
    required this.id,
    required this.ngayLap,
    required this.soChungTu,
    required this.loaiChungTu,
    required this.lyDo,
    required this.soTien,
    required this.quyTienMatId,
    required this.kyKeToanId,
    this.createdAt,
    this.updatedAt,
  }) : assert(soTien > 0, 'So tien phai lon hon 0'),
       assert(id.isNotEmpty, 'Id khong duoc de trong'),
       assert(soChungTu.isNotEmpty, 'So chung tu khong duoc de trong'),
       assert(loaiChungTu == 'PHIEU_THU' || loaiChungTu == 'PHIEU_CHI', 
              'Loai chung tu phai la PHIEU_THU hoac PHIEU_CHI'),
       assert(lyDo.isNotEmpty, 'Ly do khong duoc de trong'),
       assert(quyTienMatId.isNotEmpty, 'Quy tien mat id khong duoc de trong'),
       assert(kyKeToanId.isNotEmpty, 'Ky ke toan id khong duoc de trong');

  /// Kiểm tra đây có phải là nghiệp vụ thu tiền không
  /// @return true nếu loaiChungTu là PHIEU_THU
  bool get isThu => loaiChungTu == 'PHIEU_THU';
  
  /// Kiểm tra đây có phải là nghiệp vụ chi tiền không
  /// @return true nếu loaiChungTu là PHIEU_CHI
  bool get isChi => loaiChungTu == 'PHIEU_CHI';

  /// Tạo bản sao của entity với các trường được thay thế
  SoQuyTienMat copyWith({
    String? id,
    DateTime? ngayLap,
    String? soChungTu,
    String? loaiChungTu,
    String? lyDo,
    int? soTien,
    String? quyTienMatId,
    String? kyKeToanId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SoQuyTienMat(
      id: id ?? this.id,
      ngayLap: ngayLap ?? this.ngayLap,
      soChungTu: soChungTu ?? this.soChungTu,
      loaiChungTu: loaiChungTu ?? this.loaiChungTu,
      lyDo: lyDo ?? this.lyDo,
      soTien: soTien ?? this.soTien,
      quyTienMatId: quyTienMatId ?? this.quyTienMatId,
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
    quyTienMatId,
    kyKeToanId,
    createdAt,
    updatedAt,
  ];
}