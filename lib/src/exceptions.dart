abstract class _BaseException implements Exception {
  _BaseException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// Exception thrown when the matrix or vector dimension is invalid
class InvalidDimensionsException extends _BaseException {
  InvalidDimensionsException([String? message]) : super(message ?? '');
}

/// Exception thrown when a matrix or vector operation is invalid
class InvalidOperationException extends _BaseException {
  InvalidOperationException([String? message]) : super(message ?? '');
}

/// Error thrown when a qubit is invalid
class InvalidQubitError extends Error implements _BaseException {
  InvalidQubitError([String? message]) : message = message ?? '';

  @override
  final String message;

  @override
  String toString() => '${super.toString()}: $message';
}
