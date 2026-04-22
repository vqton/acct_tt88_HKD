# OpenCode Agent Guidelines for HKD Accounting

## Quick Start
1. Read `IMPLEMENTATION_ROADMAP.md` to see what's pending
2. Check `FEATURE_GUIDE.md` for implementation patterns
3. Implement using: Entity → Repository → Model → Datasource → Provider → UI
4. Update docs and commit

## Essential Commands
```bash
flutter pub get           # Install dependencies
flutter analyze          # Check errors (run after every change)
flutter test             # Run all tests
flutter format .         # Format code
```

## Architecture Overview
```
lib/
├── main.dart            # Entry, DI, DB tables
├── main_page.dart       # Navigation shell
├── core/               # Shared (failures, widgets)
└── features/           # Business modules
    ├── master_data/    # MD-01 to MD-08
    ├── ct/             # CT-01 to CT-08 (Chứng từ)
    ├── tt/             # TT-01, TT-02 (Quỹ/Tiền)
    ├── kh/             # KH-01 to KH-04 (Kho)
    ├── sk/             # SK-01 to SK-08 (Sổ)
    ├── tx/             # TX-01 to TX-04 (Thuế)
    ├── ns/             # NS-01 to NS-03 (Nhân sự)
    └── qt/             # QT-01 to QT-06 (Quản trị)
```

## Layer Order (Core to Edge)

### 1. Domain Layer (Business Logic)
```dart
// features/<feature>/domain/entities/<name>.dart
// features/<feature>/domain/repositories/<name>_repository.dart
// features/<feature>/domain/services/<name>_service.dart
```
- Pure Dart, no Flutter dependencies
- Entities extend Equatable with copyWith()
- Repository interfaces return Either<Failure, T>

### 2. Data Layer (Data Access)
```dart
// features/<feature>/data/models/<name>_model.dart
// features/<feature>/data/datasources/<name>_local_datasource.dart
// features/<feature>/data/repositories/<name>_repository_impl.dart
```
- Models extend Entity, add fromEntity/toEntity/fromMap/toMap
- Datasources use sqflite for SQLite operations
- Repository impl wraps datasource with Either return

### 3. Presentation Layer (UI)
```dart
// features/<feature>/presentation/providers/<name>_provider.dart
// features/<feature>/presentation/pages/<name>_page.dart
// features/<feature>/presentation/widgets/<name>_list_item.dart
// features/<feature>/presentation/widgets/<name>_form_dialog.dart
```
- Providers: StateNotifierProvider for lists
- Pages: ConsumerWidget with ref.watch()
- Widgets: Reusable components

## File Naming Convention
**Strict:** `[feature]_[type].dart`

| Type | Example |
|------|---------|
| Entity | `phieu_chi.dart` |
| Model | `phieu_chi_model.dart` |
| Repository | `phieu_chi_repository.dart` |
| Repository Impl | `phieu_chi_repository_impl.dart` |
| Datasource | `phieu_chi_local_datasource.dart` |
| Provider | `phieu_chi_provider.dart` |
| Page | `phieu_chi_page.dart` |
| Widget | `phieu_chi_list_item.dart` |
| Dialog | `phieu_chi_form_dialog.dart` |

## Implementation Checklist

When implementing a new UC (e.g., CT-05):

1. **Domain** (2 files)
   - [ ] `entities/phieu_chi.dart`
   - [ ] `repositories/phieu_chi_repository.dart`

2. **Data** (3 files)
   - [ ] `models/phieu_chi_model.dart`
   - [ ] `datasources/phieu_chi_local_datasource.dart`
   - [ ] `repositories/phieu_chi_repository_impl.dart`

3. **Presentation** (3-4 files)
   - [ ] `providers/phieu_chi_provider.dart`
   - [ ] `pages/phieu_chi_page.dart`
   - [ ] `widgets/phieu_chi_list_item.dart`
   - [ ] `widgets/phieu_chi_form_dialog.dart` (if CRUD)

4. **main.dart** (3 updates)
   - [ ] Add imports
   - [ ] Add table in `_initializeDatabase()`
   - [ ] Register datasource + repository in `setupDependencies()`

5. **Documentation** (2 updates)
   - [ ] Update IMPLEMENTATION_ROADMAP.md (status column)
   - [ ] Update PERFORMANCE_GAP_ANALYSIS.md

## Key Patterns

### Entity with Computed Field
```dart
class PhieuChi extends Equatable {
  final String id;
  final List<ChiTiet> chiTietList;

  int get tongTien => chiTietList.fold(0, (sum, i) => sum + i.thanhTien);

  @override
  List<Object?> get props => [id, chiTietList];
}
```

### Repository with Error Handling
```dart
@override
Future<Either<Failure, PhieuChi>> create(PhieuChi entity) async {
  try {
    final id = await ds.save(PhieuChiModel.fromEntity(entity));
    final result = await ds.getById(id);
    return Right(result.toEntity());
  } catch (e) {
    return Left(DatabaseFailure(e.toString()));
  }
}
```

### Provider with AsyncValue
```dart
class PhieuChiNotifier extends StateNotifier<AsyncValue<List<PhieuChi>>> {
  PhieuChiNotifier() : super(const AsyncValue.loading()) {
    load();
  }

  Future<void> load() async {
    state = const AsyncValue.loading();
    final result = await repo.getList();
    state = result.when(
      success: (data) => AsyncValue.data(data),
      failure: (e) => AsyncValue.error(e, StackTrace.current),
    );
  }
}
```

### UI with ref.watch
```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  return ref.watch(provider).when(
    loading: () => CircularProgressIndicator(),
    error: (e, _) => Text('Lỗi: $e'),
    data: (list) => ListView.builder(
      itemCount: list.length,
      itemBuilder: (_, i) => ListItem(item: list[i]),
    ),
  );
}
```

## Common Gotchas
1. **Missing Either wrapper** - All repository methods must return Either<Failure, T>
2. **StateProvider vs StateNotifierProvider** - Use StateNotifierProvider for lists
3. **main.dart not updated** - Forgot datasource/repository registration
4. **DB table not created** - Forgot table in _initializeDatabase()
5. **Imports** - Use `package:hkd_accounting/features/...`

## Key Reference Files
| File | Purpose |
|------|---------|
| `FEATURE_GUIDE.md` | Full implementation templates |
| `IMPLEMENTATION_ROADMAP.md` | What to implement next |
| `PERFORMANCE_GAP_ANALYSIS.md` | Progress tracking |
| `lib/main.dart` | DI & DB setup |
| `lib/main_page.dart` | Navigation & routing |
| `docs/UC_HKD_TT88_2021.md` | Business requirements |

## Completed UCs (27/43 - 63%)
- **Sprint 0**: MD-01→MD-08, QT-01 ✅
- **Sprint 1**: CT-01, CT-02, CT-08, TT-01, TT-02, SK-07, SK-08 ✅
- **Sprint 2**: CT-03, CT-04, KH-01→KH-04, SK-03 ✅
- **Sprint 3**: CT-06, CT-07, SK-01, SK-02, SK-04 ✅