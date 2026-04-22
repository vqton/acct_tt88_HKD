// ============================================================================
// Domain Layer - Entities
// Based on UC_HKD_TT88_2021 - QT-01: Quản lý tài khoản người dùng & phân quyền
// ============================================================================

import 'package:equatable/equatable.dart';

class VaiTroEntity extends Equatable {
  final String id;
  final String tenVaiTro;
  final String moTa;
  final bool coTheLapChungTu;
  final bool coThePheDuyetChungTu;
  final bool coTheThuChiTienMat;
  final bool coTheNhapXuatKho;
  final bool coTheGhiSoKeToan;
  final bool coTheTinhThue;
  final bool coTheCauHinhHeThong;
  final bool coThePhanQuyen;
  final DateTime? createdAt;

  const VaiTroEntity({
    required this.id,
    required this.tenVaiTro,
    required this.moTa,
    this.coTheLapChungTu = false,
    this.coThePheDuyetChungTu = false,
    this.coTheThuChiTienMat = false,
    this.coTheNhapXuatKho = false,
    this.coTheGhiSoKeToan = false,
    this.coTheTinhThue = false,
    this.coTheCauHinhHeThong = false,
    this.coThePhanQuyen = false,
    this.createdAt,
  });

  static List<VaiTroEntity> get defaultRoles => [
        const VaiTroEntity(
          id: 'ADMIN',
          tenVaiTro: 'Quản trị viên',
          moTa: 'Quản lý hệ thống và phân quyền',
          coTheCauHinhHeThong: true,
          coThePhanQuyen: true,
        ),
        const VaiTroEntity(
          id: 'KE_TOAN_VIEN',
          tenVaiTro: 'Kế toán viên',
          moTa: 'Lập chứng từ, ghi sổ, tính thuế',
          coTheLapChungTu: true,
          coTheGhiSoKeToan: true,
          coTheTinhThue: true,
        ),
        const VaiTroEntity(
          id: 'THU_QUY',
          tenVaiTro: 'Thủ quỹ',
          moTa: 'Quản lý quỹ tiền mặt',
          coTheThuChiTienMat: true,
        ),
        const VaiTroEntity(
          id: 'THU_KHO',
          tenVaiTro: 'Thủ kho',
          moTa: 'Quản lý kho hàng hóa',
          coTheNhapXuatKho: true,
        ),
        const VaiTroEntity(
          id: 'NGUOI_DAI_DIEN',
          tenVaiTro: 'Người đại diện',
          moTa: 'Đại diện HKD phê duyệt chứng từ',
          coThePheDuyetChungTu: true,
        ),
      ];

  VaiTroEntity copyWith({
    String? id,
    String? tenVaiTro,
    String? moTa,
    bool? coTheLapChungTu,
    bool? coThePheDuyetChungTu,
    bool? coTheThuChiTienMat,
    bool? coTheNhapXuatKho,
    bool? coTheGhiSoKeToan,
    bool? coTheTinhThue,
    bool? coTheCauHinhHeThong,
    bool? coThePhanQuyen,
    DateTime? createdAt,
  }) {
    return VaiTroEntity(
      id: id ?? this.id,
      tenVaiTro: tenVaiTro ?? this.tenVaiTro,
      moTa: moTa ?? this.moTa,
      coTheLapChungTu: coTheLapChungTu ?? this.coTheLapChungTu,
      coThePheDuyetChungTu: coThePheDuyetChungTu ?? this.coThePheDuyetChungTu,
      coTheThuChiTienMat: coTheThuChiTienMat ?? this.coTheThuChiTienMat,
      coTheNhapXuatKho: coTheNhapXuatKho ?? this.coTheNhapXuatKho,
      coTheGhiSoKeToan: coTheGhiSoKeToan ?? this.coTheGhiSoKeToan,
      coTheTinhThue: coTheTinhThue ?? this.coTheTinhThue,
      coTheCauHinhHeThong: coTheCauHinhHeThong ?? this.coTheCauHinhHeThong,
      coThePhanQuyen: coThePhanQuyen ?? this.coThePhanQuyen,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        tenVaiTro,
        moTa,
        coTheLapChungTu,
        coThePheDuyetChungTu,
        coTheThuChiTienMat,
        coTheNhapXuatKho,
        coTheGhiSoKeToan,
        coTheTinhThue,
        coTheCauHinhHeThong,
        coThePhanQuyen,
        createdAt,
      ];
}