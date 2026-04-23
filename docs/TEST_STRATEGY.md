# Test Strategy Document
## HKD Accounting System - Kế toán HKD/CNKD

**Version:** 1.0  
**Date:** 2026-04-23  
**Author:** QA Lead (20 years experience)  
**Status:** Approved for Implementation  

---

## 1. Executive Summary

### 1.1 Purpose
This test strategy defines the comprehensive testing approach for the HKD Accounting System (Kế toán HKD/CNKD theo Thông tư 88/2021/TT-BTC). It establishes test objectives, scope, methodologies, and acceptance criteria to ensure software quality meets business requirements.

### 1.2 System Overview
- **Application Type:** Flutter Mobile/Desktop Accounting Software
- **Architecture:** Clean Architecture (Domain/Data/Presentation layers)
- **Database:** SQLite (local storage)
- **Framework:** Flutter 3.27.1 with Riverpod state management
- **Total Features:** 43 Use Cases across 7 modules

### 1.3 Quality Objectives
| Objective | Target | Current |
|-----------|--------|---------|
| Unit Test Coverage | ≥80% | ~5% |
| Integration Test Coverage | ≥60% | 0% |
| Defect Detection Rate | ≥95% | N/A |
| Test Automation | ≥70% | ~10% |
| Build Success Rate | 100% | Pending |

---

## 2. Test Scope

### 2.1 In Scope
- **Unit Tests:** Domain entities, use cases, repository logic, services
- **Widget Tests:** UI components, form dialogs, list items
- **Integration Tests:** End-to-end user workflows
- **Performance Tests:** Database operations, UI rendering
- **Regression Tests:** All implemented features

### 2.2 Out of Scope
- **Platform-specific tests:** iOS/Android native features (deferred)
- **Security penetration testing** (Phase 2)
- **Accessibility testing** (Phase 2)
- **Legacy data migration testing** (future enhancement)

### 2.3 Module Coverage Matrix

| Module | UC Count | Priority | Test Types |
|--------|----------|----------|------------|
| Master Data (MD) | 9 | P0 | Unit, Widget, Integration |
| Chứng từ (CT) | 8 | P0 | Unit, Widget, Integration |
| Quỹ/Tiền (TT) | 2 | P0 | Unit, Widget |
| Kho hàng (KH) | 4 | P1 | Unit, Widget |
| Sổ Kế toán (SK) | 7 | P1 | Unit, Widget |
| Thuế (TX) | 5 | P1 | Unit, Widget |
| Quản trị (QT) | 6 | P2 | Unit, Widget |

---

## 3. Test Types & Strategy

### 3.1 Unit Testing

#### 3.1.1 Domain Layer Tests
**Target:** Entities, Use Cases, Repository Interfaces, Services

**Test Coverage Requirements:**
```dart
// Entity Tests - Required for ALL entities
group('PhieuThu Entity Tests', () {
  test('should create valid PhieuThu with required fields', () {
    final phieuThu = PhieuThu(
      id: 'PT001',
      soPhieu: 'PT-2026-001',
      ngayLap: DateTime(2026, 4, 23),
      soTien: 10000000,
      trangThai: 'MOI',
    );
    expect(phieuThu.id, 'PT001');
    expect(phieuThu.trangThai, 'MOI');
  });

  test('copyWith should preserve unchanged fields', () {
    final original = PhieuThu(...);
    final modified = original.copyWith(soTien: 20000000);
    expect(modified.id, original.id);
    expect(modified.ngayLap, original.ngayLap);
  });

  test('props should include all fields for Equatable', () {
    final p1 = PhieuThu(...);
    final p2 = PhieuThu(...);
    expect(p1, equals(p2));
  });
});
```

**Use Case Tests - Required Pattern:**
```dart
group('CreatePhieuThu Tests', () {
  late MockPhieuThuRepository mockRepository;
  late CreatePhieuThu useCase;

  setUp(() {
    mockRepository = MockPhieuThuRepository();
    useCase = CreatePhieuThu(mockRepository);
  });

  test('should create phieu thu when repository succeeds', () async {
    final phieuThu = PhieuThu(...);
    when(mockRepository.createPhieuThu(any))
        .thenAnswer((_) async => Right(phieuThu));

    final result = await useCase(phieuThu);

    expect(result.isRight(), true);
    verify(mockRepository.createPhieuThu(phieuThu)).called(1);
  });

  test('should return failure when repository fails', () async {
    when(mockRepository.createPhieuThu(any))
        .thenAnswer((_) async => Left(DatabaseFailure('Error')));

    final result = await useCase(phieuThu);

    expect(result.isLeft(), true);
  });
});
```

#### 3.1.2 Data Layer Tests
**Target:** Models, Repository Implementations, Datasources

**Model Tests:**
- `fromEntity()` should correctly convert Domain → Model
- `toEntity()` should correctly convert Model → Domain
- `fromMap()` should correctly parse database rows
- `toMap()` should correctly serialize for database

