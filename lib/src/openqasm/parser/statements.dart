part of 'ast_nodes.dart';

abstract class Statement extends OpenQASMNode {
  const Statement._() : super._();
}

class SubroutineDefinition extends Statement {
  final String name;
  final List<Argument>? arguments;
  final TypeNode? returnType;
  final List<Statement> body;

  SubroutineDefinition(this.name, this.arguments, this.returnType, this.body)
    : super._();
}

class IncludeStatement extends Statement {
  final String filename;

  IncludeStatement(this.filename) : super._();
}

class QubitDeclaration extends Statement {
  final String name;
  final QubitTypeNode type;

  QubitDeclaration(this.name, this.type) : super._();
}

class ClassicalDeclaration extends Statement {
  final TypeNode type;
  final String name;
  final Expression? initializer;

  ClassicalDeclaration(this.type, this.name, {this.initializer}) : super._();
}

class GateStatement extends Statement {
  final String name;
  final List<String>? parameters;
  final List<String> qubits;
  final List<Statement> body;

  GateStatement(this.name, this.parameters, this.qubits, this.body) : super._();
}

class GateCallStatement extends Statement {
  final String name;
  final List<Expression>? arguments;
  final List<Expression> qubits;
  final List<GateModifier>? modifiers;

  GateCallStatement(this.name, this.arguments, this.qubits, {this.modifiers})
    : super._();
}

class AssignmentStatement extends Statement {
  final Expression target;
  final Expression value;
  final String operator;

  AssignmentStatement(this.target, this.value, {required this.operator})
    : super._();
}

class ExpressionStatement extends Statement {
  final Expression expression;

  ExpressionStatement(this.expression) : super._();
}

class MeasurementStatement extends Statement {
  final Expression measureExpression;
  final String? targetIdentifier;

  MeasurementStatement(this.measureExpression, this.targetIdentifier)
    : super._();
}

class ResetStatement extends Statement {
  final Expression qubit;

  ResetStatement(this.qubit) : super._();
}

class BarrierStatement extends Statement {
  final List<Expression>? qubits;

  BarrierStatement(this.qubits) : super._();
}

class AliasStatement extends Statement {
  final String name;
  final Expression value;

  AliasStatement(this.name, this.value) : super._();
}

class ExternStatement extends Statement {
  final String name;
  final List<TypeNode> argumentTypes;
  final TypeNode? returnType;

  ExternStatement(this.name, this.argumentTypes, {this.returnType}) : super._();
}

class ConstantDeclaration extends Statement {
  final TypeNode type;
  final String name;
  final Expression value;

  ConstantDeclaration(this.type, this.name, this.value) : super._();
}

class IOStatement extends Statement {
  final String direction; // input or output
  final TypeNode type;
  final String name;

  IOStatement(this.direction, this.type, this.name) : super._();
}

abstract class FlowStatement extends Statement {
  FlowStatement._() : super._();

  List<Statement> get body;
}

class IfStatement extends FlowStatement {
  final Expression condition;
  final List<Statement> ifBody;
  final List<Statement>? elseBody;

  @override
  List<Statement> get body => ifBody;

  IfStatement(this.condition, this.ifBody, {this.elseBody}) : super._();
}

class ForStatement extends FlowStatement {
  final String loopVariable;
  final ScalarTypeNode variableType;
  final Expression range; // Expression or RangeExpression or SetExpression

  @override
  final List<Statement> body;

  ForStatement(this.loopVariable, this.variableType, this.range, this.body)
    : super._();
}

class WhileStatement extends FlowStatement {
  final Expression condition;

  @override
  final List<Statement> body;

  WhileStatement(this.condition, this.body) : super._();
}

class BreakStatement extends Statement {
  const BreakStatement() : super._();
}

class ContinueStatement extends Statement {
  const ContinueStatement() : super._();
}

class ReturnStatement extends Statement {
  final Expression? expression;

  ReturnStatement(this.expression) : super._();
}
