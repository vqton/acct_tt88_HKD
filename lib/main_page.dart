import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/features/master_data/presentation/pages/hkd_info_page.dart';
import 'package:hkd_accounting/features/master_data/presentation/pages/ky_ke_toan_page.dart';
import 'package:hkd_accounting/features/master_data/presentation/pages/nghe_nghiep_page.dart';

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
  ];

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
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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