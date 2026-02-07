import 'dart:async';
import '../parser/ast_nodes.dart';
import '_execution_context.dart';
import '_range_result.dart'; // Added for RangeResult
import 'exceptions.dart';

/// Resolves OpenQASM expressions to qubit addresses.
class QbitResolver {
  QbitResolver(this.context, this.evaluate);

  final ExecutionContext context;
  final Future<dynamic> Function(Expression) evaluate;

  /// Resolves an expression to a list of qubit addresses.
  Future<List<int>> resolve(Expression expr) async {
    if (expr is MeasureExpression) {
      return resolve(expr.qubit);
    }

    if (expr is IdentifierExpression) {
      final register = context.symbols.lookupQubit(expr.name);
      if (register == null) {
        throw EvaluationException('Unknown qubit register "${expr.name}"');
      }
      return register.qubits;
    } else if (expr is IndexExpression) {
      // Evaluate index expression
      // The evaluator's _evaluateIndex handles qubit register indexing
      // However, QbitResolver is called BEFORE the evaluator in some cases (like gate calls)
      // to resolve qubits. Or it's called BY the evaluator.

      // If expr.expression is an identifier for a qubit register, we need to handle it.
      if (expr.expression case IdentifierExpression identifier) {
        final name = identifier.name;
        final register = context.symbols.lookupQubit(name);

        if (register != null) {
          // It is a qubit register index access.
          // We need to evaluate the index.
          // Since evaluate() is now async, we await it.
          final indexValue = await evaluate(expr.indices[0]);
          if (indexValue is int) {
            return [register.qubits[indexValue]];
          } else if (indexValue is List<int>) {
            return indexValue.map((i) => register.qubits[i]).toList();
          } else if (indexValue is RangeResult) {
            return indexValue.values.map((i) => register.qubits[i]).toList();
          }
          throw EvaluationException('Invalid qubit index: $indexValue');
        }
      }
      // If it's not a direct register access, maybe it evaluates to a list of integers (aliases? not supported yet)
    } else if (expr is HardwareQubitExpression) {
      return [expr.index];
    }

    throw EvaluationException(
      'Cannot resolve qubits from expression of type ${expr.runtimeType}',
    );
  }

  /// Resolves a list of expressions to a flat list of qubit addresses.
  Future<List<int>> resolveAll(Iterable<Expression> exprs) async {
    final results = await Future.wait(exprs.map(resolve));
    return results.expand((x) => x).toList();
  }
}
