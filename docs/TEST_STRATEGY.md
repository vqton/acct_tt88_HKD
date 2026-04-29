# Test Strategy Document
## HKD Accounting System - Kế toán HKD/CNKD

**Version:** 2.0  
**Date:** 2026-04-28  
**Author:** QA Lead (20 years experience)  
**Status:** Updated for .NET 9 Rewrite  

---
## 1. Executive Summary

### 1.1 Purpose
This test strategy defines the comprehensive testing approach for the HKD Accounting System (Kế toán HKD/CNKD theo Thông tư 88/2021/TT-BTC), rewritten in .NET 9. It establishes test objectives, scope, methodologies, and acceptance criteria to ensure software quality meets business requirements.

### 1.2 System Overview
- **Application Type:** ASP.NET Core Web API (Clean Architecture)
- **Architecture:** Clean Architecture (Domain, Application, Infrastructure, API layers)
- **Database:** SQLite with Entity Framework Core 9
- **Framework:** .NET 9.0 with MediatR 12.4 (CQRS), FluentValidation 11.9
- **Total Features:** 43 Use Cases across 7 modules
- **Testing Frameworks:** xUnit, Moq

### 1.3 Quality Objectives
| Objective | Target | Current |
|-----------|--------|---------|
| Unit Test Coverage | ≥80% | ~15% (3 use cases implemented) |
| Integration Test Coverage | ≥60% | 0% |
| Defect Detection Rate | ≥95% | N/A |
| Test Automation | ≥70% | ~100% (all tests automated) |
| Build Success Rate | 100% | 100% |

---
## 2. Test Scope

### 2.1 In Scope
- **Unit Tests:** Domain entities, Application layer Commands/Queries, Repository interfaces, Validation rules
- **Integration Tests:** API controllers, EF Core database operations, MediatR pipeline
- **Performance Tests:** API response times, EF Core query performance
- **Regression Tests:** All implemented features

### 2.2 Out of Scope
- **Frontend tests** (deferred until frontend implementation)
- **Security penetration testing** (Phase 2)
- **Accessibility testing** (Phase 2)
- **Legacy data migration testing** (future enhancement)

### 2.3 Module Coverage Matrix
| Module | UC Count | Priority | Test Types |
|--------|----------|----------|------------|
| Master Data (MD) | 8 | P0 | Unit, Integration |
| Chứng từ (CT) | 8 | P0 | Unit, Integration |
| Sổ kế toán (SK) | 8 | P1 | Unit, Integration |
| Kho hàng (KH) | 4 | P1 | Unit, Integration |
| Thuế (TX) | 4 | P1 | Unit, Integration |
| Nhân sự (NS) | 3 | P1 | Unit, Integration |
| Tiền tệ (TT) | 2 | P2 | Unit, Integration |
| Quản trị (QT) | 6 | P2 | Unit, Integration |

---
## 3. Test Types & Strategy

### 3.1 Unit Testing

#### 3.1.1 Domain Layer Tests
**Target:** Entities, Domain Services, Repository Interfaces
**Test Coverage Requirements:**
- All entity creation with valid/invalid data
- Entity behavior methods
- Domain event handling

Example:
```csharp
public class HkdInfoTests
{
    [Fact]
    public void Create_ValidHkdInfo_SetsPropertiesCorrectly()
    {
        // Arrange & Act
        var hkdInfo = new HkdInfo(
            taxCode: "0101234567",
            name: "Test HKD",
            address: "123 Test St",
            representative: "Nguyen Van A",
            inventoryValuationMethod: InventoryValuationMethod.WeightedAverage
        );

        // Assert
        Assert.Equal("0101234567", hkdInfo.TaxCode);
        Assert.Equal("Test HKD", hkdInfo.Name);
    }

    [Fact]
    public void Create_InvalidTaxCode_ThrowsArgumentException()
    {
        // Act & Assert
        Assert.Throws<ArgumentException>(() => new HkdInfo(
            taxCode: "",
            name: "Test HKD",
            address: "123 Test St",
            representative: "Nguyen Van A",
            inventoryValuationMethod: InventoryValuationMethod.WeightedAverage
        ));
    }
}
```

