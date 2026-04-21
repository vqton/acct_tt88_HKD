# THIẾT KẾ HỆ THỐNG — HỆ THỐNG KẾ TOÁN HKD/CNKD

**Căn cứ pháp lý:** Thông tư 88/2021/TT-BTC ngày 11/10/2021 của Bộ Tài chính  
**Phiên bản tài liệu:** 1.0  
**Ngày lập:** 2025  
**Người phân tích:** Lead BA / System Architect  

---

## 1. Tổng quan hệ thống

### 1.1. Mục tiêu và phạm vi

Hệ thống kế toán HKD/CNKD được xây dựng nhằm hỗ trợ hộ kinh doanh và cá nhân kinh doanh thực hiện đầy đủ chế độ kế toán theo quy định tại Thông tư 88/2021/TT-BTC. Hệ thống đáp ứng các yêu cầu cơ bản bao gồm: quản lý chứng từ kế toán bắt buộc, ghi và quản lý bảy loại sổ kế toán từ S1-HKD đến S7-HKD, theo dõi kho hàng hóa và vật tư, tính toán nghĩa vụ thuế GTGT và thuế thu nhập cá nhân, quản lý nhân sự và thanh toán tiền lương, cũng như quản lý quỹ tiền mặt và tài khoản ngân hàng.

Hệ thống được thiết kế theo kiến trúc modular với forty-three use cases được tổ chức thành tám nhóm chức năng chính: Master Data, Chứng từ kế toán, Sổ kế toán, Kho hàng, Thuế, Nhân sự và tiền lương, Tiền tệ, và Quản trị hệ thống. Mỗi nhóm chức năng được phát triển độc lập nhưng có mối liên kết dữ liệu chặt chẽ, đảm bảo tính toàn vẹn và nhất quán của thông tin kế toán trong suốt quá trình vận hành.

### 1.2. Các yêu cầu phi chức năng

Về hiệu suất, hệ thống cần đáp ứng thời gian phản hồi dưới hai giây cho các thao tác thông thường như truy vấn chứng từ, tra cứu sổ kế toán và tìm kiếm danh mục. Đối với các nghiệp vụ phức tạp như tính lương cho nhiều người lao động, tổng hợp báo cáo cuối kỳ hoặc tính giá xuất kho theo phương pháp FIFO, thời gian xử lý không được vượt quá mười giây. Hệ thống cần hỗ trợ đồng thời tối thiểu năm người dùng mà không gây ra tình trạng suy giảm hiệu suất đáng kể.

Về bảo mật, toàn bộ dữ liệu kế toán phải được mã hóa khi truyền qua mạng bằng giao thức HTTPS với chứng chỉ SSL/TLS. Dữ liệu quan trọng như thông tin thuế, lương nhân viên và số dư tài khoản cần được mã hóa ở trạng thái nghỉ sử dụng thuật toán AES-256. Hệ thống xác thực người dùng qua tên đăng nhập và mật khẩu kết hợp với cơ chế phân quyền Role-Based Access Control, đảm bảo nguyên tắc bất kiêm nhiệm trong các nghiệp vụ kế toán. Mọi thao tác của người dùng phải được ghi log đầy đủ với dấu thời gian chính xác phục vụ mục đích audit trail.

Về khả dụng, hệ thống cần đạt mức availability 99,5% trong giờ làm việc, với thời gian downtime cho phép không quá hai giờ mỗi tháng cho các hoạt động bảo trì planned. Dữ liệu kế toán phải được backup hàng ngày theo lịch tự động, với retention policy tối thiểu mười năm theo quy định pháp luật về lưu trữ hồ sơ kế toán. Hệ thống cần có cơ chế disaster recovery cho phép phục hồi dữ liệu trong vòng bốn giờ trong trường hợp xảy ra sự cố nghiêm trọng.

Về khả năng mở rộng, kiến trúc hệ thống được thiết kế theo nguyên tắc microservices với khả năng scale ngang để đáp ứng nhu cầu tăng trưởng số lượng người dùng và khối lượng dữ liệu. Các module có thể được triển khai độc lập trên các container, cho phép nâng cấp hoặc bảo trì từng phần mà không ảnh hưởng đến toàn bộ hệ thống. Giao diện người dùng được thiết kế responsive, hỗ trợ truy cập từ máy tính để bàn và thiết bị di động.

---

## 2. Kiến trúc hệ thống

### 2.1. Kiến trúc tổng quan

Hệ thống kế toán HKD/CNKD được thiết kế theo mô hình ba tầng Three-Tier Architecture, phân tách rõ ràng giữa tầng trình bày Presentation Layer, tầng nghiệp vụ Business Logic Layer và tầng dữ liệu Data Access Layer. Mỗi tầng hoạt động độc lập và giao tiếp thông qua các giao diện được định nghĩa rõ ràng, giúp hệ thống dễ bảo trì, mở rộng và kiểm thử.

Tầng trình bày sử dụng công nghệ Single Page Application với framework React hoặc Vue.js, cung cấp giao diện người dùng hiện đại, thân thiện và phản hồi nhanh. Tầng này giao tiếp với tầng nghiệp vụ thông qua các RESTful API được bảo vệ bằng JSON Web Token. Giao diện được thiết kế theo nguyên tắc mobile-first, đảm bảo trải nghiệm nhất quán trên mọi thiết bị.

Tầng nghiệp vụ được xây dựng trên nền tảng Node.js với Express hoặc Spring Boot nếu sử dụng Java, xử lý toàn bộ logic nghiệp vụ bao gồm các tính toán kế toán, quy trình phê duyệt chứng từ, tính lương và khấu trừ bảo hiểm, cũng như tổng hợp báo cáo. Tầng này áp dụng các nguyên thiết kế phần mềm như Dependency Injection và Repository Pattern để đảm bảo tính modular và khả năng kiểm thử.

Tầng dữ liệu sử dụng PostgreSQL làm cơ sở dữ liệu chính cho các thông tin kế toán có cấu trúc, đảm bảo tính ACID cần thiết cho các giao dịch tài chính. Redis được sử dụng cho caching dữ liệu tạm thời và quản lý session người dùng, giúp cải thiện hiệu suất hệ thống. MinIO hoặc Amazon S3 được sử dụng để lưu trữ các tài liệu đính kèm như hình ảnh chứng từ, hóa đơn điện tử và các file scan.

### 2.2. Sơ đồ kiến trúc và các thành phần

Kiến trúc hệ thống được tổ chức thành các thành phần chính hoạt động phối hợp với nhau. API Gateway đóng vai trò điểm đầu vào duy nhất cho tất cả các yêu cầu từ client, thực hiện xác thực, định tuyến và giới hạn tốc độ. Phía sau API Gateway là các service chuyên biệt, mỗi service负责 một nhóm chức năng nghiệp vụ riêng biệt.

Service Master Data quản lý toàn bộ thông tin danh mục bao gồm thông tin hộ kinh doanh, danh mục hàng hóa và dịch vụ, danh mục ngành nghề và thuế suất, nhà cung cấp, khách hàng, người lao động, tài khoản ngân hàng và cấu hình kỳ kế toán. Service này đóng vai trò nền tảng, cung cấp dữ liệu tham chiếu cho tất cả các service khác trong hệ thống.

Service Chứng từ xử lý việc lập, phê duyệt và lưu trữ các loại chứng từ kế toán bao gồm phiếu thu, phiếu chi, phiếu nhập kho, phiếu xuất kho, bảng thanh toán tiền lương và hóa đơn. Service này đảm bảo tuân thủ quy trình phê duyệt hai bước theo quy định, với người lập chứng từ và người phê duyệt phải là hai đối tượng khác nhau.

Service Sổ Kế toán tự động ghi nhận các nghiệp vụ phát sinh từ chứng từ đã được phê duyệt vào bảy loại sổ kế toán theo quy định của Thông tư 88/2021. Service này thực hiện các tính toán tự động như tổng hợp doanh thu theo ngành nghề, tính số dư quỹ tiền mặt, cập nhật số dư tài khoản ngân hàng và theo dõi nghĩa vụ thuế với ngân sách nhà nước.

