part of 'ast_nodes.dart';

abstract class Statement extends OpenQASMNode {
  final List<Annotation> annotations;

  const Statement._(super.source, {this.annotations = const []}) : super._();
}

class Annotation extends OpenQASMNode {
  final String name;
  final String? content;

  Annotation(super.source, this.name, this.content) : super._();
}

class PragmaStatement extends Statement {
  final String content;

  PragmaStatement(super.source, this.content) : super._();
}

class CalibrationGrammarStatement extends Statement {
  final String grammar;

  CalibrationGrammarStatement(
    super.source,
    this.grammar, {
    super.annotations = const [],
  }) : super._();
}

class CalibrationStatement extends Statement {
  final String? body;

  CalibrationStatement(super.source, this.body, {super.annotations = const []})
    : super._();
}

class DefCalStatement extends Statement {
  final String name;
  final List<Expression> operands;
  final List<Expression>? arguments;
  final TypeNode? returnType;
  final String? body;

  DefCalStatement(
    super.source,
    this.name,
    this.operands,
    this.arguments,
    this.returnType,
    this.body, {
    super.annotations = const [],
  }) : super._();
}

class DelayStatement extends Statement {
  final Expression duration;
  final List<Expression> qubits;

  DelayStatement(
    super.source,
    this.duration,
    this.qubits, {
    super.annotations = const [],
  }) : super._();
}

class BoxStatement extends Statement {
  final Expression? duration;
  final List<Statement> body;

  BoxStatement(
    super.source,
    this.body, {
    this.duration,
    super.annotations = const [],
  }) : super._();
}

class EndStatement extends Statement {
  EndStatement(super.source, {super.annotations = const []}) : super._();
}

class OldStyleDeclarationStatement extends Statement {
  final String type; // creg or qreg
  final String name;
  final Expression? size;

  OldStyleDeclarationStatement(
    super.source,
    this.type,
    this.name,
    this.size, {
    super.annotations = const [],
  }) : super._();
}

class SubroutineDefinition extends Statement {
  final String name;
  final List<Argument>? arguments;
  final TypeNode? returnType;
  final List<Statement> body;

  SubroutineDefinition(
    super.source,
    this.name,
    this.arguments,
    this.returnType,
    this.body, {
    super.annotations = const [],
  }) : super._();
}

class IncludeStatement extends Statement {
  final String filename;

  IncludeStatement(
    super.source,
    this.filename, {
    List<Annotation> annotations = const [],
  }) : super._();
}

class QubitDeclaration extends Statement {
  final String name;
  final QubitTypeNode type;

  QubitDeclaration(
    super.source,
    this.name,
    this.type, {
    super.annotations = const [],
  }) : super._();
}

class ClassicalDeclaration extends Statement {
  final TypeNode type;
  final String name;
  final Expression? initializer;

  ClassicalDeclaration(
    super.source,
    this.type,
    this.name, {
    this.initializer,
    super.annotations = const [],
  }) : super._();
}

class GateStatement extends Statement {
  final String name;
  final List<String>? parameters;
  final List<String> qubits;
  final List<Statement> body;

  GateStatement(
    super.source,
    this.name,
    this.parameters,
    this.qubits,
    this.body, {
    super.annotations = const [],
  }) : super._();
}

class GateCallStatement extends Statement {
  final String name;
  final List<Expression>? arguments;
  final List<Expression> qubits;
  final List<GateModifier>? modifiers;

  GateCallStatement(
    super.source,
    this.name,
    this.arguments,
    this.qubits, {
    this.modifiers,
    super.annotations = const [],
  }) : super._();
}

class AssignmentStatement extends Statement {
  final Expression target;
  final Expression value;
  final String operator;

  AssignmentStatement(
    super.source,
    this.target,
    this.value, {
    required this.operator,
    super.annotations = const [],
  }) : super._();
}

class ExpressionStatement extends Statement {
  final Expression expression;

  ExpressionStatement(
    super.source,
    this.expression, {
    super.annotations = const [],
  }) : super._();
}

class MeasurementStatement extends Statement {
  final Expression measureExpression;
  final String? targetIdentifier;

  MeasurementStatement(
    super.source,
    this.measureExpression,
    this.targetIdentifier, {
    super.annotations = const [],
  }) : super._();
}

class ResetStatement extends Statement {
  final Expression qubit;

  ResetStatement(
    super.source,
    this.qubit, {
    List<Annotation> annotations = const [],
  }) : super._();
}

class BarrierStatement extends Statement {
  final List<Expression>? qubits;

  BarrierStatement(
    super.source,
    this.qubits, {
    List<Annotation> annotations = const [],
  }) : super._();
}

class AliasStatement extends Statement {
  final String name;
  final Expression value;

  AliasStatement(
    super.source,
    this.name,
    this.value, {
    super.annotations = const [],
  }) : super._();
}

class ExternStatement extends Statement {
  final String name;
  final List<TypeNode> argumentTypes;
  final TypeNode? returnType;

  ExternStatement(
    super.source,
    this.name,
    this.argumentTypes, {
    this.returnType,
    super.annotations = const [],
  }) : super._();
}

class ConstantDeclaration extends Statement {
  final TypeNode type;
  final String name;
  final Expression? value;

  ConstantDeclaration(
    super.source,
    this.type,
    this.name,
    this.value, {
    super.annotations = const [],
  }) : super._();
}

class IOStatement extends Statement {
  final String direction; // input or output
  final TypeNode type;
  final String name;

  IOStatement(
    super.source,
    this.direction,
    this.type,
    this.name, {
    super.annotations = const [],
  }) : super._();
}

abstract class FlowStatement extends Statement {
  FlowStatement._(super.source, {List<Annotation> annotations = const []})
    : super._();

  List<Statement> get body;
}

class IfStatement extends FlowStatement {
  final Expression condition;
  final List<Statement> ifBody;
  final List<Statement>? elseBody;

  @override
  List<Statement> get body => ifBody;

  IfStatement(
    super.source,
    this.condition,
    this.ifBody, {
    this.elseBody,
    super.annotations = const [],
  }) : super._();
}

class ForStatement extends FlowStatement {
  final String loopVariable;
  final ScalarTypeNode? variableType;
  final Expression range; // Expression or RangeExpression or SetExpression

  @override
  final List<Statement> body;

  ForStatement(
    super.source,
    this.loopVariable,
    this.variableType,
    this.range,
    this.body, {
    super.annotations = const [],
  }) : super._();
}

class WhileStatement extends FlowStatement {
  final Expression condition;

  @override
  final List<Statement> body;

  WhileStatement(
    super.source,
    this.condition,
    this.body, {
    super.annotations = const [],
  }) : super._();
}

class BreakStatement extends Statement {
  const BreakStatement(super.source, {List<Annotation> annotations = const []})
    : super._();
}

class ContinueStatement extends Statement {
  const ContinueStatement(
    super.source, {
    List<Annotation> annotations = const [],
  }) : super._();
}

class ReturnStatement extends Statement {
  final Expression? expression;

  ReturnStatement(
    super.source,
    this.expression, {
    List<Annotation> annotations = const [],
  }) : super._();
}
