import 'dart:math' as math;

import '../parser/ast_nodes.dart';
import '_builtin_library.dart';
import '_execution_context.dart';
import '_flow_exceptions.dart';
import '_qbit_resolver.dart';
import '_range_result.dart';
import 'exceptions.dart';

/// Evaluates OpenQASM expressions to runtime values.
class ExpressionEvaluator {
  ExpressionEvaluator(this.context, this.statementExecutor) {
    _qbitResolver = QbitResolver(context, evaluate);
  }

  final ExecutionContext context;
  final void Function(List<Statement>) statementExecutor;
  late final QbitResolver _qbitResolver;

  /// Evaluates an expression and returns its value.
  dynamic evaluate(Expression? expr) {
    if (expr == null) return null;

    return switch (expr) {
      LiteralExpression e => e.value,
      IdentifierExpression e => _evaluateIdentifier(e),
      BinaryExpression e => _evaluateBinary(e),
      UnaryExpression e => _evaluateUnary(e),
      CallExpression e => _evaluateCall(e),
      IndexExpression e => _evaluateIndex(e),
      RangeExpression e => _evaluateRange(e),
      SetExpression e => e.expressions.map(evaluate).toList(),
      CastExpression e => _evaluateCast(e),
      HardwareQubitExpression e => e.index,
      DurationOfExpression() => 0, // TODO: Implement properly
      MeasureExpression e => _evaluateMeasure(e),
      _ => throw EvaluationException(
        'Unknown expression type: ${expr.runtimeType}',
      ),
    };
  }

  dynamic _evaluateMeasure(MeasureExpression expr) {
    final qubits = _qbitResolver.resolve(expr.qubit);
    if (qubits.isEmpty) {
      throw EvaluationException('No qubits specified for measurement');
    }

    final qmem = context.quantumMemory;
    if (qmem == null) {
      throw EvaluationException('Cannot measure: no quantum memory');
    }

    return qmem.read(qubits: qubits);
  }

  dynamic _evaluateIdentifier(IdentifierExpression expr) {
    // First check for built-in constants
    if (BuiltinLibrary.isConstant(expr.name)) {
      return BuiltinLibrary.getConstant(expr.name);
    }

    // Look up variable or constant in symbols
    try {
      return context.getVariable(expr.name);
    } catch (e) {
      throw EvaluationException('Undefined identifier: ${expr.name}');
    }
  }

  dynamic _evaluateBinary(BinaryExpression expr) {
    final left = evaluate(expr.left);
    final right = evaluate(expr.right);

    return switch (expr.operator) {
      // Arithmetic
      '+' => left + right,
      '-' => left - right,
      '*' => left * right,
      '/' => left / right,
      '%' => left % right,
      '**' => math.pow(left as num, right as num),

      // Bitwise
      '&' => (left as int) & (right as int),
      '|' => (left as int) | (right as int),
      '^' => (left as int) ^ (right as int),
      '<<' => (left as int) << (right as int),
      '>>' => (left as int) >> (right as int),

      // Logical
      '&&' => toBool(left) && toBool(right),
      '||' => toBool(left) || toBool(right),

      // Comparison
      '==' => left == right,
      '!=' => left != right,
      '<' => (left as num) < (right as num),
      '>' => (left as num) > (right as num),
      '<=' => (left as num) <= (right as num),
      '>=' => (left as num) >= (right as num),

      _ => throw EvaluationException(
        'Unknown binary operator: ${expr.operator}',
      ),
    };
  }

  dynamic _evaluateUnary(UnaryExpression expr) {
    final value = evaluate(expr.expression);

    return switch (expr.operator) {
      '-' => -(value as num),
      '!' => !toBool(value),
      '~' => ~(value as int),
      _ => throw EvaluationException(
        'Unknown unary operator: ${expr.operator}',
      ),
    };
  }

  dynamic _evaluateCall(CallExpression expr) {
    final args = expr.arguments.map(evaluate).toList();

    // Built-in functions
    if (BuiltinLibrary.isFunction(expr.name)) {
      final fn = BuiltinLibrary.getFunction(expr.name)!;
      try {
        return Function.apply(fn, args);
      } catch (e) {
        throw EvaluationException(
          'Error calling built-in function ${expr.name}: $e',
        );
      }
    }

    // User-defined subroutines
    final subroutine = context.symbols.lookupSubroutine(expr.name);
    if (subroutine != null) {
      if (args.length != (subroutine.arguments?.length ?? 0)) {
        throw EvaluationException(
          'Function ${expr.name} expects ${subroutine.arguments?.length ?? 0} arguments, but got ${args.length}',
        );
      }

      context.pushScope();
      try {
        // Bind arguments
        if (subroutine.arguments != null) {
          for (var i = 0; i < args.length; i++) {
            final argDef = subroutine.arguments![i];
            context.declareClassicalVariable(argDef.name, argDef.type, args[i]);
          }
        }

        // Execute body
        statementExecutor(subroutine.body);
      } catch (e) {
        if (e is ReturnException) {
          return e.value;
        }
        rethrow;
      } finally {
        context.popScope();
      }
      return null;
    }

    throw EvaluationException(
      'Unknown or unimplemented function: ${expr.name}',
    );
  }

  dynamic _evaluateIndex(IndexExpression expr) {
    // If it's an identifier, check if it's a qubit register FIRST
    if (expr.expression case IdentifierExpression identifier) {
      final name = identifier.name;
      final register = context.symbols.lookupQubit(name);

      if (register != null) {
        final result = evaluate(
          expr.indices[0],
        ); // Qubit registers expect single index
        if (result is int) return result;
        if (result is RangeResult) return result.values.toList();
        if (result is List) return result.cast<int>();
        throw EvaluationException('Invalid qubit index: $result');
      }
    }

    final base = evaluate(expr.expression);
    final indices = expr.indices.map(evaluate).toList();

    // Array indexing for classical values
    if (base is List) {
      if (indices.length == 1) {
        final index = indices[0];
        if (index is int) {
          return base[index];
        } else if (index is RangeResult) {
          return base.sublist(index.start, index.stop);
        } else if (index is List) {
          return index.map((i) => base[i as int]).toList();
        }
      }
    }

    throw EvaluationException('Cannot index $base with $indices');
  }

  RangeResult _evaluateRange(RangeExpression expr) {
    final start = expr.start != null ? evaluate(expr.start) as int : 0;
    int step = 1;
    int stop = 0;

    if (expr.stop != null) {
      // start:step:stop
      step = expr.step != null ? evaluate(expr.step) as int : 1;
      stop = evaluate(expr.stop) as int;
    } else {
      // start:stop (step OMITS)
      // In this case, expr.step actually contains the STOP value
      stop = expr.step != null ? evaluate(expr.step) as int : 0;
      step = 1;
    }

    return RangeResult(start, stop, step);
  }

  dynamic _evaluateCast(CastExpression expr) {
    final value = evaluate(expr.expression);
    final type = expr.type;

    if (type is ScalarTypeNode) {
      return switch (type.name) {
        'int' ||
        'uint' => (value is num) ? value.toInt() : int.parse(value.toString()),
        'float' =>
          (value is num) ? value.toDouble() : double.parse(value.toString()),
        'bool' => toBool(value),
        'bit' => (value as num).toInt() & 1,
        _ => value,
      };
    }

    return value;
  }

  static bool toBool(dynamic value) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) return value.isNotEmpty;
    return false;
  }
}
