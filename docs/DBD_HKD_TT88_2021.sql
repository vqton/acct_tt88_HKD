-- ============================================================
-- DATABASE SCHEMA: HKD Accounting System
-- Based on: Thông tư 88/2021/TT-BTC
-- Compatible: ANSI SQL (MariaDB, PostgreSQL, H2)
-- ============================================================

-- ============================================================
-- SECTION 1: MASTER DATA - Core Business Information
-- ============================================================

-- MD-01: Thông tin Hộ kinh doanh / Cá nhân kinh doanh
CREATE TABLE hkd_info (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ten_hkd VARCHAR(255) NOT NULL,
    dia_chi_tru_so VARCHAR(500),
    ma_so_thue VARCHAR(20) UNIQUE NOT NULL,
    so_cccd_nguoi_dai_dien VARCHAR(20),
    ho_ten_nguoi_dai_dien VARCHAR(100),
    phuong_phap_tinh_gia_xuat_kho VARCHAR(20) NOT NULL DEFAULT 'BINH_QUAN',
    trang_thai VARCHAR(20) DEFAULT 'HOAT_DONG',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- MD-03: Danh mục ngành nghề & Thuế suất (with versioning)
CREATE TABLE dm_nhom_nghe (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ma_nhom_nghe VARCHAR(20) NOT NULL,
    ten_nhom_nghe VARCHAR(255) NOT NULL,
    ty_le_thue_gtgt DECIMAL(5,2) NOT NULL,
    ty_le_thue_tncn DECIMAL(5,2) NOT NULL,
    ngay_hieu_luc DATE NOT NULL,
    ngay_het_hieu_luc DATE,
    trang_thai VARCHAR(20) DEFAULT 'HOAT_DONG',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE (ma_nhom_nghe, ngay_hieu_luc)
);

-- MD-02: Danh mục hàng hóa / Dịch vụ
CREATE TABLE dm_hang_hoa (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ma_hang VARCHAR(20) UNIQUE NOT NULL,
    ten_hang VARCHAR(255) NOT NULL,
    nhan_hieu_quy_cach VARCHAR(255),
    don_vi_tinh VARCHAR(20) NOT NULL,
    nhom_nghe_id BIGINT,
    loai_hang VARCHAR(20) NOT NULL,
    don_gia_mua_chuan DECIMAL(18,2),
    trang_thai VARCHAR(20) DEFAULT 'DANG_KINH_DOANH',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (nhom_nghe_id) REFERENCES dm_nhom_nghe(id)
);

-- MD-04: Danh mục nhà cung cấp
CREATE TABLE dm_nha_cung_cap (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ma_nha_cc VARCHAR(20) UNIQUE NOT NULL,
    ten_nha_cc VARCHAR(255) NOT NULL,
    dia_chi VARCHAR(500),
    ma_so_thue VARCHAR(20),
    so_tai_khoan VARCHAR(50),
    nguoi_lien_he VARCHAR(100),
    so_dien_thoai VARCHAR(20),
    loai_nha_cc VARCHAR(20),
    trang_thai VARCHAR(20) DEFAULT 'DANG_GIAO_DICH',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- MD-05: Danh mục khách hàng
CREATE TABLE dm_khach_hang (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ma_khach VARCHAR(20) UNIQUE NOT NULL,
    ten_khach VARCHAR(255) NOT NULL,
    dia_chi VARCHAR(500),
    ma_so_thue VARCHAR(20),
    so_dien_thoai VARCHAR(20),
    loai_khach VARCHAR(20),
    trang_thai VARCHAR(20) DEFAULT 'DANG_GIAO_DICH',
    is_default CHAR(1) DEFAULT 'N',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- MD-06: Danh mục người lao động
CREATE TABLE dm_nhan_vien (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ma_nhan_vien VARCHAR(20) UNIQUE NOT NULL,
    ho_ten VARCHAR(100) NOT NULL,
    so_cccd VARCHAR(20) NOT NULL,
    ma_so_thue_ca_nhan VARCHAR(20),
    bac_luong VARCHAR(20),
    he_so_luong DECIMAL(10,2),
    hinh_thuc_tra_luong VARCHAR(20),
    don_gia_luong DECIMAL(18,2),
    ty_le_bhxh_nld DECIMAL(5,2) DEFAULT 8.0,
    ty_le_bhyt_nld DECIMAL(5,2) DEFAULT 1.5,
    ty_le_bhtn_nld DECIMAL(5,2) DEFAULT 1.0,
    tai_khoan_ngan_hang VARCHAR(50),
    ngay_bat_dau_lam_viec DATE,
    trang_thai VARCHAR(20) DEFAULT 'DANG_LAM_VIEC',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Lịch sử thay đổi bậc lương
CREATE TABLE dm_nhan_vien_luong_history (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    nhan_vien_id BIGINT NOT NULL,
    bac_luong_cu VARCHAR(20),
    bac_luong_moi VARCHAR(20),
    he_so_cu DECIMAL(10,2),
    he_so_moi DECIMAL(10,2),
    ngay_hieu_luc DATE NOT NULL,
    ly_do VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (nhan_vien_id) REFERENCES dm_nhan_vien(id)
);

-- MD-07: Danh mục tài khoản ngân hàng
CREATE TABLE dm_tai_khoan_ngan_hang (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ma_tai_khoan VARCHAR(20) UNIQUE NOT NULL,
    ten_ngan_hang VARCHAR(100) NOT NULL,
    chi_nhanh VARCHAR(100),
    so_tai_khoan VARCHAR(50) UNIQUE NOT NULL,
    ten_chu_tai_khoan VARCHAR(100) NOT NULL,
    loai_tai_khoan VARCHAR(20),
    trang_thai VARCHAR(20) DEFAULT 'DANG_SU_DUNG',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- MD-08: Kỳ kế toán
CREATE TABLE ky_ke_toan (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    nam_tai_chinh INTEGER NOT NULL,
    ngay_bat_dau DATE NOT NULL,
    ngay_ket_thuc DATE NOT NULL,
    trang_thai VARCHAR(20) DEFAULT 'MO',
    ngay_khoa_so_thuc_te DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE (nam_tai_chinh)
);

-- ============================================================
-- SECTION 2: CHỨNG TỪ KẾ TOÁN
-- ============================================================

-- CT-01: Phiếu thu
CREATE TABLE phieu_thu (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    so_phieu VARCHAR(20) UNIQUE NOT NULL,
    ngay_lap DATE NOT NULL,
    ky_ke_toan_id BIGINT,
    khach_hang_id BIGINT,
    ho_ten_nguoi_nop VARCHAR(100) NOT NULL,
    dia_chi VARCHAR(500),
    ly_do_nop TEXT NOT NULL,
    so_tien DECIMAL(18,2) NOT NULL,
    so_tien_bang_chu VARCHAR(200) NOT NULL,
    chung_tu_goc TEXT,
    nguoi_lap_id BIGINT,
    nguoi_duyet_id BIGINT,
    trang_thai VARCHAR(20) DEFAULT 'CHO_DUYET',
    ngay_duyet DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ky_ke_toan_id) REFERENCES ky_ke_toan(id),
    FOREIGN KEY (khach_hang_id) REFERENCES dm_khach_hang(id)
);

-- CT-02: Phiếu chi
CREATE TABLE phieu_chi (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    so_phieu VARCHAR(20) UNIQUE NOT NULL,
    ngay_lap DATE NOT NULL,
    ky_ke_toan_id BIGINT,
    ho_ten_nguoi_nhan VARCHAR(100) NOT NULL,
    dia_chi VARCHAR(500),
    ly_do_chi TEXT NOT NULL,
    so_tien DECIMAL(18,2) NOT NULL,
    so_tien_bang_chu VARCHAR(200) NOT NULL,
    chung_tu_goc TEXT,
    nguoi_lap_id BIGINT,
    nguoi_duyet_id BIGINT,
    trang_thai VARCHAR(20) DEFAULT 'CHO_DUYET',
    ngay_duyet DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ky_ke_toan_id) REFERENCES ky_ke_toan(id)
);

-- CT-03: Phiếu nhập kho
CREATE TABLE phieu_nhap_kho (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    so_phieu VARCHAR(20) UNIQUE NOT NULL,
    ngay_lap DATE NOT NULL,
    ky_ke_toan_id BIGINT,
    nha_cung_cap_id BIGINT,
    so_hoa_don VARCHAR(50),
    dia_diem_nhap VARCHAR(255),
    ly_do_nhap TEXT,
    nguoi_giao_hang VARCHAR(100),
    nguoi_lap_id BIGINT,
    nguoi_duyet_id BIGINT,
    trang_thai VARCHAR(20) DEFAULT 'CHO_DUYET',
    ngay_duyet DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ky_ke_toan_id) REFERENCES ky_ke_toan(id),
    FOREIGN KEY (nha_cung_cap_id) REFERENCES dm_nha_cung_cap(id)
);

CREATE TABLE phieu_nhap_kho_chi_tiet (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    phieu_nhap_kho_id BIGINT NOT NULL,
    hang_hoa_id BIGINT NOT NULL,
    so_luong_theo_chung_tu DECIMAL(18,4),
    so_luong_thuc_nhan DECIMAL(18,4),
    don_gia DECIMAL(18,2),
    thanh_tien DECIMAL(18,2),
    FOREIGN KEY (phieu_nhap_kho_id) REFERENCES phieu_nhap_kho(id),
    FOREIGN KEY (hang_hoa_id) REFERENCES dm_hang_hoa(id)
);

-- CT-04: Phiếu xuất kho
CREATE TABLE phieu_xuat_kho (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    so_phieu VARCHAR(20) UNIQUE NOT NULL,
    ngay_lap DATE NOT NULL,
    ky_ke_toan_id BIGINT,
    ho_ten_nguoi_nhan VARCHAR(100),
    bo_phan VARCHAR(100),
    ly_do_xuat TEXT,
    dia_diem_xuat VARCHAR(255),
    nguoi_lap_id BIGINT,
    nguoi_duyet_id BIGINT,
    trang_thai VARCHAR(20) DEFAULT 'CHO_DUYET',
    ngay_duyet DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ky_ke_toan_id) REFERENCES ky_ke_toan(id)
);

CREATE TABLE phieu_xuat_kho_chi_tiet (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    phieu_xuat_kho_id BIGINT NOT NULL,
    hang_hoa_id BIGINT NOT NULL,
    so_luong_yeu_cau DECIMAL(18,4),
    so_luong_thuc_xuat DECIMAL(18,4),
    don_gia DECIMAL(18,2),
    thanh_tien DECIMAL(18,2),
    FOREIGN KEY (phieu_xuat_kho_id) REFERENCES phieu_xuat_kho(id),
    FOREIGN KEY (hang_hoa_id) REFERENCES dm_hang_hoa(id)
);

-- CT-05: Bảng thanh toán tiền lương
CREATE TABLE bang_luong (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ky_luong VARCHAR(20) NOT NULL,
    thang INTEGER NOT NULL,
    nam INTEGER NOT NULL,
    ky_ke_toan_id BIGINT,
    tong_thu_nhap DECIMAL(18,2),
    tong_khau_tru DECIMAL(18,2),
    tong_con_phai_tra DECIMAL(18,2),
    nguoi_lap_id BIGINT,
    nguoi_duyet_id BIGINT,
    trang_thai VARCHAR(20) DEFAULT 'CHO_DUYET',
    ngay_duyet DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ky_ke_toan_id) REFERENCES ky_ke_toan(id),
    UNIQUE (thang, nam)
);

