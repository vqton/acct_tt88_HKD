// ============================================================================
// Main Entry Point
// HKD Accounting Application - Kế toán HKD/CNKD theo Thông tư 88/2021/TT-BTC
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hkd_accounting/features/master_data/data/datasources/nghe_nghiep_local_datasource.dart';
import 'package:hkd_accounting/features/master_data/data/repositories/nghe_nghiep_repository_impl.dart';
import 'package:hkd_accounting/features/master_data/domain/repositories/nghe_nghiep_repository.dart';
import 'package:hkd_accounting/features/master_data/data/datasources/hkd_info_local_datasource.dart';
import 'package:hkd_accounting/features/master_data/data/repositories/hkd_info_repository_impl.dart';
import 'package:hkd_accounting/features/master_data/domain/repositories/hkd_info_repository.dart';
import 'package:hkd_accounting/features/master_data/data/models/hkd_info_model.dart';
import 'package:hkd_accounting/features/master_data/data/datasources/ky_ke_toan_local_datasource.dart';
import 'package:hkd_accounting/features/master_data/data/repositories/ky_ke_toan_repository_impl.dart';
import 'package:hkd_accounting/features/master_data/domain/repositories/ky_ke_toan_repository.dart';
import 'package:hkd_accounting/features/master_data/data/datasources/hang_hoa_local_datasource.dart';
import 'package:hkd_accounting/features/master_data/data/repositories/hang_hoa_repository_impl.dart';
import 'package:hkd_accounting/features/master_data/domain/repositories/hang_hoa_repository.dart';
import 'package:hkd_accounting/features/master_data/data/datasources/nha_cung_cap_local_datasource.dart';
import 'package:hkd_accounting/features/master_data/data/repositories/nha_cung_cap_repository_impl.dart';
import 'package:hkd_accounting/features/master_data/domain/repositories/nha_cung_cap_repository.dart';
import 'package:hkd_accounting/features/master_data/data/datasources/nguoi_lao_dong_local_datasource.dart';
import 'package:hkd_accounting/features/master_data/data/repositories/nguoi_lao_dong_repository_impl.dart';
import 'package:hkd_accounting/features/master_data/domain/repositories/nguoi_lao_dong_repository.dart';
import 'package:hkd_accounting/features/master_data/data/datasources/tai_khoan_ngan_hang_local_datasource.dart';
import 'package:hkd_accounting/features/master_data/data/repositories/tai_khoan_ngan_hang_repository_impl.dart';
import 'package:hkd_accounting/features/master_data/domain/repositories/tai_khoan_ngan_hang_repository.dart';
import 'package:hkd_accounting/features/ct/data/datasources/phieu_chi_local_datasource.dart';
import 'package:hkd_accounting/features/ct/data/repositories/phieu_chi_repository_impl.dart';
import 'package:hkd_accounting/features/ct/domain/repositories/phieu_chi_repository.dart';
import 'package:hkd_accounting/features/ct/data/datasources/phieu_nhap_kho_local_datasource.dart';
import 'package:hkd_accounting/features/ct/data/repositories/phieu_nhap_kho_repository_impl.dart';
import 'package:hkd_accounting/features/ct/domain/repositories/phieu_nhap_kho_repository.dart';
import 'package:hkd_accounting/features/ct/data/datasources/phieu_xuat_kho_local_datasource.dart';
import 'package:hkd_accounting/features/ct/data/repositories/phieu_xuat_kho_repository_impl.dart';
import 'package:hkd_accounting/features/ct/domain/repositories/phieu_xuat_kho_repository.dart';
import 'package:hkd_accounting/features/ct/data/datasources/hoa_don_local_datasource.dart';
import 'package:hkd_accounting/features/ct/data/repositories/hoa_don_repository_impl.dart';
import 'package:hkd_accounting/features/ct/domain/repositories/hoa_don_repository.dart';
import 'package:hkd_accounting/features/sk/data/datasources/so_doanh_thu_local_datasource.dart';
import 'package:hkd_accounting/features/sk/data/repositories/so_doanh_thu_repository_impl.dart';
import 'package:hkd_accounting/features/sk/domain/repositories/so_doanh_thu_repository.dart';
// import 'package:hkd_accounting/features/sk/data/datasources/so_chi_phi_local_datasource.dart';
// import 'package:hkd_accounting/features/sk/data/repositories/so_chi_phi_repository_impl.dart';
// import 'package:hkd_accounting/features/sk/domain/repositories/so_chi_phi_repository.dart';
import 'package:hkd_accounting/features/kh/data/datasources/ton_kho_local_datasource.dart';
import 'package:hkd_accounting/features/kh/data/repositories/ton_kho_repository_impl.dart';
import 'package:hkd_accounting/features/kh/domain/repositories/ton_kho_repository.dart';
import 'package:hkd_accounting/features/tt/data/datasources/quy_tien_mat_local_datasource.dart';
import 'package:hkd_accounting/features/tt/data/repositories/quy_tien_mat_repository_impl.dart';
import 'package:hkd_accounting/features/tt/domain/repositories/quy_tien_mat_repository.dart';
import 'package:hkd_accounting/features/tt/data/datasources/tien_gui_ngan_hang_local_datasource.dart';
import 'package:hkd_accounting/features/tt/data/repositories/tien_gui_ngan_hang_repository_impl.dart';
import 'package:hkd_accounting/features/tt/domain/repositories/tien_gui_ngan_hang_repository.dart';
import 'package:hkd_accounting/features/master_data/data/datasources/khach_hang_local_datasource.dart';
import 'package:hkd_accounting/features/master_data/data/repositories/khach_hang_repository_impl.dart';
import 'package:hkd_accounting/features/master_data/domain/repositories/khach_hang_repository.dart';
import 'package:hkd_accounting/features/qt/data/datasources/nguoi_dung_local_datasource.dart';
import 'package:hkd_accounting/features/qt/data/repositories/nguoi_dung_repository_impl.dart';
import 'package:hkd_accounting/features/qt/domain/repositories/nguoi_dung_repository.dart';
import 'package:hkd_accounting/features/qt/data/datasources/lich_su_chung_tu_local_datasource.dart';
import 'package:hkd_accounting/features/qt/data/repositories/lich_su_chung_tu_repository_impl.dart';
import 'package:hkd_accounting/features/qt/domain/repositories/lich_su_chung_tu_repository.dart';
import 'package:hkd_accounting/features/tx/data/datasources/tien_thue_local_datasource.dart';
import 'package:hkd_accounting/features/tx/data/datasources/phieu_nop_thue_local_datasource.dart';
import 'package:hkd_accounting/features/tx/data/datasources/so_thue_local_datasource.dart';
import 'package:hkd_accounting/features/tx/data/repositories/tien_thue_repository_impl.dart';
import 'package:hkd_accounting/features/tx/data/repositories/tien_thue_tncn_repository_impl.dart';
import 'package:hkd_accounting/features/tx/data/repositories/phieu_nop_thue_repository_impl.dart';
import 'package:hkd_accounting/features/tx/data/repositories/so_thue_repository_impl.dart';
import 'package:hkd_accounting/features/tx/domain/repositories/tien_thue_repository.dart';
import 'package:hkd_accounting/features/tx/domain/repositories/tien_thue_tncn_repository.dart';
import 'package:hkd_accounting/features/tx/domain/repositories/phieu_nop_thue_repository.dart';
import 'package:hkd_accounting/features/tx/domain/repositories/so_thue_repository.dart';
import 'package:hkd_accounting/features/kh/data/datasources/phieu_kiem_ke_local_datasource.dart';
import 'package:hkd_accounting/features/kh/data/repositories/phieu_kiem_ke_repository_impl.dart';
import 'package:hkd_accounting/features/kh/domain/repositories/phieu_kiem_ke_repository.dart';
import 'package:hkd_accounting/features/ct/domain/usecases/approve_phieu_thu.dart';
import 'package:hkd_accounting/features/ct/domain/usecases/create_phieu_thu.dart';
import 'package:hkd_accounting/features/ct/domain/usecases/approve_phieu_chi.dart';
import 'package:hkd_accounting/features/ct/domain/usecases/create_phieu_chi.dart';
import 'package:hkd_accounting/features/ct/data/datasources/phieu_thu_local_datasource.dart';
import 'package:hkd_accounting/features/ct/data/repositories/phieu_thu_repository_impl.dart';
import 'package:hkd_accounting/features/ct/domain/repositories/phieu_thu_repository.dart';
import 'package:hkd_accounting/features/ct/data/datasources/bang_luong_local_datasource.dart';
import 'package:hkd_accounting/features/ct/data/repositories/bang_luong_repository_impl.dart';
import 'package:hkd_accounting/features/ct/domain/repositories/bang_luong_repository.dart';
import 'package:hkd_accounting/main_page.dart';
import 'dart:io' show Directory;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final getIt = GetIt.instance;

