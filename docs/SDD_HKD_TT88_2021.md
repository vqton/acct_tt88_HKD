# THIẾT KẾ TOÁN HỆ THỐNG - HỆ THỐNG KẾ TOÁN HKD/CNKD
**Căn cứ pháp lý:** Thông tư 88/2021/TT-BTC ngày 11/10/2021 của Bộ Tài chính  
**Phiên bản tài liệu:** 2.0  
**Ngày lập:** 2025  
**Ngày cập nhật:** 2026-04-28  

## 1. Tổng quan hệ thống

### 1.1. Mục tiêu và phạm vi
Hệ thống kế toán HKD/CNKD được viết lại hoàn toàn bằng .NET 9, nhằm hỗ trợ hộ kinh doanh và cá nhân kinh doanh thực hiện đầy đủ chế độ kế toán theo quy định tại Thông tư 88/2021/TT-BTC. Hệ thống đáp ứng các yêu cầu cơ bản bao gồm: quản lý chứng từ kế toán bắt buộc, ghi và quản lý bảy loại sổ kế toán từ S1-HKD đến S7-HKD, theo dõi kho hàng hóa và vật tư, tính toán nghĩa vụ thuế GTGT và thuế thu nhập cá nhân, quản lý nhân sự và thanh toán tiền lương, cũng như quản lý quỹ tiền mặt và tài khoản ngân hàng.

Hệ thống được thiết kế theo kiến trúc Clean Architecture của .NET 9 với forty-three use cases được tổ chức thành tám nhóm chức năng chính: Master Data, Chứng từ kế toán, Sổ kế toán, Kho hàng, Thuế, Nhân sự và tiền lương, Tiền tệ, và Quản trị hệ thống. Mỗi nhóm chức năng được phát triển độc lập nhưng có mối liên kết dữ liệu chặt chẽ, đảm bảo tính toàn vẹn và nhất quán của thông tin kế toán trong suốt quá trình vận hành.

### 1.2. Các yêu cầu phi chức năng
Về hiệu suất, hệ thống cần đáp ứng thời gian phản hồi dưới hai giây cho các thao tác thông thường như truy vấn chứng từ, tra cứu sổ kế toán và tìm kiếm danh mục. Đối với các nghiệp vụ phức tạp như tính lương cho nhiều người lao động, tổng hợp báo cáo cuối kỳ hoặc tính giá xuất kho theo phương pháp FIFO, thời gian xử lý không được vượt quá mười giây. Hệ thống cần hỗ trợ đồng thời tối thiểu năm người dùng mà không gây ra tình trạng suy giảm hiệu suắt đáng kể.

Về bảo mật, toàn bộ dữ liệu kế toán phải được mã hóa khi truyền qua mạng bằng giao thức HTTPS với chứng chỉ SSL/TLS. Dữ liệu quan trọng như thông tin thuế, lương nhân viên và số dư tài khoản cần được mã hóa ở trạng thái nghỉ (at rest) sử dụng thuật toán AES-256. Hệ thống xác thực người dùng qua tên đăng nhập và mật khẩu kết hợp với cơ chế phân quyền Role-Based Access Control, đảm bảo nguyên tắc bất kiêm nhiệm trong các nghiệp vụ kế toán. Mọi thao tác của người dùng phải được ghi log đầy đủ với dấu thời gian chính xác phục vụ mục đích audit trail.

## 2. Kiến trúc hệ thống

### 2.1. Kiến trúc tổng quan
Hệ thống kế toán HKD/CNKD được thiết kế theo kiến trúc Clean Architecture của .NET 9, phân tách rõ ràng thành bốn tầng: Domain, Application, Infrastructure, và API. Mỗi tầng hoạt động độc lập và giao tiếp thông qua các giao diện được định nghĩa rõ ràng, giúp hệ thống dễ bảo trì, mở rộng và kiểm thử.

Tầng **Domain** chứa các thực thể nghiệp vụ (Entities), interface của repository, và logic nghiệp vụ cốt lõi không phụ thuộc vào bất kỳ framework bên ngoài nào. Tầng này là trọng tâm của hệ thống, không có dependency vào các tầng khác.

Tầng **Application** chứa các use case (MediatR Commands/Queries), DTOs với FluentValidation, và các service interface. Tầng này phụ thuộc vào Domain layer, xử lý các nghiệp vụ ứng dụng, không phụ thuộc vào Infrastructure hay API.

Tầng **Infrastructure** implement các interface từ Domain/Application, bao gồm Entity Framework Core DbContext (AppDbContext), Repository implementations, và các external service integrations. Tầng này phụ thuộc vào Domain và Application layers.

