# HKD Accounting System (Hệ thống Kế toán HKD/CNKD)

A Flutter-based accounting application for Household Businesses (HKD) and Individual Business (CNKD) in Vietnam, following Thông tư 88/2021/TT-BTC.

## Overview

- **Target Users**: Small household businesses and individual entrepreneurs in Vietnam
- **Platform**: Mobile (Android/iOS), Desktop (Windows/Linux/macOS)
- **Architecture**: Clean Architecture with Riverpod state management

## Current Status

| Metric | Status |
|--------|--------|
| Use Cases Implemented | 34/43 (79%) |
| Database Tables | 27 |
| Flutter Build | ⚠️ ~583 analysis errors (need fixing) |

## Quick Start

### Prerequisites
- Flutter SDK 3.x
- Dart SDK 3.x
- Android SDK (for mobile)
- Linux development libraries (for Linux desktop)

### Setup

```bash
# Clone the repository
git clone https://github.com/vqton/acct_tt88_HKD.git
cd acct_tt88

# Install dependencies
flutter pub get

# Run Flutter analyze to check for errors
flutter analyze

# Run the app
flutter run
```

### Using Pre-installed Flutter (Linux/WSL)

If Flutter is not in PATH, use the pre-installed version:

```bash
# Run analyze
/tmp/flutter/bin/flutter analyze

# Build debug APK
/tmp/flutter/bin/flutter build apk --debug
```

## Project Structure

```
lib/
├── main.dart                    # Entry point, DI setup, DB init
├── main_page.dart               # Navigation shell
├── core/
│   ├── error/                   # Failures, exceptions
│   ├── usecases/                # Base UseCase class
│   └── widgets/                 # Shared widgets (CustomScaffold)
└── features/
    ├── master_data/             # MD-01 to MD-08 (9 UCs)
    ├── ct/                      # CT-01 to CT-08 (8 UCs) - Chứng từ
    ├── tt/                      # TT-01, TT-02 - Quỹ/Tiền
    ├── kh/                      # KH-01 to KH-04 - Kho
    ├── sk/                      # SK-01 to SK-08 - Sổ
    ├── tx/                      # TX-01 to TX-04 - Thuế
    ├── ns/                      # NS-01 to NS-03 - Nhân sự
    └── qt/                      # QT-01 to QT-06 - Quản trị
```

## Implemented Features

### ✅ Complete (34 UCs)
- **Master Data**: MD-01→MD-08, QT-01
- **Vouchers**: CT-01 (Phiếu thu), CT-03, CT-04, CT-06, CT-07, CT-08
- **Warehouse**: KH-01→KH-04
- **Accounting Books**: SK-01, SK-02, SK-03, SK-04, SK-05, SK-07, SK-08
- **Funds**: TT-01, TT-02
- **Tax**: TX-01→TX-04
- **Admin**: QT-05

### ❌ Not Implemented (9 UCs)
- CT-02 (Phiếu chi) - Partial
- CT-05 (Bảng lương)
- NS-01, NS-02, NS-03 (Nhân sự/Lương)
- SK-06 (Sổ lương)
- QT-02, QT-03, QT-04, QT-06

## Known Issues

### Flutter Analysis Errors (~583 errors)

The project currently has analysis errors. Common issues and fixes are documented in IMPLEMENTATION_ROADMAP.md.

**Common Fixes:**

1. **Missing dartz imports:**
```dart
import 'package:dartz/dartz.dart';
```

2. **Missing Failure class:**
```dart
import 'package:hkd_accounting/core/error/failures.dart';
```

3. **Entity constructor issues:** Don't use `assert` in `const` constructors

### Key Dependencies

- `flutter_riverpod: ^2.4.0` - State management
- `get_it: ^7.6.0` - Dependency injection
- `sqflite: ^2.3.0` - SQLite database
- `dartz: ^0.10.1` - Functional programming (Either type)
- `equatable: ^2.0.5` - Value equality
- `path_provider: ^2.1.0` - File system paths

## Documentation

- `IMPLEMENTATION_ROADMAP.md` - Full implementation plan with status
- `PERFORMANCE_GAP_ANALYSIS.md` - Gap analysis and recommendations
- `docs/UC_HKD_TT88_2021.md` - Use case specifications
- `docs/SDD_HKD_TT88_2021.md` - System design document

## Development Guidelines

### Architecture Layers (in order)

1. **Domain** - Entities, Repository interfaces, Use cases
2. **Data** - Models, Datasources, Repository implementations
3. **Presentation** - Providers, Pages, Widgets

### File Naming Convention

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

### Key Patterns

**Entity with Equatable:**
```dart
class PhieuChi extends Equatable {
  final String id;
  final int soTien;
  
  const PhieuChi({required this.id, required this.soTien});
  
  @override
  List<Object?> get props => [id, soTien];
}
```

**Repository with Either:**
```dart
abstract class PhieuChiRepository {
  Future<Either<Failure, PhieuChi>> create(PhieuChi entity);
}
```

**Provider with StateNotifier:**
```dart
final phieuChiProvider = StateNotifierProvider<PhieuChiNotifier, PhieuChiState>((ref) {
  return PhieuChiNotifier();
});
```

## License

This project is for educational and internal use purposes.

---

*For questions or contributions, please contact the development team.*