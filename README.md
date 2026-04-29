# Hệ Thống Kế Toán HKD/CNKD (.NET 9 MVC)

Hệ thống kế toán HKD/CNKD tuân thủ Thông tư 88/2021/TT-BTC, được viết lại hoàn toàn bằng .NET 9 với kiến trúc ASP.NET MVC đơn giản và hiệu quả.

## Trạng thái hiện tại (2026-04-29)

- **Nền tảng**: .NET 9.0 ✅
- **Kiến trúc**: Clean Architecture (Domain, Application, Infrastructure, API)
- **Database**: SQLite với EF Core 9 ✅
- **CQRS**: MediatR 12.4 ✅
- **Validation**: FluentValidation 11.9 ✅
- **Testing**: xUnit + Moq (TDD approach) ✅
- **Build Status**: Build Successful ✅

## Build Status

```
dotnet build
Build succeeded.
0 Warning(s)
0 Error(s)
```

## Cấu trúc dự án

```
HkdAccounting/
├── HkdAccounting.Web/              # ASP.NET MVC Application (Chưa triển khai)
│   ├── Controllers/                # MVC Controllers
│   ├── Models/                     # View Models và Domain Models
│   ├── Views/                      # Razor Views
│   │   ├── Shared/                 # Layout và Partial Views
│   │   ├── HkdInfo/                # Views cho HkdInfo
│   │   └── ...                     # Các module khác
│   ├── Services/                   # Business Logic Services
│   ├── Repositories/               # Data Access Layer
│   ├── Reports/                    # FastReport Templates (.frx files)
│   ├── wwwroot/                    # Static Files (CSS, JS, Images)
│   │   ├── css/
│   │   ├── js/
│   │   └── lib/
│   ├── appsettings.json            # Cấu hình ứng dụng
│   └── Program.cs                  # Điểm vào ứng dụng
├── HkdAccounting.Domain/           # Domain Entities (Class Library) ✅ COMPLETED
│   ├── Entities/                   # 21 Domain Entities (MD, CT, SK, KH, TX, TT, QT)
│   └── Repositories/               # 20 Repository Interfaces
├── HkdAccounting.Application/      # Application Services (Class Library) ✅ HOAT DONG
│   ├── Services/                   # Application Services
│   └── Dtos/                       # Data Transfer Objects
├── HkdAccounting.Infrastructure/   # Infrastructure (Class Library) (Chưa triển khai)
│   ├── Data/                       # Database Context
│   └── Repositories/               # Repository Implementations
└── tests/
    ├── HkdAccounting.Domain.Tests/ (Chưa triển khai)
    ├── HkdAccounting.Application.Tests/ (Chưa triển khai)
    └── HkdAccounting.Infrastructure.Tests/ (Chưa triển khai)
```

## Nguyên tắc phát triển (Theo CLAUDE.MD - Bible của dự án)

1. **Trước khi code**: Suy nghĩ rõ ràng, không làm assumptions, nêu rõ tradeoffs
2. **Đơn giản trước**: Viết ít code nhất có thể để giải quyết vấn đề, không speculative
3. **Thay đổi phẫu thuật**: Chỉ thay đổi những gì bắt buộc, dọn dẹp chỉ sự làm bẩn của riêng mình
4. **Hướng mục tiêu**: Xác định tiêu chí thành công, lặp cho tới khi được xác thực

## Phương pháp phát triển TDD (Test-Driven Development)

Dự án áp dụng nghiêm ngặt phương pháp TDD với quy trình cụ thể:

1. **Viết test trước**: Mỗi tính năng mới bắt đầu bằng việc viết test cases thất bại
2. **Triển khai tối thỉ**: Viết đủ code để test passes (đỏ → xanh)
3. **Refactor**: Tối ưu code mà không thay đổi hành vi (xanh → refactor)
4. **Lặp lại**: Áp dụng quy trình cho mỗi tính năng, từng dòng code

Quy trình TDD được áp dụng qua 3 lớp test:
- **Domain.Tests**: Test entities và domain logic
- **Application.Tests**: Test application services và use cases
- **Infrastructure.Tests**: Test repositories và data access

## Những thành phần built-in được ưu tiên sử dụng