Tầng **API** là ASP.NET Core Web API, cung cấp các REST endpoint, xử lý HTTP request/response, cấu hình Dependency Injection và middleware. Tầng này phụ thuộc vào Application và Infrastructure layers.

Hệ thống sử dụng MediatR 12.4 cho mô hình CQRS, FluentValidation 11.9 cho validation, Entity Framework Core 9 với SQLite cho dữ liệu.

### 2.2. Sơ đồ kiến trúc và các thành phần
Kiến trúc hệ thống được tổ chức thành các thành phần chính hoạt động phối hợp với nhau. API Gateway đóng vai trò điểm đầu vào duy nhất cho tất cả các yêu cầu từ client, thực hiện xác thực, định tuyến và giới hạn tốc độ. Phía sau API Gateway là các service chuyên biệt, mỗi service phụ trách một nhóm chức năng nghiệp vụ riêng biệt.

Service Master Data quản lý toàn bộ thông tin danh mục bao gồm thông tin hộ kinh doanh, danh mục hàng hóa và dịch vụ, danh mục ngành nghề và thuế suất, nhà cung cấp, khách hàng, người lao động, tài khoản ngân hàng và cấu hình kỳ kế toán. Service này đóng vai trò nền tảng, cung cấp dữ liệu tham chiếu cho tất cả các service khác trong hệ thống.

Service Chứng từ xử lý việc lập, phê duyệt và lưu trữ các loại chứng từ kế toán bao gồm phiếu thu, phiếu chi, phiếu nhập kho, phiếu xuất kho, bảng thanh toán tiền lương và hóa đơn. Service này đảm bảo tuân thủ quy trình phê duyệt hai bước theo quy định, với người lập chứng từ và người phê duyệt phải là hai đối tượng khác nhau.

Service Sổ Kế toán tự động ghi nhận các nghiệp vụ phát sinh từ chứng từ đã được phê duyệt vào bảy loại sổ kế toán theo quy định của Thông tư 88/2021. Service này thực hiện các tính toán tự động như tổng hợp doanh thu theo ngành nghề, tính số dư quỹ tiền mặt, cập nhật số dư tài khoản ngân hàng và theo dõi nghĩa vụ thuế với ngân sách nhà nước.

Service Kho hàng quản lý toàn bộ quy trình nhập xuất hàng hóa bao gồm kiểm kê hàng tồn kho và tính giá xuất kho theo hai phương pháp Bình quân gia quyền và FIFO. Service này tích hợp chặt chẽ với Service Chứng từ và Service Sổ Kế toán để đảm bảo tính nhất quán giữa chứng từ, sổ kho và sổ kế toán chi tiết vật tư hàng hóa.

Service Thuế thực hiện các tính toán liên quan đến nghĩa vụ thuế bao gồm xác định doanh thu chịu thuế, tính thuế GTGT theo tỷ lệ quy định cho từng ngành nghề, tính thuế TNCN cho chủ hộ kinh doanh và người lao động, cũng như theo dõi tình trạng nộp thuế vào ngân sách nhà nước. Service này sử dụng dữ liệu từ Service Sổ Kế toán và Master Data để đảm bảo tính chính xác của các khoản thuế được tính toán.

Service Nhân sự và Tiền lương quản lý thông tin người lao động, tính lương theo sản phẩm hoặc thời gian, khấu trừ các khoản bảo hiểm xã hội, bảo hiểm y tế, bảo hiểm thất nghiệp và thuế thu nhập cá nhân, cũng như theo dõi việc thanh toán lương cho người lao động. Service này tích hợp với Service Chứng từ để tự động tạo phiếu chi trả lương.

Service Tiền tệ quản lý quỹ tiền mặt và tiền gửi ngân hàng, theo dõi các giao dich thu chi, tính số dư tồn quỹ và đối chiếu với sổ sách kế toán. Service này cung cấp các cảnh báo khi số dư quỹ âm hoặc khi có chênh lệch giữa sổ sách và thực tế.

Service Quản trị Hệ thống cung cấp các chức năng quản lý người dùng và phân quyền, sửa chữa và điều chỉnh sổ kế toán, đóng kỳ kế toán và khóa sổ, tổng hợp báo cáo cuối kỳ, lưu trữ và tra cứu chứng từ, cũng như ghi nhật ký hệ thống và audit trail. Service này đảm bảo tính bảo mật và tuân thủ các quy định pháp luật về kế toán.
