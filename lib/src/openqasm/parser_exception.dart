class ParserException implements Exception {
  ParserException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

class InvalidTokenException extends ParserException {
  InvalidTokenException(String message) : super(message);
}

class SyntaxException extends ParserException {
  SyntaxException(String message) : super(message);
}