CREATE TABLE bang_luong_chi_tiet (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    bang_luong_id BIGINT NOT NULL,
    nhan_vien_id BIGINT NOT NULL,
    so_cong DECIMAL(10,2),
    luong_san_pham DECIMAL(18,2),
    luong_thoi_gian DECIMAL(18,2),
    phu_cap_quy_luong DECIMAL(18,2),
    phu_cap_ngoai_quy DECIMAL(18,2),
    tien_thuong DECIMAL(18,2),
    tong_thu_nhap DECIMAL(18,2),
    bhxh_khau_tru DECIMAL(18,2),
    bhyt_khau_tru DECIMAL(18,2),
    bhtn_khau_tru DECIMAL(18,2),
    thue_tncn_khau_tru DECIMAL(18,2),
    tong_khau_tru DECIMAL(18,2),
    so_con_phai_tra DECIMAL(18,2),
    so_tien_thuc_nhan DECIMAL(18,2),
    ky_nhan CHAR(1),
    ngay_nhan DATETIME,
    FOREIGN KEY (bang_luong_id) REFERENCES bang_luong(id),
    FOREIGN KEY (nhan_vien_id) REFERENCES dm_nhan_vien(id)
);

-- CT-06: Hóa đơn
CREATE TABLE hoa_don (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    so_hoa_don VARCHAR(50) UNIQUE NOT NULL,
    ngay_lap DATE NOT NULL,
    loai_hoa_don VARCHAR(20),
    ky_ke_toan_id BIGINT,
    nha_cung_cap_id BIGINT,
    khach_hang_id BIGINT,
    phieu_nhap_kho_id BIGINT,
    phieu_xuat_kho_id BIGINT,
    tien_hang DECIMAL(18,2),
    tien_thue DECIMAL(18,2),
    tong_tien DECIMAL(18,2),
    trang_thai VARCHAR(20) DEFAULT 'MOI',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ky_ke_toan_id) REFERENCES ky_ke_toan(id),
    FOREIGN KEY (nha_cung_cap_id) REFERENCES dm_nha_cung_cap(id),
    FOREIGN KEY (khach_hang_id) REFERENCES dm_khach_hang(id),
    FOREIGN KEY (phieu_nhap_kho_id) REFERENCES phieu_nhap_kho(id),
    FOREIGN KEY (phieu_xuat_kho_id) REFERENCES phieu_xuat_kho(id)
);

