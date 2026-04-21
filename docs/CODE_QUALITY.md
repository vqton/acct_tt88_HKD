# Code Quality Standards

## 1. General Principles
- Follow Effective Dart guidelines
- Write clean, readable, and maintainable code
- Prefer composition over inheritance
- Keep functions small and focused (single responsibility principle)
- Aim for functions < 30 lines of code
- Use meaningful and descriptive names
- Avoid magic numbers and strings
- Comment only when necessary (why, not what)
- Keep dependencies minimal and up-to-date

## 2. Dart Specific Rules
- Use `final` for variables that don't change after initialization
- Prefer `const` for compile-time constants
- Use `=>` for single-line functions
- Prefer `async/await` over raw Futures when possible
- Use cascades (`..`) for multiple operations on the same object
- Prefer collection literals and methods (map, where, fold)
- Avoid unnecessary imports
- Use `late` only when necessary and with caution
- Handle all futures (don't leave unawaited futures)
- Use `Equatable` for value-based equality when needed
- Use `freezed` or `json_serializable` for complex data models when appropriate

## 3. Testing Standards
- Follow Test-Driven Development (TDD): write tests before implementation
- Aim for 100% code coverage on domain and data layers
- Unit tests should be fast, isolated, and repeatable
- Use descriptive test names that explain the scenario and expected outcome
- Follow Arrange-Act-Assert (AAA) pattern
- Mock external dependencies (repositories, datasources) in unit tests
- Integration tests for critical user flows
- Test edge cases and error conditions
- Keep tests in the same directory structure as the code they test

## 4. Architecture Standards
- Follow Clean Architecture principles
- Separate concerns: Domain (business logic), Data, Presentation
- Domain layer should have no dependencies on external frameworks
- Use dependency injection (GetIt/Injectable) for loose coupling
- Use Riverpod for state management
- Keep UI layer (presentation) thin and dumb
- Business logic should reside in domain/use cases, not in UI
- Entities should be pure Dart objects with no framework dependencies
- Use Either<Failure, Success> for error handling in domain layer
- Avoid direct database access in UI or use cases - go through repositories

## 5. Naming Conventions
- Use `lowerCamelCase` for variables, functions, and parameters
- Use `UpperCamelCase` for classes, enums, and typedefs
- Use `UPPER_CASE_WITH_UNDERSCORES` for constants
- Use descriptive names that convey intent
- Prefix interfaces with `I` is NOT used in Dart (use abstract classes)
- Test files: `[feature]_[what_is_tested]_test.dart`
- Test groups should describe the unit under test
- Use meaningful test case descriptions

## 6. Error Handling
- Use exceptions only for unexpected/runtime errors
- Use Either<Failure, T> for expected errors in domain layer
- Create specific failure classes for different error types
- Handle errors gracefully in UI (show user-friendly messages)
- Log errors appropriately for debugging
- Never swallow exceptions without handling

## 7. Performance Considerations
- Avoid expensive operations in build() methods
- Use const constructors where possible
- Optimize database queries (indexes, limit, offset)
- Consider pagination for large lists
- Use async/await to avoid blocking UI thread
- Dispose of controllers and streams properly
- Use ValueListenableBuilder for efficient rebuilds
- Consider using Isolates for heavy computations

## 8. Security
- Never hardcode secrets (API keys, passwords)
- Use secure storage for sensitive data
- Validate and sanitize user input
- Use HTTPS for network calls
- Implement proper authentication and authorization
- Follow principle of least privilege

## 9. Documentation
- Document public APIs with dartdoc
- Explain why, not what
- Keep documentation updated with code changes
- Use TODO comments with assignee and date when appropriate
- Document complex business rules

## 10. Flutter Specific
- Use StatefulWidget only when necessary, prefer StatelessWidget
- Extract widget methods for complex UI
- Use Builder when you need a BuildContext from a different part of the tree
- Avoid setState in initState or dispose
- Use Keys only when necessary for preserving state
- Consider using automaticKeepAlive for tabs
- Use MediaQuery for responsive design
- Implement proper error boundaries
- Use Theme for consistent styling
- Follow Material Design 3 guidelines