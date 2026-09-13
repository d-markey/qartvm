part of 'ast_nodes.dart';

abstract class Expression extends OpenQASMNode {
  const Expression._(super.source) : super._();

  Expression optimize() => this;

  static List<Expression>? tryOptimize(List<Expression>? expressions) {
    if (expressions == null) return null;
    List<Expression>? optimized;
    final len = expressions.length;
    for (var i = 0; i < len; i++) {
      final expr = expressions[i], oexpr = expr.optimize();
      if (optimized == null && oexpr != expr) {
        optimized = (i == 0) ? [] : expressions.take(i - 1).toList();
      }
      if (optimized != null) {
        optimized.add(oexpr);
      }
    }
    return optimized;
  }
}

class RangeExpression extends Expression {
  final Expression? start;
  final Expression? step;
  final Expression? stop;

  RangeExpression(super.source, {this.start, this.step, this.stop}) : super._();

  @override
  RangeExpression optimize() {
    final ostart = start?.optimize();
    final ostep = step?.optimize();
    final ostop = stop?.optimize();
    return (ostart != start || ostep != step || ostop != stop)
        ? _traceOptimization(
            RangeExpression(source, start: ostart, step: ostep, stop: ostop),
          )
        : this;
  }
}

class SetExpression extends Expression {
  final List<Expression> expressions;

  SetExpression(super.source, this.expressions) : super._();

  @override
  SetExpression optimize() {
    final optimized = Expression.tryOptimize(expressions);
    return (optimized != null)
        ? _traceOptimization(SetExpression(source, optimized))
        : this;
  }
}

class IdentifierExpression extends Expression {
  final String name;

  IdentifierExpression(super.source, this.name) : super._();
}

class HardwareQubitExpression extends Expression {
  final QbitAddress address;

  HardwareQubitExpression(super.source, this.address) : super._();
}

enum LiteralType {
  bool,
  uint,
  int,
  float,
  complex,
  bitstring,
  string,
  timing,
  any;

  static LiteralType? combine(LiteralType left, LiteralType right) {
    switch (left) {
      case .bool:
        return .bool;
      case .uint:
        if (right == .uint) return .uint;
        continue integer_case;
      integer_case:
      case .int:
        if (right == .int || right == .uint) return .int;
        if (right == .float) return .float;
        if (right == .complex) return .complex;
        return null;
      case .float:
        if (right == .int || right == .uint) return .float;
        if (right == .float) return .float;
        if (right == .complex) return .complex;
        return null;
      case .complex:
        if (right == .int || right == .uint) return .complex;
        if (right == .float) return .complex;
        if (right == .complex) return .complex;
        return null;
      case .bitstring:
        if (right == .int || right == .uint) return .bitstring;
        if (right == .bitstring) return .bitstring;
        return null;
      case .string:
        return .string;
      case .timing:
        return .timing;
      case .any:
        return .any;
    }
  }
}

class LiteralExpression extends Expression {
  final dynamic value;
  final LiteralType type;

  LiteralExpression(super.source, this.value, this.type) : super._();
}

class BinaryExpression extends Expression {
  final Expression left;
  final String operator;
  final Expression right;

  BinaryExpression(super.source, this.left, this.operator, this.right)
    : super._();

  @override
  Expression optimize() {
    final oleft = left.optimize(), oright = right.optimize();
    if (operator == '+') {
      if (oleft case LiteralExpression value) {
        if (value.value == 0) return _traceOptimization(oright);
      }
      if (oright case LiteralExpression value) {
        if (value.value == 0) return _traceOptimization(oleft);
      }
    }
    if (operator == '-') {
      if (oleft case LiteralExpression value) {
        if (value.value == 0) {
          return _traceOptimization(UnaryExpression(source, operator, oright));
        }
      }
      if (oright case LiteralExpression value) {
        if (value.value == 0) return _traceOptimization(oleft);
      }
    }
    if (operator == '*') {
      if (oleft case LiteralExpression value) {
        if (value.value == 1) return _traceOptimization(oright);
      }
      if (oright case LiteralExpression value) {
        if (value.value == 1) return _traceOptimization(oleft);
      }
    }
    if (operator == '/') {
      if (oright case LiteralExpression value) {
        if (value.value == 1) return _traceOptimization(oleft);
      }
    }

    if (oleft is LiteralExpression && oright is LiteralExpression) {
      final resType = LiteralType.combine(oleft.type, oright.type);
      if (resType != null) {
        final l = applyCast(oleft.value, resType);
        final r = applyCast(oright.value, resType);
        final res = applyBinaryOp(l, operator, r);
        if (res != null) {
          return _traceOptimization(LiteralExpression(source, res, resType));
        }
      }
    }

    return (oleft != left || oright != right)
        ? _traceOptimization(BinaryExpression(source, oleft, operator, oright))
        : super.optimize();
  }
}

class UnaryExpression extends Expression {
  final String operator;
  final Expression expression;

  UnaryExpression(super.source, this.operator, this.expression) : super._();

  @override
  Expression optimize() {
    final expr = expression.optimize();
    if (expr case LiteralExpression value) {
      if (value.value case num v) {
        return _traceOptimization(LiteralExpression(source, -v, expr.type));
      }
    }
    return (expr != expression)
        ? _traceOptimization(UnaryExpression(source, operator, expr))
        : super.optimize();
  }
}

class CallExpression extends Expression {
  final String name;
  final List<Expression> arguments;

  CallExpression(super.source, this.name, this.arguments) : super._();

  @override
  CallExpression optimize() {
    final optimized = Expression.tryOptimize(arguments);
    return (optimized != null)
        ? _traceOptimization(CallExpression(source, name, optimized))
        : this;
  }
}

class IndexExpression extends Expression {
  final Expression expression;
  final List<Expression> indices;

  IndexExpression(super.source, this.expression, this.indices) : super._();

  @override
  IndexExpression optimize() {
    final expr = expression.optimize();
    final optimized = Expression.tryOptimize(indices);
    return (optimized != null || expr != expression)
        ? _traceOptimization(
            IndexExpression(source, expr, optimized ?? indices),
          )
        : this;
  }
}

class CastExpression extends Expression {
  final TypeNode type;
  final Expression expression;

  CastExpression(super.source, this.type, this.expression) : super._();

  @override
  CastExpression optimize() {
    final expr = expression.optimize();
    return (expr != expression)
        ? _traceOptimization(CastExpression(source, type, expr))
        : this;
  }
}

class DurationOfExpression extends Expression {
  final List<Statement> statements;

  DurationOfExpression(super.source, this.statements) : super._();

  @override
  DurationOfExpression optimize() {
    final optimized = Statement.tryOptimize(statements);
    return (optimized != null)
        ? _traceOptimization(DurationOfExpression(source, optimized))
        : this;
  }
}

class MeasureExpression extends Expression {
  final Expression qubit;

  MeasureExpression(super.source, this.qubit) : super._();

  @override
  MeasureExpression optimize() {
    final expr = qubit.optimize();
    return (expr != qubit)
        ? _traceOptimization(MeasureExpression(source, expr))
        : this;
  }
}

class ArrayLiteralExpression extends Expression {
  final List<Expression>
  elements; // Can be Expression or ArrayLiteralExpression

  ArrayLiteralExpression(super.source, this.elements) : super._();

  @override
  ArrayLiteralExpression optimize() {
    final optimized = Expression.tryOptimize(elements);
    return (optimized != null)
        ? _traceOptimization(ArrayLiteralExpression(source, optimized))
        : this;
  }
}
