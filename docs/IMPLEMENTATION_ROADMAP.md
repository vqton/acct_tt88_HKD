# Implementation Roadmap — HKD Accounting System

**Document Version:** 1.0  
**Date:** 2026-04-29  
**Author:** Project Manager (20 years experience)  
**Status:** Finalized for .NET 9 Rewrite  

---

## Executive Summary

### Current State (2026-04-28)
| Metric | Value |
|---------|-------|
| **Platform** | .NET 9.0 ✅ |
| **Architecture** | Clean Architecture ✅ |
| **Database** | SQLite + EF Core 9 ✅ |
| **CQRS** | MediatR 12.4 ✅ |
| **Validation** | FluentValidation 11.9 ✅ |
| **Testing** | xUnit + Moq (TDD) ✅ |
| **API** | ASP.NET Core Web API ✅ |
| **Build Status** | Build Successful ✅ |
| **Unit Test Coverage** | ~15% (3 use cases) |

### Target State (End of Implementation)
| Metric | Target | Current | Gap |
|---------|--------|---------|-----|
| **Total Use Cases** | 43 | 3 | 40 |
| **Unit Test Coverage** | ≥80% | ~15% | 65% |
| **Integration Test Coverage** | ≥60% | 0% | 60% |
| **Modules Completed** | 8 | 2 | 6 |
| **API Endpoints** | 43 | 5 | 38 |

---

## Module Implementation Order (Data Dependency)

### Phase 1: Master Data Foundation (P0 - Weeks 1-4)
**Priority:** P0 (Critical Path)  
**Dependencies:** None  
**Provides:** Foundation for all other modules

| UC | Feature | Est. Days | Depends On | Status |
|----|---------|-----------|------------|--------|
| MD-01 | HKD/CNKD Info | 2 | — | ✅ Complete |
| MD-03 | Tax Rates | 2 | — | ✅ Complete |
| MD-02 | Goods/Services | 3 | MD-03 | ✅ Complete |
| MD-04 | Partners (Suppliers) | 3 | MD-01 | 🔶 Ready to start |
| MD-05 | Customers | 3 | MD-01 | 🔶 Ready to start |
| MD-06 | Employees | 3 | MD-01 | 📋 Pending |
| MD-07 | Bank Accounts | 2 | MD-01 | 📋 Pending |
| MD-08 | Accounting Periods | 2 | MD-01 | 📋 Pending |

**Phase 1 Success Criteria:**
- ✅ All Master Data entities created with EF Core
- ✅ CRUD endpoints for all 8 entities
- ✅ MediatR Commands/Queries implemented
- ✅ FluentValidation on all DTOs
- ✅ Unit tests with ≥80% coverage
- ✅ Integration tests for all endpoints

---

### Phase 2: Voucher Management (P0 - Weeks 5-8)
**Priority:** P0  
**Dependencies:** MD-01, MD-04, MD-05  
**Provides:** Input for Accounting Books

| UC | Feature | Est. Days | Depends On | Status |
|----|---------|-----------|------------|--------|
| CT-01 | Phieu Thu (Receipt) | 3 | MD-01, MD-05 | ✅ Complete |
| CT-02 | Phieu Chi (Payment) | 3 | MD-01 | ✅ Complete |
| CT-03 | Phieu Nhap Kho (Goods Receipt) | 4 | MD-02, MD-04 | 📋 Pending |
| CT-04 | Phieu Xuat Kho (Goods Issue) | 4 | MD-02 | 📋 Pending |
| CT-05 | Bang Luong (Payroll) | 5 | MD-06 | 📋 Pending |
| CT-06 | Hoa Don (Invoices) | 5 | MD-02, MD-03, MD-04, MD-05 | 📋 Pending |
| CT-07 | Luu Tru Chung Tu (Archive) | 3 | MD-08 | 📋 Pending |
| CT-08 | Phe Duyet Chung Tu (Approve) | 3 | CT-01 to CT-05 | 📋 Pending |

**Phase 2 Success Criteria:**
- ✅ All voucher types with proper business rules
- ✅ Two-step approval process (preparer ≠ approver)
- ✅ Soft delete (IsActive flag)
- ✅ Audit trail for all approvals
- ✅ Integration with Master Data

---

### Phase 3: Accounting Books (P1 - Weeks 9-12)
**Priority:** P1  
**Dependencies:** CT-01 to CT-08, MD-08  
**Provides:** Legal accounting records

| UC | Feature | Est. Days | Depends On | Status |
|----|---------|-----------|------------|--------|
| SK-01 | Mo So Ke Toan (Open Books) | 3 | MD-01, MD-08 | 📋 Pending |
| SK-02 | So Doanh Thu S1-HKD | 4 | CT-06, MD-03 | 📋 Pending |
| SK-03 | So Vat Tu Hang Hoa S2-HKD | 4 | CT-03, CT-04 | 📋 Pending |
| SK-04 | So Chi Phi S3-HKD | 4 | CT-02, CT-04 | 📋 Pending |
| SK-05 | So Nghia Vu Thue S4-HKD | 4 | SK-02, TX-02, TX-03 | 📋 Pending |
| SK-06 | So Tien Luong S5-HKD | 4 | CT-05 | 📋 Pending |
| SK-07 | So Quy Tien Mat S6-HKD | 3 | CT-01, CT-02 | 📋 Pending |
| SK-08 | So Tien Gui Ngan Hang S7-HKD | 3 | MD-07 | 📋 Pending |