#### 3.1.2 Application Layer Tests
**Target:** MediatR Commands/Queries, FluentValidation Validators, DTOs
**Test Pattern:**
```csharp
public class CreateGoodsCommandTests
{
    private readonly Mock<IGoodsRepository> _goodsRepositoryMock;
    private readonly CreateGoodsCommand.CreateGoodsCommandHandler _handler;

    public CreateGoodsCommandTests()
    {
        _goodsRepositoryMock = new Mock<IGoodsRepository>();
        _handler = new CreateGoodsCommand.CreateGoodsCommandHandler(_goodsRepositoryMock.Object);
    }

    [Fact]
    public async Task Handle_ValidCommand_CreatesGoods()
    {
        // Arrange
        var command = new CreateGoodsCommand { Name = "Test Goods", Unit = "Cai" };
        _goodsRepositoryMock.Setup(repo => repo.AddAsync(It.IsAny<Goods>()))
            .ReturnsAsync((Goods g) => g);

        // Act
        var result = await _handler.Handle(command, CancellationToken.None);

        // Assert
        Assert.True(result.IsSuccess);
        _goodsRepositoryMock.Verify(repo => repo.AddAsync(It.IsAny<Goods>()), Times.Once);
    }
}
```

### 3.2 Integration Testing
**Target:** API Controllers, EF Core Database Context, MediatR Pipeline
**Test Setup:**
```csharp
public class GoodsControllerIntegrationTests : IAsyncLifetime
{
    private readonly WebApplicationFactory<Program> _factory;
    private readonly HttpClient _client;

    public GoodsControllerIntegrationTests()
    {
        _factory = new WebApplicationFactory<Program>()
            .WithWebHostBuilder(builder =>
            {
                builder.ConfigureServices(services =>
                {
                    services.RemoveDbContext<AppDbContext>();
                    services.AddDbContext<AppDbContext>(options =>
                        options.UseInMemoryDatabase("TestDb"));
                });
            });
        _client = _factory.CreateClient();
    }

    [Fact]
    public async Task GetGoods_ReturnsOkResult()
    {
        // Act
        var response = await _client.GetAsync("/api/goods");

        // Assert
        response.EnsureSuccessStatusCode();
    }
}
```

### 3.3 Test Pyramid
```
       ┌─────────────┐
       │ Integration │  ← 20% of test effort
       │   Tests     │
       └─────────────┘
      ┌┴─────────────┴┐
      │    Unit Tests   │  ← 80% of test effort
      │   (Domain, App)  │
      └───────────────┘
```

---
## 4. Test Environment

### 4.1 Test Database Strategy
| Test Type | Database | Tool |
|-----------|----------|------|
| Unit Tests | In-Memory EF Core | InMemoryDatabase |
| Integration Tests | SQLite In-Memory | Microsoft.EntityFrameworkCore.Sqlite.InMemory |
| API Tests | SQLite File | hkd_accounting_test.db |

### 4.2 Mock Strategy
| Component | Mock Tool | Rationale |
|-----------|----------|----------|
| Repositories | Moq | Control test scenarios |
| External Services | Moq | Test business logic in isolation |
| Database | In-Memory EF Core | Fast, isolated tests |

---
## 5. Test Execution

### 5.1 Running Tests
```bash
# All tests
dotnet test

# Unit tests only
dotnet test tests/Domain.UnitTests tests/Application.UnitTests

# Integration tests only
dotnet test tests/Infrastructure.UnitTests tests/Api.IntegrationTests

# With coverage
dotnet test /p:CollectCoverage=true
```

### 5.2 CI/CD Pipeline
```yaml
# .github/workflows/test.yml
name: .NET Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
       
      - name: Setup .NET
        uses: actions/setup-dotnet@v4
        with:
          dotnet-version: '9.0.x'
           
      - name: Restore dependencies
        run: dotnet restore
           
      - name: Run unit tests
        run: dotnet test tests/Domain.UnitTests tests/Application.UnitTests --no-restore
          
      - name: Run integration tests
        run: dotnet test tests/Infrastructure.UnitTests tests/Api.IntegrationTests --no-restore
           
      - name: Analyze code
        run: dotnet format --verify-no-changes
         
      - name: Build verification
        run: dotnet build --no-restore
```

---
## 6. Success Metrics
| KPI | Sprint 1 Target | Final Target |
|-----|-----------------|--------------|
| Unit Test Coverage | 40% | 80% |
| Integration Test Coverage | 20% | 60% |
| Defect Escape Rate | <15% | <5% |
| Test Execution Time | <5 min | <2 min |
| Code Review Coverage | 100% | 100% |

---
*Updated 2026-04-28 for .NET 9 rewrite*
