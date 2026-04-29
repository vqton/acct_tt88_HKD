## 5. Nhóm CT — Chứng từ kế toán (tiếp theo)

### CT-01: Lập phiếu thu (MD-01, MD-05)

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | CT-01 |
| Tên | Lập phiếu thu |
| Actor chính | Kế toán viên |
| Actor phụ | Người đại diện HKD, Thủ quỹ, Người nộp tiền |
| Phụ thuộc | MD-01, MD-05 |
| Trigger | Phát sinh khoản tiền mặt nhập quỹ |

**Tiền điều kiện:** Có sự kiện phát sinh tiền mặt nhập quỹ  
**Hậu điều kiện:** Phiếu thu được tạo, ký duyệt; sổ quỹ tiền mặt (S6) tự động cập nhật  

**Business rules:**
- Mọi khoản tiền mặt nhập quỹ bắt buộc phải có phiếu thu\
- Phiếu thu không được xóa sau khi đã ký duyệt — chỉ được lập phiếu điều chỉnh\
- Trường hợp đại diện kiêm thủ quỹ hoặc người lập biểu: ký đồng thời các chức danh kiêm nhiệm\

### CT-02: Lập phiếu chi (MD-01)

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | CT-02 |
| Tên | Lập phiếu chi |
| Actor chính | Kế toán viên |
| Actor phụ | Người đại diện HKD, Thủ quỹ, Người nhận tiền |
| Phụ thuộc | MD-01 |
| Trigger | Có nhu cầu chi tiền mặt hợp lệ, chứng từ gốc đã được duyệt |

**Tiền điều kiện:** Chứng từ gốc (hóa đơn mua hàng, bảng lương, hợp đồng...) đã được phê duyệt  
**Hậu điều kiện:** Phiếu chi được tạo, tiền được xuất quỹ; S6 tự động cập nhật  

**Business rules:**
- Thủ quỹ tuyệt đối không xuất quỹ khi chưa có chữ ký đại diện\
- Mọi khoản tiền mặt xuất quỹ bắt buộc phải có phiếu chi\

## 6. Nhóm SK — Sổ kế toán (tiếp theo)

### SK-01: Mở sổ kế toán đầu kỳ (MD-01, MD-08)

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | SK-01 |
| Actor chính | Kế toán viên |
| Actor phụ | Người đại diện HKD |
| Phụ thuộc | MD-01, MD-08 |
| Trigger | Đầu năm tài chính hoặc khi bắt đầu sử dụng hệ thống |

**Luồng chính:**
1. Đầu kỳ kế toán, tạo mới 7 loại sổ: S1-HKD đến S7-HKD\
2. Điền thông tin header: tên HKD, địa chỉ, địa điểm kinh doanh, năm, ngày mở sổ\
3. Kết chuyển số dư cuối kỳ trước sang số dư đầu kỳ mới\
4. HKD nhiều địa điểm: mở sổ chi tiết theo từng địa điểm kinh doanh\

### SK-02: Ghi sổ chi tiết doanh thu bán hàng/DV (S1-HKD) (CT-06, MD-03)

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | SK-02 |
| Biểu mẫu | Mẫu số S1-HKD |
| Actor chính | Hệ thống (tự động) / Kế toán viên |
| Phụ thuộc | CT-06, MD-03 |
| Trigger | Phát sinh doanh thu (hóa đơn bán hàng, phiếu thu bán hàng) |

**Luồng chính:**
1. Khi phát sinh doanh thu → hệ thống ghi vào S1\
2. Phân loại doanh thu theo nhóm ngành nghề cùng mức thuế suất GTGT và TNCN\
3. Ghi: ngày tháng (cột A), số hiệu chứng từ (cột B,C), diễn giải (cột D), doanh thu từng cột ngành nghề\
4. Cuối kỳ: tổng hợp doanh thu làm căn cứ tính thuế GTGT và TNCN\

## 7. Nhóm KH — Kho hàng (tiếp theo)

### KH-01: Nhập kho hàng hóa (CT-03, MD-02)

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | KH-01 |
| Actor chính | Thủ kho |
| Phụ thuộc | CT-03, MD-02 |
| Trigger | Hàng về đến kho |

