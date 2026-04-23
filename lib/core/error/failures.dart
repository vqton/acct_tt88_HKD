// ============================================================================
// Core Layer - Failures
// ============================================================================

import 'dart:core';

abstract class Failure implements Exception {
  final String message;
  const Failure(this.message);

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(String message) : super(message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(String message) : super(message);
}

class EmptyFailure extends Failure {
  const EmptyFailure([String message = 'No data found']) : super(message);
}