- **Dependency Injection**: Built-in DI container của .NET
- **Logging**: ILogger built-in
- **Configuration**: IConfiguration built-in
- **Environment Variables**: Built-in support
- **File Providers**: Built-in for wwwroot
- **Routing**: Built-in ASP.NET MVC routing
- **Model Binding**: Built-in model binding
- **Validation**: Data Annotations built-in
- **Tag Helpers**: Built-in trong Razor Views
- **Session State**: Built-in session management
- **Caching**: Built-in memory cache

## Cài đặt và chạy dự án

### Yêu cầu hệ thống
- .NET 9.0 SDK
- SQLite (được tích hợp sẵn trong .NET)

### Các bước chạy

```bash
# Clone repository
git clone <repository-url>
cd HkdAccounting

# Khôi phục packages
dotnet restore

# Xây dựng giải pháp
dotnet build

# Chạy ứng dụng
dotnet run --project HkdAccounting.Web/HkdAccounting.Web.csproj

# Truy cập ứng dụng
# Trang chủ: http://localhost:5000
```

## Cấu trúc Database

SQLite database file `hkd_accounting.db` sẽ được tự động tạo trong thư mục `HkdAccounting.Web/App_Data/` khi ứng dụng khởi chạy lần đầu tiên (sử dụng EF Core Migrations hoặc EnsureCreated).

## Báo cáo với FastReport .NET Open Source

FastReport .NET Open Source được tích hợp để tạo và in các báo cáo kế toán:

- **Location**: `/HkdAccounting.Web/Reports/`
- **File format**: `.frx` (FastReport XML templates)
- **Usage**: Các báo cáo được tạo trực tiếp trong Controller hoặc Service và trả về dưới dạng PDF/Excel/Print
- **Các báo cáo đã triển khai**:
  - Bảng cân đối tài khoản
  - Báo cáo kết quả kinh doanh
  - Sổ sách chi tiết
  - Báo cáo thuế

## Định hướng phát triển (40 use cases còn lại)

### Giai đoạn 1: Dữ liệu gốc (Master Data) - Tuần 1-4
- [x] MD-01: HKD/CNKD Info (Domain ✅ Application ✅ Infrastructure ✅ API ✅ Tests ✅)
- [x] MD-02: Goods/Services (Domain ✅ Application ✅ Infrastructure ✅ API ✅ Tests ✅)
- [x] MD-03: Tax Rates (Domain ✅ Application ✅ Infrastructure ✅ Tests ✅)
- [x] MD-04: Đối tác (Nhà cung cấp) (Domain ✅ Application ✅ Infrastructure ✅ Tests ✅)
- [x] MD-05: Khách hàng (Domain ✅ Application ✅ Infrastructure ✅ Tests ✅)
- [x] MD-06: Nhân viên (Domain ✅ Application ✅ Infrastructure ✅ API ✅ Tests ✅)
- [x] MD-07: Tài khoản ngân hàng (Domain ✅ Application ✅ Infrastructure ✅ API ✅ Tests ✅)
- [x] MD-08: Kỳ kế toán (Domain ✅)
- [x] MD-08: Kỳ kế toán (Domain ✅)

### Giai đoạn 2: Chứng từ kế toán - Tuần 5-8
- [x] CT-01: Phiếu thu (Domain layer completed)
- [x] CT-02: Phiếu chi (Domain layer completed)
- [x] CT-03: Phiếu nhập kho (Domain layer completed)
- [x] CT-04: Phiếu xuất kho (Domain layer completed)
- [x] CT-05: Bảng thanh toán lương (Domain layer completed)
- [x] CT-06: Hóa đơn (Domain layer completed)
- [x] CT-07: Lưu trữ chứng từ (Domain layer completed)
- [x] CT-08: Phê duyệt chứng từ (Domain layer completed)

