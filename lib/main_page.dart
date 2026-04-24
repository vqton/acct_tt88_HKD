// ============================================================================
// Main Page / Navigation Shell
// HKD Accounting Application - Main navigation and routing
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/features/master_data/presentation/pages/hkd_info_page.dart';
import 'package:hkd_accounting/features/master_data/presentation/pages/ky_ke_toan_page.dart';
import 'package:hkd_accounting/features/master_data/presentation/pages/nghe_nghiep_page.dart';
import 'package:hkd_accounting/features/master_data/presentation/pages/hang_hoa_page.dart';
import 'package:hkd_accounting/features/kh/presentation/pages/nhap_kho_page.dart';
import 'package:hkd_accounting/features/kh/presentation/pages/xuat_kho_page.dart';
import 'package:hkd_accounting/features/kh/presentation/pages/ton_kho_page.dart';
import 'package:hkd_accounting/features/kh/presentation/pages/kiem_ke_page.dart';
import 'package:hkd_accounting/features/master_data/presentation/pages/nha_cung_cap_page.dart';
import 'package:hkd_accounting/features/master_data/presentation/pages/khach_hang_page.dart';
import 'package:hkd_accounting/features/master_data/presentation/pages/nguoi_lao_dong_page.dart';
import 'package:hkd_accounting/features/master_data/presentation/pages/tai_khoan_ngan_hang_page.dart';
import 'package:hkd_accounting/features/ct/presentation/pages/phieu_chi_page.dart';
import 'package:hkd_accounting/features/tt/presentation/pages/quy_tien_mat_page.dart';
import 'package:hkd_accounting/features/tt/presentation/pages/tien_gui_ngan_hang_page.dart';
import 'package:hkd_accounting/features/qt/presentation/pages/tra_cuu_chung_tu_page.dart';
import 'package:hkd_accounting/features/tx/presentation/pages/tra_cuu_thue_page.dart';
import 'package:hkd_accounting/features/tx/presentation/pages/so_thue_page.dart';
import 'package:hkd_accounting/features/ct/presentation/pages/bang_luong_page.dart';
import 'package:hkd_accounting/features/sk/presentation/pages/so_theo_doi_tien_luong_page.dart';
import 'package:hkd_accounting/features/sk/presentation/pages/so_quy_tien_mat_page.dart';
import 'package:hkd_accounting/features/sk/presentation/pages/so_ke_toan_page.dart';
import 'package:hkd_accounting/features/ns/presentation/pages/tinh_luong_page.dart';
import 'package:hkd_accounting/features/ns/presentation/pages/thanh_toan_luong_page.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    HkdInfoPage(),
    NgheNghiepPage(),
    KyKeToanPage(),
    HangHoaPage(),
    NhaCungCapPage(),
    KhachHangPage(),
    NguoiLaoDongPage(),
    TaiKhoanNganHangPage(),
    PhieuChiPage(),
    BangLuongPage(),
    QuyTienMatPage(),
    TienGuiNganHangPage(),
    TonKhoPage(),
    NhapKhoPage(),
    XuatKhoPage(),
    KiemKePage(),
    TraCuuChungTuPage(),
    TraCuuThuePage(),
    SoThuePage(),
    SoKeToanPage(),
    SoTheoDoiTienLuongPage(),
    TinhLuongPage(),
    ThanhToanLuongPage(),
  ];

  // Separate pages for navigation (not in bottom nav)
  Widget getKhoPage(int index) {
    switch (index) {
      case 0:
        return const TonKhoPage();
      case 1:
        return const NhapKhoPage();
      case 2:
        return const XuatKhoPage();
      case 3:
        return const KiemKePage();
      default:
        return const TonKhoPage();
    }
  }

  static const List<BottomNavigationBarItem> _bottomNavigationBarItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Thông tin HKD',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.category),
      label: 'Ngành nghề',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today),
      label: 'Kỳ kế toán',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.inventory),
      label: 'Hàng hóa',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.store),
      label: 'Nhà cung cấp',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Khách hàng',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.people),
      label: 'Người lao động',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_balance),
      label: 'Tài khoản NH',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.receipt),
      label: 'Phiếu chi',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.payments),
      label: 'Bảng lương',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_balance_wallet),
      label: 'Quỹ TM',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_balance),
      label: 'Tiền gửi NH',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.inventory_2),
      label: 'Tồn kho',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.move_to_inbox),
      label: 'Nhập kho',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.unarchive),
      label: 'Xuất kho',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.fact_check),
      label: 'Kiểm kê',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Tra cứu CT',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.receipt_long),
      label: 'Thuế',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.book),
      label: 'Sổ thuế',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_balance),
      label: 'Sổ kế toán',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.people),
      label: 'S5-Lương',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.calculate),
      label: 'Tính lương',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.payments),
      label: 'Thanh toán',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}