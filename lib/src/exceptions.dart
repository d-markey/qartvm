abstract class _BaseException implements Exception {
  _BaseException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

class InvalidDimensionsException extends _BaseException {
  InvalidDimensionsException([String? message]) : super(message ?? '');
}

class InvalidOperationException extends _BaseException {
  InvalidOperationException([String? message]) : super(message ?? '');
}

class InvalidQubitException extends _BaseException {
  InvalidQubitException([String? message]) : super(message ?? '');
}
