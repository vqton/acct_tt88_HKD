# Hệ thống Kế toán HKD/CNKD - Lộ Trình Triển Khai và Kế Hoạch Thực Thi

## Tóm Tắt
Dựa trên phân tích toàn diện tài liệu thiết kế hệ thống (SDD_HKD_TT88_2021.md), danh sách use cases (UC_HKD_TT88_2021.md), và tiêu chuẩn chất lượng mã nguồn (CODE_QUALITY.md), cùng với việc đánh giá mã nguồn hiện tại, tài liệu này cung cấp lộ trình triển khai chi tiết và kế hoạch thực thi cho dự án.

## Trạng Thái Hiện Tại
- **Mã nguồn đã triển khai**: Chỉ có 5 file Dart liên quan đến Master Data - MD-01 (Quản lý thông tin HKD/CNKD)
- **Cơ sở dữ liệu**: Đã thiết kế bảng hkd_info với các trường cơ bản
- **Kiến trúc**: Sử dụng Clean Architecture với Riverpod để quản lý trạng thái
- **Thư viện chính**: Flutter, Riverpod, Sqflite, GetIt/Injectable

## Lộ Trình Triển Khai Đề Xuất (18 Tuần)

### Sprint 0 - Nền tảng (Tuần 1-2)
**Mục tiêu**: Thiết lập toàn bộ master data trước khi vận hành

| STT | UC | Tên Use Case | Mô tả ngắn |
|-----|----|--------------|------------|
| 1 | MD-01 | Quản lý thông tin HKD/CNKD | Đã triển khai phần cơ bản |
| 2 | MD-03 | Quản lý danh mục ngành nghề & thuế suất | Cần triển khai |
| 3 | MD-08 | Cấu hình kỳ kế toán | Cần triển khai |
| 4 | MD-02 | Quản lý danh mục hàng hóa/dịch vụ | Cần triển khai |
| 5 | MD-04 | Quản lý danh mục nhà cung cấp | Cần triển khai |
| 6 | MD-05 | Quản lý danh mục khách hàng | Cần triển khai |
| 7 | MD-06 | Quản lý danh mục người lao động | Cần triển khai |
| 8 | MD-07 | Quản lý danh mục tài khoản ngân hàng | Cần triển khai |
| 9 | QT-01 | Quản lý danh mục tài khoản người dùng & phân quyền | Cần triển khai |

### Sprint 1 - Chứng từ & Quỹ (Tuần 3-5)
**Mục tiêu**: Xây dựng các chức năng chứng từ cơ bản và quản lý quỹ

| STT | UC | Tên Use Case | Mô tả ngắn |
|-----|----|--------------|------------|
| 10 | CT-08 | Phê duyệt chứng từ (ký duyệt) | Cần triển khai |
| 11 | CT-01 | Lập phiếu thu | Cần triển khai |
| 12 | CT-02 | Lập phiếu chi | Cần triển khai |
| 13 | SK-07 | Ghi sổ quỹ tiền mặt (S6-HKD) | Cần triển khai |
| 14 | TT-01 | Quản lý quỹ tiền mặt | Cần triển khai |
| 15 | SK-08 | Ghi sổ tiền gửi ngân hàng (S7-HKD) | Cần triển khai |
| 16 | TT-02 | Quản lý tiền gửi ngân hàng | Cần triển khai |

### Sprint 2 - Kho hàng (Tuần 6-8)
**Mục tiêu**: Triển khai các chức năng quản lý kho hàng và tồn kho

| STT | UC | Tên Use Case | Mô tả ngắn |
|-----|----|--------------|------------|
| 17 | CT-03 | Lập phiếu nhập kho | Cần triển khai |
| 18 | CT-04 | Lập phiếu xuất kho | Cần triển khai |
| 19 | KH-04 | Tính giá xuất kho (Bình quân / FIFO) | Cần triển khai |
| 20 | KH-01 | Nhập kho hàng hóa | Cần triển khai |
| 21 | KH-02 | Xuất kho hàng hóa | Cần triển khai |
| 22 | SK-03 | Ghi sổ chi tiết vật tư, hàng hóa (S2-HKD) | Cần triển khai |
| 23 | KH-03 | Kiểm kê hàng tồn kho | Cần triển khai |

### Sprint 3 - Doanh thu & Sổ Kế toán (Tuần 9-11)
**Mục tiêu**: Xây dựng các chức năng liên quan đến doanh thu và ghi sổ kế toán