-- Chữ ký điện tử / trạng thái phê duyệt
CREATE TABLE chung_tu_ky (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    chung_tu_type VARCHAR(50) NOT NULL,
    chung_tu_id BIGINT NOT NULL,
    nguoi_ky_id BIGINT,
    chuc_danh VARCHAR(50),
    chu_ky TEXT,
    thoi_gian_ky DATETIME,
    trang_thai VARCHAR(20) DEFAULT 'CHUA_KY'
);

-- ============================================================
-- SECTION 3: SỔ KẾ TOÁN
-- ============================================================

-- SK-02: Sổ doanh thu (S1-HKD) - Theo nhóm ngành nghề
CREATE TABLE so_doanh_thu (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ky_ke_toan_id BIGINT,
    nhom_nghe_id BIGINT,
    ngay_chung_tu DATE,
    so_hieu_chung_tu VARCHAR(30),
    dien_giai TEXT,
    doanh_thu DECIMAL(18,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ky_ke_toan_id) REFERENCES ky_ke_toan(id),
    FOREIGN KEY (nhom_nghe_id) REFERENCES dm_nhom_nghe(id)
);

-- SK-03: Sổ chi tiết vật tư hàng hóa (S2-HKD)
CREATE TABLE so_vat_tu_hang_hoa (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ky_ke_toan_id BIGINT,
    hang_hoa_id BIGINT,
    ton_dau_so_luong DECIMAL(18,4) DEFAULT 0,
    ton_dau_thanh_tien DECIMAL(18,2) DEFAULT 0,
    nhap_so_luong DECIMAL(18,4) DEFAULT 0,
    nhap_thanh_tien DECIMAL(18,2) DEFAULT 0,
    xuat_so_luong DECIMAL(18,4) DEFAULT 0,
    xuat_thanh_tien DECIMAL(18,2) DEFAULT 0,
    ton_cuoi_so_luong DECIMAL(18,4) DEFAULT 0,
    ton_cuoi_thanh_tien DECIMAL(18,2) DEFAULT 0,
    don_gia_xuat_kho DECIMAL(18,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ky_ke_toan_id) REFERENCES ky_ke_toan(id),
    FOREIGN KEY (hang_hoa_id) REFERENCES dm_hang_hoa(id)
);