Service Kho hàng quản lý toàn bộ quy trình nhập xuất hàng hóa bao gồm kiểm kê hàng tồn kho và tính giá xuất kho theo hai phương pháp Bình quân gia quyền và FIFO. Service này tích hợp chặt chẽ với Service Chứng từ và Service Sổ Kế toán để đảm bảo tính nhất quán giữa chứng từ, sổ kho và sổ kế toán chi tiết vật tư hàng hóa.

Service Thuế thực hiện các tính toán liên quan đến nghĩa vụ thuế bao gồm xác định doanh thu chịu thuế, tính thuế GTGT theo tỷ lệ quy định cho từng ngành nghề, tính thuế TNCN cho chủ hộ kinh doanh và người lao động, cũng như theo dõi tình trạng nộp thuế vào ngân sách nhà nước. Service này sử dụng dữ liệu từ Service Sổ Kế toán và Master Data để đảm bảo tính chính xác của các khoản thuế được tính toán.

Service Nhân sự và Tiền lương quản lý thông tin người lao động, tính lương theo sản phẩm hoặc thời gian, khấu trừ các khoản bảo hiểm xã hội, bảo hiểm y tế, bảo hiểm thất nghiệp và thuế thu nhập cá nhân, cũng như theo dõi việc thanh toán lương cho người lao động. Service này tích hợp với Service Chứng từ để tự động tạo phiếu chi trả lương.

Service Tiền tệ quản lý quỹ tiền mặt và tiền gửi ngân hàng, theo dõi các giao dịch thu chi, tính số dư tồn quỹ và đối chiếu với sổ sách kế toán. Service này cung cấp các cảnh báo khi số dư quỹ âm hoặc khi có chênh lệch giữa sổ sách và thực tế.

Service Quản trị Hệ thống cung cấp các chức năng quản lý người dùng và phân quyền, sửa chữa và điều chỉnh sổ kế toán, đóng kỳ kế toán và khóa sổ, tổng hợp báo cáo cuối kỳ, lưu trữ và tra cứu chứng từ, cũng như ghi nhật ký hệ thống và audit trail. Service này đảm bảo tính bảo mật và tuân thủ các quy định pháp luật về kế toán.

### 2.3. Sơ đồ luồng dữ liệu

Luồng dữ liệu trong hệ thống tuân theo một thứ tự phụ thuộc logic chặt chẽ được xác định bởi bản chất của nghiệp vụ kế toán. Dữ liệu Master Data được thiết lập đầu tiên và đóng vai trò nền tảng cho tất cả các nghiệp vụ tiếp theo. Khi có phát sinh nghiệp vụ kinh tế như bán hàng, mua hàng, thu chi tiền hoặc nhập xuất kho, hệ thống tạo chứng từ kế toán tương ứng.

Sau khi chứng từ được lập, nó trình qua người có thẩm quyền phê duyệt. Chỉ các chứng từ đã được phê duyệt mới được ghi vào sổ kế toán tương ứng một cách tự động. Dữ liệu từ các sổ kế toán được tổng hợp để phục vụ các báo cáo quản trị, báo cáo thuế và các yêu cầu từ cơ quan chức năng. Toàn bộ quá trình này được ghi log đầy đủ để phục vụ mục đích kiểm toán và audit trail.

---

## 3. Thiết kế cơ sở dữ liệu

### 3.1. Mô hình dữ liệu quan hệ

Cơ sở dữ liệu của hệ thống kế toán HKD/CNKD được thiết kế theo nguyên tắc chuẩn hóa Third Normal Form nhằm loại bỏ dư thừa dữ liệu và đảm bảo tính toàn vẹn tham chiếu. Mô hình dữ liệu phản ánh đầy đủ cấu trúc nghiệp vụ theo forty-three use cases đã được phân tích, với các bảng được tổ chức theo từng nhóm chức năng.

Nhóm Master Data bao gồm các bảng lưu trữ thông tin nền tảng của hệ thống. Bảng `hkd_info` lưu trữ thông tin về hộ kinh doanh bao gồm tên hộ kinh doanh, địa chỉ, mã số thuế, thông tin người đại diện, phương pháp tính giá xuất kho và kỳ kế toán áp dụng. Mã số thuế được định nghĩa là khóa chính và là duy nhất trong toàn hệ thống, không cho phép thay đổi sau khi tạo.

Bảng `dm_nhom_nghe` lưu trữ danh mục ngành nghề kinh doanh cùng với thuế suất GTGT và thuế suất TNCN tương ứng. Bảng này được thiết kế với cơ chế lưu trữ lịch sử thay đổi thuế suất, sử dụng các trường `ngay_hieu_luc` và `ngay_het_hieu_luc` để xác định thời điểm áp dụng của từng mức thuế suất. Điều này đảm bảo rằng các giao dịch cũ luôn sử dụng thuế suất tại thời điểm phát sinh, đáp ứng yêu cầu của quy định pháp luật.

Bảng `dm_hang_hoa` lưu trữ thông tin hàng hóa và dịch vụ bao gồm mã hàng, tên hàng, đơn vị tính, nhóm ngành nghề và loại hàng. Mỗi hàng hóa liên kết đến một nhóm ngành nghề thông qua khóa ngoại, từ đó tự động kế thừa thuế suất GTGT và TNCN. Trạng thái hàng hóa được quản lý thông qua trường `trang_thai` với hai giá trị `dang_kinh_doanh` và `ngung_kinh_doanh`, đảm bảo không xóa vĩnh viễn các mặt hàng đã có giao dịch.

Các bảng `dm_nha_cung_cap`, `dm_khach_hang` và `dm_nhan_vien` lần lượt lưu trữ thông tin nhà cung cấp, khách hàng và người lao động. Mỗi bảng đều có trường `trang_thai` để quản lý trạng thái hoạt động mà không xóa dữ liệu lịch sử. Bảng `dm_nhan_vien` bổ sung các trường về lương và các khoản khấu trừ bảo hiểm, cũng như lịch sử thay đổi bậc lương được lưu trong bảng riêng `dm_nhan_vien_luong_history`.

Bảng `dm_tai_khoan_ngan_hang` lưu trữ thông tin tài khoản ngân hàng của hộ kinh doanh, liên kết với thông tin hộ kinh doanh qua khóa ngoại. Bảng `ky_ke_toan` lưu trữ thông tin kỳ kế toán bao gồm năm tài chính, ngày bắt đầu, ngày kết thúc và trạng thái của kỳ. Trạng thái kỳ có thể là `mo`, `dong` hoặc `khoa_so`, quyết định việc có cho phép ghi chứng từ vào kỳ đó hay không.

Nhóm Chứng từ bao gồm các bảng lưu trữ thông tin về các loại chứng từ kế toán. Bảng `phieu_thu` lưu trữ thông tin phiếu thu bao gồm số phiếu, ngày lập, người nộp tiền, lý do nộp, số tiền và trạng thái phê duyệt. Trạng thái phê duyệt được quản lý qua các giá trị `cho_duyet`, `da_duyet` và `tu_choi`, đảm bảo tuân thủ quy trình phê duyệt hai bước.

Bảng `phieu_chi` có cấu trúc tương tự như bảng phiếu thu nhưng bổ sung trường `nguoi_nhan_tien` và liên kết đến chứng từ gốc thông qua bảng trung gian `phieu_chi_chung_tu_goc`. Bảng `phieu_nhap_kho` và `phieu_xuat_kho` lưu trữ thông tin về nhập xuất kho hàng hóa, với các chi tiết được lưu trong bảng `phieu_nhap_kho_chi_tiet` và `phieu_xuat_kho_chi_tiet` để quan hệ nhiều-nhiều với danh mục hàng hóa.

Bảng `bang_luong` lưu trữ thông tin bảng thanh toán tiền lương hàng tháng bao gồm kỳ lương, thông tin người lao động, các khoản thu nhập, các khoản khấu trừ và số còn phải trả. Chi tiết từng khoản được lưu trong bảng `bang_luong_chi_tiet` với các cột tương ứng theo mẫu 05-LĐTL quy định tại Thông tư 88/2021.

Bảng `hoa_don` lưu trữ thông tin hóa đơn cả đầu vào và đầu ra, với trường `loai_hoa_don` phân biệt hai loại. Hóa đơn đầu vào liên kết với nhà cung cấp và phiếu nhập kho, trong khi hóa đơn đầu ra liên kết với khách hàng và phiếu xuất kho. Bảng `chung_tu_ky` lưu trữ thông tin về chữ ký điện tử và trạng thái phê duyệt của từng chứng từ.

