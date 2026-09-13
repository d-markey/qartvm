import 'dart:async';

import 'package:qartvm/src/qregister.dart';

import '../parser/_eval.dart';
import '../parser/ast_nodes.dart';
import '_builtin_library.dart';
import '_flow_exceptions.dart';
import '_qbit_resolver.dart';
import '_range_result.dart';
import '_state_context.dart';
import 'exceptions.dart';

/// Evaluates OpenQASM expressions to runtime values.
class ExpressionEvaluator {
  ExpressionEvaluator(this.context, this.statementExecutor) {
    _qbitResolver = QbitResolver(context, evaluate);
  }

  final StateContext context;
  final Future<void> Function(List<Statement>) statementExecutor;
  late final QbitResolver _qbitResolver;

  /// Evaluates an expression and returns its value.
  Future<dynamic> evaluate(Expression? expr) async {
    if (expr == null) return null;

    return switch (expr) {
      LiteralExpression e => e.value,
      IdentifierExpression e => _evaluateIdentifier(e),
      BinaryExpression e => _evaluateBinary(e),
      UnaryExpression e => _evaluateUnary(e),
      CallExpression e => _evaluateCall(e),
      IndexExpression e => _evaluateIndex(e),
      RangeExpression e => _evaluateRange(e),
      SetExpression e => Future.wait(e.expressions.map(evaluate)),
      CastExpression e => _evaluateCast(e),
      HardwareQubitExpression e => e.address,
      DurationOfExpression() => 0, // TODO: Implement properly
      MeasureExpression e => _evaluateMeasure(e),
      _ => throw EvaluationException(
        'Unknown expression type: ${expr.runtimeType}',
        expr,
      ),
    };
  }

  Future<dynamic> _evaluateMeasure(MeasureExpression expr) async {
    final qubits = await _qbitResolver.resolve(expr.qubit);
    if (qubits.isEmpty) {
      throw EvaluationException('No qubits specified for measurement', expr);
    }

    final qmem = context.quantumMemory;
    if (qmem == null) {
      throw EvaluationException('Cannot measure: no quantum memory', expr);
    }

    final value = qmem.read(qbits: qubits);

    // Record the measurement in context
    final key = _getExpressionKey(expr.qubit);
    context.recordMeasurement('$key (${qubits.join(',')})', value);

    return value;
  }

  /// Returns a string representation of an expression to be used as a key.
  String _getExpressionKey(Expression expr) {
    if (expr is IdentifierExpression) return expr.name;
    if (expr is IndexExpression) {
      final base = _getExpressionKey(expr.expression);
      // We don't evaluate indices here to keep the key stable/structural,
      // or should we evaluate? Usually keys like "q[0]" are expected.
      // If index is a variable, evaluating it gives the current index.
      // Let's try to evaluate if it's simple or just use placeholder?
      // Actually, for it to be a useful key, it should probably be resolved if possible.
      // But OpenQASM typical output uses structural names if they are constant.
      // For now, let's keep it simple: if it's a literal, use it.
      final indices = expr.indices.map((i) {
        if (i is LiteralExpression) return '[${i.value}]';
        return '[?]'; // Placeholder for dynamic indices
      }).join();
      return '$base$indices';
    }
    if (expr is HardwareQubitExpression) return '\$${expr.address}';
    return expr.toString();
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
      //throw EvaluationException('Undefined identifier: ${expr.name}', expr);
    }