-- SK-04: Sổ chi phí sản xuất kinh doanh (S3-HKD)
CREATE TABLE so_chi_phi (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ky_ke_toan_id BIGINT,
    ngay_chung_tu DATE,
    so_hieu_chung_tu VARCHAR(30),
    dien_giai TEXT,
    tong_tien DECIMAL(18,2) DEFAULT 0,
    cp_nhan_cong DECIMAL(18,2) DEFAULT 0,
    cp_dien DECIMAL(18,2) DEFAULT 0,
    cp_nuoc DECIMAL(18,2) DEFAULT 0,
    cp_vien_thong DECIMAL(18,2) DEFAULT 0,
    cp_thue_kho_baipha_mat_bang DECIMAL(18,2) DEFAULT 0,
    cp_quan_ly DECIMAL(18,2) DEFAULT 0,
    cp_khac DECIMAL(18,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ky_ke_toan_id) REFERENCES ky_ke_toan(id)
);

-- SK-05: Sổ theo dõi nghĩa vụ thuế (S4-HKD)
CREATE TABLE so_nghia_vu_thue (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ky_ke_toan_id BIGINT,
    sac_thue VARCHAR(30) NOT NULL,
    thue_phai_nop DECIMAL(18,2) DEFAULT 0,
    thue_da_nop DECIMAL(18,2) DEFAULT 0,
    thue_con_phai_nop DECIMAL(18,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ky_ke_toan_id) REFERENCES ky_ke_toan(id)
);