**Repository Implementation Tests:**
- Success path: verify `Right()` with correct data
- Failure path: verify `Left()` with appropriate `Failure`
- Error handling: verify exceptions are caught and wrapped

### 3.2 Widget Testing

#### 3.2.1 Component Testing Strategy
```
Test Pyramid:
       ┌─────────────┐
       │  Widget    │  ← 30% of test effort
       │   Tests    │
      ┌┴─────────────┴┐
     │  Integration   │  ← 20% of test effort
     │    Tests       │
    ┌┴────────────────┴┐
   │    Unit Tests     │  ← 50% of test effort
   │   (Entities,      │
   │   UseCases)       │
   └───────────────────┘
```

#### 3.2.2 Widget Test Template
```dart
group('PhieuThuPage Widget Tests', () {
  testWidgets('should display loading indicator when loading',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PhieuThuPage(),
        overrides: [
          phieuThuListProvider.overrideWith((ref) => 
            PhieuThuListNotifier()..state = const AsyncValue.loading()),
        ],
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should display list when data loaded',
      (WidgetTester tester) async {
    final testData = [PhieuThu(id: '1', ...), PhieuThu(id: '2', ...)];

    await tester.pumpWidget(
      MaterialApp(
        home: PhieuThuPage(),
        overrides: [
          phieuThuListProvider.overrideWithValue(
            AsyncValue.data(testData),
          ),
        ],
      ),
    );

    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('should show error message on failure',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PhieuThuPage(),
        overrides: [
          phieuThuListProvider.overrideWithValue(
            AsyncValue.error('Load failed', StackTrace.current),
          ),
        ],
      ),
    );

    expect(find.text('Lỗi: Load failed'), findsOneWidget);
  });
});
```

### 3.3 Integration Testing

#### 3.3.1 Critical User Flows (Priority 1)
| Flow ID | Description | Test Scenario |
|---------|-------------|---------------|
| INT-01 | Create Receipt (CT-01) | Create → Save → Verify in list |
| INT-02 | Create Payment (CT-02) | Create → Save → Verify in list |
| INT-03 | Create Goods Receipt (CT-03) | Create → Save → Verify inventory updated |
| INT-04 | Create Goods Issue (CT-04) | Create → Save → Verify inventory updated |
| INT-05 | Create Invoice (CT-06) | Create → Save → Verify tax calculation |
| INT-06 | Tax Calculation (TX-02) | Input revenue → Calculate VAT → Verify result |

#### 3.3.2 Integration Test Template
```dart
group('Create Receipt Integration Tests', () {
  late PhieuThuRepository repository;
  late PhieuThuNotifier notifier;

  setUp(() async {
    // Setup test database
    repository = PhieuThuRepositoryImpl(TestDatabase());
    notifier = PhieuThuNotifier(repository: repository);
  });

  test('complete workflow: create, save, retrieve', () async {
    // 1. Create new receipt
    final newReceipt = PhieuThu(
      id: 'PT-TEST-001',
      soPhieu: 'PT-2026-0001',
      ngayLap: DateTime.now(),
      soTien: 5000000,
      trangThai: 'MOI',
    );

    // 2. Save via notifier
    await notifier.savePhieuThu(newReceipt);

    // 3. Wait for async operation
    await Future.delayed(Duration(milliseconds: 100));

    // 4. Retrieve and verify
    final result = await repository.getPhieuThuById('PT-TEST-001');
    result.fold(
      (failure) => fail('Should not fail'),
      (retrieved) {
        expect(retrieved?.soTien, 5000000);
        expect(retrieved?.soPhieu, 'PT-2026-0001');
      },
    );
  });
});
```

---

## 4. Test Environment

### 4.1 Test Database Strategy
```
┌─────────────────────────────────────────┐
│           Test Environment              │
├─────────────────────────────────────────┤
│  Unit Tests    │  In-Memory SQLite     │
│                │  (mockito sqflite)    │
├────────────────┼───────────────────────┤
│  Widget Tests  │  In-Memory SQLite     │
│                │  (mockito sqflite)    │
├────────────────┼───────────────────────┤
│  Integration   │  Separate Test DB     │
│  Tests         │  (hkd_accounting_test)│
└─────────────────────────────────────────┘
```

### 4.2 Mock Strategy
| Component | Mock Tool | Rationale |
|-----------|-----------|-----------|
| Repositories | mockito | Control test scenarios |
| Use Cases | mockito | Test business logic in isolation |
| Database | sqflite_ffi | In-memory for fast tests |
| GetIt/DI | Riverpod overrides | Avoid actual DI in tests |

---

## 5. Test Data Management

### 5.1 Test Data Fixtures
```dart
// test/fixtures/phieu_thu_fixture.dart
class PhieuThuFixture {
  static PhieuThu valid() => PhieuThu(
    id: 'PT-FIXTURE-001',
    soPhieu: 'PT-2026-0001',
    ngayLap: DateTime(2026, 1, 15),
    soTien: 10000000,
    trangThai: 'MOI',
  );

  static PhieuThu approved() => valid().copyWith(
    trangThai: 'DA_DUYET',
  );

  static List<PhieuThu> multiple(int count) => List.generate(
    count,
    (i) => valid().copyWith(id: 'PT-$i'),
  );
}
```