Nhóm Sổ Kế toán bao gồm các bảng lưu trữ dữ liệu được tổng hợp từ chứng từ. Bảng `so_doanh_thu` tương ứng với S1-HKD lưu trữ thông tin doanh thu bán hàng và cung cấp dịch vụ theo từng nhóm ngành nghề. Bảng này được thiết kế với các cột tương ứng với các mức thuế suất khác nhau, cho phép tổng hợp doanh thu theo từng loại thuế.

Bảng `so_vat_tu_hang_hoa` tương ứng với S2-HKD lưu trữ thông tin về tồn kho, nhập xuất hàng hóa theo từng mặt hàng. Bảng này được cập nhật tự động từ các phiếu nhập kho và phiếu xuất kho đã được phê duyệt. Đơn giá xuất kho được tính toán dựa trên phương pháp được cấu hình trong thông tin hộ kinh doanh.

Các bảng `so_chi_phi`, `so_nghia_vu_thue`, `so_tien_luong` và `so_quy_tien_mat` lần lượt lưu trữ dữ liệu cho S3-HKD, S4-HKD, S5-HKD và S6-HKD. Bảng `so_tien_gui_ngan_hang` lưu trữ dữ liệu cho S7-HKD với mỗi bản ghi tương ứng với một tài khoản ngân hàng cụ thể. Tất cả các bảng sổ kế toán đều có trường `ky_ke_toan_id` để phân biệt dữ liệu theo từng kỳ kế toán.

Nhóm Kho hàng sử dụng chung dữ liệu từ bảng phiếu nhập kho và phiếu xuất kho, nhưng bổ sung thêm bảng `phieu_kiem_ke` để lưu trữ kết quả kiểm kê hàng tồn kho định kỳ. Bảng này lưu trữ thông tin về hàng hóa kiểm kê, số lượng theo sổ sách, số lượng thực tế và chênh lệch nếu có.

Nhóm Thuế bao gồm các bảng lưu trữ kết quả tính thuế và tình trạng nộp thuế. Bảng `ket_qua_tinh_thue` lưu trữ kết quả tính thuế GTGT và thuế TNCN theo từng kỳ kế toán. Bảng `lich_su_nop_thue` lưu trữ thông tin về việc nộp thuế vào ngân sách nhà nước bao gồm số tiền đã nộp, ngày nộp và chứng từ kèm theo.

Nhóm Nhân sự và Tiền lương sử dụng chung dữ liệu từ bảng người lao động và bảng lương, nhưng bổ sung thêm các bảng `lich_su_cham_cong` để lưu trữ dữ liệu chấm công hàng ngày và `bhxh_khau_tru` để lưu trữ thông tin khấu trừ bảo hiểm xã hội, bảo hiểm y tế và bảo hiểm thất nghiệp.

Nhóm Quản trị bao gồm các bảng quản lý người dùng và phân quyền. Bảng `users` lưu trữ thông tin người dùng hệ thống bao gồm tên đăng nhập, mật khẩu đã mã hóa, thông tin cá nhân và trạng thái hoạt động. Bảng `roles` định nghĩa các vai trò trong hệ thống như kế toán viên, thủ quỹ, thủ kho, người đại diện và quản trị viên. Bảng `permissions` định nghĩa các quyền hạn chế trên các chức năng cụ thể. Bảng `user_roles` và `role_permissions` thiết lập mối quan hệ nhiều-nhiều giữa người dùng và vai trò, giữa vai trò và quyền.

Bảng `audit_log` lưu trữ toàn bộ nhật ký hoạt động của hệ thống bao gồm người thực hiện, hành động, đối tượng, thời gian và giá trị trước sau khi thay đổi. Bảng này được thiết kế với cơ chế ghi chỉ append, không cho phép sửa hoặc xóa dữ liệu để đảm bảo tính toàn vẹn của audit trail.

### 3.2. Thiết kế index và tối ưu hóa

Để đảm bảo hiệu suất truy vấn, các bảng dữ liệu được đánh index trên các trường thường xuyên sử dụng trong điều kiện WHERE và JOIN. Đối với bảng chứng từ như phiếu thu và phiếu chi, index được tạo trên các trường `ngay_lap`, `trang_thai`, `nguoi_lap` và `ky_ke_toan_id`. Đối với bảng sổ kế toán, index được tạo trên trường `ky_ke_toan_id` và các trường phân loại ngành nghề để tối ưu hóa truy vấn tổng hợp báo cáo thuế.

Các truy vấn phức tạp như tính giá xuất kho theo phương pháp FIFO được tối ưu hóa bằng cách sử dụng CTE Common Table Expression và window functions của PostgreSQL. Kết quả tính toán của các báo cáo thường xuyên được lưu trữ vào bảng cache để giảm thời gian xử lý cho các lần truy vận tiếp theo.

---

## 4. Thiết kế API

### 4.1. Cấu trúc RESTful API

Hệ thống cung cấp các RESTful API cho giao tiếp giữa client và server. Tất cả các API tuân theo các nguyên tắc thiết kế nhất quán bao gồm sử dụng danh từ số nhiều cho tên resource, sử dụng các phương thức HTTP chuẩn như GET, POST, PUT và DELETE để thực hiện các thao tác tương ứng, sử dụng mã trạng thái HTTP chuẩn để phản hồi kết quả, và trả về dữ liệu JSON cho tất cả các response.

API cho nhóm Master Data bao gồm các endpoint quản lý thông tin hộ kinh doanh tại `/api/v1/hkd`, quản lý danh mục hàng hóa tại `/api/v1/hang-hoa`, quản lý danh mục ngành nghề tại `/api/v1/nhom-nghe`, quản lý nhà cung cấp tại `/api/v1/nha-cung-cap`, quản lý khách hàng tại `/api/v1/khach-hang`, quản lý người lao động tại `/api/v1/nhan-vien`, quản lý tài khoản ngân hàng tại `/api/v1/tai-khoan-ngan-hang`, và quản lý kỳ kế toán tại `/api/v1/ky-ke-toan`.

API cho nhóm Chứng từ bao gồm các endpoint lập phiếu thu tại `/api/v1/phieu-thu`, lập phiếu chi tại `/api/v1/phieu-chi`, lập phiếu nhập kho tại `/api/v1/phieu-nhap-kho`, lập phiếu xuất kho tại `/api/v1/phieu-xuat-kho`, lập bảng lương tại `/api/v1/bang-luong`, quản lý hóa đơn tại `/api/v1/hoa-don`, lưu trữ chứng từ tại `/api/v1/chung-tu` và phê duyệt chứng từ tại `/api/v1/phieu/{id}/phe-duyet`.

API cho nhóm Sổ Kế toán bao gồm các endpoint mở sổ kế toán tại `/api/v1/so-ke-toan/mo-so`, ghi sổ doanh thu tại `/api/v1/so-doanh-thu`, ghi sổ vật tư hàng hóa tại `/api/v1/so-vat-tu`, ghi sổ chi phí tại `/api/v1/so-chi-phi`, ghi sổ nghĩa vụ thuế tại `/api/v1/so-nghia-vu-thue`, ghi sổ tiền lương tại `/api/v1/so-tien-luong`, ghi sổ quỹ tiền mặt tại `/api/v1/so-quy-tien-mat`, và ghi sổ tiền gửi ngân hàng tại `/api/v1/so-tien-gui-ngan-hang`.

API cho nhóm Kho hàng bao gồm các endpoint nhập kho tại `/api/v1/kho/nhap`, xuất kho tại `/api/v1/kho/xuat`, kiểm kê tại `/api/v1/kho/kiem-ke` và tính giá xuất kho tại `/api/v1/kho/tinh-gia-xuat`. API cho nhóm Thuế bao gồm các endpoint xác định doanh thu chịu thuế tại `/api/v1/thue/doanh-thu-chiu-thue`, tính thuế GTGT tại `/api/v1/thue/gtgt`, tính thuế TNCN tại `/api/v1/thue/tncn` và theo dõi nộp thuế tại `/api/v1/thue/nop-thue`.