-- SK-06: Sổ theo dõi thanh toán tiền lương (S5-HKD)
CREATE TABLE so_tien_luong (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ky_ke_toan_id BIGINT,
    nhan_vien_id BIGINT,
    luong_phai_tra DECIMAL(18,2) DEFAULT 0,
    luong_da_tra DECIMAL(18,2) DEFAULT 0,
    luong_con_phai_tra DECIMAL(18,2) DEFAULT 0,
    bhxh_phai_tra DECIMAL(18,2) DEFAULT 0,
    bhxh_da_tra DECIMAL(18,2) DEFAULT 0,
    bhxh_con_phai_tra DECIMAL(18,2) DEFAULT 0,
    bhyt_phai_tra DECIMAL(18,2) DEFAULT 0,
    bhyt_da_tra DECIMAL(18,2) DEFAULT 0,
    bhyt_con_phai_tra DECIMAL(18,2) DEFAULT 0,
    bhtn_phai_tra DECIMAL(18,2) DEFAULT 0,
    bhtn_da_tra DECIMAL(18,2) DEFAULT 0,
    bhtn_con_phai_tra DECIMAL(18,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ky_ke_toan_id) REFERENCES ky_ke_toan(id),
    FOREIGN KEY (nhan_vien_id) REFERENCES dm_nhan_vien(id)
);

-- SK-07: Sổ quỹ tiền mặt (S6-HKD)
CREATE TABLE so_quy_tien_mat (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ky_ke_toan_id BIGINT,
    ngay_chung_tu DATE,
    so_hieu_phieu_thu VARCHAR(30),
    so_hieu_phieu_chi VARCHAR(30),
    dien_giai TEXT,
    thu DECIMAL(18,2) DEFAULT 0,
    chi DECIMAL(18,2) DEFAULT 0,
    so_du DECIMAL(18,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ky_ke_toan_id) REFERENCES ky_ke_toan(id)
);

