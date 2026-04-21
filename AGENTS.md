# OpenCode Agent Guidelines for HKD Accounting

## Essential Commands
- `flutter pub get` – install dependencies (always first after checkout)
- `flutter test` – run all unit tests
- `flutter test test/<feature>/domain/<entity>_test.dart` – test specific entity
- `flutter analyze` – lint and type check
- `flutter format .` – apply project formatting
- `flutter pub run build_runner build --delete-conflicting-outputs` – generate providers/models
- `flutter pub run build_runner watch` – auto-regenerate during dev

## Architecture Essentials
- **Clean Architecture**: Domain → Data → Presentation layers in each feature
- **State Management**: Riverpod (StateNotifierProvider for lists, StateProvider for selections)
- **DI**: GetIt via `setupDependencies()` in main.dart (registerLazySingleton)
- **Database**: SQLite via sqflite; table schemas in *_local_datasource.dart `_onCreate()
- **Error Handling**: Always Either<Failure, Success> from dartz
- **Entities**: Extend Equatable, implement copyWith() and props
- **Models**: Bidirectional conversion (fromEntity/toEntity, fromMap/toMap)

## Critical Conventions
- **Tests First**: TDD required - create *_test.dart before implementation
- **File Naming**: Strictly follow `[feature]_[type].dart` (e.g., phieu_chi_repository.dart)
- **Providers**: Always use `ref.read(provider.notifier)` for mutations, `ref.watch(provider)` for state
- **Pages**: ConsumerWidget with ref.watch() for async data loading states
- **Widgets**: Reusable dialogs (_form_dialog.dart) and list items (_list_item.dart)
- **Imports**: Use feature-relative paths (e.g., `package:hkd_accounting/features/...`)

## Generated Code Workflow
1. Add Riverpod annotator (`@riverpod`) or Injectable (`@singleton`)
2. Run `flutter pub run build_runner build --delete-conflicting-outputs`
3. Import generated files as `*.g.dart`
4. For watch mode during dev: `flutter pub run build_runner watch`

## Verification Sequence
1. `flutter analyze` – zero errors/warnings
2. `flutter test` – all tests pass
3. Manual UI verification on device/emulator for feature work

## Key Reference Files
- `IMPLEMENTATION_ROADMAP.md` – current sprint progress and milestones
- `docs/CODE_QUALITY.md` – mandatory code standards
- `lib/main.dart` – app entrypoint and dependency setup
- Any `*_local_datasource.dart` – table schema source of truth

## Common Gotchas
- Forgetting to run build_runner after adding annotations causes "not found" errors
- Missing Either<Failure, Success> wrapper in repository methods
- Using StateProvider instead of StateNotifierProvider for mutable lists
- Not updating `_onCreate()` in database helpers when modifying models
- Forgetting to add new datasources/repositories to main.dart setupDependencies()