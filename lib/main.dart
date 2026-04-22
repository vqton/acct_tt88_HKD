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
import 'package:hkd_accounting/features/sk/data/datasources/so_chi_phi_local_datasource.dart';
import 'package:hkd_accounting/features/sk/data/repositories/so_chi_phi_repository_impl.dart';
import 'package:hkd_accounting/features/sk/domain/repositories/so_chi_phi_repository.dart';
import 'package:hkd_accounting/features/kh/data/datasources/ton_kho_local_datasource.dart';
import 'package:hkd_accounting/features/kh/data/repositories/ton_kho_repository_impl.dart';
import 'package:hkd_accounting/features/kh/domain/repositories/ton_kho_repository.dart';
import 'package:hkd_accounting/features/tt/data/datasources/quy_tien_mat_local_datasource.dart';
import 'package:hkd_accounting/features/tt/data/repositories/quy_tien_mat_repository_impl.dart';
import 'package:hkd_accounting/features/tt/domain/repositories/quy_tien_mat_repository.dart';
import 'package:hkd_accounting/features/tt/data/datasources/tien_gui_ngan_hang_local_datasource.dart';
import 'package:hkd_accounting/features/tt/data/repositories/tien_gui_ngan_hang_repository_impl.dart';
import 'package:hkd_accounting/features/tt/domain/repositories/tien_gui_ngan_hang_repository.dart';
import 'package:hkd_accounting/features/ct/domain/usecases/approve_phieu_thu.dart';
import 'package:hkd_accounting/lib/main_page.dart';
import 'dart:io' show Directory;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
  getIt.registerLazySingleton<PhieuNhapKhoLocalDatasource>(() => PhieuNhapKhoLocalDatasourceImpl(database));
  getIt.registerLazySingleton<PhieuXuatKhoLocalDatasource>(() => PhieuXuatKhoLocalDatasourceImpl(database));
  getIt.registerLazySingleton<HoaDonLocalDatasource>(() => HoaDonLocalDatasourceImpl(database));
  getIt.registerLazySingleton<SoDoanhThuLocalDatasource>(() => SoDoanhThuLocalDatasourceImpl(database));
  getIt.registerLazySingleton<SoChiPhiLocalDatasource>(() => SoChiPhiLocalDatasourceImpl(database));
  getIt.registerLazySingleton<TonKhoLocalDatasource>(() => TonKhoLocalDatasourceImpl(database));
  getIt.registerLazySingleton<QuyTienMatLocalDatasource>(() => QuyTienMatLocalDatasourceImpl(database));
  getIt.registerLazySingleton<TienGuiNganHangLocalDatasource>(() => TienGuiNganHangLocalDatasourceImpl(database));
   
  // Register repositories
  getIt.registerLazySingleton<HkdInfoRepository>(() => HkdInfoRepositoryImpl(getIt.get<HkdInfoLocalDatasource>()));
  getIt.registerLazySingleton<NgheNghiepRepository>(() => NgheNghiepRepositoryImpl(getIt.get<NgheNghiepLocalDatasource>()));
  getIt.registerLazySingleton<KyKeToanRepository>(() => KyKeToanRepositoryImpl(getIt.get<KyKeToanLocalDatasource>()));
  getIt.registerLazySingleton<HangHoaRepository>(() => HangHoaRepositoryImpl(getIt.get<HangHoaLocalDatasource>()));
  getIt.registerLazySingleton<NhaCungCapRepository>(() => NhaCungCapRepositoryImpl(getIt.get<NhaCungCapLocalDatasource>()));
  getIt.registerLazySingleton<NguoiLaoDongRepository>(() => NguoiLaoDongRepositoryImpl(getIt.get<NguoiLaoDongLocalDatasource>()));
  getIt.registerLazySingleton<TaiKhoanNganHangRepository>(() => TaiKhoanNganHangRepositoryImpl(getIt.get<TaiKhoanNganHangLocalDatasource>()));
  getIt.registerLazySingleton<PhieuChiRepository>(() => PhieuChiRepositoryImpl(getIt.get<PhieuChiLocalDatasource>()));
  getIt.registerLazySingleton<PhieuNhapKhoRepository>(() => PhieuNhapKhoRepositoryImpl(getIt.get<PhieuNhapKhoLocalDatasource>()));
  getIt.registerLazySingleton<PhieuXuatKhoRepository>(() => PhieuXuatKhoRepositoryImpl(getIt.get<PhieuXuatKhoLocalDatasource>()));
  getIt.registerLazySingleton<HoaDonRepository>(() => HoaDonRepositoryImpl(getIt.get<HoaDonLocalDatasource>()));
  getIt.registerLazySingleton<SoDoanhThuRepository>(() => SoDoanhThuRepositoryImpl(getIt.get<SoDoanhThuLocalDatasource>()));
  getIt.registerLazySingleton<SoChiPhiRepository>(() => SoChiPhiRepositoryImpl(getIt.get<SoChiPhiLocalDatasource>()));
  getIt.registerLazySingleton<TonKhoRepository>(() => TonKhoRepositoryImpl(getIt.get<TonKhoLocalDatasource>()));
  getIt.registerLazySingleton<QuyTienMatRepository>(() => QuyTienMatRepositoryImpl(getIt.get<QuyTienMatLocalDatasource>()));
  getIt.registerLazySingleton<TienGuiNganHangRepository>(() => TienGuiNganHangRepositoryImpl(getIt.get<TienGuiNganHangLocalDatasource>()));
   
  // Register use cases
  getIt.registerLazySingleton<CreatePhieuThu>(() => CreatePhieuThu(getIt.get<PhieuThuRepository>()));
  getIt.registerLazySingleton<ApprovePhieuThu>(() => ApprovePhieuThu(getIt.get<PhieuThuRepository>()));
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