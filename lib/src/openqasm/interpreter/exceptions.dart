import '../parser/ast_nodes.dart';

/// Base class for all OpenQASM interpreter exceptions.
abstract class OpenQasmException implements Exception {
  OpenQasmException(this.message, [this.node]);

  final String message;
  final OpenQASMNode? node;

  @override
  String toString() {
    final ctx = node?.source.toString();
    return (ctx == null)
        ? '$runtimeType: $message'
        : '$runtimeType: $message at $ctx';
  }
}

/// Thrown when an error occurs during program interpretation.
class InterpreterException extends OpenQasmException {
  InterpreterException(super.message, [super.node]);
}

/// Thrown when an error occurs during expression evaluation.
class EvaluationException extends OpenQasmException {
  EvaluationException(super.message, [super.node]);
}

/// Exception thrown during qubit resolution.
class QbitResolutionException extends OpenQasmException {
  QbitResolutionException(super.message, [super.node]);
}

/// Thrown when an error occurs during execution context operations.
class ExecutionException extends OpenQasmException {
  ExecutionException(super.message, [super.node]);
}

/// Exception thrown during gate execution.
class GateExecutionException extends OpenQasmException {
  GateExecutionException(super.message, [super.node]);
}

/// Thrown when an error occurs during symbol table operations.
class SymbolTableException extends OpenQasmException {
  SymbolTableException(super.message, [super.node]);
}

/// Thrown when an include file cannot be loaded.
class IncludeException extends OpenQasmException {
  final String? filename;

  IncludeException(String message, {this.filename, OpenQASMNode? node})
    : super(message, node);

  @override
  String toString() {
    if (filename != null) {
      return 'OpenQASM Include Error: Failed to load "$filename": ${super.toString()}';
    }
    return 'OpenQASM Include Error: ${super.toString()}';
  }
}