### 5.2 Test Data Rules
1. **Never use production data** in tests
2. **Use fixture factories** for consistent test data
3. **Reset database state** before each test
4. **Isolate tests** - no shared mutable state

---

## 6. Defect Management

### 6.1 Defect Severity Classification
| Severity | Definition | Examples | Response Time |
|----------|------------|----------|---------------|
| **Critical** | System crash, data loss | DB corruption, cannot save | Immediate |
| **High** | Major function broken | Cannot create receipt | 24 hours |
| **Medium** | Function impaired | Save works but list doesn't refresh | 48 hours |
| **Low** | Cosmetic/minor | Typo in label | Next sprint |

### 6.2 Defect Tracking Workflow
```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   NEW       │ ──→ │  IN PROGRESS│ ──→ │   VERIFIED  │
└─────────────┘     └─────────────┘     └─────────────┘
                           │                    │
                           ↓                    ↓
                    ┌─────────────┐     ┌─────────────┐
                    │  REOPENED   │ ──→ │   CLOSED    │
                    └─────────────┘     └─────────────┘
```

---

## 7. Test Execution Schedule

### 7.1 CI/CD Pipeline
```yaml
# .github/workflows/test.yml
name: Flutter Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Install Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.27.1'
          
      - name: Run unit tests
        run: flutter test test/domain/ test/data/
        
      - name: Run widget tests  
        run: flutter test test/widget/
        
      - name: Run integration tests
        run: flutter test test/integration/
        
      - name: Analyze code
        run: flutter analyze
        
      - name: Build verification
        run: flutter build apk --debug
```

### 7.2 Test Execution Gates
| Gate | Condition | Block Deploy |
|------|-----------|--------------|
| Unit Tests | ≥80% pass | Yes |
| Widget Tests | ≥70% pass | Yes |
| Integration Tests | 100% pass | Yes |
| Code Analysis | 0 errors | Yes |
| Build | Success | Yes |

---

## 8. Risk Analysis & Mitigation

| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|------------|
| Low test coverage | High | High | Mandatory coverage gates |
| Flaky widget tests | Medium | Medium | Use `tester.pumpAndSettle()` |
| Database state leakage | High | Low | Reset DB in `setUp()` |
| DI complexity | Medium | Medium | Use Riverpod overrides |
| Missing fixtures | Low | Medium | Create fixture library |

---

## 9. Test Deliverables

| Deliverable | Location | Frequency |
|-------------|----------|-----------|
| Test Reports | `test/reports/` | Per sprint |
| Coverage Reports | `test/coverage/` | Per build |
| Defect Reports | GitHub Issues | As found |
| Test Strategy | `docs/TEST_STRATEGY.md` | Quarterly review |

---

## 10. Success Metrics

### 10.1 Key Performance Indicators
| KPI | Sprint 1 Target | Final Target |
|-----|-----------------|--------------|
| Unit Test Coverage | 40% | 80% |
| Widget Test Coverage | 20% | 60% |
| Defect Escape Rate | <15% | <5% |
| Test Execution Time | <10 min | <5 min |
| Code Review Coverage | 100% | 100% |

### 10.2 Quality Gates
- ✅ All new code requires test coverage ≥50%
- ✅ All bug fixes require regression tests
- ✅ No Critical/High defects in production
- ✅ Code review approval required for merge

---

## 11. Appendix

### A. Test File Naming Convention
```
test/
├── domain/
│   ├── entities/
│   │   └── phieu_thu_test.dart
│   ├── usecases/
│   │   └── create_phieu_thu_test.dart
│   └── repositories/
│       └── phieu_thu_repository_test.dart
├── data/
│   ├── models/
│   │   └── phieu_thu_model_test.dart
│   └── repositories/
│       └── phieu_thu_repository_impl_test.dart
├── widget/
│   ├── pages/
│   │   └── phieu_thu_page_test.dart
│   └── widgets/
│       └── phieu_thu_form_dialog_test.dart
├── integration/
│   └── create_receipt_flow_test.dart
└── fixtures/
    └── phieu_thu_fixture.dart
```

### B. Running Tests
```bash
# All tests
flutter test

# Unit tests only
flutter test test/domain/ test/data/models/

# Widget tests only  
flutter test test/widget/

# Integration tests
flutter test test/integration/

# With coverage
flutter test --coverage

# Watch mode
flutter test --watch
```

### C. Coverage Report
```bash
# Generate HTML coverage report
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

---

**Document Approval**
| Role | Name | Date | Signature |
|------|------|------|-----------|
| QA Lead | [Your Name] | 2026-04-23 | ☐ |
| Tech Lead | [Your Name] | 2026-04-23 | ☐ |
| Project Manager | [Your Name] | 2026-04-23 | ☐ |

---

*End of Test Strategy Document*