    // Look up variable or constant in symbols
    try {
      return context.getQubitRegister(expr.name);
    } catch (e) {
      throw EvaluationException('Undefined identifier: ${expr.name}', expr);
    }
  }

  Future<dynamic> _evaluateBinary(BinaryExpression expr) async {
    final left = await evaluate(expr.left);
    final right = await evaluate(expr.right);
    final res = applyBinaryOp(left, expr.operator, right);
    if (res == null) {
      throw EvaluationException(
        'Unknown binary operator: ${expr.operator}',
        expr,
      );
    }
    return res;
  }

  Future<dynamic> _evaluateUnary(UnaryExpression expr) async {
    final value = await evaluate(expr.expression);
    final res = applyUnaryOp(expr.operator, value);
    if (res == null) {
      throw EvaluationException(
        'Unknown unary operator: ${expr.operator}',
        expr,
      );
    }
    return res;
  }

  Future<dynamic> _evaluateCall(CallExpression expr) async {
    final args = await Future.wait(expr.arguments.map(evaluate));

    // Built-in functions
    if (BuiltinLibrary.isFunction(expr.name)) {
      final fn = BuiltinLibrary.getFunction(expr.name)!;
      try {
        return Function.apply(fn, args);
      } catch (e) {
        throw EvaluationException(
          'Error calling built-in function ${expr.name}: $e',
          expr,
        );
      }
    }

    // User-defined subroutines
    final subroutine = context.symbols.lookupSubroutine(expr.name);
    if (subroutine != null) {
      if (args.length != (subroutine.arguments?.length ?? 0)) {
        throw EvaluationException(
          'Function ${expr.name} expects ${subroutine.arguments?.length ?? 0} arguments, but got ${args.length}',
          expr,
        );
      }

      context.pushScope();
      try {
        // Bind arguments
        if (subroutine.arguments != null) {
          for (var i = 0; i < args.length; i++) {
            final argDef = subroutine.arguments![i], val = args[i];
            if (val is QRegister) {
              context.pushQubitRegister(argDef.name, val);
            } else {
              context.declareClassicalVariable(argDef.name, argDef.type, val);
            }
          }
        }

        // Execute body
        await statementExecutor(subroutine.body);
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
      expr,
    );
  }

  Future<dynamic> _evaluateIndex(IndexExpression expr) async {
    // If it's an identifier, check if it's a qubit register FIRST
    if (expr.expression case IdentifierExpression identifier) {
      final name = identifier.name;
      final register = context.symbols.lookupQubit(name);

      if (register != null) {
        final result = await evaluate(
          expr.indices[0],
        ); // Qubit registers expect single index
        if (result is int) return result;
        if (result is RangeResult) return result.values.toList();
        if (result is List) return result.cast<int>();
        throw EvaluationException(
          'Invalid qubit index: $result',
          expr.indices[0],
        );
      }
    }

    final array = await evaluate(expr.expression);
    final indices = await Future.wait(expr.indices.map(evaluate));

    // Array indexing for classical values
    if (array is List) {
      if (indices.length == 1) {
        final index = indices[0];
        if (index is int) {
          return array[index];
        } else if (index is RangeResult) {
          return array.sublist(index.start, index.stop);
        } else if (index is List) {
          return index.map((i) => array[i as int]).toList();
        }
      }
    }

    throw EvaluationException('Cannot index $array with $indices', expr);
  }

  Future<RangeResult> _evaluateRange(RangeExpression expr) async {
    final start = expr.start != null ? await evaluate(expr.start) as int : 0;
    int step = 1;
    int stop = 0;

    if (expr.stop != null) {
      // start:step:stop
      step = expr.step != null ? await evaluate(expr.step) as int : 1;
      stop = await evaluate(expr.stop) as int;
    } else {
      // start:stop (step OMITS)
      // In this case, expr.step actually contains the STOP value
      stop = expr.step != null ? await evaluate(expr.step) as int : 0;
      step = 1;
    }

    return RangeResult(start, stop, step);
  }

  Future<dynamic> _evaluateCast(CastExpression expr) async {
    final value = await evaluate(expr.expression);
    final type = expr.type;

    if (type is ScalarTypeNode) {
      return switch (type.name) {
        'int' || 'uint' => toInt(value),
        'float' => toFloat(value),
        'bool' => toBool(value),
        'bit' => toInt(value) & 1,
        'complex' => toComplex(value),
        _ => value,
      };
    }

    return value;
  }
}
