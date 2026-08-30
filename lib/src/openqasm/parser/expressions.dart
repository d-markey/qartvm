part of 'ast_nodes.dart';

abstract class Expression extends OpenQASMNode {
  const Expression._(super.source) : super._();
}

class RangeExpression extends Expression {
  final Expression? start;
  final Expression? step;
  final Expression? stop;

  RangeExpression(super.source, {this.start, this.step, this.stop}) : super._();
}

class SetExpression extends Expression {
  final List<Expression> expressions;

  SetExpression(super.source, this.expressions) : super._();
}

class IdentifierExpression extends Expression {
  final String name;

  IdentifierExpression(super.source, this.name) : super._();
}

class HardwareQubitExpression extends Expression {
  final int index;

  HardwareQubitExpression(super.source, this.index) : super._();
}

class LiteralExpression extends Expression {
  final dynamic value;
  final String type;

  LiteralExpression(super.source, this.value, this.type) : super._();
}

class BinaryExpression extends Expression {
  final Expression left;
  final String operator;
  final Expression right;

  BinaryExpression(super.source, this.left, this.operator, this.right)
    : super._();
}

class UnaryExpression extends Expression {
  final String operator;
  final Expression expression;

  UnaryExpression(super.source, this.operator, this.expression) : super._();
}

class CallExpression extends Expression {
  final String name;
  final List<Expression> arguments;

  CallExpression(super.source, this.name, this.arguments) : super._();
}

class IndexExpression extends Expression {
  final Expression expression;
  final List<Expression> indices;

  IndexExpression(super.source, this.expression, this.indices) : super._();
}

class CastExpression extends Expression {
  final TypeNode type;
  final Expression expression;

  CastExpression(super.source, this.type, this.expression) : super._();
}

class DurationOfExpression extends Expression {
  final List<Statement> statements;

  DurationOfExpression(super.source, this.statements) : super._();
}

class MeasureExpression extends Expression {
  final Expression qubit;

  MeasureExpression(super.source, this.qubit) : super._();
}

class ArrayLiteralExpression extends Expression {
  final List<dynamic> elements; // Can be Expression or ArrayLiteralExpression

  ArrayLiteralExpression(super.source, this.elements) : super._();
}
