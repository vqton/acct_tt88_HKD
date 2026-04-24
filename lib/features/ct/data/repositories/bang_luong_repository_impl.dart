// ============================================================================
// Data Layer - Repository Implementation
// Based on UC_HKD_TT88_2021 - CT-05: Lập bảng thanh toán tiền lương
// ============================================================================

import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/ct/data/datasources/bang_luong_local_datasource.dart';
import 'package:hkd_accounting/features/ct/data/models/bang_luong_model.dart';
import 'package:hkd_accounting/features/ct/domain/entities/bang_luong.dart';
import 'package:hkd_accounting/features/ct/domain/repositories/bang_luong_repository.dart';

class BangLuongRepositoryImpl implements BangLuongRepository {
  final BangLuongLocalDatasource datasource;

  BangLuongRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, BangLuong>> create(BangLuong bangLuong) async {
    try {
      final model = BangLuongModel.fromEntity(bangLuong);
      final id = await datasource.save(model);
      final result = await datasource.getById(id);
      return Right(result!.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BangLuong?>> getById(String id) async {
    try {
      final result = await datasource.getById(id);
      return Right(result?.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BangLuong>>> getList() async {
    try {
      final result = await datasource.getList();
      return Right(result.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BangLuong>>> getByKyKeToan(
      String kyKeToanId) async {
    try {
      final result = await datasource.getByKyKeToan(kyKeToanId);
      return Right(result.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> update(BangLuong bangLuong) async {
    try {
      final model = BangLuongModel.fromEntity(bangLuong);
      await datasource.update(model);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> delete(String id) async {
    try {
      await datasource.delete(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BangLuong>> approve(
      String id, String nguoiDuyet) async {
    try {
      final existing = await datasource.getById(id);
      if (existing == null) {
        return const Left(NotFoundFailure('Không tìm thấy bảng lương'));
      }
      final updated = BangLuongModel(
        id: existing.id,
        maBangLuong: existing.maBangLuong,
        kyKeToanId: existing.kyKeToanId,
        thangNam: existing.thangNam,
        ngayLap: existing.ngayLap,
        chiTietList: existing.chiTietList,
        tongLuongSanPham: existing.tongLuongSanPham,
        tongLuongThoiGian: existing.tongLuongThoiGian,
        tongPhuCapQuyLuong: existing.tongPhuCapQuyLuong,
        tongPhuCapNgoaiQuy: existing.tongPhuCapNgoaiQuy,
        tongTienThuong: existing.tongTienThuong,
        tongThuNhap: existing.tongThuNhap,
        tongBhxh: existing.tongBhxh,
        tongBhyt: existing.tongBhyt,
        tongBhtn: existing.tongBhtn,
        tongThueTNCN: existing.tongThueTNCN,
        tongKhauTru: existing.tongKhauTru,
        tongTraNhanVien: existing.tongTraNhanVien,
        trangThai: 'DA_DUYET',
        nguoiLap: existing.nguoiLap,
        nguoiDuyet: nguoiDuyet,
        ngayDuyet: DateTime.now(),
        createdAt: existing.createdAt,
        updatedAt: DateTime.now(),
      );
      await datasource.update(updated);
      final result = await datasource.getById(id);
      return Right(result!.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ChiTietBangLuong>> addChiTiet(
      ChiTietBangLuong chiTiet) async {
    try {
      final model = ChiTietBangLuongModel(
        id: chiTiet.id,
        bangLuongId: chiTiet.bangLuongId,
        nguoiLaoDongId: chiTiet.nguoiLaoDongId,
        maNld: chiTiet.maNld,
        hoTen: chiTiet.hoTen,
        soCong: chiTiet.soCong,
        donGiaLuong: chiTiet.donGiaLuong,
        luongSanPham: chiTiet.luongSanPham,
        luongCoBan: chiTiet.luongCoBan,
        heSoLuong: chiTiet.heSoLuong,
        phuCapQuyLuong: chiTiet.phuCapQuyLuong,
        phuCapNgoaiQuy: chiTiet.phuCapNgoaiQuy,
        tienThuong: chiTiet.tienThuong,
        thuNhap: chiTiet.thuNhap,
        bhxh: chiTiet.bhxh,
        bhyt: chiTiet.bhyt,
        bhtn: chiTiet.bhtn,
        thueTNCN: chiTiet.thueTNCN,
        tongKhauTru: chiTiet.tongKhauTru,
        soPhaiTra: chiTiet.soPhaiTra,
        kyNhan: chiTiet.kyNhan,
        ngayNhan: chiTiet.ngayNhan,
      );
      final id = await datasource.saveChiTiet(model);
      return Right(chiTiet);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteChiTiet(String chiTietId) async {
    try {
      await datasource.deleteChiTiet(chiTietId);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}