API cho nhóm Nhân sự bao gồm các endpoint tính lương tại `/api/v1/luong/tinh-luong`, khấu trừ bảo hiểm tại `/api/v1/luong/khau-tru-bhxh` và thanh toán lương tại `/api/v1/luong/thanh-toan`. API cho nhóm Tiền tệ bao gồm các endpoint quản lý quỹ tiền mặt tại `/api/v1/quy-tien-mat` và quản lý tiền gửi ngân hàng tại `/api/v1/tien-gui-ngan-hang`. API cho nhóm Quản trị bao gồm các endpoint quản lý người dùng tại `/api/v1/users`, quản lý vai trò tại `/api/v1/roles`, đóng kỳ kế toán tại `/api/v1/ky-ke-toan/{id}/dong`, sửa chữa sổ kế toán tại `/api/v1/so-ke-toan/dieu-chinh` và truy vấn audit log tại `/api/v1/audit-logs`.

### 4.2. Xác thực và ủy quyền

Tất cả các API được bảo vệ bằng cơ chế xác thực JWT JSON Web Token. Khi người dùng đăng nhập thành công, hệ thống cấp cho họ một access token có thời hạn mặc định là sáu mươi phút và một refresh token có thời hạn bảy ngày. Access token được gửi kèm trong header Authorization của mỗi request với định dạng Bearer token.

Quyền truy cập API được kiểm soát thông qua Role-Based Access Control dựa trên vai trò của người dùng. Mỗi endpoint được định nghĩa yêu cầu một hoặc nhiều vai trò cụ thể. Ví dụ, endpoint tạo phiếu chi chỉ có thể được truy cập bởi người dùng có vai trò kế toán viên, trong khi endpoint phê duyệt chứng từ chỉ có thể được truy cập bởi người dùng có vai trò người đại diện hộ kinh doanh.

Ngoài ra, hệ thống còn áp dụng nguyên tắc phân quyền theo dữ liệu Data-Level Authorization, đảm bảo người dùng chỉ có thể truy cập dữ liệu thuộc phạm vi được phép. Ví dụ, kế toán viên chỉ có thể xem và chỉnh sửa chứng từ mà họ lập hoặc được phân công, trong khi người đại diện có thể xem và phê duyệt tất cả chứng từ của hộ kinh doanh.

### 4.3. Rate limiting và bảo mật

Để bảo vệ hệ thống khỏi các cuộc tấn công DDoS và lạm dụng API, hệ thống áp dụng cơ chế rate limiting với các giới hạn khác nhau cho từng loại endpoint. Các endpoint đọc dữ liệu có giới hạn một trăm request mỗi phút, trong khi các endpoint ghi dữ liệu có giới hạn ba mươi request mỗi phút. Khi vượt quá giới hạn, hệ thống trả về mã lỗi 429 Too Many Requests kèm theo thời gian chờ trước khi có thể thực hiện request tiếp theo.

Tất cả các API endpoint yêu cầu kết nối HTTPS sử dụng TLS 1.3. Các header bảo mật như Content-Security-Policy, X-Content-Type-Options và X-Frame-Options được thiết lập để ngăn chặn các cuộc tấn công phổ biến như XSS, clickjacking và MIME type sniffing. Input validation được thực hiện ở cả phía client và server để đảm bảo dữ liệu đầu vào hợp lệ và an toàn.

---

## 5. Thiết kế module và chức năng

### 5.1. Module Master Data

Module Master Data đóng vai trò nền tảng cho toàn bộ hệ thống, quản lý tất cả các thông tin danh mục được sử dụng trong các nghiệp vụ kế toán. Module này được triển khai đầu tiên và phải hoàn thành trước khi vận hành bất kỳ module nghiệp vụ nào khác, tuân theo nguyên tắc setup-once-reuse-everywhere.

Chức năng quản lý thông tin hộ kinh doanh cho phép nhập và cập nhật các thông tin cơ bản như tên hộ kinh doanh, địa chỉ trụ sở, mã số thuế, thông tin người đại diện và phương pháp tính giá xuất kho. Hệ thống kiểm tra tính duy nhất của mã số thuế và không cho phép thay đổi sau khi tạo. Phương pháp tính giá xuất kho được khóa cứng theo năm tài chính, không cho phép thay đổi giữa chừng để đảm bảo tính nhất quán của số liệu kế toán.

Chức năng quản lý danh mục ngành nghề và thuế suất cung cấp giao diện để quản lý các nhóm ngành nghề kinh doanh cùng với thuế suất GTGT và TNCN tương ứng. Hệ thống lưu trữ lịch sử thay đổi thuế suất, cho phép truy vấn thuế suất áp dụng tại bất kỳ thời điểm nào trong quá khứ. Chức năng cập nhật thuế suất yêu cầu xác nhận hai bước để ngăn chặn thay đổi vô tình hoặc trái phép.

Chức năng quản lý danh mục hàng hóa cho phép tạo, chỉnh sửa và vô hiệu hóa các mặt hàng. Mỗi mặt hàng được liên kết với một nhóm ngành nghề để tự động kế thừa thuế suất. Hệ thống ngăn chặn xóa các mặt hàng đã có giao dịch, thay vào đó chuyển sang trạng thái ngừng kinh doanh. Mã hàng hóa sau khi tạo là bất biến, không cho phép thay đổi để đảm bảo tính toàn vẹn của dữ liệu lịch sử.

Các chức năng quản lý danh mục nhà cung cấp, khách hàng, người lao động và tài khoản ngân hàng cung cấp các thao tác CRUD cơ bản với các ràng buộc nghiệp vụ tương ứng. Đối với danh mục người lao động, hệ thống lưu trữ lịch sử thay đổi bậc lương để phục vụ mục đích tính lương và khai thuế chính xác theo thời điểm.

Chức năng cấu hình kỳ kế toán cho phép tạo và quản lý các kỳ kế toán theo năm dương lịch. Hệ thống hỗ trợ ba trạng thái kỳ là mở, đóng và khóa sổ. Khi kỳ kế toán ở trạng thái khóa sổ, toàn bộ giao dịch thuộc kỳ đó chuyển sang chế độ chỉ đọc, không cho phép bất kỳ sửa đổi nào. Hệ thống cảnh báo khi người dùng cố gắng ghi chứng từ vào kỳ đã đóng hoặc khóa sổ.

### 5.2. Module Chứng từ Kế toán

Module Chứng từ Kế toán quản lý toàn bộ vòng đời của các chứng từ kế toán từ khỏi tạo, phê duyệt đến lưu trữ. Module này đảm bảo tuân thủ nguyên tắc kế toán quan trọng là mọi nghiệp vụ kinh tế phát sinh phải có chứng từ hợp lệ, và chứng từ phải được phê duyệt trước khi ghi sổ.

Chức năng lập phiếu thu cho phép kế toán viên tạo phiếu thu với đầy đủ thông tin theo mẫu số 01-TT. Hệ thống tự động sinh số phiếu liên tục trong kỳ kế toán, không cho phép ngắt quãng. Khi lưu phiếu thu, hệ thống kiểm tra các ràng buộc nghiệp vụ như kỳ kế toán phải đang ở trạng thái mở, thông tin khách hàng phải tồn tại trong danh mục. Sau khi phiếu thu được phê duyệt bởi người đại diện, hệ thống tự động cập nhật sổ quỹ tiền mặt và không cho phép xóa phiếu.

Chức năng lập phiếu chi hoạt động tương tự như phiếu thu nhưng bổ sung thêm kiểm tra yêu cầu chứng từ gốc phải được phê duyệt trước khi lập phiếu chi. Hệ thống ngăn chặn thủ quỹ xuất quỹ khi chưa có chữ ký của người đại diện trên phiếu chi, đảm bảo tuân thủ nguyên tắc kiểm soát nội bộ trong quản lý tiền.

Chức năng lập phiếu nhập kho và phiếu xuất kho quản lý các nghiệp vụ nhập xuất hàng hóa. Hệ thống cho phép số lượng thực tế khác với số lượng theo chứng từ, ghi nhận đúng số thực tế để phản ánh tình hình thực tế của kho hàng. Đối với phiếu xuất kho, hệ thống kiểm tra số lượng tồn kho trước khi cho phép xuất, ngăn chặn xuất kho vượt quá số lượng hiện có.

