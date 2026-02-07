/// Internal exception for control-flow statements.
class FlowException implements Exception {}

/// Internal exception for break statements.
class BreakException extends FlowException {}

/// Internal exception for continue statements.
class ContinueException extends FlowException {}

/// Internal exception for end statements.
class EndException extends FlowException {}

/// Internal exception for return statements.
class ReturnException extends FlowException {
  ReturnException(this.value);
  final dynamic value;
}
