part of 'ast_nodes.dart';

abstract class Statement extends OpenQASMNode {
  final List<Annotation> annotations;

  const Statement._({this.annotations = const []}) : super._();
}

class Annotation extends OpenQASMNode {
  final String name;
  final String? content;

  Annotation(this.name, this.content) : super._();
}

class PragmaStatement extends Statement {
  final String content;

  PragmaStatement(this.content) : super._();
}

class CalibrationGrammarStatement extends Statement {
  final String grammar;

  CalibrationGrammarStatement(
    this.grammar, {
    List<Annotation> annotations = const [],
  }) : super._(annotations: annotations);
}

class CalibrationStatement extends Statement {
  final String? body;

  CalibrationStatement(this.body, {List<Annotation> annotations = const []})
    : super._(annotations: annotations);
}

class DefCalStatement extends Statement {
  final String name;
  final List<Expression> operands;
  final List<Expression>? arguments;
  final TypeNode? returnType;
  final String? body;

  DefCalStatement(
    this.name,
    this.operands,
    this.arguments,
    this.returnType,
    this.body, {
    List<Annotation> annotations = const [],
  }) : super._(annotations: annotations);
}

class DelayStatement extends Statement {
  final Expression duration;
  final List<Expression> qubits;

  DelayStatement(
    this.duration,
    this.qubits, {
    List<Annotation> annotations = const [],
  }) : super._(annotations: annotations);
}

class BoxStatement extends Statement {
  final Expression? duration;
  final List<Statement> body;

  BoxStatement(
    this.body, {
    this.duration,
    List<Annotation> annotations = const [],
  }) : super._(annotations: annotations);
}

class EndStatement extends Statement {
  EndStatement({List<Annotation> annotations = const []})
    : super._(annotations: annotations);
}

class OldStyleDeclarationStatement extends Statement {
  final String type; // creg or qreg
  final String name;
  final Expression? size;

  OldStyleDeclarationStatement(
    this.type,
    this.name,
    this.size, {
    List<Annotation> annotations = const [],
  }) : super._(annotations: annotations);
}

class SubroutineDefinition extends Statement {
  final String name;
  final List<Argument>? arguments;
  final TypeNode? returnType;
  final List<Statement> body;

  SubroutineDefinition(
    this.name,
    this.arguments,
    this.returnType,
    this.body, {
    List<Annotation> annotations = const [],
  }) : super._(annotations: annotations);
}

class IncludeStatement extends Statement {
  final String filename;

  IncludeStatement(this.filename, {List<Annotation> annotations = const []})
    : super._(annotations: annotations);
}

class QubitDeclaration extends Statement {
  final String name;
  final QubitTypeNode type;

  QubitDeclaration(
    this.name,
    this.type, {
    List<Annotation> annotations = const [],
  }) : super._(annotations: annotations);
}

class ClassicalDeclaration extends Statement {
  final TypeNode type;
  final String name;
  final Expression? initializer;

  ClassicalDeclaration(
    this.type,
    this.name, {
    this.initializer,
    List<Annotation> annotations = const [],
  }) : super._(annotations: annotations);
}

class GateStatement extends Statement {
  final String name;
  final List<String>? parameters;
  final List<String> qubits;
  final List<Statement> body;

  GateStatement(
    this.name,
    this.parameters,
    this.qubits,
    this.body, {
    List<Annotation> annotations = const [],
  }) : super._(annotations: annotations);
}

class GateCallStatement extends Statement {
  final String name;
  final List<Expression>? arguments;
  final List<Expression> qubits;
  final List<GateModifier>? modifiers;

  GateCallStatement(
    this.name,
    this.arguments,
    this.qubits, {
    this.modifiers,
    List<Annotation> annotations = const [],
  }) : super._(annotations: annotations);
}

class AssignmentStatement extends Statement {
  final Expression target;
  final Expression value;
  final String operator;

  AssignmentStatement(
    this.target,
    this.value, {
    required this.operator,
    List<Annotation> annotations = const [],
  }) : super._(annotations: annotations);
}

class ExpressionStatement extends Statement {
  final Expression expression;

  ExpressionStatement(
    this.expression, {
    List<Annotation> annotations = const [],
  }) : super._(annotations: annotations);
}

class MeasurementStatement extends Statement {
  final Expression measureExpression;
  final String? targetIdentifier;

  MeasurementStatement(
    this.measureExpression,
    this.targetIdentifier, {
    List<Annotation> annotations = const [],
  }) : super._(annotations: annotations);
}

class ResetStatement extends Statement {
  final Expression qubit;

  ResetStatement(this.qubit, {List<Annotation> annotations = const []})
    : super._(annotations: annotations);
}

class BarrierStatement extends Statement {
  final List<Expression>? qubits;

  BarrierStatement(this.qubits, {List<Annotation> annotations = const []})
    : super._(annotations: annotations);
}

class AliasStatement extends Statement {
  final String name;
  final Expression value;

  AliasStatement(
    this.name,
    this.value, {
    List<Annotation> annotations = const [],
  }) : super._(annotations: annotations);
}

class ExternStatement extends Statement {
  final String name;
  final List<TypeNode> argumentTypes;
  final TypeNode? returnType;

  ExternStatement(
    this.name,
    this.argumentTypes, {
    this.returnType,
    List<Annotation> annotations = const [],
  }) : super._(annotations: annotations);
}

class ConstantDeclaration extends Statement {
  final TypeNode type;
  final String name;
  final Expression value;

  ConstantDeclaration(
    this.type,
    this.name,
    this.value, {
    List<Annotation> annotations = const [],
  }) : super._(annotations: annotations);
}

class IOStatement extends Statement {
  final String direction; // input or output
  final TypeNode type;
  final String name;

  IOStatement(
    this.direction,
    this.type,
    this.name, {
    List<Annotation> annotations = const [],
  }) : super._(annotations: annotations);
}

abstract class FlowStatement extends Statement {
  FlowStatement._({List<Annotation> annotations = const []})
    : super._(annotations: annotations);

  List<Statement> get body;
}

class IfStatement extends FlowStatement {
  final Expression condition;
  final List<Statement> ifBody;
  final List<Statement>? elseBody;

  @override
  List<Statement> get body => ifBody;

  IfStatement(
    this.condition,
    this.ifBody, {
    this.elseBody,
    List<Annotation> annotations = const [],
  }) : super._(annotations: annotations);
}

class ForStatement extends FlowStatement {
  final String loopVariable;
  final ScalarTypeNode? variableType;
  final Expression range; // Expression or RangeExpression or SetExpression

  @override
  final List<Statement> body;

  ForStatement(
    this.loopVariable,
    this.variableType,
    this.range,
    this.body, {
    List<Annotation> annotations = const [],
  }) : super._(annotations: annotations);
}

class WhileStatement extends FlowStatement {
  final Expression condition;

  @override
  final List<Statement> body;

  WhileStatement(
    this.condition,
    this.body, {
    List<Annotation> annotations = const [],
  }) : super._(annotations: annotations);
}

class BreakStatement extends Statement {
  const BreakStatement({List<Annotation> annotations = const []})
    : super._(annotations: annotations);
}

class ContinueStatement extends Statement {
  const ContinueStatement({List<Annotation> annotations = const []})
    : super._(annotations: annotations);
}

class ReturnStatement extends Statement {
  final Expression? expression;

  ReturnStatement(this.expression, {List<Annotation> annotations = const []})
    : super._(annotations: annotations);
}