Chức năng lập bảng thanh toán tiền lương tổng hợp dữ liệu chấm công và tính toán lương cho người lao động theo các phương pháp lương sản phẩm, lương thời gian hoặc kết hợp. Hệ thống tự động tính toán các khoản khấu trừ bao gồm BHXH, BHYT, BHTN và thuế TNCN theo quy định hiện hành. Bảng lương được lưu trữ theo mẫu 05-LĐTL quy định tại Thông tư 88/2021, cho phép tùy chỉnh các cột phù hợp với thực tế của hộ kinh doanh.

Chức năng quản lý hóa đơn hỗ trợ quản lý cả hóa đơn đầu vào và hóa đơn đầu ra. Hệ thống cho phép liên kết hóa đơn với phiếu nhập kho hoặc phiếu xuất kho tương ứng, đối chiếu thông tin để đảm bảo tính nhất quán. Nội dung hóa đơn phải khớp với thông tin trên chứng từ kèm theo theo quy định của luật thuế.

Chức năng phê duyệt chứng từ thực hiện quy trình phê duyệt hai bước theo nguyên tắc bất kiêm nhiệm. Chứng từ sau khi được lập sẽ có trạng thái chờ phê duyệt, chỉ sau khi người đại diện ký duyệt mới chuyển sang trạng thái đã phê duyệt và được ghi vào sổ kế toán. Hệ thống ghi nhận thời gian, người phê duyệt và lý do nếu từ chối. Trường hợp người đại diện kiêm nhiệm các chức danh khác, hệ thống ghi nhận đồng thời các chức danh kiêm nhiệm theo quy định tại Điều 3 Thông tư 88/2021.

Chức năng lưu trữ chứng từ đánh dấu trạng thái hoàn tất cho các chứng từ đã được phê duyệt và ghi sổ, tổ chức lưu trữ theo loại chứng từ và kỳ kế toán. Hệ thống hỗ trợ tra cứu nhanh chóng theo số phiếu, ngày tháng, loại nghiệp vụ, người lập và người phê duyệt.

### 5.3. Module Sổ Kế toán

Module Sổ Kế toán tự động ghi nhận các nghiệp vụ từ chứng từ đã được phê duyệt vào bảy loại sổ kế toán theo quy định tại Điều 5 và Phụ lục 2 Thông tư 88/2021. Module này đảm bảo tính tự động hóa cao, giảm thiểu thao tác thủ công của kế toán viên đồng thời đảm bảo tính chính xác của dữ liệu được ghi.

Chức năng mở sổ kế toán đầu kỳ thực hiện khởi tạo bảy loại sổ kế toán cho năm tài chính mới. Hệ thống tự động kết chuyển số dư cuối kỳ trước sang số dư đầu kỳ mới, đồng thời kiểm tra tính cân bằng giữa các sổ. Đối với hộ kinh doanh có nhiều địa điểm kinh doanh, hệ thống hỗ trợ mở sổ chi tiết theo từng địa điểm theo quy định.

Chức năng ghi sổ doanh thu bán hàng và cung cấp dịch vụ tự động phân loại doanh thu theo nhóm ngành nghề cùng mức thuế suất GTGT và TNCN. Hệ thống tổng hợp doanh thu cuối kỳ từ các hóa đơn bán hàng và phiếu thu, làm căn cứ cho việc tính thuế GTGT và thuế TNCN. Sổ này được thiết kế với các cột tương ứng với các nhóm ngành nghề khác nhau, cho phép theo dõi chi tiết doanh thu theo từng loại thuế suất.

Chức năng ghi sổ chi tiết vật tư hàng hóa tự động cập nhật từ các phiếu nhập kho và phiếu xuất kho đã được phê duyệt. Hệ thống tính toán số lượng tồn kho và thành tiền tồn kho sau mỗi nghiệp vụ nhập xuất. Đơn giá xuất kho được tính toán theo phương pháp đã được cấu hình trong thông tin hộ kinh doanh, đảm bảo tính nhất quán trong suốt năm tài chính.

Chức năng ghi sổ chi phí sản xuất kinh doanh tổng hợp các khoản chi phí từ phiếu chi và phiếu xuất kho, phân loại vào các cột chi phí tương ứng bao gồm chi phí nhân công, điện, nước, viễn thông, thuê kho bãi, chi phí quản lý và chi phí khác. Hệ thống đối chiếu tự động với các chứng từ gốc để đảm bảo tính chính xác.

Chức năng ghi sổ theo dõi nghĩa vụ thuế với ngân sách nhà nước theo dõi số thuế phải nộp và số thuế đã nộp cho từng sắc thuế bao gồm thuế GTGT, thuế TNCN đối với chủ hộ kinh doanh và thuế TNCN đối với người lao động. Hệ thống tự động tính số dư cuối kỳ, xác định số còn phải nộp hoặc số nộp thừa. Trường hợp nộp thừa, số dư âm được hiển thị để phản ánh tình trạng nộp thừa chờ quyết toán.

Chức năng ghi sổ theo dõi thanh toán tiền lương theo dõi số lương phải trả, số đã trả và số còn phải trả cho từng người lao động. Tương tự, hệ thống theo dõi các khoản BHXH, BHYT, BHTN phải nộp, đã nộp và còn phải nộp cho cơ quan bảo hiểm xã hội. Sổ này được cập nhật tự động từ bảng lương và phiếu chi trả lương.

Chức năng ghi sổ quỹ tiền mặt tự động cập nhật từ các phiếu thu và phiếu chi, tính số dư tồn quỹ sau từng nghiệp vụ. Hệ thống cảnh báo khi số dư quỹ âm, ngăn chặn việc chi vượt quỹ. Cuối kỳ, hệ thống tổng hợp tổng thu, tổng chi và số dư cuối kỳ. Trường hợp có chênh lệch giữa sổ sách và thực tế, hệ thống yêu cầu lập biên bản xử lý trước khi khóa sổ.

Chức năng ghi sổ tiền gửi ngân hàng theo dõi các giao dịch gửi tiền và rút tiền cho từng tài khoản ngân hàng. Hệ thống đối chiếu tự động với sao kê ngân hàng cuối tháng, xác định các chênh lệch thừa hoặc thiếu để xử lý kịp thời.

### 5.4. Module Kho hàng

Module Kho hàng quản lý toàn bộ quy trình nhập xuất hàng hóa và vật tư, đảm bảo tính chính xác của số liệu tồn kho và hỗ trợ việc kiểm kê định kỳ theo quy định.

Chức năng nhập kho hàng hóa cho phép thủ kho thực hiện nghiệp vụ nhập kho khi hàng hóa về đến kho. Hệ thống hỗ trợ kiểm đếm hàng thực tế so với hóa đơn hoặc lệnh nhập, ghi nhận số lượng thực nhận. Trường hợp số lượng thực nhận ít hơn số lượng theo chứng từ, hệ thống tạo thông báo yêu cầu lập biên bản xác nhận hàng thiếu với người giao hàng. Sau khi nhập kho hoàn tất, hệ thống tự động cập nhật sổ chi tiết vật tư hàng hóa và lưu trữ các chứng từ kèm theo.

Chức năng xuất kho hàng hóa kiểm tra số lượng tồn kho trước khi cho phép xuất, ngăn chặn xuất khi số lượng tồn không đủ. Khi phiếu xuất kho được phê duyệt, hệ thống cập nhật sổ chi tiết vật tư hàng hóa và tính giá xuất kho theo phương pháp đã cấu hình. Người nhận hàng ký xác nhận trên phiếu xuất, hệ thống lưu trữ thông tin này làm căn cứ cho việc đối chiếu sau này.

Chức năng kiểm kê hàng tồn kho hỗ trợ lập phiếu kiểm kê theo định kỳ hoặc đột xuất. Hệ thống so sánh số lượng thực tế với số lượng trên sổ, xác định chênh lệch thừa hoặc thiếu. Hàng thừa phát hiện khi kiểm kê được tự động tạo phiếu nhập kho để điều chỉnh sổ sách. Hàng thiếu yêu cầu lập biên bản xác định nguyên nhân và xử lý theo quy định trước khi điều chỉnh sổ sách.

