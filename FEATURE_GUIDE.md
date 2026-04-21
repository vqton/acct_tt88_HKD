# Flutter Developer Guide
## HKD Accounting System

---

## 1. Project Structure

```
lib/
├── main.dart                    # App entry, DI setup, DB init
├── main_page.dart               # Navigation shell
├── core/                        # Shared utilities
│   ├── error/                   # Failures, exceptions
│   ├── widgets/                 # Common widgets
│   └── utils/                   # Helpers
└── features/                    # Business modules
    ├── master_data/             # MD-01 to MD-08
    ├── ct/                      # CT-01 to CT-08 (Chứng từ)
    ├── tt/                      # TT-01, TT-02 (Quỹ & Ngân hàng)
    ├── kh/                      # KH-01 to KH-04 (Kho hàng)
    └── sk/                      # SK-01 to SK-08 (Sổ kế toán)
```

---

## 2. Clean Architecture Layers

Each feature follows:
```
features/<feature_name>/
├── domain/                      # Business logic (pure Dart)
│   ├── entities/               # Core business objects
│   ├── repositories/           # Abstract interfaces
│   └── services/               # Domain services
├── data/                       # Data access
│   ├── models/                 # DB/JSON representations
│   ├── datasources/            # Local/Remote data access
│   └── repositories/           # Interface implementations
└── presentation/               # UI
    ├── providers/              # Riverpod state management
    ├── pages/                  # Screen widgets
    └── widgets/                # Reusable UI components
```

---

## 3. File Naming Convention

**Strict pattern:** `[feature]_[type].dart`

| Type | Example | Purpose |
|------|---------|---------|
| Entity | `phieu_chi.dart` | Business object |
| Model | `phieu_chi_model.dart` | Data transfer |
| Repository | `phieu_chi_repository.dart` | Interface |
| Repository Impl | `phieu_chi_repository_impl.dart` | Implementation |
| Datasource | `phieu_chi_local_datasource.dart` | DB access |
| Provider | `phieu_chi_provider.dart` | State management |
| Page | `phieu_chi_page.dart` | Screen |
| Widget | `phieu_chi_list_item.dart` | UI component |
| Widget | `phieu_chi_form_dialog.dart` | Form dialog |
| Service | `tinh_gia_xuat_kho_service.dart` | Business service |

---

## 4. Entity Template

```dart
// Domain Layer - Entity
import 'package:equatable/equatable.dart';

class PhieuChi extends Equatable {
  final String id;
  final String soPhieu;
  // ... fields

  const PhieuChi({
    required this.id,
    required this.soPhieu,
    // ... required params
  });

  int get tongTien => /* computed */;

  PhieuChi copyWith({
    String? id,
    // ... optional params
  }) {
    return PhieuChi(
      id: id ?? this.id,
      // ...
    );
  }

  @override
  List<Object?> get props => [id, soPhieu, /* ... */];
}
```

---

## 5. Repository Interface Template

```dart
// Domain Layer - Repository
import 'package:dartz/dartz.dart';
import 'package:hkd_accounting/core/error/failures.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_chi.dart';

abstract class PhieuChiRepository {
  Future<Either<Failure, PhieuChi>> createPhieuChi(PhieuChi phieuChi);
  Future<Either<Failure, PhieuChi?>> getPhieuChiById(String id);
  Future<Either<Failure, List<PhieuChi>>> getPhieuChiList();
  Future<Either<Failure, void>> updatePhieuChi(PhieuChi phieuChi);
  Future<Either<Failure, void>> deletePhieuChi(String id);
}
```

---

## 6. Model Template

```dart
// Data Layer - Model
import 'package:hkd_accounting/features/ct/domain/entities/phieu_chi.dart';

class PhieuChiModel extends PhieuChi {
  const PhieuChiModel({/* super fields */});

  factory PhieuChiModel.fromEntity(PhieuChi entity) {
    return PhieuChiModel(/* map from entity */);
  }

  factory PhieuChiModel.fromMap(Map<String, dynamic> map) {
    return PhieuChiModel(/* map from DB */);
  }

  Map<String, dynamic> toMap() {
    return {/* to DB */};
  }

  PhieuChi toEntity() => PhieuChi(/* from model */);
}
```

---

## 7. Datasource Template

```dart
// Data Layer - Local Datasource
import 'package:sqflite/sqflite.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_chi.dart';
import 'package:hkd_accounting/features/ct/data/models/phieu_chi_model.dart';

abstract class PhieuChiLocalDatasource {
  Future<PhieuChiModel?> getPhieuChiById(String id);
  Future<List<PhieuChiModel>> getPhieuChiList();
  Future<String> savePhieuChi(PhieuChiModel model);
  Future<void> updatePhieuChi(PhieuChiModel model);
  Future<void> deletePhieuChi(String id);
}

class PhieuChiLocalDatasourceImpl implements PhieuChiLocalDatasource {
  final Database _database;
  // ... implementation
}
```

---

## 8. Provider Template

