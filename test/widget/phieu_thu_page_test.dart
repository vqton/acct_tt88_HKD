// ============================================================================
// TDD - Widget Layer Tests
// Based on UC_HKD_TT88_2021 - CT-01: Lập phiếu thu
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:hkd_accounting/features/ct/presentation/pages/phieu_thu_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/features/ct/presentation/providers/phieu_thu_provider.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_thu.dart';
import 'package:hkd_accounting/features/ct/domain/usecases/create_phieu_thu.dart';
import 'package:hkd_accounting/features/ct/data/repositories/phieu_thu_repository.dart';
import 'package:hkd_accounting/features/ct/data/datasources/phieu_thu_local_datasource.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get_it/get_it.dart';

// Mock use case
class MockCreatePhieuThu extends Mock implements CreatePhieuThu {}

void main() {
  late MockCreatePhieuThu mockCreatePhieuThu;

  setUp(() {
    mockCreatePhieuThu = MockCreatePhieuThu();
    // Register mock with GetIt
    final getIt = GetIt.instance;
    getIt.resetLazySingleton<CreatePhieuThu>(() => mockCreatePhieuThu);
  });

  tearDown(() {
    GetIt.instance.reset<CreatePhieuThu>();
  });

  group('PhieuThuPage Widget Tests', () {
    testWidgets('displays form fields correctly', (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            phieuThuProvider.overrideWithValue(
              PhieuThuNotifier(createPhieuThuUseCase: mockCreatePhieuThu),
            )
          ],
          child: const MaterialApp(
            home: PhieuThuPage(),
          ),
        ),
      );

      // Verify that the form fields are present
      expect(find.text('Lập phiếu thu'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(11)); // 11 form fields
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('shows error when form is submitted with empty fields', (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            phieuThuProvider.overrideWithValue(
              PhieuThuNotifier(createPhieuThuUseCase: mockCreatePhieuThu),
            )
          ],
          child: const MaterialApp(
            home: PhieuThuPage(),
          ),
        ),
      );

      // Tap the submit button without filling the form
      await tester.tap(find.text('Tạo phiếu thu'));
      await tester.pump();

      // Verify that validation messages appear
      expect(find.text('Vui lòng nhập số phiếu'), findsOneWidget);
      expect(find.text('Vui lòng nhập ngày lập'), findsOneWidget);
      expect(find.text('Vui lòng nhập người nộp'), findsOneWidget);
      expect(find.text('Vui lòng nhập lý do nộp'), findsOneWidget);
      expect(find.text('Vui lòng nhập số tiền'), findsOneWidget);
      expect(find.text('Vui lòng nhập số tiền bằng chữ'), findsOneWidget);
    });

    testWidgets('calls create phieu thu use case when form is valid', (WidgetTester tester) async {
      // Arrange
      when(() => mockCreatePhieuThu(any())).thenAnswer((_) async => const Right(PhieuThu(
        id: 'PT001',
        soPhieu: 'PT001',
        ngayLap: DateTime(2023, 1, 15),
        nguoiNop: 'Nguyen Van A',
        diaChiNguoiNop: '123 Street',
        lyDoNop: 'Test',
        soTien: 100000,
        soTienBangChu: 'Mot tram nghin dong',
        chungTuGocKemTheo: '',
        hkdInfoId: 'HKD001',
        khachHangId: 'KH001',
        kyKeToanId: 'KKT001',
        trangThai: 'CHO_DUYET',
        createdAt: DateTime(2023, 1, 15),
      )));

      // Build our app and trigger a frame
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            phieuThuProvider.overrideWithValue(
              PhieuThuNotifier(createPhieuThuUseCase: mockCreatePhieuThu),
            )
          ],
          child: const MaterialApp(
            home: PhieuThuPage(),
          ),
        ),
      );

      // Fill in the form with valid data
      await tester.enterText(find.byKey(const Key('soPhieu')), 'PT001');
      await tester.enterText(find.byKey(const Key('ngayLap')), '2023-01-15');
      await tester.enterText(find.byKey(const Key('nguoiNop')), 'Nguyen Van A');
      await tester.enterText(find.byKey(const Key('diaChiNguoiNop')), '123 Street');
      await tester.enterText(find.byKey(const Key('lyDoNop')), 'Test');
      await tester.enterText(find.byKey(const Key('soTien')), '100000');
      await tester.enterText(find.byKey(const Key('soTienBangChu')), 'Mot tram nghin dong');
      await tester.enterText(find.byKey(const Key('chungTuGocKemTheo')), '');
      await tester.enterText(find.byKey(const Key('hkdInfoId')), 'HKD001');
      await tester.enterText(find.byKey(const Key('khachHangId')), 'KH001');
      await tester.enterText(find.byKey(const Key('kyKeToanId')), 'KKT001');
      await tester.enterText(find.byKey(const Key('trangThai')), 'CHO_DUYET');

      // Tap the submit button
      await tester.tap(find.text('Tạo phiếu thu'));
      await tester.pump();

      // Verify that the use case was called
      verify(() => mockCreatePhieuThu(any())).called(1);
    });
  });
}

// Helper extension to find widgets by key
extension KeyFinder on WidgetTester {
  Finder findByKey(Key key) => find.byKey(key);
}