Chức năng tính giá xuất kho là chức năng tự động được kích hoạt khi lập phiếu xuất kho. Đối với phương pháp Bình quân gia quyền cả kỳ dự trữ, hệ thống tính đơn giá xuất kho theo công thức lấy tổng giá trị hàng tồn đầu kỳ cộng giá trị hàng nhập trong kỳ chia cho tổng số lượng tương ứng. Đơn giá này được áp dụng cho tất cả các lần xuất kho trong kỳ và chỉ được tính chính xác vào cuối kỳ.

Đối với phương pháp Nhập trước xuất trước FIFO, hệ thống theo dõi từng lô nhập hàng bao gồm số lượng, đơn giá và ngày nhập. Khi xuất kho, hệ thống tự động lấy giá của lô nhập đầu tiên, khi lô đầu hết mới chuyển sang lô tiếp theo. Hàng tồn cuối kỳ được tính theo giá của lô nhập gần nhất. Hệ thống lưu trữ đầy đủ lịch sử tính giá để phục vụ kiểm toán và đối chiếu.

### 5.5. Module Thuế

Module Thuế thực hiện các tính toán liên quan đến nghĩa vụ thuế đối với ngân sách nhà nước, đảm bảo tuân thủ quy định tại Điều 6 Thông tư 88/2021 và Luật Quản lý thuế. Module này tích hợp chặt chẽ với module Sổ Kế toán để đảm bảo tính chính xác và nhất quán của số liệu thuế.

Chức năng xác định doanh thu chịu thuế tổng hợp doanh thu từ sổ doanh thu S1-HKD theo từng nhóm ngành nghề. Hệ thống phân loại doanh thu chịu thuế GTGT và doanh thu chịu thuế TNCN dựa trên thuế suất của từng nhóm ngành nghề. Kết quả được ghi vào sổ theo dõi nghĩa vụ thuế S4-HKD ở cột số thuế phải nộp, làm căn cứ cho việc khai thuế với cơ quan thuế.

Chức năng tính thuế GTGT thực hiện tính toán số thuế GTGT phải nộp theo công thức lấy doanh thu bán hàng hóa hoặc dịch vụ theo từng ngành nghề nhân với tỷ lệ phần trăm tính thuế GTGT theo quy định của pháp luật thuế cho từng ngành nghề đó. Hệ thống sử dụng thuế suất từ danh mục ngành nghề và thuế suất, đảm bảo sử dụng đúng mức thuế suất áp dụng tại thời điểm phát sinh giao dịch.

Chức năng tính thuế TNCN xử lý hai đối tượng khác nhau. Đối với chủ hộ kinh doanh, thuế TNCN được tính bằng tổng doanh thu bán hàng hoặc cung cấp dịch vụ nhân với thuế suất TNCN theo ngành nghề từ danh mục. Đối với người lao động làm việc tại hộ kinh doanh, thuế TNCN được tổng hợp từ cột thuế TNCN trên bảng lương, đã được khấu trừ từ thu nhập của từng người lao động. Hệ thống tách biệt theo từng đối tượng nộp thuế khi ghi vào sổ nghĩa vụ thuế.

Chức năng theo dõi nộp thuế vào ngân sách nhà nước quản lý tình trạng nộp thuế dựa trên các chứng từ nộp thuế bao gồm giấy nộp tiền vào ngân sách nhà nước hoặc giấy báo nợ ngân hàng. Hệ thống tự động cập nhật số thuế đã nộp vào sổ S4-HKD và tính số dư còn phải nộp hoặc nộp thừa. Trường hợp nộp thừa, số nộp thừa được ghi vào cột số đã nộp, số dư âm thể hiện số nộp thừa chờ quyết toán cuối năm.

### 5.6. Module Nhân sự và Tiền lương

Module Nhân sự và Tiền lương quản lý thông tin người lao động và thực hiện các tính toán liên quan đến tiền lương, bảo hiểm xã hội và thuế thu nhập cá nhân đối với người lao động. Module này tuân thủ quy định tại Điều 4 và Phụ lục 2 Thông tư 88/2021.

Chức năng tính lương người lao động tổng hợp dữ liệu chấm công bao gồm số công làm việc và số sản phẩm hoàn thành trong kỳ. Hệ thống tính lương sản phẩm bằng số sản phẩm nhân với đơn giá lương sản phẩm, tính lương thời gian bằng số công nhân với đơn giá lương thời gian. Đối với người lao động nghỉ việc hoặc ngừng việc trong kỳ, hệ thống tính lương theo tỷ lệ phần trăm lương theo quy định trong hợp đồng lao động.

Hệ thống cộng thêm các khoản phụ cấp thuộc quỹ lương, phụ cấp ngoài quỹ lương và tiền thưởng để tính tổng thu nhập. Kết quả tính lương được sử dụng làm đầu vào cho việc lập bảng thanh toán tiền lương. Hệ thống lưu trữ lịch sử tính lương theo từng kỳ, cho phép truy vấn và đối chiếu khi cần thiết.

Chức năng khấu trừ và theo dõi BHXH, BHYT, BHTN tính toán các khoản bảo hiểm phải nộp bao gồm phần người lao động chịu và phần hộ kinh doanh chịu theo quy định hiện hành. Phần người lao động chịu được khấu trừ từ tiền lương và ghi vào các cột tương ứng trong bảng lương. Hệ thống theo dõi số phải trả, số đã trả và số còn phải trả đối với cơ quan bảo hiểm xã hội trong sổ theo dõi tiền lương S5-HKD.

Chức năng theo dõi và thanh toán lương căn cứ vào số còn phải trả trong bảng lương để tạo phiếu chi trả lương. Hệ thống hỗ trợ hai phương thức thanh toán là trả bằng tiền mặt và trả qua ngân hàng. Đối với thanh toán bằng tiền mặt, người lao động ký nhận trên bảng lương. Đối với thanh toán qua ngân hàng, hệ thống tạo lệnh chuyển khoản hàng loạt và không yêu cầu chữ ký trên bảng lương. Sau khi thanh toán, hệ thống cập nhật sổ theo dõi tiền lương với số đã trả và tính số còn phải trả.

### 5.7. Module Tiền tệ

Module Tiền tệ quản lý quỹ tiền mặt và tiền gửi ngân hàng, theo dõi các giao dịch thu chi và đối chiếu số liệu với thực tế. Module này đảm bảo tính chính xác và kịp thời của thông tin về tài sản lưu động của hộ kinh doanh.

Chức năng quản lý quỹ tiền mặt mở sổ quỹ tiền mặt S6-HKD đầu kỳ kế toán và kết chuyển số dư từ kỳ trước. Hệ thống tự động cập nhật số dư tồn quỹ khi có phiếu thu hoặc phiếu chi được thực hiện, hiển thị số dư real-time sau mỗi giao dịch. Chức năng cảnh báo khi số dư quỹ âm, ngăn chặn việc chi tiền vượt quá số tiền mặt thực tế trong quỹ. Cuối tháng, hệ thống so sánh số dư trên sổ với tiền mặt thực tế, yêu cầu lập biên bản xử lý nếu có chênh lệch trước khi khóa sổ.

Chức năng quản lý tiền gửi ngân hàng mở sổ tiền gửi ngân hàng S7-HKD cho từng tài khoản tại từng ngân hàng. Hệ thống ghi nhận các khoản gửi vào dựa trên giấy báo có hoặc ủy nhiệm thu, các khoản rút ra dựa trên giấy báo nợ hoặc ủy nhiệm chi. Số dư còn lại được tính tự động sau mỗi giao dịch. Cuối tháng, hệ thống đối chiếu số dư trên sổ với sao kê ngân hàng, xác định và xử lý các chênh lệch thừa hoặc thiếu nếu có.

### 5.8. Module Quản trị hệ thống

Module Quản trị hệ thống cung cấp các chức năng quản lý và vận hành hệ thống, đảm bảo tính bảo mật, toàn vẹn dữ liệu và tuân thủ các quy định pháp luật về kế toán.

Chức năng quản lý tài khoản người dùng và phân quyền cho phép quản trị viên tạo, chỉnh sửa và vô hiệu hóa tài khoản người dùng. Hệ thống áp dụng nguyên tắc phân quyền Role-Based Access Control với năm vai trò chính là kế toán viên, thủ quỹ, thủ kho, người đại diện hộ kinh doanh và quản trị viên. Mỗi vai trò có các quyền hạn chế được định nghĩa rõ ràng, đảm bảo nguyên tắc bất kiêm nhiệm trong các nghiệp vụ kế toán.

