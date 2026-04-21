# Use Case Specification — Hệ thống kế toán HKD/CNKD
**Căn cứ pháp lý:** Thông tư 88/2021/TT-BTC ngày 11/10/2021 của Bộ Tài chính  
**Hiệu lực:** 01/01/2022  
**Phiên bản tài liệu:** 1.0  
**Người phân tích:** Lead BA  
**Ngày lập:** 2025  

---

## Mục lục

1. [Tổng quan hệ thống](#1-tổng-quan-hệ-thống)
2. [Danh sách actors](#2-danh-sách-actors)
3. [Danh sách use cases tổng hợp](#3-danh-sách-use-cases-tổng-hợp)
4. [Nhóm MD — Master Data](#4-nhóm-md--master-data)
5. [Nhóm CT — Chứng từ kế toán](#5-nhóm-ct--chứng-từ-kế-toán)
6. [Nhóm SK — Sổ kế toán](#6-nhóm-sk--sổ-kế-toán)
7. [Nhóm KH — Kho hàng](#7-nhóm-kh--kho-hàng)
8. [Nhóm TX — Thuế](#8-nhóm-tx--thuế)
9. [Nhóm NS — Nhân sự & tiền lương](#9-nhóm-ns--nhân-sự--tiền-lương)
10. [Nhóm TT — Tiền tệ](#10-nhóm-tt--tiền-tệ)
11. [Nhóm QT — Quản trị hệ thống](#11-nhóm-qt--quản-trị-hệ-thống)
12. [Ma trận phụ thuộc use cases](#12-ma-trận-phụ-thuộc-use-cases)
13. [Thứ tự triển khai đề xuất](#13-thứ-tự-triển-khai-đề-xuất)

---

## 1. Tổng quan hệ thống

### Phạm vi
Hệ thống hỗ trợ hộ kinh doanh (HKD) và cá nhân kinh doanh (CNKD) nộp thuế theo phương pháp kê khai thực hiện đầy đủ chế độ kế toán theo quy định tại Thông tư 88/2021/TT-BTC, bao gồm:
- Lập, lưu trữ và phê duyệt toàn bộ chứng từ kế toán bắt buộc
- Ghi và quản lý 7 loại sổ kế toán (S1-HKD đến S7-HKD)
- Quản lý kho hàng hóa, vật tư, sản phẩm
- Theo dõi và tính toán nghĩa vụ thuế (GTGT, TNCN)
- Quản lý nhân sự và thanh toán tiền lương
- Quản lý quỹ tiền mặt và tài khoản ngân hàng

### Tổng số use cases: 43
| Nhóm | Ký hiệu | Số lượng |
|------|---------|----------|
| Master Data | MD | 8 |
| Chứng từ kế toán | CT | 8 |
| Sổ kế toán | SK | 8 |
| Kho hàng | KH | 4 |
| Thuế | TX | 4 |
| Nhân sự & tiền lương | NS | 3 |
| Tiền tệ | TT | 2 |
| Quản trị hệ thống | QT | 6 |
| **Tổng** | | **43** |

---

## 2. Danh sách Actors

### Actors nội bộ
| Actor | Mô tả | Quyền hạn chính |
|-------|-------|----------------|
| Người đại diện HKD | Chủ hộ kinh doanh hoặc người được ủy quyền | Phê duyệt chứng từ, ký sổ kế toán, quản lý toàn bộ |
| Kế toán viên | Người thực hiện công tác kế toán | Lập chứng từ, ghi sổ, tính thuế, lập bảng lương |
| Thủ quỹ | Người quản lý quỹ tiền mặt (có thể kiêm nhiệm) | Thu chi tiền mặt, ghi sổ quỹ |
| Thủ kho | Người quản lý kho hàng hóa (có thể kiêm nhiệm) | Nhập xuất kho, kiểm kê |
| Admin hệ thống | Quản trị viên ứng dụng | Cấu hình, phân quyền, quản lý master data hệ thống |

### Actors ngoài hệ thống
| Actor | Mô tả | Tương tác |
|-------|-------|-----------|
| Cơ quan thuế | Cục thuế / Chi cục thuế | Nhận tờ khai, giấy nộp thuế |
| Cơ quan BHXH | Bảo hiểm xã hội | Nhận chứng từ nộp BHXH/BHYT/BHTN |
| Ngân hàng | Ngân hàng giao dịch của HKD | Giấy báo Nợ/Có, sao kê tài khoản |
| Người lao động | NLĐ làm việc tại HKD | Ký nhận lương |
| Nhà cung cấp | Đơn vị cung cấp hàng hóa/DV đầu vào | Giao hàng, xuất hóa đơn |
| Khách hàng | Bên mua hàng hóa/DV | Nhận hóa đơn, nộp tiền |

---

## 3. Danh sách Use Cases tổng hợp

### Nguyên tắc sắp xếp
Các use cases được sắp xếp theo thứ tự **phụ thuộc dữ liệu** (data dependency order):
1. Master Data phải được thiết lập trước khi thực hiện bất kỳ nghiệp vụ nào
2. Trong Master Data: Tầng 1 (độc lập) → Tầng 2 (phụ thuộc Tầng 1) → Tầng 3 (cấu hình)
3. Chứng từ là đầu vào của Sổ kế toán — CT phải trước SK
4. Kho hàng cần Chứng từ (phiếu nhập/xuất)
5. Thuế cần Sổ doanh thu (S1) — TX sau SK
6. Nhân sự cần Chứng từ (phiếu chi, bảng lương)

### Danh sách đầy đủ

| STT | Mã UC | Tên use case | Nhóm | Actor chính | Phụ thuộc |
|-----|-------|-------------|------|------------|-----------|
| 1 | MD-01 | Quản lý thông tin HKD/CNKD | Master Data | Người đại diện | — |
| 2 | MD-02 | Quản lý danh mục hàng hóa/dịch vụ | Master Data | Kế toán viên | MD-03 |
| 3 | MD-03 | Quản lý danh mục ngành nghề & thuế suất | Master Data | Admin | — |
| 4 | MD-04 | Quản lý danh mục nhà cung cấp | Master Data | Kế toán viên | MD-01 |
| 5 | MD-05 | Quản lý danh mục khách hàng | Master Data | Kế toán viên | MD-01 |
| 6 | MD-06 | Quản lý danh mục người lao động | Master Data | Kế toán / Đại diện | MD-01 |
| 7 | MD-07 | Quản lý danh mục tài khoản ngân hàng | Master Data | Người đại diện | MD-01 |
| 8 | MD-08 | Cấu hình kỳ kế toán | Master Data | Admin | MD-01 |
| 9 | CT-01 | Lập phiếu thu | Chứng từ | Kế toán viên | MD-01, MD-05 |
| 10 | CT-02 | Lập phiếu chi | Chứng từ | Kế toán viên | MD-01 |
| 11 | CT-03 | Lập phiếu nhập kho | Chứng từ | Thủ kho / KTV | MD-02, MD-04 |
| 12 | CT-04 | Lập phiếu xuất kho | Chứng từ | Thủ kho / KTV | MD-02 |
| 13 | CT-05 | Lập bảng thanh toán tiền lương & thu nhập NLĐ | Chứng từ | Kế toán viên | MD-06 |
| 14 | CT-06 | Quản lý hóa đơn (đầu vào & đầu ra) | Chứng từ | Kế toán viên | MD-02, MD-03, MD-04, MD-05 |
| 15 | CT-07 | Lưu trữ chứng từ kế toán | Chứng từ | Kế toán viên | MD-08 |
| 16 | CT-08 | Phê duyệt chứng từ (ký duyệt) | Chứng từ | Người đại diện | CT-01 đến CT-05 |
| 17 | SK-01 | Mở sổ kế toán đầu kỳ | Sổ kế toán | Kế toán viên | MD-01, MD-08 |
| 18 | SK-02 | Ghi sổ chi tiết doanh thu bán hàng/DV (S1-HKD) | Sổ kế toán | Hệ thống / KTV | CT-06, MD-03 |
| 19 | SK-03 | Ghi sổ chi tiết vật tư, hàng hóa (S2-HKD) | Sổ kế toán | Hệ thống / KTV | CT-03, CT-04 |
| 20 | SK-04 | Ghi sổ chi phí sản xuất kinh doanh (S3-HKD) | Sổ kế toán | Hệ thống / KTV | CT-02, CT-04 |
| 21 | SK-05 | Ghi sổ theo dõi nghĩa vụ thuế với NSNN (S4-HKD) | Sổ kế toán | Hệ thống / KTV | SK-02, TX-02, TX-03 |
| 22 | SK-06 | Ghi sổ theo dõi thanh toán tiền lương (S5-HKD) | Sổ kế toán | Hệ thống / KTV | CT-05 |
| 23 | SK-07 | Ghi sổ quỹ tiền mặt (S6-HKD) | Sổ kế toán | Thủ quỹ | CT-01, CT-02 |
| 24 | SK-08 | Ghi sổ tiền gửi ngân hàng (S7-HKD) | Sổ kế toán | Kế toán viên | MD-07 |
| 25 | KH-01 | Nhập kho hàng hóa | Kho hàng | Thủ kho | CT-03, MD-02 |
| 26 | KH-02 | Xuất kho hàng hóa | Kho hàng | Thủ kho | CT-04, MD-02, SK-03 |
| 27 | KH-03 | Kiểm kê hàng tồn kho | Kho hàng | Thủ kho / KTV | SK-03 |
| 28 | KH-04 | Tính giá xuất kho (Bình quân / FIFO) | Kho hàng | Hệ thống | MD-01 (phương pháp), SK-03 |
| 29 | TX-01 | Xác định doanh thu chịu thuế | Thuế | Kế toán viên | SK-02, MD-03 |
| 30 | TX-02 | Tính thuế giá trị gia tăng (GTGT) | Thuế | Kế toán viên | TX-01, MD-03 |
| 31 | TX-03 | Tính thuế thu nhập cá nhân (TNCN) | Thuế | Kế toán viên | TX-01, CT-05, MD-03 |
| 32 | TX-04 | Theo dõi nộp thuế vào NSNN | Thuế | Kế toán viên | TX-02, TX-03, SK-05 |
| 33 | NS-01 | Tính lương người lao động | Nhân sự | Kế toán viên | MD-06 |
| 34 | NS-02 | Khấu trừ và theo dõi BHXH/BHYT/BHTN | Nhân sự | Kế toán viên | NS-01, MD-06 |
| 35 | NS-03 | Theo dõi và thanh toán lương | Nhân sự | KTV / Thủ quỹ | CT-05, NS-01, NS-02 |
| 36 | TT-01 | Quản lý quỹ tiền mặt | Tiền tệ | Thủ quỹ | CT-01, CT-02, SK-07 |
| 37 | TT-02 | Quản lý tiền gửi ngân hàng | Tiền tệ | Kế toán viên | MD-07, SK-08 |
| 38 | QT-01 | Quản lý danh mục tài khoản người dùng & phân quyền | Quản trị | Admin | MD-01 |
| 39 | QT-02 | Sửa chữa / điều chỉnh sổ kế toán | Quản trị | KTV / Đại diện | SK-01 đến SK-08 |
| 40 | QT-03 | Đóng kỳ kế toán và khóa sổ | Quản trị | Admin / Đại diện | MD-08, tất cả SK |
| 41 | QT-04 | Báo cáo tổng hợp cuối kỳ | Quản trị | Kế toán viên | Tất cả SK, TX |
| 42 | QT-05 | Lưu trữ và tra cứu lịch sử chứng từ | Quản trị | Kế toán viên | CT-07 |
| 43 | QT-06 | Nhật ký hệ thống và audit trail | Quản trị | Admin | Tất cả |

---

## 4. Nhóm MD — Master Data

> **Nguyên tắc:** Setup-once, reuse-everywhere. Toàn bộ nhóm MD phải được hoàn thành trước khi vận hành bất kỳ module nghiệp vụ nào.

---

### MD-01: Quản lý thông tin HKD/CNKD

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | MD-01 |
| Tên | Quản lý thông tin HKD/CNKD |
| Tầng | Master Data Tầng 1 (core identity) |
| Actor chính | Người đại diện HKD |
| Actor phụ | Admin hệ thống |
| Phụ thuộc | Không có |
| Được dùng bởi | Tất cả 42 UC còn lại |

**Tiền điều kiện:** Hệ thống được cài đặt lần đầu  
**Hậu điều kiện:** Thông tin HKD được lưu, là nền tảng cho toàn bộ hoạt động hệ thống

**Dữ liệu quản lý:**
| Field | Bắt buộc | Ghi chú |
|-------|---------|--------|
| Tên hộ kinh doanh / cá nhân kinh doanh | Có | Theo giấy phép kinh doanh |
| Địa chỉ trụ sở chính | Có | |
| Mã số thuế (MST) | Có | Khóa định danh duy nhất |
| Danh sách địa điểm kinh doanh | Có | Mỗi địa điểm mở sổ KT riêng |
| Phương pháp tính giá xuất kho | Có | Bình quân gia quyền HOẶC FIFO |
| Kỳ kế toán áp dụng | Có | Năm dương lịch |
| Họ tên người đại diện | Có | |
| Số CCCD/CMND người đại diện | Có | |

**Business rules:**
- MST là khóa duy nhất, không được trùng, không được thay đổi sau khi tạo
- Phương pháp tính giá xuất kho chỉ chọn 1 lần, nhất quán cả năm tài chính — không cho phép thay đổi giữa chừng
- Mỗi địa điểm kinh doanh tạo ra một bộ sổ kế toán riêng biệt

---

### MD-02: Quản lý danh mục hàng hóa/dịch vụ

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | MD-02 |
| Tầng | Master Data Tầng 1 |
| Actor chính | Kế toán viên |
| Phụ thuộc | MD-03 (để gán nhóm ngành nghề — lấy thuế suất) |
| Được dùng bởi | CT-03, CT-04, CT-06, KH-01, KH-02, KH-04, SK-02, SK-03 |

**Dữ liệu quản lý:**
| Field | Bắt buộc | Ghi chú |
|-------|---------|--------|
| Mã hàng hóa/DV | Có | Tự sinh, duy nhất, immutable |
| Tên hàng hóa/DV | Có | Khớp với tên trên hóa đơn |
| Nhãn hiệu, quy cách, phẩm chất | Không | Dùng trên phiếu nhập/xuất kho |
| Đơn vị tính | Có | kg, cái, hộp, m², lần... |
| Nhóm ngành nghề kinh doanh | Có | FK → MD-03 (tự động lấy thuế suất) |
| Loại hàng | Có | Vật tư / Hàng hóa / Thành phẩm / Dịch vụ |
| Đơn giá mua chuẩn | Không | Tham khảo, có thể override |
| Trạng thái | Có | Đang kinh doanh / Ngừng kinh doanh |

**Business rules:**
- Không xóa hàng đã phát sinh giao dịch — chỉ đặt trạng thái "Ngừng kinh doanh"
- Mã hàng hóa sau khi tạo không được thay đổi (immutable key)
- Một mặt hàng chỉ thuộc một nhóm ngành nghề để đảm bảo tính thuế đúng cột trên S1

---

### MD-03: Quản lý danh mục ngành nghề & thuế suất

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | MD-03 |
| Tầng | Master Data Tầng 1 (hệ thống) |
| Actor chính | Admin hệ thống |
| Phụ thuộc | Không có |
| Được dùng bởi | MD-02, SK-02, TX-02, TX-03, CT-06 |

**Dữ liệu quản lý:**
| Field | Bắt buộc | Ghi chú |
|-------|---------|--------|
| Mã nhóm ngành nghề | Có | Theo phân loại cơ quan thuế |
| Tên nhóm ngành nghề | Có | Ví dụ: "Phân phối, cung cấp hàng hóa" |
| Tỷ lệ % thuế GTGT | Có | 1%, 5%, 10%, 0% (không chịu thuế) |
| Tỷ lệ % thuế TNCN | Có | 0.5%, 2%, 5%... theo ngành nghề |
| Ngày hiệu lực | Có | Lịch sử thay đổi thuế suất |
| Ngày hết hiệu lực | Không | NULL = đang hiệu lực |

**Business rules:**
- Lưu lịch sử thay đổi thuế suất (versioning) — giao dịch cũ giữ thuế suất tại thời điểm phát sinh
- Read-only với người dùng thông thường — chỉ Admin được cập nhật
- Cập nhật thuế suất yêu cầu xác nhận 2 bước (prevent accidental change)

---

### MD-04: Quản lý danh mục nhà cung cấp

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | MD-04 |
| Tầng | Master Data Tầng 2 |
| Actor chính | Kế toán viên |
| Phụ thuộc | MD-01 |
| Được dùng bởi | CT-03, CT-06 |

**Dữ liệu quản lý:**
| Field | Bắt buộc | Ghi chú |
|-------|---------|--------|
| Mã nhà cung cấp | Có | Tự sinh, duy nhất |
| Tên nhà cung cấp | Có | |
| Địa chỉ | Có | |
| Mã số thuế | Không | Bắt buộc nếu là tổ chức (lấy hóa đơn GTGT) |
| Số tài khoản ngân hàng | Không | Phục vụ thanh toán chuyển khoản |
| Người liên hệ, số điện thoại | Không | |
| Loại nhà cung cấp | Có | Tổ chức / Cá nhân |
| Trạng thái | Có | Đang giao dịch / Ngừng |

**Business rules:**
- Không xóa nhà cung cấp đã phát sinh giao dịch
- Tên nhà cung cấp trên phiếu nhập kho và hóa đơn phải khớp với bản ghi MD-04

---

### MD-05: Quản lý danh mục khách hàng

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | MD-05 |
| Tầng | Master Data Tầng 2 |
| Actor chính | Kế toán viên |
| Phụ thuộc | MD-01 |
| Được dùng bởi | CT-01, CT-04, CT-06 |

**Dữ liệu quản lý:**
| Field | Bắt buộc | Ghi chú |
|-------|---------|--------|
| Mã khách hàng | Có | Tự sinh, duy nhất |
| Tên khách hàng | Có | |
| Địa chỉ | Không | |
| Mã số thuế | Không | Bắt buộc nếu KH yêu cầu hóa đơn GTGT |
| Số điện thoại | Không | |
| Loại khách hàng | Có | Tổ chức / Cá nhân / Bán lẻ |
| Trạng thái | Có | Đang giao dịch / Ngừng |

**Business rules:**
- Tạo sẵn bản ghi mặc định "Khách vãng lai" để gán nhanh cho giao dịch bán lẻ không cần tên
- Không xóa khách hàng đã phát sinh giao dịch

---

### MD-06: Quản lý danh mục người lao động

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | MD-06 |
| Tầng | Master Data Tầng 2 |
| Actor chính | Người đại diện HKD / Kế toán viên |
| Phụ thuộc | MD-01 |
| Được dùng bởi | CT-05, NS-01, NS-02, NS-03 |

**Dữ liệu quản lý:**
| Field | Bắt buộc | Ghi chú |
|-------|---------|--------|
| Mã nhân viên | Có | Tự sinh |
| Họ và tên | Có | |
| Số CCCD/CMND | Có | Để khai thuế TNCN |
| Mã số thuế cá nhân | Không | Nếu có |
| Bậc lương / hệ số lương | Có | |
| Hình thức trả lương | Có | Sản phẩm / Thời gian / Kết hợp |
| Đơn giá lương | Có | Theo đơn vị (SP hoặc ngày công) |
| Tỷ lệ % BHXH NLĐ chịu | Có | Theo quy định pháp luật hiện hành |
| Tỷ lệ % BHYT NLĐ chịu | Có | Theo quy định pháp luật hiện hành |
| Tỷ lệ % BHTN NLĐ chịu | Có | Theo quy định pháp luật hiện hành |
| Tài khoản ngân hàng NLĐ | Không | Để trả lương chuyển khoản |
| Ngày bắt đầu làm việc | Có | |
| Trạng thái | Có | Đang làm việc / Đã nghỉ việc |

**Business rules:**
- NLĐ đã nghỉ việc không được xóa — chỉ đổi trạng thái (cần để đối chiếu hồ sơ thuế, BHXH)
- Lịch sử thay đổi bậc lương phải được lưu lại (audit trail) — mỗi thay đổi ghi ngày hiệu lực
- Theo TT 88/2021, HKD được bố trí người thân (cha mẹ, vợ chồng, con, anh chị em ruột) làm kế toán

---

### MD-07: Quản lý danh mục tài khoản ngân hàng

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | MD-07 |
| Tầng | Master Data Tầng 3 (cấu hình vận hành) |
| Actor chính | Người đại diện HKD |
| Phụ thuộc | MD-01 |
| Được dùng bởi | SK-08, TT-02, NS-03 |

**Dữ liệu quản lý:**
| Field | Bắt buộc | Ghi chú |
|-------|---------|--------|
| Mã tài khoản (nội bộ) | Có | Tự sinh |
| Tên ngân hàng | Có | |
| Chi nhánh | Không | |
| Số tài khoản | Có | Duy nhất |
| Tên chủ tài khoản | Có | Phải khớp tên HKD/CNKD |
| Loại tài khoản | Có | Thanh toán / Tiết kiệm |
| Trạng thái | Có | Đang sử dụng / Đã đóng |

**Business rules:**
- Mỗi tài khoản ngân hàng tạo ra một sổ S7-HKD riêng biệt (theo quy định TT 88/2021)
- Tài khoản đã đóng không được xóa nếu còn giao dịch lịch sử

---

### MD-08: Cấu hình kỳ kế toán

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | MD-08 |
| Tầng | Master Data Tầng 3 (cấu hình hệ thống) |
| Actor chính | Admin hệ thống |
| Phụ thuộc | MD-01 |
| Được dùng bởi | SK-01, CT-07, QT-03, toàn bộ module ghi sổ |

**Dữ liệu quản lý:**
| Field | Bắt buộc | Ghi chú |
|-------|---------|--------|
| Năm tài chính | Có | Ví dụ: 2024 |
| Ngày bắt đầu kỳ | Có | 01/01/YYYY |
| Ngày kết thúc kỳ | Có | 31/12/YYYY |
| Trạng thái kỳ | Có | Mở / Đóng / Khóa sổ |
| Ngày khóa sổ thực tế | Không | Ghi nhận khi thực hiện QT-03 |

**Business rules:**
- Khi kỳ kế toán ở trạng thái "Khóa sổ": toàn bộ giao dịch thuộc kỳ đó là read-only
- Mỗi năm tài chính chỉ có một kỳ kế toán chính (năm dương lịch)
- Hệ thống cảnh báo khi cố ghi chứng từ vào kỳ đã đóng/khóa

---

## 5. Nhóm CT — Chứng từ kế toán

> **Căn cứ pháp lý:** Điều 4, Phụ lục 1 TT 88/2021/TT-BTC  
> **Nguyên tắc:** Mọi khoản thu/chi tiền mặt và mọi nghiệp vụ nhập/xuất kho đều bắt buộc có chứng từ. Không có chứng từ = không được ghi sổ.

---

### CT-01: Lập phiếu thu

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | CT-01 |
| Biểu mẫu | Mẫu số 01-TT |
| Actor chính | Kế toán viên |
| Actor phụ | Người đại diện HKD, Thủ quỹ, Người nộp tiền |
| Phụ thuộc | MD-01, MD-05 |
| Trigger | Phát sinh khoản tiền mặt nhập quỹ |

**Tiền điều kiện:** Có sự kiện phát sinh tiền mặt nhập quỹ (thu bán hàng, thu nợ, thu khác)  
**Hậu điều kiện:** Phiếu thu được tạo, ký duyệt; sổ quỹ tiền mặt (S6) tự động cập nhật

**Luồng chính:**
1. Kế toán viên khởi tạo phiếu thu mới trong kỳ kế toán đang mở
2. Hệ thống tự sinh số phiếu liên tục trong kỳ (không được ngắt quãng)
3. Kế toán điền: họ tên người nộp, địa chỉ, lý do nộp, số tiền (số và chữ), chứng từ gốc kèm theo
4. Người đại diện HKD ký duyệt; người nộp tiền ký xác nhận
5. Thủ quỹ nhận đủ tiền → ghi "Đã nhận đủ số tiền (bằng chữ)" → ký tên
6. Hệ thống tạo 2 liên: liên 1 lưu HKD dùng ghi sổ quỹ, liên 2 giao người nộp
7. Hệ thống tự động cập nhật sổ quỹ tiền mặt (SK-07)

**Luồng ngoại lệ:**
- Số tiền thực nhận khác số ghi trên phiếu → thủ quỹ không ký, trả lại kế toán chỉnh sửa

**Business rules:**
- Mọi khoản tiền mặt nhập quỹ bắt buộc phải có phiếu thu
- Phiếu thu không được xóa sau khi đã ký duyệt — chỉ được lập phiếu điều chỉnh
- Trường hợp đại diện kiêm thủ quỹ hoặc người lập biểu: ký đồng thời các chức danh kiêm nhiệm

---

### CT-02: Lập phiếu chi

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | CT-02 |
| Biểu mẫu | Mẫu số 02-TT |
| Actor chính | Kế toán viên |
| Actor phụ | Người đại diện HKD, Thủ quỹ, Người nhận tiền |
| Phụ thuộc | MD-01 |
| Trigger | Có nhu cầu chi tiền mặt hợp lệ, chứng từ gốc đã được duyệt |

**Tiền điều kiện:** Chứng từ gốc (hóa đơn mua hàng, bảng lương, hợp đồng...) đã được phê duyệt  
**Hậu điều kiện:** Phiếu chi được tạo, tiền được xuất quỹ; S6 tự động cập nhật

**Luồng chính:**
1. Kế toán lập phiếu chi: họ tên người nhận, địa chỉ, lý do chi, số tiền (số và chữ), chứng từ gốc kèm theo
2. Người đại diện HKD ký duyệt (ký theo từng liên)
3. Sau khi có chữ ký đại diện, thủ quỹ mới được xuất quỹ
4. Người nhận tiền ký xác nhận + ghi số tiền thực nhận bằng chữ
5. Hệ thống tự động cập nhật sổ quỹ tiền mặt (SK-07)

**Business rules:**
- Thủ quỹ tuyệt đối không xuất quỹ khi chưa có chữ ký đại diện
- Mọi khoản tiền mặt xuất quỹ bắt buộc phải có phiếu chi
- Phiếu chi không được xóa sau khi đã ký duyệt

---

### CT-03: Lập phiếu nhập kho

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | CT-03 |
| Biểu mẫu | Mẫu số 03-VT |
| Actor chính | Thủ kho / Kế toán viên |
| Actor phụ | Người giao hàng, Người đại diện HKD |
| Phụ thuộc | MD-02, MD-04 |
| Trigger | Nhận hàng mua ngoài / hàng tự sản xuất / hàng thuê gia công / hàng thừa phát hiện khi kiểm kê |

**Luồng chính:**
1. Thủ kho kiểm đếm hàng nhận thực tế
2. Kế toán lập phiếu: ghi tên/nhãn hiệu/quy cách/phẩm chất, mã số, đơn vị tính, số lượng theo chứng từ (cột 1), số lượng thực nhập (cột 2), đơn giá, thành tiền
3. Ghi số hóa đơn/lệnh nhập kho, địa điểm nhập kho
4. Người đại diện HKD ký duyệt
5. Hệ thống tự động cập nhật sổ chi tiết vật tư hàng hóa (SK-03)

**Business rules:**
- Số lượng thực nhập (cột 2) có thể khác số lượng theo chứng từ (cột 1) — phải ghi đúng số thực tế
- Phiếu nhập kho lập thành 2 liên: liên 1 lưu HKD, liên 2 giao người giao hàng

---

### CT-04: Lập phiếu xuất kho

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | CT-04 |
| Biểu mẫu | Mẫu số 04-VT |
| Actor chính | Thủ kho / Kế toán viên |
| Actor phụ | Người nhận hàng, Người đại diện HKD |
| Phụ thuộc | MD-02 |
| Trigger | Yêu cầu xuất kho bán hàng / sử dụng nội bộ / xuất chế biến |

**Luồng chính:**
1. Có yêu cầu xuất kho (bán hàng, sử dụng nội bộ, xuất chế biến)
2. Kế toán lập phiếu xuất kho: họ tên người nhận, bộ phận, lý do xuất, địa điểm xuất
3. Ghi số lượng yêu cầu (cột 1), số lượng thực xuất (cột 2), đơn giá, thành tiền
4. Cột 4 (thành tiền) = Cột 2 × Cột 3
5. Người đại diện HKD ký duyệt
6. Hệ thống tự động cập nhật SK-03 và SK-04

**Business rules:**
- Số lượng thực xuất có thể bằng hoặc ít hơn số lượng yêu cầu
- Không cho phép xuất kho khi số lượng tồn kho không đủ

---

### CT-05: Lập bảng thanh toán tiền lương & thu nhập NLĐ

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | CT-05 |
| Biểu mẫu | Mẫu số 05-LĐTL |
| Actor chính | Kế toán viên |
| Actor phụ | Người đại diện HKD, Người lao động |
| Phụ thuộc | MD-06 |
| Chu kỳ | Cuối mỗi tháng |

**Luồng chính:**
1. Tổng hợp dữ liệu chấm công: số công, sản phẩm hoàn thành, đơn giá lương
2. Tính lương sản phẩm (cột 2,3), lương thời gian (cột 4,5), lương ngừng/nghỉ việc (cột 6,7)
3. Cộng phụ cấp thuộc quỹ lương (cột 8), phụ cấp ngoài quỹ lương (cột 9), tiền thưởng (cột 10)
4. Tổng thu nhập (cột 11) = tổng tất cả khoản trên
5. Tính khấu trừ: BHXH (cột 12), BHYT (cột 13), BHTN (cột 14), thuế TNCN (cột 16)
6. Tổng khấu trừ (cột 17) = cột 12 + 13 + 14 + 15 + 16
7. Số còn phải trả (cột 18) = cột 11 − cột 17
8. Người đại diện ký duyệt → lập phiếu chi trả lương
9. NLĐ ký nhận cột C khi lĩnh lương (miễn nếu trả qua ngân hàng)

**Business rules:**
- HKD có thể thêm/bớt/sắp xếp lại cột 1-10 và cột 12-16 cho phù hợp thực tế
- Bảng lương được lưu tại HKD làm căn cứ thống kê lao động tiền lương

---

### CT-06: Quản lý hóa đơn (đầu vào & đầu ra)

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | CT-06 |
| Actor chính | Kế toán viên |
| Actor ngoài | Cơ quan thuế |
| Phụ thuộc | MD-02, MD-03, MD-04, MD-05 |

**Luồng chính:**
1. Lập hóa đơn khi bán hàng/cung cấp dịch vụ (bao gồm hóa đơn điện tử)
2. Quản lý nội dung, hình thức, trình tự lập theo quy định pháp luật thuế
3. Lưu trữ hóa đơn đầu vào (mua hàng) và hóa đơn đầu ra (bán hàng)
4. Đối chiếu hóa đơn với phiếu nhập kho (đầu vào) và phiếu thu/phiếu xuất kho (đầu ra)

**Business rules:**
- Hóa đơn điện tử thực hiện theo quy định pháp luật về hóa đơn điện tử
- Nội dung hóa đơn phải khớp với phiếu nhập/xuất kho tương ứng

---

### CT-07: Lưu trữ chứng từ kế toán

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | CT-07 |
| Actor chính | Kế toán viên |
| Actor phụ | Người đại diện HKD |
| Phụ thuộc | MD-08 |
| Căn cứ pháp lý | Điều 41 Luật Kế toán; Điều 9-17 NĐ 174/2016/NĐ-CP |

**Luồng chính:**
1. Sau khi chứng từ ký duyệt và ghi sổ → hệ thống đánh dấu trạng thái "Hoàn tất"
2. Lưu trữ bản giấy (liên 1) và/hoặc bản điện tử
3. Phân loại theo loại chứng từ, kỳ kế toán
4. Hỗ trợ tra cứu theo số phiếu, ngày tháng, loại nghiệp vụ

---

### CT-08: Phê duyệt chứng từ (ký duyệt)

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | CT-08 |
| Actor chính | Người đại diện HKD |
| Actor phụ | Kế toán viên |
| Phụ thuộc | CT-01 đến CT-05 |

**Luồng chính:**
1. Kế toán trình chứng từ cho người đại diện
2. Người đại diện kiểm tra nội dung, ký họ tên và đóng dấu (nếu có)
3. Hệ thống ghi nhận trạng thái "Đã phê duyệt", khóa chỉnh sửa
4. Trường hợp kiêm nhiệm: người đại diện ký đồng thời cả hai chức danh

**Business rules:**
- Chứng từ bắt buộc phải có chữ ký đại diện HKD trước khi thực hiện nghiệp vụ (ví dụ: thủ quỹ không được xuất quỹ nếu chưa có chữ ký trên phiếu chi)
- Sau khi phê duyệt, chỉ Admin mới có thể hủy duyệt kèm lý do và ghi log

---

## 6. Nhóm SK — Sổ kế toán

> **Căn cứ pháp lý:** Điều 5, Phụ lục 2 TT 88/2021/TT-BTC  
> **Nguyên tắc:** 7 loại sổ kế toán (S1 đến S7). Sổ được ghi tự động từ chứng từ đã phê duyệt. HKD nhiều địa điểm kinh doanh phải mở sổ chi tiết theo từng địa điểm.

---

### SK-01: Mở sổ kế toán đầu kỳ

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | SK-01 |
| Actor chính | Kế toán viên |
| Actor phụ | Người đại diện HKD |
| Phụ thuộc | MD-01, MD-08 |
| Trigger | Đầu năm tài chính hoặc khi bắt đầu sử dụng hệ thống |

**Luồng chính:**
1. Đầu kỳ kế toán, tạo mới 7 loại sổ: S1-HKD đến S7-HKD
2. Điền thông tin header: tên HKD, địa chỉ, địa điểm kinh doanh, năm, ngày mở sổ
3. Kết chuyển số dư cuối kỳ trước sang số dư đầu kỳ mới
4. HKD nhiều địa điểm: mở sổ chi tiết theo từng địa điểm kinh doanh

**Business rules:**
- Sổ kế toán mở trên phương tiện điện tử theo Điều 26 Luật Kế toán
- Số dư đầu kỳ phải bằng số dư cuối kỳ trước (kiểm tra tự động)

---

### SK-02: Ghi sổ chi tiết doanh thu bán hàng hóa/DV (S1-HKD)

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | SK-02 |
| Biểu mẫu | Mẫu số S1-HKD |
| Actor chính | Hệ thống (tự động) / Kế toán viên |
| Phụ thuộc | CT-06, MD-03 |
| Trigger | Phát sinh doanh thu (hóa đơn bán hàng, phiếu thu bán hàng) |

**Luồng chính:**
1. Khi phát sinh doanh thu → hệ thống ghi vào S1
2. Phân loại doanh thu theo nhóm ngành nghề cùng mức thuế suất GTGT và TNCN
3. Ghi: ngày tháng (cột A), số hiệu chứng từ (cột B,C), diễn giải (cột D), doanh thu từng cột ngành nghề
4. Cuối kỳ: tổng hợp doanh thu làm căn cứ tính thuế GTGT và TNCN

**Business rules:**
- S1 mở theo từng nhóm ngành nghề có cùng mức thuế suất
- HKD có thể mở thêm sổ chi tiết theo từng sản phẩm/dịch vụ nếu có nhu cầu quản lý

---

### SK-03: Ghi sổ chi tiết vật tư, hàng hóa (S2-HKD)

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | SK-03 |
| Biểu mẫu | Mẫu số S2-HKD |
| Actor chính | Hệ thống (tự động) / Kế toán viên |
| Phụ thuộc | CT-03, CT-04 |
| Trigger | Phiếu nhập kho hoặc phiếu xuất kho được phê duyệt |

**Luồng chính:**
1. Khi nhập kho: ghi vào cột Nhập (số lượng cột 2, thành tiền cột 3)
2. Khi xuất kho: ghi vào cột Xuất (số lượng cột 4, thành tiền cột 5)
3. Tự động tính tồn kho: cột 6 (số lượng tồn), cột 7 (thành tiền tồn)
4. Cuối kỳ: đối chiếu với kết quả kiểm kê thực tế (KH-03)

**Business rules:**
- Đơn giá xuất kho tính theo phương pháp đã chọn tại MD-01 (Bình quân hoặc FIFO)
- Thông tin trên S2 đối chiếu với kiểm kê thực tế để xác định thừa/thiếu

---

### SK-04: Ghi sổ chi phí sản xuất kinh doanh (S3-HKD)

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | SK-04 |
| Biểu mẫu | Mẫu số S3-HKD |
| Actor chính | Hệ thống (tự động) / Kế toán viên |
| Phụ thuộc | CT-02, CT-04 |
| Trigger | Phát sinh chi phí SXKD có chứng từ hợp lệ |

**Luồng chính:**
1. Căn cứ chứng từ chi phí phát sinh trong kỳ
2. Ghi tổng số tiền (cột 1) và diễn giải (cột D)
3. Phân loại vào các cột chi phí tương ứng:
   - Cột 2: chi phí nhân công
   - Cột 3: chi phí điện
   - Cột 4: chi phí nước
   - Cột 5: chi phí viễn thông
   - Cột 6: chi phí thuê kho bãi, mặt bằng kinh doanh
   - Cột 7: chi phí quản lý (chi phí văn phòng phẩm, công cụ dụng cụ)
   - Cột 8: chi phí khác (hội nghị, công tác, lãi vay, nhượng bán tài sản, thuê ngoài...)

---

### SK-05: Ghi sổ theo dõi nghĩa vụ thuế với NSNN (S4-HKD)

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | SK-05 |
| Biểu mẫu | Mẫu số S4-HKD |
| Actor chính | Hệ thống / Kế toán viên |
| Actor ngoài | Cơ quan thuế |
| Phụ thuộc | SK-02, TX-02, TX-03 |

**Luồng chính:**
1. Mở S4 chi tiết theo từng sắc thuế: thuế GTGT, thuế TNCN (chủ HKD), thuế TNCN (NLĐ)
2. Ghi cột 1 (số thuế phải nộp) từ kết quả TX-02 và TX-03
3. Ghi cột 2 (số thuế đã nộp): căn cứ giấy nộp tiền vào NSNN hoặc giấy báo Nợ ngân hàng
4. Tự động tính số dư cuối kỳ (còn phải nộp hoặc nộp thừa)

**Business rules:**
- Nếu số thuế đã nộp > số thuế phải nộp → ghi số nộp thừa vào cột 2, số dư âm thể hiện nộp thừa
- Chứng từ ghi vào cột 2: tờ khai thuế, giấy nộp tiền vào NSNN kèm phiếu chi hoặc giấy báo Nợ ngân hàng

---

### SK-06: Ghi sổ theo dõi thanh toán tiền lương (S5-HKD)

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | SK-06 |
| Biểu mẫu | Mẫu số S5-HKD |
| Actor chính | Hệ thống / Kế toán viên |
| Actor ngoài | Cơ quan BHXH |
| Phụ thuộc | CT-05 |
| Trigger | Bảng lương tháng được duyệt và lập phiếu chi trả lương |

**Luồng chính:**
1. Ghi cột phải trả lương (cột 1): căn cứ cột 18 bảng lương
2. Ghi cột đã trả (cột 2): căn cứ phiếu chi hoặc giấy báo Nợ ngân hàng
3. Cột còn phải trả (cột 3) = cột 1 − cột 2
4. Theo dõi BHXH (cột 4,5,6), BHYT (cột 7,8,9), BHTN (cột 10,11,12) tương tự

---

### SK-07: Ghi sổ quỹ tiền mặt (S6-HKD)

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | SK-07 |
| Biểu mẫu | Mẫu số S6-HKD |
| Actor chính | Thủ quỹ |
| Phụ thuộc | CT-01, CT-02 |
| Trigger | Mỗi phiếu thu hoặc phiếu chi được thực hiện |

**Luồng chính:**
1. Ghi số hiệu phiếu thu (cột C), phiếu chi (cột D) theo trình tự thời gian
2. Ghi số tiền Thu (cột 1), Chi (cột 2)
3. Tự động tính số dư tồn quỹ (cột 3) sau từng nghiệp vụ
4. Cuối kỳ: cộng tổng thu, tổng chi, số dư cuối kỳ

**Business rules:**
- Số tồn quỹ trên sổ phải khớp với số tiền mặt thực tế trong quỹ
- Nếu lệch phải điều tra nguyên nhân, lập biên bản xử lý trước khi khóa sổ
- Cảnh báo khi số dư quỹ âm (không cho phép chi vượt quỹ)

---

### SK-08: Ghi sổ tiền gửi ngân hàng (S7-HKD)

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | SK-08 |
| Biểu mẫu | Mẫu số S7-HKD |
| Actor chính | Kế toán viên |
| Actor ngoài | Ngân hàng |
| Phụ thuộc | MD-07 |
| Trigger | Nhận giấy báo Nợ/Có hoặc bảng sao kê ngân hàng |

**Luồng chính:**
1. Mỗi tài khoản tại mỗi ngân hàng → một sổ S7 riêng
2. Ghi số tiền gửi vào (cột 1 — Thu), số tiền rút ra (cột 2 — Chi), số dư còn lại (cột 3)
3. Cuối tháng: cộng tổng gửi vào, rút ra; tính số dư
4. Đối chiếu số dư S7 với sao kê ngân hàng để xác định chênh lệch thừa/thiếu

---

## 7. Nhóm KH — Kho hàng

> **Căn cứ pháp lý:** Điều 4 (phiếu nhập/xuất kho), Điều 5 (S2-HKD) TT 88/2021/TT-BTC

---

### KH-01: Nhập kho hàng hóa

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | KH-01 |
| Actor chính | Thủ kho |
| Phụ thuộc | CT-03, MD-02 |
| Trigger | Hàng về đến kho |

**Luồng chính:**
1. Kiểm nhận hàng về: đối chiếu số lượng thực nhận với hóa đơn/lệnh nhập
2. Lập phiếu nhập kho (CT-03)
3. Cập nhật sổ chi tiết vật tư hàng hóa (SK-03)
4. Lưu trữ chứng từ kèm theo (hóa đơn, biên bản giao nhận)

**Luồng ngoại lệ:**
- Số lượng thực nhập < chứng từ → ghi số thực nhập, lập biên bản xác nhận hàng thiếu với người giao hàng

---

### KH-02: Xuất kho hàng hóa

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | KH-02 |
| Actor chính | Thủ kho |
| Phụ thuộc | CT-04, MD-02, SK-03 |
| Trigger | Phiếu xuất kho đã được phê duyệt |

**Luồng chính:**
1. Nhận phiếu xuất kho đã ký duyệt
2. Kiểm tra tồn kho đủ đáp ứng yêu cầu
3. Xuất hàng, ghi số lượng thực xuất vào phiếu (cột 2)
4. Người nhận hàng ký xác nhận
5. Cập nhật SK-03

**Luồng ngoại lệ:**
- Tồn kho không đủ → thông báo cho bộ phận yêu cầu, không xuất kho

---

### KH-03: Kiểm kê hàng tồn kho

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | KH-03 |
| Actor chính | Thủ kho + Kế toán viên |
| Phụ thuộc | SK-03 |
| Trigger | Định kỳ (cuối kỳ kế toán) hoặc đột xuất |

**Luồng chính:**
1. Kiểm đếm thực tế từng mặt hàng trong kho
2. Đối chiếu với số liệu trên S2 (SK-03)
3. Xác định chênh lệch thừa/thiếu
4. Hàng thừa phát hiện khi kiểm kê: lập phiếu nhập kho (CT-03)
5. Hàng thiếu: lập biên bản, xác định nguyên nhân, xử lý theo quy định

---

### KH-04: Tính giá xuất kho

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | KH-04 |
| Actor chính | Hệ thống (tự động) |
| Phụ thuộc | MD-01 (phương pháp đã chọn), SK-03 |
| Trigger | Khi lập phiếu xuất kho (CT-04) |

**Phương pháp 1 — Bình quân gia quyền cả kỳ dự trữ:**

```
Đơn giá xuất kho = (Giá trị hàng tồn đầu kỳ + Giá trị hàng nhập trong kỳ)
                  ÷ (Số lượng hàng tồn đầu kỳ + Số lượng hàng nhập trong kỳ)
```

Áp dụng đơn giá này cho tất cả xuất kho trong kỳ. Chỉ tính được đơn giá chính xác vào cuối kỳ.

**Phương pháp 2 — Nhập trước xuất trước (FIFO):**
- Hàng nhập trước xuất trước theo từng lô nhập
- Đơn giá xuất theo giá lô nhập đầu kỳ, hết lô đầu mới tính lô tiếp theo
- Hàng tồn cuối kỳ = giá của lô nhập gần nhất

**Business rules:**
- HKD phải nhất quán một phương pháp trong suốt năm tài chính (cấu hình tại MD-01)
- Không được đổi phương pháp giữa năm

---

## 8. Nhóm TX — Thuế

> **Căn cứ pháp lý:** Điều 6 TT 88/2021/TT-BTC; Luật Quản lý thuế ngày 13/06/2019

---

### TX-01: Xác định doanh thu chịu thuế

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | TX-01 |
| Actor chính | Kế toán viên |
| Phụ thuộc | SK-02, MD-03 |
| Trigger | Cuối kỳ khai thuế |

**Luồng chính:**
1. Tổng hợp từ S1: doanh thu bán hàng hóa, dịch vụ theo từng nhóm ngành nghề
2. Phân loại theo nhóm ngành nghề kinh doanh (link MD-03)
3. Xác định doanh thu chịu thuế GTGT và doanh thu chịu thuế TNCN
4. Ghi kết quả vào S4 (cột thuế phải nộp)

---

### TX-02: Tính thuế giá trị gia tăng (GTGT)

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | TX-02 |
| Actor chính | Kế toán viên |
| Actor ngoài | Cơ quan thuế |
| Phụ thuộc | TX-01, MD-03 |

**Công thức:**
```
Thuế GTGT phải nộp = Doanh thu bán hàng hóa/DV (theo từng ngành nghề)
                   × Tỷ lệ % tính thuế GTGT (theo quy định pháp luật thuế từng ngành)
```

**Luồng chính:**
1. Căn cứ doanh thu theo từng nhóm ngành nghề trên S1
2. Tính thuế GTGT theo tỷ lệ % tương ứng từ MD-03
3. Ghi vào S4 cột 1 (số thuế phải nộp)
4. Khai thuế với cơ quan thuế theo kỳ quy định

---

### TX-03: Tính thuế thu nhập cá nhân (TNCN)

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | TX-03 |
| Actor chính | Kế toán viên |
| Phụ thuộc | TX-01, CT-05, MD-03 |

**Đối tượng 1 — Chủ HKD/CNKD:**
```
Thuế TNCN = Tổng doanh thu bán hàng/DV × Thuế suất TNCN (theo ngành nghề từ MD-03)
```

**Đối tượng 2 — NLĐ làm việc tại HKD:**
```
Thuế TNCN = Tổng số thuế TNCN trên Bảng lương (cột 16 CT-05)
```

Ghi kết quả vào S4 theo từng sắc thuế, tách biệt theo từng đối tượng nộp thuế.

---

### TX-04: Theo dõi nộp thuế vào NSNN

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | TX-04 |
| Actor chính | Kế toán viên |
| Actor ngoài | Ngân hàng / Kho bạc Nhà nước |
| Phụ thuộc | TX-02, TX-03, SK-05 |

**Luồng chính:**
1. Thực hiện nộp thuế: trực tiếp kho bạc hoặc chuyển khoản ngân hàng
2. Nhận giấy nộp tiền vào NSNN hoặc giấy báo Nợ ngân hàng
3. Ghi vào S4 cột 2 (số thuế đã nộp)
4. Hệ thống tự tính số dư: còn phải nộp hoặc nộp thừa

**Business rules:**
- Nếu nộp thừa: số nộp thừa ghi vào cột 2, số dư âm thể hiện nộp thừa chờ quyết toán
- Chứng từ bắt buộc kèm theo: giấy nộp tiền vào NSNN hoặc giấy báo Nợ ngân hàng

---

## 9. Nhóm NS — Nhân sự & tiền lương

> **Căn cứ pháp lý:** Điều 4 (Mẫu 05-LĐTL), Phụ lục 2 (S5-HKD) TT 88/2021/TT-BTC

---

### NS-01: Tính lương người lao động

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | NS-01 |
| Actor chính | Kế toán viên |
| Phụ thuộc | MD-06 |
| Chu kỳ | Hàng tháng |

**Luồng chính:**
1. Tổng hợp dữ liệu chấm công: số công, số sản phẩm hoàn thành
2. Tính lương sản phẩm = Số SP × Đơn giá lương SP
3. Tính lương thời gian = Số công × Đơn giá lương thời gian
4. Tính lương ngừng/nghỉ việc hưởng % lương (theo hợp đồng)
5. Cộng phụ cấp thuộc quỹ lương, phụ cấp ngoài quỹ lương, tiền thưởng
6. Tổng thu nhập (cột 11) = tổng tất cả khoản trên
7. Kết quả đầu vào cho CT-05 (lập bảng lương)

---

### NS-02: Khấu trừ và theo dõi BHXH/BHYT/BHTN

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | NS-02 |
| Actor chính | Kế toán viên |
| Actor ngoài | Cơ quan BHXH |
| Phụ thuộc | NS-01, MD-06 |

**Luồng chính:**
1. Tính BHXH phải nộp (bao gồm phần NLĐ chịu + phần HKD chịu)
2. Tính BHYT, BHTN tương tự
3. Khấu trừ phần NLĐ chịu từ tiền lương (ghi cột 12, 13, 14 bảng lương)
4. Ghi vào SK-06: cột phải trả cơ quan BHXH, số đã trả, còn phải trả
5. Nộp BHXH cho cơ quan BHXH theo kỳ; ghi chứng từ nộp vào SK-06

---

### NS-03: Theo dõi và thanh toán lương

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | NS-03 |
| Actor chính | Kế toán viên / Thủ quỹ |
| Phụ thuộc | CT-05, NS-01, NS-02 |
| Trigger | Bảng lương được người đại diện ký duyệt |

**Luồng chính:**
1. Căn cứ cột 18 bảng lương → lập phiếu chi (CT-02) để trả lương
2. Trả bằng tiền mặt: thủ quỹ chi tiền, NLĐ ký cột C bảng lương
3. Trả qua ngân hàng: lập lệnh chuyển khoản, không yêu cầu NLĐ ký bảng lương
4. Ghi vào SK-06: cột đã trả, tính còn phải trả

---

## 10. Nhóm TT — Tiền tệ

---

### TT-01: Quản lý quỹ tiền mặt

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | TT-01 |
| Actor chính | Thủ quỹ |
| Phụ thuộc | CT-01, CT-02, SK-07 |

**Luồng chính:**
1. Mở sổ quỹ S6 đầu kỳ, kết chuyển số dư từ kỳ trước
2. Thu quỹ: mỗi phiếu thu hoàn thành → cộng vào số dư
3. Chi quỹ: mỗi phiếu chi hoàn thành → trừ khỏi số dư
4. Số dư quỹ hiển thị real-time sau từng giao dịch
5. Cuối tháng: đối chiếu sổ quỹ với tiền mặt thực tế trong quỹ

**Business rules:**
- Cảnh báo và ngăn chặn khi số dư quỹ âm (không cho phép chi vượt quỹ)
- Số tồn quỹ trên sổ phải khớp với tiền mặt thực tế — nếu lệch phải lập biên bản xử lý

---

### TT-02: Quản lý tiền gửi ngân hàng

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | TT-02 |
| Actor chính | Kế toán viên |
| Actor ngoài | Ngân hàng |
| Phụ thuộc | MD-07, SK-08 |

**Luồng chính:**
1. Mỗi tài khoản tại mỗi ngân hàng → một sổ S7 riêng (liên kết MD-07)
2. Ghi nhận gửi tiền vào (cột 1): căn cứ giấy báo Có, ủy nhiệm thu
3. Ghi nhận rút/chi (cột 2): căn cứ giấy báo Nợ, séc, ủy nhiệm chi
4. Tự động tính số dư còn lại (cột 3)
5. Cuối tháng: đối chiếu số dư S7 với sao kê ngân hàng
6. Xác định và xử lý chênh lệch (nếu có)

---

## 11. Nhóm QT — Quản trị hệ thống

---

### QT-01: Quản lý tài khoản người dùng & phân quyền

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | QT-01 |
| Actor chính | Admin hệ thống |
| Phụ thuộc | MD-01 |

**Nguyên tắc phân quyền (Segregation of Duties):**
| Chức năng | Kế toán viên | Thủ quỹ | Thủ kho | Người đại diện | Admin |
|-----------|:---:|:---:|:---:|:---:|:---:|
| Lập chứng từ | Có | — | — | — | — |
| Phê duyệt chứng từ | — | — | — | Có | — |
| Thu chi tiền mặt | — | Có | — | — | — |
| Nhập xuất kho | — | — | Có | — | — |
| Ghi sổ kế toán | Có | — | — | — | — |
| Tính thuế | Có | — | — | — | — |
| Cấu hình hệ thống | — | — | — | — | Có |
| Phân quyền | — | — | — | — | Có |

**Business rules:**
- Nguyên tắc bất kiêm nhiệm: người lập chứng từ khác người phê duyệt; người ghi sổ khác người kiểm soát
- Trường hợp HKD quy mô nhỏ kiêm nhiệm: hệ thống ghi nhận đồng thời các chức danh kiêm nhiệm (theo điều 3 TT 88/2021)

---

### QT-02: Sửa chữa / điều chỉnh sổ kế toán

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | QT-02 |
| Actor chính | Kế toán viên / Người đại diện |
| Phụ thuộc | SK-01 đến SK-08 |
| Căn cứ pháp lý | Điều 27 Luật Kế toán |

**Luồng chính:**
1. Phát hiện sai sót trên sổ kế toán
2. Xác định phương pháp sửa chữa phù hợp:
   - Cùng kỳ, chưa khóa sổ: gạch chân chữ số sai, ghi số đúng lên trên
   - Sau khi khóa sổ: lập bút toán điều chỉnh (ghi âm hoặc ghi bổ sung)
3. Ghi lý do điều chỉnh, người thực hiện, ngày điều chỉnh (audit trail bắt buộc)
4. Người đại diện xác nhận điều chỉnh

---

### QT-03: Đóng kỳ kế toán và khóa sổ

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | QT-03 |
| Actor chính | Admin / Người đại diện |
| Phụ thuộc | MD-08, tất cả SK |
| Trigger | Kết thúc năm tài chính |

**Luồng chính:**
1. Kiểm tra toàn bộ chứng từ trong kỳ đã được phê duyệt và ghi sổ đầy đủ
2. Đối chiếu số dư quỹ tiền mặt với thực tế (TT-01)
3. Đối chiếu số dư tiền gửi ngân hàng với sao kê (TT-02)
4. Kiểm kê hàng tồn kho lần cuối (KH-03)
5. Xác nhận số thuế phải nộp và đã nộp (TX-04)
6. Thực hiện đóng kỳ → cập nhật trạng thái kỳ kế toán thành "Khóa sổ" (MD-08)
7. Sau khi khóa sổ: mọi giao dịch thuộc kỳ là read-only

---

### QT-04: Báo cáo tổng hợp cuối kỳ

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | QT-04 |
| Actor chính | Kế toán viên |
| Phụ thuộc | Tất cả nhóm SK, TX |

**Các báo cáo cần thiết:**
| Báo cáo | Nguồn dữ liệu | Mục đích |
|---------|--------------|---------|
| Tổng hợp doanh thu theo ngành nghề | S1-HKD | Khai thuế GTGT, TNCN |
| Tổng hợp chi phí SXKD | S3-HKD | Quản lý chi phí |
| Tình hình thực hiện nghĩa vụ thuế | S4-HKD | Đối chiếu với cơ quan thuế |
| Tình hình tồn kho cuối kỳ | S2-HKD | Kiểm kê, báo cáo tài sản |
| Tình hình quỹ tiền mặt | S6-HKD | Đối chiếu quỹ |
| Tình hình tiền gửi ngân hàng | S7-HKD | Đối chiếu ngân hàng |
| Bảng tổng hợp lương và BHXH | S5-HKD | Báo cáo lao động |

---

### QT-05: Lưu trữ và tra cứu lịch sử chứng từ

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | QT-05 |
| Actor chính | Kế toán viên |
| Phụ thuộc | CT-07 |
| Căn cứ pháp lý | Điều 41 Luật Kế toán; Điều 9-17 NĐ 174/2016/NĐ-CP |

**Chức năng tra cứu:**
- Tìm kiếm theo số phiếu, ngày tháng, loại chứng từ, người lập, người phê duyệt
- Lọc theo kỳ kế toán, địa điểm kinh doanh
- Xuất danh sách chứng từ theo bộ lọc

---

### QT-06: Nhật ký hệ thống và Audit Trail

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | QT-06 |
| Actor chính | Admin hệ thống |
| Phụ thuộc | Tất cả use cases |

**Thông tin bắt buộc ghi log:**
- Ai thực hiện (user ID, tên, chức danh)
- Thực hiện gì (create/update/delete/approve/reject)
- Trên đối tượng nào (loại chứng từ, số phiếu, sổ kế toán)
- Khi nào (timestamp chính xác đến giây)
- Giá trị trước và sau khi thay đổi (diff)

**Business rules:**
- Log không được xóa hoặc sửa bởi bất kỳ user nào kể cả Admin
- Audit trail là cơ sở pháp lý khi có tranh chấp hoặc kiểm tra thuế

---

## 12. Ma trận phụ thuộc Use Cases

```
       MD-01 MD-02 MD-03 MD-04 MD-05 MD-06 MD-07 MD-08
CT-01    ●           ●                         
CT-02    ●                                     
CT-03    ●     ●           ●                   
CT-04    ●     ●                               
CT-05    ●                       ●             
CT-06    ●     ●     ●     ●     ●             
CT-07                                   ●
SK-01    ●                               ●
SK-02                ●                         
SK-03                                           
SK-04                                           
SK-05                                           
SK-06                                           
SK-07                                           
SK-08                               ●           
TX-01                ●                         
TX-02                ●                         
TX-03                ●                         
NS-01                       ●                 
NS-02                       ●                 
TT-02                               ●           
QT-01    ●                                     
QT-03                               ●
```

Ký hiệu: ● = UC hàng ngang phụ thuộc trực tiếp vào MD cột dọc

---

## 13. Thứ tự triển khai đề xuất

### Sprint 0 — Nền tảng (tuần 1-2)
**Mục tiêu:** Thiết lập toàn bộ master data trước khi vận hành

| Thứ tự | UC | Lý do |
|--------|-----|-------|
| 1 | MD-01 | Core identity — toàn bộ hệ thống phụ thuộc |
| 2 | MD-03 | Thuế suất — phụ thuộc của MD-02 |
| 3 | MD-08 | Kỳ kế toán — cần có trước khi mở sổ |
| 4 | MD-02 | Danh mục hàng hóa (cần MD-03) |
| 5 | MD-04 | Nhà cung cấp |
| 6 | MD-05 | Khách hàng |
| 7 | MD-06 | Người lao động |
| 8 | MD-07 | Tài khoản ngân hàng |
| 9 | QT-01 | Phân quyền người dùng |

### Sprint 1 — Chứng từ & Quỹ (tuần 3-5)
| Thứ tự | UC | Lý do |
|--------|-----|-------|
| 10 | CT-08 | Luồng phê duyệt cần xây trước |
| 11 | CT-01 | Phiếu thu — nghiệp vụ cơ bản nhất |
| 12 | CT-02 | Phiếu chi |
| 13 | SK-07 | Sổ quỹ tiền mặt (tự động từ CT-01, CT-02) |
| 14 | TT-01 | Quản lý quỹ tiền mặt |
| 15 | SK-08 | Sổ tiền gửi ngân hàng |
| 16 | TT-02 | Quản lý tiền gửi ngân hàng |

### Sprint 2 — Kho hàng (tuần 6-8)
| Thứ tự | UC | Lý do |
|--------|-----|-------|
| 17 | CT-03 | Phiếu nhập kho |
| 18 | CT-04 | Phiếu xuất kho |
| 19 | KH-04 | Tính giá xuất kho (logic cần xây trước khi vận hành) |
| 20 | KH-01 | Nhập kho hàng hóa |
| 21 | KH-02 | Xuất kho hàng hóa |
| 22 | SK-03 | Sổ chi tiết vật tư, hàng hóa |
| 23 | KH-03 | Kiểm kê hàng tồn kho |

### Sprint 3 — Doanh thu & Sổ KT (tuần 9-11)
| Thứ tự | UC | Lý do |
|--------|-----|-------|
| 24 | CT-06 | Quản lý hóa đơn |
| 25 | SK-01 | Mở sổ kế toán đầu kỳ |
| 26 | SK-02 | Sổ doanh thu S1 |
| 27 | SK-04 | Sổ chi phí SXKD S3 |
| 28 | CT-07 | Lưu trữ chứng từ |
| 29 | QT-05 | Tra cứu lịch sử chứng từ |

### Sprint 4 — Thuế (tuần 12-13)
| Thứ tự | UC | Lý do |
|--------|-----|-------|
| 30 | TX-01 | Xác định doanh thu chịu thuế |
| 31 | TX-02 | Tính thuế GTGT |
| 32 | TX-03 | Tính thuế TNCN |
| 33 | SK-05 | Sổ nghĩa vụ thuế S4 |
| 34 | TX-04 | Theo dõi nộp thuế NSNN |

### Sprint 5 — Nhân sự & Lương (tuần 14-16)
| Thứ tự | UC | Lý do |
|--------|-----|-------|
| 35 | NS-01 | Tính lương NLĐ |
| 36 | NS-02 | Khấu trừ BHXH/BHYT/BHTN |
| 37 | CT-05 | Bảng thanh toán tiền lương |
| 38 | NS-03 | Thanh toán lương |
| 39 | SK-06 | Sổ theo dõi tiền lương S5 |

### Sprint 6 — Hoàn thiện (tuần 17-18)
| Thứ tự | UC | Lý do |
|--------|-----|-------|
| 40 | QT-04 | Báo cáo tổng hợp cuối kỳ |
| 41 | QT-02 | Sửa chữa sổ kế toán |
| 42 | QT-03 | Đóng kỳ & khóa sổ |
| 43 | QT-06 | Audit trail & nhật ký hệ thống |

---

## Ghi chú cuối tài liệu

### Các điểm cần elicit thêm với stakeholder
1. **Hóa đơn điện tử:** Tích hợp với cổng hóa đơn điện tử (VNPT/Viettel/MISA...) hay chỉ quản lý thủ công?
2. **Quy mô HKD:** Một địa điểm hay nhiều địa điểm kinh doanh — ảnh hưởng đến thiết kế sổ kế toán
3. **Báo cáo thuế:** Xuất file tờ khai thuế theo chuẩn của Tổng cục Thuế hay chỉ báo cáo nội bộ?
4. **Tích hợp ngân hàng:** Nhập sao kê ngân hàng thủ công hay kết nối API Open Banking?
5. **Mobile app:** Có cần ứng dụng di động cho chủ HKD phê duyệt chứng từ từ xa không?
6. **Backup & phục hồi:** Chính sách backup dữ liệu kế toán (yêu cầu pháp lý lưu trữ tối thiểu 5-10 năm)

### Tài liệu tham chiếu
- Thông tư 88/2021/TT-BTC ngày 11/10/2021 của Bộ Tài chính
- Luật Kế toán ngày 20/11/2015
- Luật Quản lý thuế ngày 13/06/2019
- Nghị định 174/2016/NĐ-CP ngày 30/12/2016

---
*Tài liệu này là đầu ra phân tích nghiệp vụ (Business Analysis Artifact). Mọi thay đổi cần được Lead BA xem xét và phê duyệt trước khi cập nhật.*
