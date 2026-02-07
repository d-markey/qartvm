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

/// Exception thrown during qubit resolution.
class QbitResolutionException extends OpenQasmException {
  QbitResolutionException(super.message);
}

/// Thrown when an error occurs during execution context operations.
class ExecutionException extends OpenQasmException {
  ExecutionException(super.message);
}

/// Exception thrown during gate execution.
class GateExecutionException extends OpenQasmException {
  GateExecutionException(super.message);
}

/// Thrown when an error occurs during symbol table operations.
class SymbolTableException extends OpenQasmException {
  SymbolTableException(super.message);
}

/// Thrown when an include file cannot be loaded.
class IncludeException extends OpenQasmException {
  final String? filename;

  IncludeException(super.message, {this.filename});

  @override
  String toString() {
    if (filename != null) {
      return 'OpenQASM Include Error: Failed to load "$filename": $message';
    }
    return 'OpenQASM Include Error: $message';
  }
}