Hệ thống ghi nhận trường hợp một người kiêm nhiệm nhiều chức danh, phổ biến trong các hộ kinh doanh quy mô nhỏ theo quy định tại Điều 3 Thông tư 88/2021. Khi đó, hệ thống cho phép cùng một người dùng có nhiều vai trò đồng thời nhưng vẫn ghi nhận đầy đủ các chức danh kiêm nhiệm trên các chứng từ và báo cáo.

Chức năng sửa chữa và điều chỉnh sổ kế toán cho phép thực hiện các bút toán điều chỉnh khi phát hiện sai sót. Hệ thống hỗ trợ hai phương pháp sửa chữa tùy theo thời điểm phát hiện sai sót. Đối với sai sót trong kỳ và chưa khóa sổ, hệ thống hỗ trợ phương pháp gạch chân và ghi số đúng. Đối với sai sót phát hiện sau khi khóa sổ, hệ thống yêu cầu lập bút toán điều chỉnh ghi âm hoặc ghi bổ sung. Mọi điều chỉnh đều được ghi nhận lý do, người thực hiện và ngày điều chỉnh trong audit trail.

Chức năng đóng kỳ kế toán và khóa sổ thực hiện quy trình đóng kỳ bao gồm kiểm tra toàn bộ chứng từ trong kỳ đã được phê duyệt và ghi sổ đầy đủ, đối chiếu số dư quỹ tiền mặt với thực tế, đối chiếu số dư tiền gửi ngân hàng với sao kê, kiểm kê hàng tồn kho lần cuối và xác nhận số thuế phải nộp và đã nộp. Sau khi hoàn tất các bước đối chiếu, hệ thống cập nhật trạng thái kỳ kế toán thành khóa sổ, chuyển toàn bộ giao dịch trong kỳ sang chế độ chỉ đọc.

Chức năng báo cáo tổng hợp cuối kỳ cung cấp các báo cáo cần thiết bao gồm tổng hợp doanh thu theo ngành nghề, tổng hợp chi phí sản xuất kinh doanh, tình hình thực hiện nghĩa vụ thuế, tình hình tồn kho cuối kỳ, tình hình quỹ tiền mặt, tình hình tiền gửi ngân hàng và bảng tổng hợp lương và bảo hiểm xã hội. Các báo cáo được xuất theo định dạng PDF và Excel, đảm bảo phù hợp với yêu cầu của cơ quan chức năng và phục vụ quản trị nội bộ.

Chức năng lưu trữ và tra cứu lịch sử chứng từ cung cấp giao diện tìm kiếm và truy xuất chứng từ theo nhiều tiêu chí bao gồm số phiếu, ngày tháng, loại chứng từ, người lập, người phê duyệt, kỳ kế toán và địa điểm kinh doanh. Hệ thống cho phép xuất danh sách chứng từ theo bộ lọc để phục vụ các yêu cầu báo cáo và kiểm toán.

Chức năng nhật ký hệ thống và audit trail ghi lại toàn bộ hoạt động của người dùng trong hệ thống bao gồm thông tin người thực hiện, hành động thực hiện, đối tượng bị tác động, thời gian chính xác đến giây và giá trị trước và sau khi thay đổi. Dữ liệu audit log được thiết kế với cơ chế chỉ ghi thêm, không cho phép sửa hoặc xóa bởi bất kỳ người dùng nào kể cả quản trị viên, đảm bảo tính toàn vẹn pháp lý của nhật ký kiểm toán.

---

## 6. Thiết kế bảo mật

### 6.1. Xác thực và ủy quyền

Hệ thống áp dụng cơ chế xác thực đa lớp để đảm bảo chỉ người dùng hợp lệ mới có thể truy cập vào hệ thống. Lớp xác thực đầu tiên sử dụng tên đăng nhập và mật khẩu, trong đó mật khẩu được lưu trữ dưới dạng băm sử dụng thuật toán bcrypt với salt ngẫu nhiên. Hệ thống yêu cầu mật khẩu có độ dài tối thiểu tám ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt để tăng cường độ an toàn.

Lớp xác thực thứ hai sử dụng mã xác thực OTP One-Time Password được gửi qua SMS hoặc email cho các giao dịch quan trọng như phê duyệt chứng từ có giá trị lớn, điều chỉnh sổ kế toán sau khi khóa sổ hoặc thay đổi thông tin thuế suất. Mã OTP có thời hạn năm phút và chỉ có hiệu lực cho một giao dịch duy nhất.

Quản lý phiên làm việc session management được thực hiện thông qua JWT với thời gian hết hạn ngắn cho access token và cơ chế refresh token để duy trì đăng nhập. Hệ thống hỗ trợ đăng nhập từ nhiều thiết bị đồng thời với giới hạn tối đa ba phiên hoạt động. Người dùng có thể đăng xuất từ xa từ một thiết bị cụ thể nếu nghi ngờ bị xâm phạm.

Phân quyền dựa trên vai trò RBAC được triển khai chi tiết với các quyền được định nghĩa ở cấp độ chức năng. Nguyên tắc bất kiêm nhiệm được thực thi nghiêm ngặt thông qua các ràng buộc hệ thống. Kế toán viên lập chứng từ không thể tự phê duyệt chứng từ của mình, người đại diện phê duyệt không thể vừa lập vừa phê duyệt cùng một chứng từ. Trường hợp vi phạm nguyên tắc này, hệ thống từ chối thực hiện thao tác và ghi nhận vào log cảnh báo.

### 6.2. Mã hóa dữ liệu

Dữ liệu được mã hóa ở cả hai trạng thái at-rest và in-transit để bảo vệ khỏi các mối đe dọa từ bên ngoài và bên trong. Dữ liệu truyền qua mạng được bảo vệ bằng giao thức TLS 1.3 với bộ mật mã hiện đại, đảm bảo tính bảo mật và toàn vẹn của dữ liệu trên đường truyền. Chứng chỉ SSL được cấp phát từ nhà cung cấp uy tín và tự động gia hạn trước ngày hết hạn.

Dữ liệu lưu trữ trong cơ sở dữ liệu được mã hóa bằng tính năng Transparent Data Encryption của PostgreSQL với thuật toán AES-256. Các trường nhạy cảm như số tài khoản ngân hàng, mã số thuế cá nhân và thông tin lương được mã hóa ở cấp ứng dụng trước khi lưu vào cơ sở dữ liệu, đảm bảo an toàn ngay cả khi ai đó có quyền truy cập vào cơ sở dữ liệu.

Khóa mật mã được quản lý thông qua hệ thống Key Management Service như AWS KMS hoặc HashiCorp Vault, với chính sách luân chuyển khóa định kỳ mỗi chín mươi ngày. Khóa dự phòng được lưu trữ ở vị trí vật lý riêng biệt với các biện pháp bảo vệ vật lý nghiêm ngặt.

### 6.3. Audit và giám sát

Hệ thống ghi log toàn bộ hoạt động ở ba cấp độ bao gồm audit log cho các nghiệp vụ kế toán, security log cho các sự kiện bảo mật và application log cho các lỗi ứng dụng. Audit log lưu trữ thông tin chi tiết về người thực hiện, hành động, đối tượng, thời gian và giá trị trước sau khi thay đổi. Security log ghi nhận các sự kiện như đăng nhập thất bại, truy cập từ địa lạ, thay đổi quyền người dùng và các nỗ lực tấn công.

Hệ thống giám sát sử dụng các công cụ như Prometheus và Grafana để theo dõi hiệu suất và tình trạng hoạt động của các thành phần. Cảnh báo tự động được gửi qua email và SMS khi phát hiện bất thường như số lượng request bất thường, thời gian phản hồi cao hoặc tài nguyên hệ thống vượt ngưỡng.

Định kỳ hàng tháng, hệ thống thực hiện đánh giá bảo mật bao gồm penetration testing và vulnerability assessment để phát hiện và khắc phục các điểm yếu bảo mật tiềm ẩn. Kết quả đánh giá được báo cáo cho ban lãnh đạo và kế hoạch khắc phục được theo dõi đến khi hoàn tất.

