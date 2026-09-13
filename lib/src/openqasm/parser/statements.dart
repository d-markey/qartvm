part of 'ast_nodes.dart';

abstract class Statement extends OpenQASMNode {
  final List<Annotation> annotations;

  const Statement._(super.source, {this.annotations = const []}) : super._();

  Statement optimize() => this;

  static List<Statement>? tryOptimize(List<Statement>? statements) {
    if (statements == null) return null;
    List<Statement>? optimized;
    final len = statements.length;
    for (var i = 0; i < len; i++) {
      final stmt = statements[i], ostmt = stmt.optimize();
      if (optimized == null && ostmt != stmt) {
        optimized = (i == 0) ? [] : statements.take(i - 1).toList();
      }
      if (optimized != null) {
        optimized.add(ostmt);
      }
    }
    return optimized;
  }
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

  @override
  DefCalStatement optimize() {
    final ops = Expression.tryOptimize(operands);
    final args = Expression.tryOptimize(arguments);
    return (ops != null || args != null)
        ? _traceOptimization(
            DefCalStatement(
              source,
              name,
              ops ?? operands,
              args ?? arguments,
              returnType,
              body,
              annotations: annotations,
            ),
          )
        : this;
  }
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

  @override
  DelayStatement optimize() {
    final odur = duration.optimize();
    final oqubits = Expression.tryOptimize(qubits);
    return (odur != duration || oqubits != null)
        ? _traceOptimization(
            DelayStatement(
              source,
              odur,
              oqubits ?? qubits,
              annotations: annotations,
            ),
          )
        : this;
  }
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

  @override
  BoxStatement optimize() {
    final odur = duration?.optimize();
    final obody = Statement.tryOptimize(body);
    return (odur != duration || obody != null)
        ? _traceOptimization(
            BoxStatement(
              source,
              obody ?? body,
              duration: odur,
              annotations: annotations,
            ),
          )
        : this;
  }
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

  @override
  OldStyleDeclarationStatement optimize() {
    final osize = size?.optimize();
    return (osize != size)
        ? _traceOptimization(
            OldStyleDeclarationStatement(
              source,
              type,
              name,
              osize,
              annotations: annotations,
            ),
          )
        : this;
  }
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

  @override
  SubroutineDefinition optimize() {
    final obody = Statement.tryOptimize(body);
    return (obody != null)
        ? _traceOptimization(
            SubroutineDefinition(
              source,
              name,
              arguments,
              returnType,
              obody,
              annotations: annotations,
            ),
          )
        : this;
  }
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

  @override
  ClassicalDeclaration optimize() {
    final init = initializer?.optimize();
    return (init != initializer)
        ? _traceOptimization(
            ClassicalDeclaration(
              source,
              type,
              name,
              initializer: init,
              annotations: annotations,
            ),
          )
        : this;
  }
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

  @override
  GateStatement optimize() {
    final obody = Statement.tryOptimize(body);
    return (obody != null)
        ? _traceOptimization(
            GateStatement(
              source,
              name,
              parameters,
              qubits,
              obody,
              annotations: annotations,
            ),
          )
        : this;
  }
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

  @override
  GateCallStatement optimize() {
    final omods = GateModifier.tryOptimize(modifiers);
    final oargs = Expression.tryOptimize(arguments);
    final oqubits = Expression.tryOptimize(qubits);
    return (omods != null || oargs != null || oqubits != null)
        ? _traceOptimization(
            GateCallStatement(
              source,
              name,
              oargs ?? arguments,
              oqubits ?? qubits,
              modifiers: omods ?? modifiers,
              annotations: annotations,
            ),
          )
        : this;
  }
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

  @override
  AssignmentStatement optimize() {
    final otarget = target.optimize();
    final ovalue = value.optimize();
    return (otarget != target || ovalue != value)
        ? _traceOptimization(
            AssignmentStatement(
              source,
              otarget,
              ovalue,
              operator: operator,
              annotations: annotations,
            ),
          )
        : this;
  }
}

class ExpressionStatement extends Statement {
  final Expression expression;

  ExpressionStatement(
    super.source,
    this.expression, {
    super.annotations = const [],
  }) : super._();

  @override
  ExpressionStatement optimize() {
    final expr = expression.optimize();
    return (expr != expression)
        ? _traceOptimization(
            ExpressionStatement(source, expr, annotations: annotations),
          )
        : this;
  }
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

  @override
  MeasurementStatement optimize() {
    final expr = measureExpression.optimize();
    return (expr != measureExpression)
        ? _traceOptimization(
            MeasurementStatement(
              source,
              expr,
              targetIdentifier,
              annotations: annotations,
            ),
          )
        : this;
  }
}

class ResetStatement extends Statement {
  final Expression qbit;

  ResetStatement(
    super.source,
    this.qbit, {
    List<Annotation> annotations = const [],
  }) : super._();

  @override
  ResetStatement optimize() {
    final expr = qbit.optimize();
    return (expr != qbit)
        ? _traceOptimization(
            ResetStatement(source, expr, annotations: annotations),
          )
        : this;
  }
}

class BarrierStatement extends Statement {
  final List<Expression>? qubits;

  BarrierStatement(
    super.source,
    this.qubits, {
    List<Annotation> annotations = const [],
  }) : super._();

  @override
  BarrierStatement optimize() {
    final oqubits = Expression.tryOptimize(qubits);
    return (oqubits != null)
        ? _traceOptimization(
            BarrierStatement(source, oqubits, annotations: annotations),
          )
        : this;
  }
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

  @override
  AliasStatement optimize() {
    final val = value.optimize();
    return (val != value)
        ? _traceOptimization(
            AliasStatement(source, name, val, annotations: annotations),
          )
        : this;
  }
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

  @override
  ConstantDeclaration optimize() {
    final val = value?.optimize();
    return (val != value)
        ? _traceOptimization(
            ConstantDeclaration(
              source,
              type,
              name,
              val,
              annotations: annotations,
            ),
          )
        : this;
  }
}

enum Direction { input, output }

class IOStatement extends Statement {
  final Direction direction; // input or output
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
  List<Statement> get body;

  FlowStatement._(super.source, {List<Annotation> annotations = const []})
    : super._();
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

  @override
  IfStatement optimize() {
    final cond = condition.optimize();
    final oif = Statement.tryOptimize(ifBody);
    final oelse = Statement.tryOptimize(elseBody);
    return (cond != condition || oif != null || oelse != null)
        ? _traceOptimization(
            IfStatement(
              source,
              cond,
              oif ?? ifBody,
              elseBody: oelse ?? elseBody,
              annotations: annotations,
            ),
          )
        : this;
  }
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

  @override
  ForStatement optimize() {
    final rng = range.optimize();
    final obody = Statement.tryOptimize(body);
    return (rng != range || obody != null)
        ? _traceOptimization(
            ForStatement(
              source,
              loopVariable,
              variableType,
              rng,
              obody ?? body,
              annotations: annotations,
            ),
          )
        : this;
  }
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

  @override
  WhileStatement optimize() {
    final cond = condition.optimize();
    final obody = Statement.tryOptimize(body);
    return (cond != condition || obody != null)
        ? _traceOptimization(
            WhileStatement(
              source,
              cond,
              obody ?? body,
              annotations: annotations,
            ),
          )
        : this;
  }
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

  @override
  ReturnStatement optimize() {
    final expr = expression?.optimize();
    return (expr != expression)
        ? _traceOptimization(
            ReturnStatement(source, expr, annotations: annotations),
          )
        : this;
  }
}
