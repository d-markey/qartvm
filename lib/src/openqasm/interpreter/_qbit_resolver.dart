import '../parser/ast_nodes.dart';
import '_execution_context.dart';

/// Resolves OpenQASM expressions to qubit addresses.
class QbitResolver {
  QbitResolver(this.context, this.evaluate);

  final ExecutionContext context;
  final dynamic Function(Expression) evaluate;

  /// Resolves an expression to a list of qubit addresses.
  List<int> resolve(Expression expr) {
    if (expr is MeasureExpression) {
      return resolve(expr.qubit);
    }

    if (expr is IdentifierExpression) {
      final register = context.symbols.lookupQubit(expr.name);
      if (register == null) {
        throw QbitResolutionException('Unknown qubit register: ${expr.name}');
      }
      return register.qubits;
    } else if (expr is IndexExpression) {
      final result = evaluate(expr);
      if (result is int) {
        return [result];
      } else if (result is List) {
        return result.cast<int>();
      }
    } else if (expr is HardwareQubitExpression) {
      return [expr.index];
    }

    throw QbitResolutionException(
      'Cannot resolve qubits from expression of type ${expr.runtimeType}',
    );
  }

  /// Resolves a list of expressions to a flat list of qubit addresses.
  List<int> resolveAll(Iterable<Expression> exprs) {
    return exprs.expand(resolve).toList();
  }
}

/// Exception thrown during qubit resolution.
class QbitResolutionException implements Exception {
  QbitResolutionException(this.message);
  final String message;

  @override
  String toString() => 'QbitResolutionException: $message';
}
