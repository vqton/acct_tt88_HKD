// ============================================================================
// Data Layer - Model
// Based on UC_HKD_TT88_2021 - CT-05: Lập bảng thanh toán tiền lương
// ============================================================================

import 'package:hkd_accounting/features/ct/domain/entities/bang_luong.dart';

class BangLuongModel extends BangLuong {
  const BangLuongModel({
    required super.id,
    required super.maBangLuong,
    required super.kyKeToanId,
    required super.thangNam,
    required super.ngayLap,
    required super.chiTietList,
    required super.tongLuongSanPham,
    required super.tongLuongThoiGian,
    required super.tongPhuCapQuyLuong,
    required super.tongPhuCapNgoaiQuy,
    required super.tongTienThuong,
    required super.tongThuNhap,
    required super.tongBhxh,
    required super.tongBhyt,
    required super.tongBhtn,
    required super.tongThueTNCN,
    required super.tongKhauTru,
    required super.tongTraNhanVien,
    required super.trangThai,
    super.nguoiLap,
    super.nguoiDuyet,
    super.ngayDuyet,
    super.createdAt,
    super.updatedAt,
  });

  factory BangLuongModel.fromEntity(BangLuong entity) {
    return BangLuongModel(
      id: entity.id,
      maBangLuong: entity.maBangLuong,
      kyKeToanId: entity.kyKeToanId,
      thangNam: entity.thangNam,
      ngayLap: entity.ngayLap,
      chiTietList: entity.chiTietList,
      tongLuongSanPham: entity.tongLuongSanPham,
      tongLuongThoiGian: entity.tongLuongThoiGian,
      tongPhuCapQuyLuong: entity.tongPhuCapQuyLuong,
      tongPhuCapNgoaiQuy: entity.tongPhuCapNgoaiQuy,
      tongTienThuong: entity.tongTienThuong,
      tongThuNhap: entity.tongThuNhap,
      tongBhxh: entity.tongBhxh,
      tongBhyt: entity.tongBhyt,
      tongBhtn: entity.tongBhtn,
      tongThueTNCN: entity.tongThueTNCN,
      tongKhauTru: entity.tongKhauTru,
      tongTraNhanVien: entity.tongTraNhanVien,
      trangThai: entity.trangThai,
      nguoiLap: entity.nguoiLap,
      nguoiDuyet: entity.nguoiDuyet,
      ngayDuyet: entity.ngayDuyet,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  factory BangLuongModel.fromMap(Map<String, dynamic> map) {
    return BangLuongModel(
      id: map['id'] as String,
      maBangLuong: map['ma_bang_luong'] as String,
      kyKeToanId: map['ky_ke_toan_id'] as String,
      thangNam: map['thang_nam'] as String,
      ngayLap: DateTime.parse(map['ngay_lap'] as String),
      chiTietList: [],
      tongLuongSanPham: (map['tong_luong_san_pham'] as num?)?.toDouble() ?? 0,
      tongLuongThoiGian: (map['tong_luong_thoi_gian'] as num?)?.toDouble() ?? 0,
      tongPhuCapQuyLuong: (map['tong_phu_cap_quy_luong'] as num?)?.toDouble() ?? 0,
      tongPhuCapNgoaiQuy: (map['tong_phu_cap_ngoai_quy'] as num?)?.toDouble() ?? 0,
      tongTienThuong: (map['tong_tien_thuong'] as num?)?.toDouble() ?? 0,
      tongThuNhap: (map['tong_thu_nhap'] as num?)?.toDouble() ?? 0,
      tongBhxh: (map['tong_bhxh'] as num?)?.toDouble() ?? 0,
      tongBhyt: (map['tong_bhyt'] as num?)?.toDouble() ?? 0,
      tongBhtn: (map['tong_bhtn'] as num?)?.toDouble() ?? 0,
      tongThueTNCN: (map['tong_thue_tncn'] as num?)?.toDouble() ?? 0,
      tongKhauTru: (map['tong_khau_tru'] as num?)?.toDouble() ?? 0,
      tongTraNhanVien: (map['tong_tra_nhan_vien'] as num?)?.toDouble() ?? 0,
      trangThai: map['trang_thai'] as String? ?? 'CHO_DUYET',
      nguoiLap: map['nguoi_lap'] as String?,
      nguoiDuyet: map['nguoi_duyet'] as String?,
      ngayDuyet: map['ngay_duyet'] != null
          ? DateTime.tryParse(map['ngay_duyet'] as String)
          : null,
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'] as String)
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.tryParse(map['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ma_bang_luong': maBangLuong,
      'ky_ke_toan_id': kyKeToanId,
      'thang_nam': thangNam,
      'ngay_lap': ngayLap.toIso8601String(),
      'tong_luong_san_pham': tongLuongSanPham,
      'tong_luong_thoi_gian': tongLuongThoiGian,
      'tong_phu_cap_quy_luong': tongPhuCapQuyLuong,
      'tong_phu_cap_ngoai_quy': tongPhuCapNgoaiQuy,
      'tong_tien_thuong': tongTienThuong,
      'tong_thu_nhap': tongThuNhap,
      'tong_bhxh': tongBhxh,
      'tong_bhyt': tongBhyt,
      'tong_bhtn': tongBhtn,
      'tong_thue_tncn': tongThueTNCN,
      'tong_khau_tru': tongKhauTru,
      'tong_tra_nhan_vien': tongTraNhanVien,
      'trang_thai': trangThai,
      'nguoi_lap': nguoiLap,
      'nguoi_duyet': nguoiDuyet,
      'ngay_duyet': ngayDuyet?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  BangLuong toEntity() => BangLuong(
        id: id,
        maBangLuong: maBangLuong,
        kyKeToanId: kyKeToanId,
        thangNam: thangNam,
        ngayLap: ngayLap,
        chiTietList: chiTietList,
        tongLuongSanPham: tongLuongSanPham,
        tongLuongThoiGian: tongLuongThoiGian,
        tongPhuCapQuyLuong: tongPhuCapQuyLuong,
        tongPhuCapNgoaiQuy: tongPhuCapNgoaiQuy,
        tongTienThuong: tongTienThuong,
        tongThuNhap: tongThuNhap,
        tongBhxh: tongBhxh,
        tongBhyt: tongBhyt,
        tongBhtn: tongBhtn,
        tongThueTNCN: tongThueTNCN,
        tongKhauTru: tongKhauTru,
        tongTraNhanVien: tongTraNhanVien,
        trangThai: trangThai,
        nguoiLap: nguoiLap,
        nguoiDuyet: nguoiDuyet,
        ngayDuyet: ngayDuyet,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

class ChiTietBangLuongModel extends ChiTietBangLuong {
  const ChiTietBangLuongModel({
    required super.id,
    required super.bangLuongId,
    required super.nguoiLaoDongId,
    required super.maNld,
    required super.hoTen,
    required super.soCong,
    required super.donGiaLuong,
    required super.luongSanPham,
    required super.luongCoBan,
    required super.heSoLuong,
    required super.phuCapQuyLuong,
    required super.phuCapNgoaiQuy,
    required super.tienThuong,
    required super.thuNhap,
    required super.bhxh,
    required super.bhyt,
    required super.bhtn,
    required super.thueTNCN,
    required super.tongKhauTru,
    required super.soPhaiTra,
    super.kyNhan,
    super.ngayNhan,
  });

  factory ChiTietBangLuongModel.fromMap(Map<String, dynamic> map) {
    return ChiTietBangLuongModel(
      id: map['id'] as String,
      bangLuongId: map['bang_luong_id'] as String,
      nguoiLaoDongId: map['nguoi_lao_dong_id'] as String,
      maNld: map['ma_nld'] as String,
      hoTen: map['ho_ten'] as String,
      soCong: (map['so_cong'] as num?)?.toDouble() ?? 0,
      donGiaLuong: (map['don_gia_luong'] as num?)?.toDouble() ?? 0,
      luongSanPham: (map['luong_san_pham'] as num?)?.toDouble() ?? 0,
      luongCoBan: (map['luong_co_ban'] as num?)?.toDouble() ?? 0,
      heSoLuong: (map['he_so_luong'] as num?)?.toDouble() ?? 0,
      phuCapQuyLuong: (map['phu_cap_quy_luong'] as num?)?.toDouble() ?? 0,
      phuCapNgoaiQuy: (map['phu_cap_ngoai_quy'] as num?)?.toDouble() ?? 0,
      tienThuong: (map['tien_thuong'] as num?)?.toDouble() ?? 0,
      thuNhap: (map['thu_nhap'] as num?)?.toDouble() ?? 0,
      bhxh: (map['bhxh'] as num?)?.toDouble() ?? 0,
      bhyt: (map['bhyt'] as num?)?.toDouble() ?? 0,
      bhtn: (map['bhtn'] as num?)?.toDouble() ?? 0,
      thueTNCN: (map['thue_tncn'] as num?)?.toDouble() ?? 0,
      tongKhauTru: (map['tong_khau_tru'] as num?)?.toDouble() ?? 0,
      soPhaiTra: (map['so_phai_tra'] as num?)?.toDouble() ?? 0,
      kyNhan: map['ky_nhan'] as String?,
      ngayNhan: map['ngay_nhan'] != null
          ? DateTime.tryParse(map['ngay_nhan'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bang_luong_id': bangLuongId,
      'nguoi_lao_dong_id': nguoiLaoDongId,
      'ma_nld': maNld,
      'ho_ten': hoTen,
      'so_cong': soCong,
      'don_gia_luong': donGiaLuong,
      'luong_san_pham': luongSanPham,
      'luong_co_ban': luongCoBan,
      'he_so_luong': heSoLuong,
      'phu_cap_quy_luong': phuCapQuyLuong,
      'phu_cap_ngoai_quy': phuCapNgoaiQuy,
      'tien_thuong': tienThuong,
      'thu_nhap': thuNhap,
      'bhxh': bhxh,
      'bhyt': bhyt,
      'bhtn': bhtn,
      'thue_tncn': thueTNCN,
      'tong_khau_tru': tongKhauTru,
      'so_phai_tra': soPhaiTra,
      'ky_nhan': kyNhan,
      'ngay_nhan': ngayNhan?.toIso8601String(),
    };
  }
}