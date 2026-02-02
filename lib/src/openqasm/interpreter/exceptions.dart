/// Base class for all OpenQASM interpreter exceptions.
abstract class OpenQasmException implements Exception {
  OpenQasmException(this.message);
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// Thrown when an error occurs during program interpretation.
class InterpreterException extends OpenQasmException {
  InterpreterException(super.message);
}

/// Thrown when an error occurs during expression evaluation.
class EvaluationException extends OpenQasmException {
  EvaluationException(super.message);
}

/// Thrown when an error occurs during execution context operations.
class ExecutionException extends OpenQasmException {
  ExecutionException(super.message);
}

/// Thrown when an error occurs during symbol table operations.
class SymbolTableException extends OpenQasmException {
  SymbolTableException(super.message);
}
