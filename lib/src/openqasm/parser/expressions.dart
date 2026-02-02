part of 'ast_nodes.dart';

abstract class Expression extends OpenQASMNode {
  const Expression._() : super._();
}

class RangeExpression extends Expression {
  final Expression? start;
  final Expression? step;
  final Expression? stop;

  RangeExpression({this.start, this.step, this.stop}) : super._();
}

class SetExpression extends Expression {
  final List<Expression> expressions;

  SetExpression(this.expressions) : super._();
}

class IdentifierExpression extends Expression {
  final String name;

  IdentifierExpression(this.name) : super._();
}

class HardwareQubitExpression extends Expression {
  final int index;

  HardwareQubitExpression(this.index) : super._();
}

class LiteralExpression extends Expression {
  final dynamic value;
  final String type;

  LiteralExpression(this.value, this.type) : super._();
}

class BinaryExpression extends Expression {
  final Expression left;
  final String operator;
  final Expression right;

  BinaryExpression(this.left, this.operator, this.right) : super._();
}

class UnaryExpression extends Expression {
  final String operator;
  final Expression expression;

  UnaryExpression(this.operator, this.expression) : super._();
}

class CallExpression extends Expression {
  final String name;
  final List<Expression> arguments;

  CallExpression(this.name, this.arguments) : super._();
}

class IndexExpression extends Expression {
  final Expression expression;
  final List<Expression> indices;

  IndexExpression(this.expression, this.indices) : super._();
}

class CastExpression extends Expression {
  final TypeNode type;
  final Expression expression;

  CastExpression(this.type, this.expression) : super._();
}

class DurationOfExpression extends Expression {
  final List<Statement> statements;

  DurationOfExpression(this.statements) : super._();
}

class MeasureExpression extends Expression {
  final Expression qubit;

  MeasureExpression(this.qubit) : super._();
}