**Phase 3 Success Criteria:**
- ✅ Automatic posting from approved vouchers
- ✅ 7 Accounting Books per legal requirement
- ✅ FIFO/Weighted Average inventory valuation
- ✅ Multi-location support (separate books per location)

---

### Phase 4: Warehouse Management (P1 - Weeks 13-14)
**Priority:** P1  
**Dependencies:** CT-03, CT-04, SK-03  

| UC | Feature | Est. Days | Depends On | Status |
|----|---------|-----------|------------|--------|
| KH-01 | Nhap Kho Hang Hoa | 3 | CT-03, MD-02 | 📋 Pending |
| KH-02 | Xuat Kho Hang Hoa | 3 | CT-04, MD-02, SK-03 | 📋 Pending |
| KH-03 | Kiem Ke Hang Ton Kho | 4 | SK-03 | 📋 Pending |
| KH-04 | Tinh Gia Xuat Kho (FIFO/Avg) | 5 | MD-01, SK-03 | 📋 Pending |

---

### Phase 5: Tax Calculation (P1 - Weeks 15-16)
**Priority:** P1  
**Dependencies:** SK-02, MD-03, CT-05  

| UC | Feature | Est. Days | Depends On | Status |
|----|---------|-----------|------------|--------|
| TX-01 | Xac Dinh Doanh Thu Chiu Thue | 3 | SK-02, MD-03 | 📋 Pending |
| TX-02 | Tinh Thue GTGT | 3 | TX-01, MD-03 | 📋 Pending |
| TX-03 | Tinh Thue TNCN | 4 | TX-01, CT-05, MD-03 | 📋 Pending |
| TX-04 | Theo Doi Nop Thue | 3 | TX-02, TX-03, SK-05 | 📋 Pending |

---

### Phase 6: HR & Payroll (P1 - Weeks 17-18)
**Priority:** P1  
**Dependencies:** MD-06, CT-05  

| UC | Feature | Est. Days | Depends On | Status |
|----|---------|-----------|------------|--------|
| NS-01 | Tinh Luong Nguoi Lao Dong | 4 | MD-06 | 📋 Pending |
| NS-02 | Khau Tru & Theo Doi BHXH | 4 | NS-01, MD-06 | 📋 Pending |
| NS-03 | Theo Doi & Thanh Toan Luong | 3 | CT-05, NS-01, NS-02 | 📋 Pending |

---

### Phase 7: Cash & Banking (P2 - Weeks 19-20)
**Priority:** P2  
**Dependencies:** CT-01, CT-02, SK-07, SK-08  

| UC | Feature | Est. Days | Depends On | Status |
|----|---------|-----------|------------|--------|
| TT-01 | Quan Ly Quy Tien Mat | 3 | CT-01, CT-02, SK-07 | 📋 Pending |
| TT-02 | Quan Ly Tien Gui Ngan Hang | 3 | MD-07, SK-08 | 📋 Pending |

---

### Phase 8: Administration (P2 - Weeks 21-24)
**Priority:** P2  
**Dependencies:** All modules  

| UC | Feature | Est. Days | Depends On | Status |
|----|---------|-----------|------------|--------|
| QT-01 | User & Role Management | 5 | MD-01 | 📋 Pending |
| QT-02 | Sua Chua/Dieu Chinh So | 4 | SK-01 to SK-08 | 📋 Pending |
| QT-03 | Dong Ky & Khoa So | 4 | MD-08, All SK | 📋 Pending |
| QT-04 | Bao Cao Tong Hop | 5 | All SK, TX | 📋 Pending |
| QT-05 | Luu Tru & Tra Cuu Chung Tu | 3 | CT-07 | 📋 Pending |
| QT-06 | Nhat Ky He Thong & Audit | 3 | All | 📋 Pending |

---

## Risk Assessment

| Risk | Impact | Probability | Mitigation |
|------|--------|------------|-----------|
| Master Data not completed first | High | Medium | **Enforce P0 priority, block dependent work** |
| Integration test coverage <60% | Medium | High | **Automate test runs in CI/CD pipeline** |
| Business rule violations | High | Medium | **TDD approach, validate against UC spec** |
| Performance issues with FIFO | Medium | Low | **Use CTE + window functions in SQL** |
| Audit trail gaps | High | Medium | **Append-only design, no delete permissions** |

---

## Success Metrics

| KPI | Sprint 1 Target | Final Target |
|-----|------------------|--------------|
| Unit Test Coverage | 40% | **80%** |
| Integration Test Coverage | 20% | **60%** |
| Defect Escape Rate | <15% | **<5%** |
| Test Execution Time | <5 min | **<2 min** |
| Code Review Coverage | 100% | **100%** |
| Build Success Rate | 100% | **100%** |

---

*Updated 2026-04-29 for .NET 9 rewrite*  
*Following TDD practices and CLAUDE.MD guidelines*