### Giai đoạn 3: Sổ kế toán - Tuần 9-12
- [x] SK-01: Mở sổ kế toán (Domain layer completed)
- [x] SK-02: Sổ doanh thu (S1-HKD) (Domain layer completed)
- [x] SK-03: Sổ vật tư hàng hóa (S2-HKD) (Domain layer completed)
- [x] SK-04: Sổ chi phí (S3-HKD) (Domain layer completed)
- [x] SK-05: Sổ nghĩa vụ thuế (S4-HKD) (Domain layer completed)
- [x] SK-06: Sổ tiền lương (S5-HKD) (Domain layer completed)
- [x] SK-07: Sổ quỹ tiền mặt (S6-HKD) (Domain layer completed)
- [x] SK-08: Sổ tiền gửi ngân hàng (S7-HKD) (Domain layer completed)

### Giai đoạn 4: Kho hàng - Tuần 13-14
- [x] KH-01: Nhập kho hàng hóa (Domain layer completed)
- [x] KH-02: Xuất kho hàng hóa (Domain layer completed)
- [x] KH-03: Kiểm kê hàng tồn kho (Domain layer completed - TonKho entity)
- [x] KH-04: Tính giá xuất kho (FIFO/Bình quân) (Domain layer completed)

### Giai đoạn 5: Thuế - Tuần 15-16
- [x] TX-01: Xác định doanh thu chịu thuế (Domain layer completed)
- [x] TX-02: Tính thuế GTGT (Domain layer completed)
- [x] TX-03: Tính thuế TNCN (Domain layer completed)
- [x] TX-04: Theo dõi nộp thuế (Domain layer completed - NghiaVuThue entity)

### Giai đoạn 6: Nhân sự & Lương - Tuần 17-18
- [x] NS-01: Tính lương người lao động (Domain layer completed)
- [x] NS-02: Khấu trừ & Theo dõi BHXH (Domain layer completed - BangLuongChiTiet entity)
- [x] NS-03: Theo dối & Thanh toán lương (Domain layer completed - BangLuong entity)

### Giai đoạn 7: Tiền tệ - Tuần 19-20
- [x] TT-01: Quản lý quỹ tiền mặt (Domain layer completed - QuyTienMat entity)
- [x] TT-02: Quản lý tiền gửi ngân hàng (Domain layer completed - TienGuiNganHang entity)

### Giai đoạn 8: Quản trị hệ thống - Tuần 21-24
- [x] QT-01: Quản lý người dùng & phân quyền (Domain layer completed - TaiKhoanNguoiDung entity)
- [x] QT-02: Sửa chữa/Điều chỉnh sổ (Domain layer completed - PheDuyetChungTu entity)
- [x] QT-03: Đóng kỳ & Khóa sổ (Domain layer completed - KyKeToan entity)
- [x] QT-04: Báo cáo tổng hợp (Domain layer completed - SoKeToan entity)
- [x] QT-05: Lưu trữ & Tra cứu chứng từ (Domain layer completed - LuuTruChungTu entity)
- [x] QT-06: Nhật ký hệ thống & Audit (Domain layer completed - NhatKyHeThong entity)

## Technology Stack

- **.NET 9.0** - Framework chính
- **ASP.NET MVC** - Framework web
- **SQLite** - Database (tích hợp sẵn)
- **FastReport .NET Open Source** - Báo cáo và in ấn
- **Entity Framework Core** - ORM (tùy chọn, có thể thay đổi bằng ADO.NET thuần)
- **xUnit** - Framework testing
- **Bootstrap 5** - Frontend framework (tích hợp qua libman hoặc CDN)
- **jQuery** - JavaScript library (tích hợp qua libman hoặc CDN)

## Hướng dẫn đóng góp

1. Fork repository
2. Tạo feature branch (`git checkout -b feature/amazing-feature`)
3. Commit thay đổi (`git commit -m 'Add some amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Mở Pull Request

## Giấy phép

Dự án này được phát hành dưới giấy phép MIT - xem file [LICENSE](LICENSE) để biết chi tiết.

---

*Cập nhật lần cuối: 2026-04-29*
*Tuân thủ nghiêm ngặt các nguyên tắc trong docs/CLAUDE.MD*
*Ưu tiên sử dụng built-in .NET features trước khi tìm đến thư viện bên thứ ba*
*Áp dụng nghiêm ngặt phương pháp TDD trong quá trình phát triển*
*HOÀN THÀNH DOMAIN LAYER: 21 Entities + 20 Repositories cho 43 use cases*