Future<Database> _initializeDatabase() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Directory documentsDirectory = await getApplicationDocumentsDirectory();
  final String path = join(documentsDirectory.path, 'hkd_accounting.db');
  
  return await openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      // Create HKD info table
      await db.execute('''
        CREATE TABLE hkd_info (
          id TEXT PRIMARY KEY,
          ten_hkd TEXT NOT NULL,
          dia_chi_tru_so TEXT,
          ma_so_thue TEXT NOT NULL,
          so_cccd_nguoi_dai_dien TEXT,
          ho_ten_nguoi_dai_dien TEXT,
          phuong_phap_tinh_gia_xuat_kho TEXT NOT NULL DEFAULT 'BINH_QUAN',
          trang_thai TEXT NOT NULL DEFAULT 'HOAT_DONG',
          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
      ''');
      
      // Create nghe nghieu table
      await db.execute('''
        CREATE TABLE nghe_nghiep (
          id TEXT PRIMARY KEY,
          ma_nhom_nghe_nghe TEXT NOT NULL,
          ten_nhom_nghe_nghe TEXT NOT NULL,
          ty_le_thue_gtgt REAL NOT NULL,
          ty_le_thue_tncn REAL NOT NULL,
          ngay_hieu_luc TEXT NOT NULL,
          ngay_het_hieu_luc TEXT,
          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
      ''');
      
      // Create ky ke toan table
      await db.execute('''
        CREATE TABLE ky_ke_toan (
          id TEXT PRIMARY KEY,
          nam_tai_chinh INTEGER NOT NULL,
          ngay_bat_dau_ky TEXT NOT NULL,
          ngay_ket_thuc_ky TEXT NOT NULL,
          trang_thai_ky TEXT NOT NULL,
          ngay_khoa_so_thuc_te TEXT,
          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      // CT-03: Phiếu nhập kho
      await db.execute('''
        CREATE TABLE phieu_nhap_kho (
          id TEXT PRIMARY KEY,
          so_phieu TEXT NOT NULL,
          ngay_lap TEXT NOT NULL,
          ky_ke_toan_id TEXT,
          nha_cung_cap_id TEXT,
          so_hoa_don TEXT,
          dia_diem_nhap TEXT,
          ly_do_nhap TEXT,
          nguoi_giao_hang TEXT,
          nguoi_lap_id TEXT,
          nguoi_duyet_id TEXT,
          trang_thai TEXT NOT NULL DEFAULT 'CHO_DUYET',
          ngay_duyet TEXT,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      await db.execute('''
        CREATE TABLE phieu_nhap_kho_chi_tiet (
          id TEXT PRIMARY KEY,
          phieu_nhap_kho_id TEXT NOT NULL,
          hang_hoa_id TEXT NOT NULL,
          so_luong_theo_chung_tu REAL,
          so_luong_thuc_nhan REAL,
          don_gia REAL,
          thanh_tien INTEGER
        )
      ''');

      // CT-04: Phiếu xuất kho
      await db.execute('''
        CREATE TABLE phieu_xuat_kho (
          id TEXT PRIMARY KEY,
          so_phieu TEXT NOT NULL,
          ngay_lap TEXT NOT NULL,
          ky_ke_toan_id TEXT,
          ho_ten_nguoi_nhan TEXT,
          bo_phan TEXT,
          ly_do_xuat TEXT,
          dia_diem_xuat TEXT,
          nguoi_lap_id TEXT,
          nguoi_duyet_id TEXT,
          trang_thai TEXT NOT NULL DEFAULT 'CHO_DUYET',
          ngay_duyet TEXT,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      await db.execute('''
        CREATE TABLE phieu_xuat_kho_chi_tiet (
          id TEXT PRIMARY KEY,
          phieu_xuat_kho_id TEXT NOT NULL,
          hang_hoa_id TEXT NOT NULL,
          so_luong_yeu_cau REAL,
          so_luong_thuc_xuat REAL,
          don_gia REAL,
          thanh_tien INTEGER
        )
      ''');

      // CT-06: Hóa đơn
      await db.execute('''
        CREATE TABLE hoa_don (
          id TEXT PRIMARY KEY,
          so_hoa_don TEXT NOT NULL,
          ngay_lap TEXT NOT NULL,
          loai_hoa_don TEXT DEFAULT 'DAU_RA',
          ky_ke_toan_id TEXT,
          nha_cung_cap_id TEXT,
          khach_hang_id TEXT,
          phieu_nhap_kho_id TEXT,
          phieu_xuat_kho_id TEXT,
          tien_hang INTEGER DEFAULT 0,
          tien_thue INTEGER DEFAULT 0,
          tong_tien INTEGER DEFAULT 0,
          trang_thai TEXT DEFAULT 'MOI',
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      // CT-05: Bảng lương & thu nhập NLĐ
      await db.execute('''
        CREATE TABLE bang_luong (
          id TEXT PRIMARY KEY,
          ma_bang_luong TEXT NOT NULL,
          ky_ke_toan_id TEXT,
          thang_nam TEXT NOT NULL,
          ngay_lap TEXT NOT NULL,
          tong_luong_san_pham REAL DEFAULT 0,
          tong_luong_thoi_gian REAL DEFAULT 0,
          tong_phu_cap_quy_luong REAL DEFAULT 0,
          tong_phu_cap_ngoai_quy REAL DEFAULT 0,
          tong_tien_thuong REAL DEFAULT 0,
          tong_thu_nhap REAL DEFAULT 0,
          tong_bhxh REAL DEFAULT 0,
          tong_bhyt REAL DEFAULT 0,
          tong_bhtn REAL DEFAULT 0,
          tong_thue_tncn REAL DEFAULT 0,
          tong_khau_tru REAL DEFAULT 0,
          tong_tra_nhan_vien REAL DEFAULT 0,
          trang_thai TEXT DEFAULT 'CHO_DUYET',
          nguoi_lap TEXT,
          nguoi_duyet TEXT,
          ngay_duyet TEXT,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      // CT-05: Chi tiết bảng lương
      await db.execute('''
        CREATE TABLE chi_tiet_bang_luong (
          id TEXT PRIMARY KEY,
          bang_luong_id TEXT NOT NULL,
          nguoi_lao_dong_id TEXT NOT NULL,
          ma_nld TEXT NOT NULL,
          ho_ten TEXT NOT NULL,
          so_cong REAL DEFAULT 0,
          don_gia_luong REAL DEFAULT 0,
          luong_san_pham REAL DEFAULT 0,
          luong_co_ban REAL DEFAULT 0,
          he_so_luong REAL DEFAULT 0,
          phu_cap_quy_luong REAL DEFAULT 0,
          phu_cap_ngoai_quy REAL DEFAULT 0,
          tien_thuong REAL DEFAULT 0,
          thu_nhap REAL DEFAULT 0,
          bhxh REAL DEFAULT 0,
          bhyt REAL DEFAULT 0,
          bhtn REAL DEFAULT 0,
          thue_tncn REAL DEFAULT 0,
          tong_khau_tru REAL DEFAULT 0,
          so_phai_tra REAL DEFAULT 0,
          ky_nhan TEXT,
          ngay_nhan TEXT
        )
      ''');

      // KH-04: Tồn kho hàng hóa
      await db.execute('''
        CREATE TABLE ton_kho (
          id TEXT PRIMARY KEY,
          ky_ke_toan_id TEXT,
          hang_hoa_id TEXT,
          ton_dau_so_luong REAL DEFAULT 0,
          ton_dau_thanh_tien INTEGER DEFAULT 0,
          nhap_so_luong REAL DEFAULT 0,
          nhap_thanh_tien INTEGER DEFAULT 0,
          xuat_so_luong REAL DEFAULT 0,
          xuat_thanh_tien INTEGER DEFAULT 0,
          ton_cuoi_so_luong REAL DEFAULT 0,
          ton_cuoi_thanh_tien INTEGER DEFAULT 0,
          don_gia_xuat_kho REAL DEFAULT 0,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      // MD-05: Khách hàng
      await db.execute('''
        CREATE TABLE khach_hang (
          id TEXT PRIMARY KEY,
          ma_khach_hang TEXT NOT NULL,
          ten_khach_hang TEXT NOT NULL,
          dia_chi TEXT,
          ma_so_thue TEXT,
          so_dien_thoai TEXT,
          loai_khach_hang TEXT NOT NULL,
          trang_thai TEXT NOT NULL,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      // QT-01: Người dùng
      await db.execute('''
        CREATE TABLE nguoi_dung (
          id TEXT PRIMARY KEY,
          ma_nguoi_dung TEXT NOT NULL,
          ho_ten TEXT NOT NULL,
          email TEXT,
          so_dien_thoai TEXT,
          vai_tro TEXT NOT NULL,
          trang_thai TEXT NOT NULL,
          mat_khau_hash TEXT,
          hkd_id TEXT,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      // KH-03: Phiếu kiểm kê
      await db.execute('''
        CREATE TABLE phieu_kiem_ke (
          id TEXT PRIMARY KEY,
          so_phieu TEXT NOT NULL,
          ngay_kiem_ke TEXT NOT NULL,
          ky_ke_toan_id TEXT NOT NULL,
          ghi_chu TEXT,
          nguoi_lap_id TEXT NOT NULL,
          nguoi_xac_nhan_id TEXT,
          trang_thai TEXT NOT NULL,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      await db.execute('''
        CREATE TABLE chi_tiet_kiem_ke (
          id TEXT PRIMARY KEY,
          phieu_kiem_ke_id TEXT NOT NULL,
          hang_hoa_id TEXT NOT NULL,
          so_luong_theo_so REAL DEFAULT 0,
          so_luong_thuc_te REAL,
          chenh_lech REAL,
          loai_chenh_lech TEXT,
          nguyen_nhan TEXT,
          xu_ly TEXT,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      // SK-02: Sổ doanh thu (S1-HKD)
      await db.execute('''
        CREATE TABLE so_doanh_thu (
          id TEXT PRIMARY KEY,
          ky_ke_toan_id TEXT,
          nhom_nghe_id TEXT,
          ngay_chung_tu TEXT,
          so_hieu_chung_tu TEXT,
          dien_giai TEXT,
          doanh_thu INTEGER DEFAULT 0,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      // TX-01/02: Tiền thuế GTGT
      await db.execute('''
        CREATE TABLE tien_thue_gtgt (
          id TEXT PRIMARY KEY,
          ky_ke_toan_id TEXT,
          nhom_nghe_id TEXT,
          ten_nhom_nghe TEXT,
          ty_le_thue_gtgt REAL DEFAULT 0,
          doanh_thu INTEGER DEFAULT 0,
          thue_gtgt_phai_nop INTEGER DEFAULT 0,
          thue_gtgt_da_nop INTEGER DEFAULT 0,
          trang_thai TEXT DEFAULT 'MOI',
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      // TX-03: Tiền thuế TNCN
      await db.execute('''
        CREATE TABLE tien_thue_tncn (
          id TEXT PRIMARY KEY,
          ky_ke_toan_id TEXT,
          nguoi_dung_id TEXT,
          ten_nguoi_nop_thue TEXT,
          loai_doi_tuong TEXT DEFAULT 'CHU_HKD',
          tong_thu_nhap INTEGER DEFAULT 0,
          thue_tncn_phai_nop INTEGER DEFAULT 0,
          thue_tncn_da_nop INTEGER DEFAULT 0,
          trang_thai TEXT DEFAULT 'MOI',
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      // TX-04: Phiếu nộp thuế
      await db.execute('''
        CREATE TABLE phieu_nop_thue (
          id TEXT PRIMARY KEY,
          ky_ke_toan_id TEXT,
          loai_thue TEXT DEFAULT 'gtgt',
          ngay_nop TEXT,
          so_tien_gtgt INTEGER DEFAULT 0,
          so_tien_tncn INTEGER DEFAULT 0,
          tong_tien INTEGER DEFAULT 0,
          so_giay_nop_tien TEXT,
          hinh_thuc_nop TEXT DEFAULT 'CHUYEN_KHOAN',
          ngan_hang_nop TEXT,
          dien_giai TEXT,
          trang_thai TEXT DEFAULT 'DA_NOP',
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      // SK-05: Sổ theo dõi nghĩa vụ thuế (S4-HKD)
      await db.execute('''
        CREATE TABLE so_thue (
          id TEXT PRIMARY KEY,
          ky_ke_toan_id TEXT,
          so_hieu_chung_tu TEXT,
          ngay_chung_tu TEXT,
          dien_giai TEXT,
          thue_gtgt_phai_nop INTEGER DEFAULT 0,
          thue_gtgt_da_nop INTEGER DEFAULT 0,
          thue_tncn_phai_nop INTEGER DEFAULT 0,
          thue_tncn_da_nop INTEGER DEFAULT 0,
          thue_gtgt_con_phai_nop INTEGER DEFAULT 0,
          thue_tncn_con_phai_nop INTEGER DEFAULT 0,
          trang_thai TEXT DEFAULT 'MOI',
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      // SK-04: Sổ chi phí (S3-HKD)
      await db.execute('''
        CREATE TABLE so_chi_phi (
          id TEXT PRIMARY KEY,
          ky_ke_toan_id TEXT,
          nhom_nghe_id TEXT,
          ngay_chung_tu TEXT,
          so_hieu_chung_tu TEXT,
          dien_giai TEXT,
          chi_phi INTEGER DEFAULT 0,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      // CT-01: Phiếu thu
      await db.execute('''
        CREATE TABLE phieu_thu (
          id TEXT PRIMARY KEY,
          so_phieu TEXT NOT NULL,
          ngay_lap TEXT NOT NULL,
          nguoi_nop TEXT NOT NULL,
          dia_chi_nguoi_nop TEXT NOT NULL,
          ly_do_nop TEXT NOT NULL,
          so_tien INTEGER NOT NULL,
          so_tien_bang_chu TEXT NOT NULL,
          chung_tu_goc_kem_theo TEXT NOT NULL,
          hkd_info_id TEXT NOT NULL,
          khach_hang_id TEXT NOT NULL,
          ky_ke_toan_id TEXT NOT NULL,
          trang_thai TEXT NOT NULL DEFAULT 'CHO_DUYET',
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      // CT-02: Phiếu chi
      await db.execute('''
        CREATE TABLE phieu_chi (
          id TEXT PRIMARY KEY,
          so_phieu TEXT NOT NULL,
          ngay_lap TEXT NOT NULL,
          nguoi_nop TEXT NOT NULL,
          dia_chi_nguoi_nop TEXT NOT NULL,
          ly_do_nop TEXT NOT NULL,
          so_tien INTEGER NOT NULL,
          so_tien_bang_chu TEXT NOT NULL,
          chung_tu_goc_kem_theo TEXT NOT NULL,
          hkd_info_id TEXT NOT NULL,
          nha_cung_cap_id TEXT,
          ky_ke_toan_id TEXT NOT NULL,
          trang_thai TEXT NOT NULL DEFAULT 'CHO_DUYET',
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          updated_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');
    },
  );
}

void setupDependencies(Database database) {
  // Register datasources
  getIt.registerLazySingleton<HkdInfoLocalDatasource>(() => HkdInfoLocalDatasourceImpl(database));
  getIt.registerLazySingleton<NgheNghiepLocalDatasource>(() => NgheNghiepLocalDatasourceImpl(database));
  getIt.registerLazySingleton<KyKeToanLocalDatasource>(() => KyKeToanLocalDatasourceImpl(database));
  getIt.registerLazySingleton<HangHoaLocalDatasource>(() => HangHoaLocalDatasourceImpl(database));
  getIt.registerLazySingleton<NhaCungCapLocalDatasource>(() => NhaCungCapLocalDatasourceImpl(database));
  getIt.registerLazySingleton<NguoiLaoDongLocalDatasource>(() => NguoiLaoDongLocalDatasourceImpl(database));
  getIt.registerLazySingleton<TaiKhoanNganHangLocalDatasource>(() => TaiKhoanNganHangLocalDatasourceImpl(database));
  getIt.registerLazySingleton<PhieuChiLocalDatasource>(() => PhieuChiLocalDatasourceImpl(database));
  getIt.registerLazySingleton<PhieuThuLocalDatasource>(() => PhieuThuLocalDatasourceImpl(database));
  getIt.registerLazySingleton<BangLuongLocalDatasource>(() => BangLuongLocalDatasourceImpl(database));
  getIt.registerLazySingleton<PhieuNhapKhoLocalDatasource>(() => PhieuNhapKhoLocalDatasourceImpl(database));
  getIt.registerLazySingleton<PhieuXuatKhoLocalDatasource>(() => PhieuXuatKhoLocalDatasourceImpl(database));
  getIt.registerLazySingleton<HoaDonLocalDatasource>(() => HoaDonLocalDatasourceImpl(database));
  getIt.registerLazySingleton<SoDoanhThuLocalDatasource>(() => SoDoanhThuLocalDatasourceImpl(database));
  // getIt.registerLazySingleton<SoChiPhiLocalDatasource>(() => SoChiPhiLocalDatasourceImpl(database));
  getIt.registerLazySingleton<TonKhoLocalDatasource>(() => TonKhoLocalDatasourceImpl(database));
  getIt.registerLazySingleton<QuyTienMatLocalDatasource>(() => QuyTienMatLocalDatasourceImpl(database));
  getIt.registerLazySingleton<TienGuiNganHangLocalDatasource>(() => TienGuiNganHangLocalDatasourceImpl(database));
  getIt.registerLazySingleton<KhachHangLocalDatasource>(() => KhachHangLocalDatasourceImpl(database));
  getIt.registerLazySingleton<NguoiDungLocalDatasource>(() => NguoiDungLocalDatasourceImpl(database));
  getIt.registerLazySingleton<PhieuKiemKeLocalDatasource>(() => PhieuKiemKeLocalDatasourceImpl(database));
getIt.registerLazySingleton<LichSuChungTuLocalDatasource>(() => LichSuChungTuLocalDatasource(database));
  getIt.registerLazySingleton<TienThueLocalDatasource>(() => TienThueLocalDatasourceImpl(database));
  getIt.registerLazySingleton<PhieuNopThueLocalDatasource>(() => PhieuNopThueLocalDatasourceImpl(database));
  getIt.registerLazySingleton<SoThueLocalDatasource>(() => SoThueLocalDatasourceImpl(database));
    
  // Register repositories
  getIt.registerLazySingleton<HkdInfoRepository>(() => HkdInfoRepositoryImpl(getIt.get<HkdInfoLocalDatasource>()));
  getIt.registerLazySingleton<NgheNghiepRepository>(() => NgheNghiepRepositoryImpl(getIt.get<NgheNghiepLocalDatasource>()));
  getIt.registerLazySingleton<KyKeToanRepository>(() => KyKeToanRepositoryImpl(getIt.get<KyKeToanLocalDatasource>()));
  getIt.registerLazySingleton<HangHoaRepository>(() => HangHoaRepositoryImpl(getIt.get<HangHoaLocalDatasource>()));
  getIt.registerLazySingleton<NhaCungCapRepository>(() => NhaCungCapRepositoryImpl(getIt.get<NhaCungCapLocalDatasource>()));
  getIt.registerLazySingleton<NguoiLaoDongRepository>(() => NguoiLaoDongRepositoryImpl(getIt.get<NguoiLaoDongLocalDatasource>()));
  getIt.registerLazySingleton<TaiKhoanNganHangRepository>(() => TaiKhoanNganHangRepositoryImpl(getIt.get<TaiKhoanNganHangLocalDatasource>()));
  getIt.registerLazySingleton<PhieuChiRepository>(() => PhieuChiRepositoryImpl(getIt.get<PhieuChiLocalDatasource>()));
  getIt.registerLazySingleton<PhieuThuRepository>(() => PhieuThuRepositoryImpl(getIt.get<PhieuThuLocalDatasource>()));
  getIt.registerLazySingleton<BangLuongRepository>(() => BangLuongRepositoryImpl(getIt.get<BangLuongLocalDatasource>()));
  getIt.registerLazySingleton<PhieuNhapKhoRepository>(() => PhieuNhapKhoRepositoryImpl(getIt.get<PhieuNhapKhoLocalDatasource>()));
  getIt.registerLazySingleton<PhieuXuatKhoRepository>(() => PhieuXuatKhoRepositoryImpl(getIt.get<PhieuXuatKhoLocalDatasource>()));
  getIt.registerLazySingleton<HoaDonRepository>(() => HoaDonRepositoryImpl(getIt.get<HoaDonLocalDatasource>()));
  getIt.registerLazySingleton<SoDoanhThuRepository>(() => SoDoanhThuRepositoryImpl(getIt.get<SoDoanhThuLocalDatasource>()));
  // getIt.registerLazySingleton<SoChiPhiRepository>(() => SoChiPhiRepositoryImpl(getIt.get<SoChiPhiLocalDatasource>()));
  getIt.registerLazySingleton<TonKhoRepository>(() => TonKhoRepositoryImpl(getIt.get<TonKhoLocalDatasource>()));
  getIt.registerLazySingleton<QuyTienMatRepository>(() => QuyTienMatRepositoryImpl(getIt.get<QuyTienMatLocalDatasource>()));
  getIt.registerLazySingleton<TienGuiNganHangRepository>(() => TienGuiNganHangRepositoryImpl(getIt.get<TienGuiNganHangLocalDatasource>()));
  getIt.registerLazySingleton<KhachHangRepository>(() => KhachHangRepositoryImpl(getIt.get<KhachHangLocalDatasource>()));
  getIt.registerLazySingleton<NguoiDungRepository>(() => NguoiDungRepositoryImpl(getIt.get<NguoiDungLocalDatasource>()));
  getIt.registerLazySingleton<PhieuKiemKeRepository>(() => PhieuKiemKeRepositoryImpl(getIt.get<PhieuKiemKeLocalDatasource>()));
getIt.registerLazySingleton<LichSuChungTuRepository>(() => LichSuChungTuRepositoryImpl(getIt.get<LichSuChungTuLocalDatasource>()));
  getIt.registerLazySingleton<TienThueRepository>(() => TienThueRepositoryImpl(getIt.get<TienThueLocalDatasource>()));
  getIt.registerLazySingleton<TienThueTncnRepository>(() => TienThueTncnRepositoryImpl(getIt.get<TienThueLocalDatasource>()));
  getIt.registerLazySingleton<PhieuNopThueRepository>(() => PhieuNopThueRepositoryImpl(getIt.get<PhieuNopThueLocalDatasource>()));
  getIt.registerLazySingleton<SoThueRepository>(() => SoThueRepositoryImpl(getIt.get<SoThueLocalDatasource>()));
    
  // Register use cases
  getIt.registerLazySingleton<CreatePhieuThu>(() => CreatePhieuThu(getIt.get<PhieuThuRepository>()));
  getIt.registerLazySingleton<ApprovePhieuThu>(() => ApprovePhieuThu(getIt.get<PhieuThuRepository>()));
  getIt.registerLazySingleton<CreatePhieuChi>(() => CreatePhieuChi(getIt.get<PhieuChiRepository>()));
  getIt.registerLazySingleton<ApprovePhieuChi>(() => ApprovePhieuChi(getIt.get<PhieuChiRepository>()));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize database
  final database = await _initializeDatabase();
  
  // Setup dependencies
  setupDependencies(database);
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Hệ thống Kế toán HKD/CNKD',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}