| STT | UC | Tên Use Case | Mô tả ngắn |
|-----|----|--------------|------------|
| 24 | CT-06 | Quản lý hóa đơn (đầu vào & đầu ra) | Cần triển khai |
| 25 | SK-01 | Mở sổ kế toán đầu kỳ | Cần triển khai |
| 26 | SK-02 | Ghi sổ chi tiết doanh thu bán hàng/DV (S1-HKD) | Cần triển khai |
| 27 | SK-04 | Ghi sổ chi phí sản xuất kinh doanh (S3-HKD) | Cần triển khai |
| 28 | CT-07 | Lưu trữ chứng từ kế toán | Cần triển khai |
| 29 | QT-05 | Lưu trữ và tra cứu lịch sử chứng từ | Cần triển khai |

### Sprint 4 - Thuế (Tuần 12-13)
**Mục tiêu**: Triển khai các chức năng tính thuế và theo dõi nộp thuế

| STT | UC | Tên Use Case | Mô tả ngắn |
|-----|----|--------------|------------|
| 30 | TX-01 | Xác định doanh thu chịu thuế | Cần triển khai |
| 31 | TX-02 | Tính thuế giá trị gia tăng (GTGT) | Cần triển khai |
| 32 | TX-03 | Tính thuế thu nhập cá nhân (TNCN) | Cần triển khai |
| 33 | SK-05 | Ghi sổ theo dõi nghĩa vụ thuế với NSNN (S4-HKD) | Cần triển khai |
| 34 | TX-04 | Theo dõi nộp thuế vào NSNN | Cần triển khai |

### Sprint 5 - Nhân sự & Lương (Tuần 14-16)
**Mục tiêu**: Xây dựng các chức năng quản lý nhân sự và tiền lương

| STT | UC | Tên Use Case | Mô tả ngắn |
|-----|----|--------------|------------|
| 35 | NS-01 | Tính lương người lao động | Cần triển khai |
| 36 | NS-02 | Khấu trừ và theo dõi BHXH/BHYT/BHTN | Cần triển khai |
| 37 | CT-05 | Lập bảng thanh toán tiền lương & thu nhập NLĐ | Cần triển khai |
| 38 | NS-03 | Theo dõi và thanh toán lương | Cần triển khai |
| 39 | SK-06 | Ghi sổ theo dõi thanh toán tiền lương (S5-HKD) | Cần triển khai |

### Sprint 6 - Hoàn thiện (Tuần 17-18)
**Mục tiêu**: Triển khai các chức năng quản trị hệ thống và hoàn thiện sản phẩm

| STT | UC | Tên Use Case | Mô tả ngắn |
|-----|----|--------------|------------|
| 40 | QT-04 | Báo cáo tổng hợp cuối kỳ | Cần triển khai |
| 41 | QT-02 | Sửa chữa / điều chỉnh sổ kế toán | Cần triển khai |
| 42 | QT-03 | Đóng kỳ kế toán và khóa sổ | Cần triển khai |
| 43 | QT-06 | Nhật ký hệ thống và audit trail | Cần triển khai |

## Kế Hoạch Thực Thi Chi Tiết

### Nguyên tắc phát triển
1. **Tuân thủ Clean Architecture**: Tách biệt rõ ràng các lớp Domain, Data, Presentation
2. **Sử dụng Riverpod** để quản lý trạng thái ứng dụng
3. **Apply Dependency Injection** với GetIt/Injectable
4. **Tuân thủ TDD**: Viết tests trước khi triển khai chức năng
5. **Tuân thủ tiêu chuẩn chất lượng mã nguồn** đã định sẵn trong CODE_QUALITY.md

### Giai đoạn phát triển cho mỗi UC

#### Giai đoạn 1: Phân tích và thiết kế (1-2 ngày)
- Đọc và hiểu требования UC từ UC_HKD_TT88_2021.md
- Xác định entities, use cases, và interfaces cần thiết
- Thiết kế database schema nếu cần
- Xác định API endpoints nếu có tương tác với backend

#### Giai đoạn 2: Triển khai Domain Layer (2-3 ngày)
- Tạo entities trong `domain/entities/`
- Định nghĩa repository interfaces trong `domain/repositories/`
- Viết unit tests cho domain logic
- Áp dụng Either<Failure, Success> để xử lý lỗi

#### Giai đoạn 3: Triển khai Data Layer (2-3 ngày)
- Tạo models trong `data/models/` (nếu cần)
- Triển khai datasources (local/remote) trong `data/datasources/`
- Triển khai repository implementations trong `data/repositories/`
- Viết unit tests cho data layer
- Thiết lập database tables nếu sử dụng SQLite