**Luồng chính:**
1. Kiểm nhận hàng về: đối chiếu số lượng thực nhận với hóa đơn/lệnh nhập\
2. Lập phiếu nhập kho (CT-03)\
3. Cập nhật sổ chi tiết vật tư hàng hóa (SK-03)\
4. Lưu trữ chứng từ kèm theo (hóa đơn, biên bản giao nhận)\

### KH-02: Xuất kho hàng hóa (CT-04, MD-02, SK-03)

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | KH-02 |
| Actor chính | Thủ kho |
| Phụ thuộc | CT-04, MD-02, SK-03 |
| Trigger | Phiếu xuất kho đã được phê duyệt |

**Business rules:**
- Khiểm tra tồn kho đủ đáp ứng yêu cầu\
- Xuất hàng, ghi số lượng thực xuất vào phiếu (cột 2)\
- Người nhận hàng ký xác nhận\

## 8. Nhóm TX — Thuế (tiếp theo)

### TX-01: Xác định doanh thu chịu thuế (SK-02, MD-03)

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | TX-01 |
| Actor chính | Kế toán viên |
| Phụ thuộc | SK-02, MD-03 |
| Trigger | Cuối kỳ khai thuế |

**Luồng chính:**
1. Tổng hợp từ S1: doanh thu bán hàng/DV theo từng nhóm ngành nghề\
2. Phân loại theo nhóm ngành nghề kinh doanh (link MD-03)\
3. Xác định doanh thu chịu thuế GTGT và doanh thu chịu thuế TNCN\
4. Ghi kết quả vào S4 (cột thuế phải nộp)\

### TX-02: Tính thuế GTGT (TX-01, MD-03)

**Công thức:**
```
Thuế GTGT phải nộp = Doanh thu bán hàng/DV × Tỷ lệ % tính thuế GTGT
```

## 9. Nhóm NS — Nhân sự & tiền lương (tiếp theo)

### NS-01: Tính lương người lao động (MD-06)

| Thuộc tính | Nội dung |
|-----------|---------|
| Mã | NS-01 |
| Actor chính | Kế toán viên |
| Phụ thuộc | MD-06 |
| Chu kỳ | Hàng tháng |

**Luồng chính:**
1. Tổng hợp dữ liệu chấm công: số công, số sản phẩm hoàn thành\
2. Tính lương sản phẩm = Số SP × Đơn giá lương sản phẩm\
3. Tính lương thời gian = Số công × Đơn giá lương thời gian\
4. Cộng phụ cấp thuộc quỹ lương, phụ cấp ngoài quỹ, tiền thưởng\
5. Kết quả đầu vào cho CT-05 (lập bảng lương)\

## 10. Nhóm TT — Tiền tệ (tiếp theo)

### TT-01: Quản lý quỹ tiền mặt (CT-01, CT-02, SK-07)

**Luồng chính:**
1. Mở sổ quỹ S6 đầu kỳ, kết chuyển số dư từ kỳ trước\
2. Thu quỹ: mỗi phiếu thu hoàn thành → cộng vào số dư\
3. Chi quỹ: mỗi phiếu chi hoàn thành → trừ khỏi số dư\
4. Số dư quỹ hiển thị real-time sau từng giao dịch\

**Business rules:**
- Cảnh báo và ngăn chặn khi số dư quỹ âm (không cho phép chi vượt quỹ)\

## 11. Nhóm QT — Quản trị hệ thống (tiếp theo)

### QT-01: Quản lý tài khoản người dùng & phân quyền

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

### QT-03: Đóng kỳ kế toán và khóa sổ (MD-08, tất cả SK)

**Luồng chính:**
1. Kiểm tra toàn bộ chứng từ trong kỳ đã được phê duyệt và ghi sổ đầy đủ\
2. Đối chiếu số dư quỹ tiền mặt với thực tế\
3. Đối chiếu số dư tiền gửi ngân hàng với sao kê\
4. Kiểm kê hàng tồn kho lần cuối\
5. Xác nhận số thuế phải nộp và đã nộp\
6. Thực hiện đóng kỳ → cập nhật trạng thái kỳ kế toán thành "Khóa sổ"\
7. Sau khi khóa sổ: mọi giao dịch thuộc kỳ là read-only\

---
*Tài liệu hoàn thành - 43 use cases được mô tả đầy đủ*