```dart
// Presentation Layer - Provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_chi.dart';
import 'package:hkd_accounting/features/ct/domain/repositories/phieu_chi_repository.dart';

class PhieuChiNotifier extends StateNotifier<AsyncValue<List<PhieuChi>>> {
  final PhieuChiRepository repository;

  PhieuChiNotifier() 
      : repository = GetIt.instance.get<PhieuChiRepository>(),
        super(const AsyncValue.loading()) {
    loadPhieuChiList();
  }

  Future<void> loadPhieuChiList() async {
    state = const AsyncValue.loading();
    final result = await repository.getPhieuChiList();
    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (err) => AsyncValue.error(err, StackTrace.current),
    );
  }

  // ... CRUD methods
}

final phieuChiProvider = StateNotifierProvider<
    PhieuChiNotifier, AsyncValue<List<PhieuChi>>>((ref) {
  return PhieuChiNotifier();
});
```

---

## 9. Page Template

```dart
// Presentation Layer - Page
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
import 'package:hkd_accounting/features/ct/presentation/providers/phieu_chi_provider.dart';
import 'package:hkd_accounting/features/ct/presentation/widgets/phieu_chi_list_item.dart';

class PhieuChiPage extends ConsumerWidget {
  const PhieuChiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      title: 'Phiếu chi',
      floatingActionButton: FloatingActionButton(
        onPressed: () { /* show form dialog */ },
        child: const Icon(Icons.add),
      ),
      body: ref.watch(phieuChiProvider).when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Lỗi: $e')),
        data: (list) => ListView.builder(
          itemCount: list.length,
          itemBuilder: (ctx, i) => PhieuChiListItem(phieuChi: list[i]),
        ),
      ),
    );
  }
}
```

---

## 10. Adding New Feature (Checklist)

### Step 1: Create Domain Layer
- [ ] Create `entities/<feature>.dart`
- [ ] Create `repositories/<feature>_repository.dart`

### Step 2: Create Data Layer
- [ ] Create `models/<feature>_model.dart`
- [ ] Create `datasources/<feature>_local_datasource.dart`
- [ ] Create `repositories/<feature>_repository_impl.dart`

### Step 3: Create Presentation Layer
- [ ] Create `providers/<feature>_provider.dart`
- [ ] Create `pages/<feature>_page.dart`
- [ ] Create `widgets/<feature>_list_item.dart`
- [ ] Create `widgets/<feature>_form_dialog.dart` (if needed)

### Step 4: Register in main.dart
- [ ] Add imports
- [ ] Add table creation in `_initializeDatabase()`
- [ ] Add datasource registration
- [ ] Add repository registration

### Step 5: Update Documentation
- [ ] Update IMPLEMENTATION_ROADMAP.md
- [ ] Update PERFORMANCE_GAP_ANALYSIS.md

---

## 11. Key Patterns

### Error Handling
Always use `Either<Failure, Success>` from dartz:
```dart
Future<Either<Failure, PhieuChi>> createPhieuChi(PhieuChi phieuChi) async {
  try {
    final id = await datasource.savePhieuChi(...);
    return Right(created);
  } catch (e) {
    return Left(DatabaseFailure(e.toString()));
  }
}
```

### State Management
- Use `StateNotifierProvider` for mutable lists
- Use `StateProvider` for selections
- Always handle `AsyncValue` states (loading, error, data)

### Navigation
- Use `showDialog()` for forms
- Use named routes in `main_page.dart` for screens

---

## 12. Database Convention

Tables use snake_case:
```sql
CREATE TABLE phieu_chi (
  id TEXT PRIMARY KEY,
  so_phieu TEXT NOT NULL,
  ngay_lap TEXT NOT NULL,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);
```

Models use camelCase:
```dart
class PhieuChiModel {
  String get soPhieu => map['so_phieu'];
  Map<String, dynamic> toMap() => {'so_phieu': soPhieu};
}
```

---

## 13. Import Paths

Always use package-relative imports:
```dart
import 'package:hkd_accounting/features/ct/domain/entities/phieu_chi.dart';
import 'package:hkd_accounting/core/widgets/custom_scaffold.dart';
```

---

## 14. Testing

Before implementing, create test file:
```dart
// test/domain/phieu_chi_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:hkd_accounting/features/ct/domain/entities/phieu_chi.dart';

void main() {
  group('PhieuChi', () {
    test('should calculate tongTien correctly', () {
      final phieuChi = PhieuChi(/* ... */);
      expect(phieuChi.tongTien, equals(100000));
    });
  });
}
```

---

## 15. Commands

```bash
flutter pub get              # Install dependencies
flutter analyze             # Check errors
flutter format .            # Format code
flutter test                # Run tests
flutter test test/xxx_test.dart  # Run specific test
```

---

## 16. Quick Reference

| Feature | Code | Status |
|---------|------|--------|
| Master Data | MD-0X | In progress |
| Chứng từ | CT-0X | In progress |
| Quỹ/Tiền | TT-0X | In progress |
| Kho hàng | KH-0X | In progress |
| Sổ kế toán | SK-0X | Pending |
| Thuế | TX-0X | Pending |
| Nhân sự | NS-0X | Pending |
| Quản trị | QT-0X | Pending |