-- SK-08: Sổ tiền gửi ngân hàng (S7-HKD)
CREATE TABLE so_tien_gui_ngan_hang (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ky_ke_toan_id BIGINT,
    tai_khoan_ngan_hang_id BIGINT,
    ngay_chung_tu DATE,
    so_hieu_bc_co VARCHAR(30),
    so_hieu_bc_no VARCHAR(30),
    dien_giai TEXT,
    gui_vao DECIMAL(18,2) DEFAULT 0,
    rut_ra DECIMAL(18,2) DEFAULT 0,
    so_du DECIMAL(18,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ky_ke_toan_id) REFERENCES ky_ke_toan(id),
    FOREIGN KEY (tai_khoan_ngan_hang_id) REFERENCES dm_tai_khoan_ngan_hang(id)
);

-- ============================================================
-- SECTION 4: KHO HÀNG
-- ============================================================

-- Kiểm kê hàng tồn kho
CREATE TABLE phieu_kiem_ke (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    so_phieu VARCHAR(20) UNIQUE NOT NULL,
    ngay_kiem_ke DATE NOT NULL,
    ky_ke_toan_id BIGINT,
    nguoi_kiem_ke_id BIGINT,
    nguoi_xac_nhan_id BIGINT,
    trang_thai VARCHAR(20) DEFAULT 'MOI',
    ghi_chu TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ky_ke_toan_id) REFERENCES ky_ke_toan(id)
);

CREATE TABLE phieu_kiem_ke_chi_tiet (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    phieu_kiem_ke_id BIGINT NOT NULL,
    hang_hoa_id BIGINT NOT NULL,
    so_luong_theo_so DECIMAL(18,4),
    so_luong_thuc_te DECIMAL(18,4),
    chech_lech DECIMAL(18,4),
    nguyen_nhan TEXT,
    xu_ly TEXT,
    FOREIGN KEY (phieu_kiem_ke_id) REFERENCES phieu_kiem_ke(id),
    FOREIGN KEY (hang_hoa_id) REFERENCES dm_hang_hoa(id)
);

-- ============================================================
-- SECTION 5: THUẾ
-- ============================================================

-- Kết quả tính thuế
CREATE TABLE ket_qua_tinh_thue (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ky_ke_toan_id BIGINT,
    loai_thue VARCHAR(20),
    doanh_thu_chiu_thue DECIMAL(18,2),
    thue_suat DECIMAL(5,2),
    thue_phai_nop DECIMAL(18,2),
    thue_da_nop DECIMAL(18,2),
    thue_con_phai_nop DECIMAL(18,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ky_ke_toan_id) REFERENCES ky_ke_toan(id)
);

-- Lịch sử nộp thuế
CREATE TABLE lich_su_nop_thue (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ky_ke_toan_id BIGINT,
    loai_thue VARCHAR(20),
    so_tien_nop DECIMAL(18,2),
    ngay_nop DATE,
    so_chung_tu VARCHAR(50),
    ghi_chu TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ky_ke_toan_id) REFERENCES ky_ke_toan(id)
);

-- ============================================================
-- SECTION 6: NHÂN SỰ
-- ============================================================

-- Chấm công
CREATE TABLE lich_su_cham_cong (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    nhan_vien_id BIGINT NOT NULL,
    ngay_cham_cong DATE NOT NULL,
    so_cong DECIMAL(10,2) DEFAULT 0,
    so_san_pham DECIMAL(10,2) DEFAULT 0,
    ghi_chu TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (nhan_vien_id) REFERENCES dm_nhan_vien(id),
    UNIQUE (nhan_vien_id, ngay_cham_cong)
);