#### Giai đoạn 4: Triển khai Presentation Layer (3-5 ngày)
- Tạo Riverpod providers cho state management
- Xây dựng UI components theo Material Design 3
- Áp dụng navigation và route management
- Viết widget tests cho components quan trọng
- Thêm error handling và loading states

#### Giai đoạn 5: Testing và refinement (1-2 ngày)
- Chạy unit tests và widget tests
- Thực hiện integration tests cho critical user flows
- Kiểm tra performance và tối ưu nếu cần
- Đảm bảo tuân thủ CODE_QUALITY.md
- Chuẩn bị documentation nếu cần

### Milestones và Kiểm tra tiến độ

| Milestone | Thời gian | Tiêu chí hoàn thành |
|-----------|-----------|-------------------|
| Hoàn thành Sprint 0 | Tuần 2 | Tất cả Master Data UC hoạt động, có thể tạo/cập nhật thông tin HKD |
| Hoàn thành Sprint 1 | Tuần 5 | Hoàn thành chức năng phiếu thu/chi, quản lý quỹ tiền mặt và ngân hàng |
| Hoàn thành Sprint 2 | Tuần 8 | Hoàn thành các chức năng kho hàng, nhập/xuất kho, tính giá xuất kho |
| Hoàn thành Sprint 3 | Tuần 11 | Hoàn thành các chức năng hóa đơn, sổ doanh thu, sổ chi phí, lưu trữ chứng từ |
| Hoàn thành Sprint 4 | Tuần 13 | Hoàn thành các chức năng thuế: GTGT, TNCN, theo dõi nộp thuế |
| Hoàn thành Sprint 5 | Tuần 16 | Hoàn thành các chức năng nhân sự, lương, BHXH/BHYT/BHTN |
| Hoàn thành Sprint 6 | Tuần 18 | Hoàn thành hệ thống hoàn chỉnh, bao gồm báo cáo, đóng kỳ, audit trail |

## Nhận Xét Về Mã Nguyên Nguồn Hiện Tại

### Điểm mạnh
- Đã thiết lập cơ bản cho Clean Architecture
- Sử dụng các thư viện hiện đại và phù hợp (Riverpod, GetIt, Sqflite)
- Mã nguồn dễ đọc và tuân thủ một số nguyên tắc cơ bản

### Khoảng cách cần bridging
1. **Thiếu đầy đủ các tính năng**: Chỉ triển khai 1/43 use cases (MD-01)
2. **Cần hoàn thiện database schema**: Cần tạo bảng cho tất cả các entities
3. **Cần triển khai các lớp còn lại**: Domain, Data, Presentation cho các UC còn lại
4. **Cần viết tests**: Hiện tại chỉ có một vài test cơ bản
5. **Cần triển khai UI**: Chưa có bất kỳ thành phần giao diện nào

### Khuyến nghị ưu tiên
1. **Hoàn thành Master Data trước** (Sprint 0) vì tất cả các UC khác phụ thuộc vào nó
2. **Tập trung vào các UC có tính cơ bản cao** như CT-01, CT-02, SK-07 trong Sprint 1
3. **Áp dụng TDD nghiêm ngặt** để đảm bảo chất lượng và giảm bugs
4. **Thực hiện code review thường xuyên** để duy trì tiêu chuẩn chất lượng
5. **Lập kế hoạch migration dữ liệu** sớm nếu cần chuyển từ hệ thống cũ

## Tài Nguyên Tham Khảo Thêm
- [Flutter Riverpod Documentation](https://riverpod.dev/)
- [Clean Architecture với Flutter](https://resocoder.com/2021/03/09/flutter-ddd-clean-architecture-course/)
- [SQFlite Database Guide](https://docs.flutter.dev/cookbook/persistence/sqlite)
- [Thông tư 88/2021/TT-BTC](https://thuvienphapluat.vn/van-ban/Thong-tu-tu-van/Thong-tu-88-2021-TT-BTC-ve-ke-toan-hoc-kiem-toan-488648.aspx)

## Kết Luận
Dự án có nền tảng tốt với kiến trúc sạch và công nghệ phù hợp. Tuy nhiên, cần triển khai thêm 42 use cases còn lại theo lộ trình được đề xuất. Với việc tập trung vào các nguyên tắc phát triển tốt, tuân thủ TDD và thực hiện theo các sprint được phân tích kỹ lưỡng, dự án có thể hoàn thành trong vòng 18 tuần như được lên kế hoạch.

---
*Lộ trình này được tạo ra dựa trên phân tích toàn diện tài liệu thiết kế hệ thống và đánh giá mã nguồn hiện tại. Có thể cần điều chỉnh dựa trên phản hồi từ các bên liên quan và phát hiện trong quá trình thực thi.*