---

## 7. Triển khai và vận hành

### 7.1. Cấu trúc triển khai

Hệ thống được triển khai trên kiến trúc container sử dụng Docker và Kubernetes cho việc quản lý và orchestrate. Môi trường triển khai bao gồm ba môi trường chính là development cho phát triển và kiểm thử, staging cho UAT và pre-production, và production cho vận hành thực tế.

Mỗi môi trường được triển khai trên các cluster riêng biệt với cấu hình phù hợp. Môi trường development sử dụng cấu hình đơn giản với một node, phục vụ mục đích phát triển và kiểm thử nhanh. Môi trường staging sử dụng cấu hình ba node để đảm bảo độ tin cậy trong quá trình kiểm thử. Môi trường production sử dụng cấu hình năm node với auto-scaling để đảm bảo high availability và khả năng chịu lỗi.

Cơ sở dữ liệu PostgreSQL được triển khai với cấu hình primary-standby replication để đảm bảo high availability. Standby server đồng bộ dữ liệu real-time từ primary server, sẵn sàng tiếp nhận khi primary server gặp sự cố. Backup được thực hiện tự động mỗi ngày với retention policy mười năm theo quy định pháp luật về lưu trữ hồ sơ kế toán.

### 7.2. Chiến lược migration và upgrade

Migration dữ liệu từ hệ thống cũ sang hệ thống mới được thực hiện theo quy trình bốn bước bao gồm extraction, transformation, validation và loading. Trong giai đoạn extraction, dữ liệu được trích xuất từ hệ thống nguồn bao gồm chứng từ, sổ kế toán, danh mục và các thông tin liên quan. Giai đoạn transformation chuyển đổi dữ liệu sang định dạng phù hợp với cấu trúc mới, bao gồm chuyển đổi mã hóa, định dạng ngày tháng và kiểm tra tính nhất quán. Giai đoạn validation kiểm tra dữ liệu sau chuyển đổi để đảm bảo tính chính xác và đầy đủ. Giai đoạn loading đưa dữ liệu vào hệ thống mới và xác nhận lần cuối.

Upgrade hệ thống được thực hiện với chiến lược blue-green deployment, cho phép chuyển đổi nhanh chóng giữa phiên bản cũ và phiên bản mới mà không gây downtime cho người dùng. Trước khi triển khai phiên bản mới trên môi trường production, hệ thống được kiểm thử kỹ lưỡng trên môi trường staging với dữ liệu production đã được ẩn danh.

### 7.3. Sao lưu và phục hồi

Chiến lược sao lưu bao gồm ba cấp độ bao gồm sao lưu hàng ngày, sao lưu hàng giờ và sao lưu transaction log. Sao lưu hàng ngày được thực hiện vào lúc 2 giờ sáng, bao gồm toàn bộ cơ sở dữ liệu và file đính kèm. Sao lưu hàng giờ được thực hiện trong giờ làm việc để giảm thiểu mất mát dữ liệu trong trường hợp xảy ra sự cố. Transaction log được sao lưu liên tục mỗi mười lăm phút, cho phép phục hồi đến thời điểm gần nhất trước khi xảy ra sự cố.

Dữ liệu sao lưu được lưu trữ ở hai vị trí địa lý khác nhau để đảm bảo khả năng phục hồi trong trường hợp xảy ra thảm họa tự nhiên hoặc sự cố hạ tầng tại một vị trí. Mỗi tháng, hệ thống thực hiện drill phục hồi để xác nhận tính khả dụng của dữ liệu sao lưu và quy trình phục hồi hoạt động đúng.

RPO Recovery Point Objective được đặt là một giờ, nghĩa là trong trường hợp xảy ra sự cố, hệ thống có thể phục hồi với mất mát dữ liệu không quá một giờ. RTO Recovery Time Objective được đặt là bốn giờ, nghĩa là hệ thống phải khôi phục và hoạt động trở lại trong vòng bốn giờ kể từ khi xảy ra sự cố.

---

## 8. Kết luận và lộ trình triển khai

### 8.1. Tóm tắt thiết kế

Thiết kế hệ thống kế toán HKD/CNKD được xây dựng dựa trên nền tảng kiến trúc ba tầng với các microservices chuyên biệt cho từng nhóm chức năng. Hệ thống đáp ứng đầy đủ forty-three use cases được định nghĩa trong tài liệu phân tích nghiệp vụ, tuân thủ nghiêm ngặt các quy định tại Thông tư 88/2021/TT-BTC và các văn bản pháp luật liên quan về kế toán, thuế và lao động.

Kiến trúc modular cho phép phát triển và triển khai độc lập từng nhóm chức năng, đồng thời đảm bảo tính tích hợp và nhất quán dữ liệu thông qua các interface được định nghĩa rõ ràng. Cơ sở dữ liệu được thiết kế theo nguyên tắc chuẩn hóa cao, kết hợp với các chiến lược index và cache để đảm bảo hiệu suất tối ưu. Bảo mật được thiết kế nhiều lớp từ xác thực, ủy quyền, mã hóa đến audit trail, đáp ứng các yêu cầu nghiêm ngặt về bảo mật dữ liệu kế toán.

### 8.2. Lộ trình triển khai đề xuất

Dựa trên ma trận phụ thuộc giữa các use cases, lộ trình triển khai được chia thành bảy sprint với tổng thời gian ước tính mười tám tuần. Sprint Zero tập trung vào việc thiết lập nền tảng bao gồm toàn bộ các use cases trong nhóm Master Data, đây là tiền đề bắt buộc cho mọi nghiệp vụ tiếp theo. Sprint One triển khai nhóm Chứng từ và Tiền tệ bao gồm phiếu thu, phiếu chi, sổ quỹ tiền mặt và sổ tiền gửi ngân hàng, là các nghiệp vụ cơ bản nhất của kế toán.

Sprint Two triển khai nhóm Kho hàng bao gồm phiếu nhập kho, phiếu xuất kho, kiểm kê và tính giá xuất kho. Sprint Three triển khai nhóm Doanh thu và Sổ Kế toán bao gồm mở sổ, sổ doanh thu, sổ chi phí và lưu trữ chứng từ. Sprint Four triển khai nhóm Thuế bao gồm xác định doanh thu chịu thuế, tính thuế GTGT, tính thuế TNCN và theo dõi nộp thuế.

Sprint Five triển khai nhóm Nhân sự và Lương bao gồm tính lương, khấu trừ bảo hiểm, thanh toán lương và sổ theo dõi tiền lương. Sprint Six hoàn thiện hệ thống với các chức năng quản trị bao gồm báo cáo tổng hợp, sửa chữa sổ kế toán, đóng kỳ và audit trail. Sau mỗi sprint, hệ thống được kiểm thử tích hợp và regression testing để đảm bảo các tính năng mới không ảnh hưởng đến các tính năng đã triển khai.

### 8.3. Các rủi ro và giả định

Các rủi ro tiềm ẩn trong quá trình triển khai bao gồm thay đổi quy định pháp luật về thuế, kế toán hoặc bảo hiểm xã hội trong thời gian triển khai, yêu cầu tích hợp với các hệ thống bên thứ ba như cổng hóa đơn điện tử hoặc ngân hàng, và khó khăn trong migration dữ liệu từ hệ thống kế toán hiện có nếu có. Để giảm thiểu các rủi ro này, hệ thống được thiết kế với các cấu hình linh hoạt cho phép cập nhật thuế suất và các tham số nghiệp vụ mà không cần thay đổi code, đồng thời tích hợp với bên thứ ba được triển khai theo từng giai đoạn với ưu tiên cao nhất.

Các giả định trong thiết kế này bao gồm hộ kinh doanh có quy mô nhỏ với một địa điểm kinh doanh chính, phần cứng và hạ tầng mạng đáp ứng yêu cầu của hệ thống, và người dùng có kiến thức cơ bản về sử dụng máy tính và internet. Các giả định này cần được xác nhận với stakeholder trước khi tiến hành triển khai.

---

*Tài liệu thiết kế hệ thống này là đầu ra của giai đoạn phân tích và thiết kế hệ thống. Mọi thay đổi cần được xem xét và phê duyệt bởi System Architect và các bên liên quan trước khi tiến hành triển khai.*