-- Khấu trừ BHXH/BHYT/BHTN
CREATE TABLE bhxh_khau_tru (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    nhan_vien_id BIGINT NOT NULL,
    thang INTEGER NOT NULL,
    nam INTEGER NOT NULL,
    luong_tinh_bh DECIMAL(18,2),
    bhxh_nld DECIMAL(18,2),
    bhxh_hkd DECIMAL(18,2),
    bhyt_nld DECIMAL(18,2),
    bhyt_hkd DECIMAL(18,2),
    bhtn_nld DECIMAL(18,2),
    bhtn_hkd DECIMAL(18,2),
    tong_nld DECIMAL(18,2),
    tong_hkd DECIMAL(18,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (nhan_vien_id) REFERENCES dm_nhan_vien(id),
    UNIQUE (nhan_vien_id, thang, nam)
);

-- ============================================================
-- SECTION 7: QUẢN TRỊ HỆ THỐNG
-- ============================================================

-- Users
CREATE TABLE users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    ho_ten VARCHAR(100),
    email VARCHAR(100),
    so_dien_thoai VARCHAR(20),
    trang_thai VARCHAR(20) DEFAULT 'HOAT_DONG',
    login_attempts INTEGER DEFAULT 0,
    locked_until DATETIME,
    last_login DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Roles
CREATE TABLE roles (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ten_role VARCHAR(50) UNIQUE NOT NULL,
    mo_ta VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Permissions
CREATE TABLE permissions (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    ten_permission VARCHAR(100) UNIQUE NOT NULL,
    mo_ta VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- User Roles
CREATE TABLE user_roles (
    user_id BIGINT NOT NULL,
    role_id BIGINT NOT NULL,
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE
);

-- Role Permissions
CREATE TABLE role_permissions (
    role_id BIGINT NOT NULL,
    permission_id BIGINT NOT NULL,
    granted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (role_id, permission_id),
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
    FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE
);

-- Audit Log - Append only
CREATE TABLE audit_log (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT,
    username VARCHAR(50),
    ho_ten VARCHAR(100),
    chuc_danh VARCHAR(50),
    hanh_dong VARCHAR(50) NOT NULL,
    doi_tuong_type VARCHAR(100) NOT NULL,
    doi_tuong_id BIGINT NOT NULL,
    gia_tri_cu TEXT,
    gia_tri_moi TEXT,
    ip_address VARCHAR(50),
    user_agent VARCHAR(255),
    thoi_gian TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- ============================================================
-- SECTION 8: INDEXES FOR PERFORMANCE
-- ============================================================

-- Master Data Indexes
CREATE INDEX idx_hkd_ma_so_thue ON hkd_info(ma_so_thue);
CREATE INDEX idx_hang_hoa_ma ON dm_hang_hoa(ma_hang);
CREATE INDEX idx_hang_hoa_nhom_nghe ON dm_hang_hoa(nhom_nghe_id);
CREATE INDEX idx_nhom_nghe_ngay_hieu_luc ON dm_nhom_nghe(ngay_hieu_luc);
CREATE INDEX idx_nha_cc_ma ON dm_nha_cung_cap(ma_nha_cc);
CREATE INDEX idx_khach_ma ON dm_khach_hang(ma_khach);
CREATE INDEX idx_nhan_vien_ma ON dm_nhan_vien(ma_nhan_vien);
CREATE INDEX idx_nhan_vien_trang_thai ON dm_nhan_vien(trang_thai);
CREATE INDEX idx_tai_khoan_ma ON dm_tai_khoan_ngan_hang(ma_tai_khoan);
CREATE INDEX idx_ky_ke_toan_nam ON ky_ke_toan(nam_tai_chinh);
CREATE INDEX idx_ky_ke_toan_trang_thai ON ky_ke_toan(trang_thai);

-- Phieu thu chi Indexes
CREATE INDEX idx_phieu_thu_ngay ON phieu_thu(ngay_lap);
CREATE INDEX idx_phieu_thu_ky_ke_toan ON phieu_thu(ky_ke_toan_id);
CREATE INDEX idx_phieu_thu_trang_thai ON phieu_thu(trang_thai);
CREATE INDEX idx_phieu_chi_ngay ON phieu_chi(ngay_lap);
CREATE INDEX idx_phieu_chi_ky_ke_toan ON phieu_chi(ky_ke_toan_id);
CREATE INDEX idx_phieu_chi_trang_thai ON phieu_chi(trang_thai);

-- Kho Indexes
CREATE INDEX idx_phieu_nhap_kho_ngay ON phieu_nhap_kho(ngay_lap);
CREATE INDEX idx_phieu_xuat_kho_ngay ON phieu_xuat_kho(ngay_lap);
CREATE INDEX idx_phieu_nhap_kho_chi_tiet ON phieu_nhap_kho_chi_tiet(phieu_nhap_kho_id, hang_hoa_id);
CREATE INDEX idx_phieu_xuat_kho_chi_tiet ON phieu_xuat_kho_chi_tiet(phieu_xuat_kho_id, hang_hoa_id);

-- Bang luong indexes
CREATE INDEX idx_bang_luong_thang_nam ON bang_luong(thang, nam);
CREATE INDEX idx_bang_luong_chi_tiet ON bang_luong_chi_tiet(bang_luong_id, nhan_vien_id);

-- So ke toan indexes
CREATE INDEX idx_so_doanh_thu_ky ON so_doanh_thu(ky_ke_toan_id, nhom_nghe_id, ngay_chung_tu);
CREATE INDEX idx_so_vat_tu_ky ON so_vat_tu_hang_hoa(ky_ke_toan_id, hang_hoa_id);
CREATE INDEX idx_so_chi_phi_ky ON so_chi_phi(ky_ke_toan_id, ngay_chung_tu);
CREATE INDEX idx_so_nghia_vu_thue_ky ON so_nghia_vu_thue(ky_ke_toan_id, sac_thue);
CREATE INDEX idx_so_tien_luong_ky ON so_tien_luong(ky_ke_toan_id, nhan_vien_id);
CREATE INDEX idx_so_quy_ky ON so_quy_tien_mat(ky_ke_toan_id, ngay_chung_tu);
CREATE INDEX idx_so_tien_gui_ky ON so_tien_gui_ngan_hang(ky_ke_toan_id, tai_khoan_ngan_hang_id, ngay_chung_tu);

-- Audit log index
CREATE INDEX idx_audit_log_thoi_gian ON audit_log(thoi_gian DESC);
CREATE INDEX idx_audit_log_user ON audit_log(user_id, thoi_gian DESC);
CREATE INDEX idx_audit_log_doi_tuong ON audit_log(doi_tuong_type, doi_tuong_id);

-- ============================================================
-- SECTION 9: SEED DATA - Default roles
-- ============================================================

INSERT INTO roles (ten_role, mo_ta) VALUES 
('ADMIN', 'Quan tri vien he thong'),
('KE_TOAN_VIEN', 'Ke toan vien'),
('THU_QUY', 'Thu quy'),
('THU_KHO', 'Thu kho'),
('NGUOI_DAI_DIEN', 'Nguoi dai dien HKD');

INSERT INTO permissions (ten_permission, mo_ta) VALUES 
('MD_VIEW', 'Xem Master Data'),
('MD_CREATE', 'Tao Master Data'),
('MD_UPDATE', 'Cap nhap Master Data'),
('MD_DELETE', 'Xoa Master Data'),
('CT_VIEW', 'Xem chung tu'),
('CT_CREATE', 'Tao chung tu'),
('CT_APPROVE', 'Phe duyet chung tu'),
('SK_VIEW', 'Xem so ke toan'),
('SK_UPDATE', 'Ghi so ke toan'),
('TX_VIEW', 'Xem thue'),
('TX_CALCULATE', 'Tinh thue'),
('NS_VIEW', 'Xem nhan su'),
('NS_MANAGE', 'Quan ly nhan su'),
('RP_VIEW', 'Xem bao cao'),
('RP_EXPORT', 'Xuat bao cao'),
('USER_MANAGE', 'Quan ly nguoi dung'),
('ROLE_MANAGE', 'Quan ly vai tro'),
('SYS_CONFIG', 'Cau hinh he thong');

-- Grant all permissions to ADMIN role
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM roles r, permissions p
WHERE r.ten_role = 'ADMIN';

-- ============================================================
-- END OF SCHEMA
-- ============================================================