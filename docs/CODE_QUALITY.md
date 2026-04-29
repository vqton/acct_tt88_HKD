# Code Quality Standards

## 1. General Principles
- Follow Effective C# guidelines and Microsoft C# coding conventions
- Write clean, readable, and maintainable code\
- Prefer composition over inheritance\
- Keep functions small and focused (single responsibility principle)\
- Aim for functions < 30 lines of code\
- Use meaningful and descriptive names\
- Avoid magic numbers and strings\
- Comment only when necessary (why, not what)\
- Keep dependencies minimal and up-to-date\
- Follow Clean Architecture principles strictly\

## 2. C# Specific Rules
- Use `var` for implicit type declarations when the type is obvious\
- Prefer `async/await` over raw Tasks when possible\
- Use `IEnumerable<T>` over `List<T>` for read-only collections\
- Avoid unnecessary `async` if the method has no `await` (compiler warning)\
- Use nullable reference types (enabled by default)\
- Handle all async methods (no fire-and-forget)\
- Use records for immutable DTOs\
- Use `=>` for single-line methods\
- Avoid unnecessary `using` directives\
- Use `nameof()` for string references to member names\

## 3. Architecture Standards
- Follow Clean Architecture principles: Domain → Application → Infrastructure → API\
- Domain layer has no dependencies on external frameworks\
- Use MediatR for CQRS pattern (Commands/Queries)\
- Use FluentValidation for DTO validation\
- Use Entity Framework Core for data access (Infrastructure layer only)\
- Use Dependency Injection for loose coupling\
- Keep API layer thin (only controller logic, no business logic)\
- Business logic resides in Domain/Application layers\
- Use `IRepository<T>` pattern for data access\
- Avoid direct database access in Application layer\

## 4. Testing Standards
- Follow Test-Driven Development (TDD): write tests before implementation\
- Aim for ≥80% code coverage on Domain and Application layers\
- Unit tests should be fast, isolated, and repeatable\
- Use descriptive test names that explain the scenario and expected outcome\
- Follow Arrange-Act-Assert (AAA) pattern\
- Mock external dependencies (repositories, external services) in unit tests\
- Integration tests for critical API endpoints and database operations\
- Test edge cases and error conditions\
- Keep tests in the same directory structure as the code they test\

## 5. Naming Conventions
- Use `PascalCase` for class names, method names, public properties\
- Use `camelCase` for local variables, method parameters\
- Use `UPPER_CASE_WITH_UNDERSCORES` for constants\
- Use descriptive names that convey intent\
- Test files: `[Feature]Tests.cs` (e.g., `GoodsTests.cs`, `CreateGoodsCommandTests.cs`)\
- Test methods: `MethodName_ExpectedBehavior_WhenCondition` (e.g., `Handle_ReturnsSuccess_WhenCommandIsValid`)\

## 6. Error Handling
- Use exceptions only for unexpected/runtime errors\
- Use `Result<T>` pattern for expected errors in Application layer\
- Create specific exception classes for different error types\
- Handle errors gracefully in API (return appropriate HTTP status codes)\
- Log errors appropriately for debugging\
- Never swalllow exceptions without handling\

## 7. Performance Considerations
- Avoid expensive operations in API controller methods\
- Use asynchronous programming for I/O-bound operations\
- Optimize EF Core queries (use `AsNoTracking()` for read-only queries, index frequently queried columns)\
- Consider pagination for large lists\
- Dispose of resources properly (use `using` statements or `IAsyncDisposable`)\
- Avoid N+1 queries in EF Core\

## 8. Security
- Never hardcode secrets (connection strings, API keys) in code\
- Use user secrets or environment variables for sensitive data\
- Validate and sanitize user input (FluentValidation)\
- Use HTTPS for all API endpoints\
- Implement proper authentication and authorization (JWT)\
- Follow principle of least privilege\

## 9. Documentation
- Document public APIs with XML documentation comments\
- Explain why, not what\
- Keep documentation updated with code changes\
- Use TODO comments with assignee and date when appropriate\
- Document complex business rules\

## 10. EF Core Specific
- Use migrations for database schema changes\
- Define entity configurations via `IEntityTypeConfiguration<T>`\
- Use SQLite for development, SQL Server for production (if needed)\
- Avoid using EF Core in Domain layer\
- Use `EnsureCreated()` only for development/testing\
