part of 'ast_node.dart';

abstract class AstExpression extends AstNode {}

abstract class AstExpressionList extends AstNodeList<AstExpression>
    implements AstExpression {}

class AstIdentifier extends AstExpression {
  AstIdentifier(Token name) {
    tokens.add(name);
  }

  Token get name => tokens.first;
}

abstract class AstExpressionLiteral extends AstIdentifier {
  AstExpressionLiteral(Token literal) : super(literal);

  Token get literal => name;
}

class AstExpressionNumber extends AstExpressionLiteral {
  AstExpressionNumber(Token number) : super(number);

  Token get value => super.literal;
}

class AstExpressionInteger extends AstExpressionNumber {
  AstExpressionInteger(Token number) : super(number);
}

class AstExpressionReal extends AstExpressionNumber {
  AstExpressionReal(Token number) : super(number);
}

class AstExpressionImaginary extends AstExpressionNumber {
  AstExpressionImaginary(Token number) : super(number);
}

class AstExpressionDuration extends AstExpressionNumber {
  AstExpressionDuration(Token number) : super(number);
}

class AstExpressionString extends AstExpressionLiteral {
  AstExpressionString(Token string) : super(string);
}

class AstExpressionConstant extends AstExpressionLiteral {
  AstExpressionConstant(Token constant) : super(constant);
}

class AstExpressionPhysicalQubit extends AstExpression {
  AstExpressionPhysicalQubit();

  Token get id => tokens.last;

  @override
  Iterable<Ast> getChildren() => tokens;
}

class AstExpressionArrayAccess extends AstExpression {
  AstExpressionArrayAccess(this.array, this.indexSet);

  final AstExpression array;
  final AstExpressionIndexSet indexSet;

  @override
  Iterable<Ast> getChildren() sync* {
    yield array;
    yield indexSet;
  }
}

class AstExpressionFunctionCall extends AstExpression {
  AstExpressionFunctionCall(this.function, this.arguments);

  final AstIdentifier function;
  final AstExpressionArguments arguments;

  @override
  Iterable<Ast> getChildren() sync* {
    yield function;
    yield arguments;
  }
}

class AstModifier extends AstNode {}

class AstPowModifier extends AstModifier {
  AstPowModifier(this.expression);

  final AstExpression expression;

  @override
  Iterable<Ast> getChildren() sync* {
    yield* tokens.take(2);
    yield expression;
    yield* tokens.skip(2).take(2);
  }
}

class AstCtrlModifier extends AstModifier {
  AstCtrlModifier(this.expression);

  final AstExpression? expression;

  @override
  Iterable<Ast> getChildren() sync* {
    yield tokens.first;
    if (expression != null) {
      yield tokens[1];
      yield expression!;
      yield tokens[2];
    }
    yield tokens.last;
  }
}

class AstExpressionGateCall extends AstExpression {
  AstExpressionGateCall(
      this.gate, this.modifiers, this.arguments, this.designator);

  final List<AstModifier>? modifiers;
  final AstIdentifier gate;
  final AstExpressionArguments? arguments;
  final AstDesignator? designator;
  final qubits = <AstExpression>[];

  @override
  Iterable<Ast> getChildren() sync* {
    if (modifiers != null) {
      for (var modifier in modifiers!) {
        yield modifier;
      }
    }
    yield gate;
    if (arguments != null) {
      yield arguments!;
    }
    if (designator != null) {
      yield designator!;
    }
    var idx = 0;
    for (var i = 0; i < qubits.length; i++) {
      if (i > 0) {
        yield tokens[idx++];
      }
      yield qubits[i];
    }
  }
}

class AstExpressionMeasureCall extends AstExpressionGateCall {
  AstExpressionMeasureCall(AstIdentifier gate, AstExpression qubit)
      : super(gate, null, null, null) {
    qubits.add(qubit);
  }

  AstExpression? _assignee;
  AstExpression? get assignee => _assignee;
  AstExpression get qubit => qubits.single;

  @override
  Iterable<Ast> getChildren() sync* {
    yield* super.getChildren();
    if (_assignee != null) {
      yield tokens.last;
      yield _assignee!;
    }
  }
}

class AstExpressionArguments extends AstExpressionList {
  AstExpressionArguments();

  @override
  Iterable<Ast> getChildren() sync* {
    var idx = 0;
    var it = iterator;
    yield tokens[idx++];
    for (var i = 0; i < length; i++) {
      if (i > 0) {
        yield tokens[idx++];
      }
      it.moveNext();
      yield it.current;
    }
    yield tokens[idx++];
  }
}

class AstExpressionArray extends AstExpressionList {
  AstExpressionArray();

  @override
  Iterable<Ast> getChildren() sync* {
    var idx = 0;
    var it = iterator;
    var max = length - 1;
    yield tokens[idx++];
    for (var i = 0; i <= max; i++) {
      it.moveNext();
      yield it.current;
      if (i < max) {
        yield tokens[idx++];
      }
    }
    yield tokens[idx++];
  }
}

class AstExpressionSlice extends AstExpression {
  AstExpressionSlice(this.start, this.incr, this.end);

  final AstExpression start;
  final AstExpression? incr;
  final AstExpression end;

  @override
  Iterable<Ast> getChildren() sync* {
    yield start;
    yield tokens.first;
    if (incr != null) {
      yield incr!;
      yield tokens.last;
    }
    yield end;
  }
}

abstract class AstExpressionIndexSet extends AstExpression {}

class AstExpressionRange extends AstExpressionIndexSet {
  AstExpressionRange(this.slice);

  @internal
  final AstExpressionSlice slice;

  @override
  Iterable<Ast> getChildren() sync* {
    yield tokens.first;
    yield slice;
    yield tokens.last;
  }
}

class AstExpressionIndex extends AstExpressionList
    implements AstExpressionIndexSet {
  AstExpressionIndex();

  @override
  Iterable<Ast> getChildren() sync* {
    var idx = 0;
    var it = iterator;
    var max = length - 1;
    yield tokens[idx++];
    for (var i = 0; i <= max; i++) {
      it.moveNext();
      yield it.current;
      if (i < max) {
        yield tokens[idx++];
      }
    }
    yield tokens[idx++];
  }
}

class AstExpressionCast extends AstExpression {
  AstExpressionCast(this.type, this.expression);

  final AstType type;
  final AstExpression expression;

  @override
  Iterable<Ast> getChildren() sync* {
    yield type;
    yield tokens.first;
    yield expression;
    yield tokens.last;
  }
}

class AstExpressionParenthesis extends AstExpression {
  AstExpressionParenthesis(this.expression);

  final AstExpression expression;

  @override
  Iterable<Ast> getChildren() sync* {
    yield tokens.first;
    yield expression;
    yield tokens.last;
  }
}

class AstExpressionAssignment extends AstExpression {
  AstExpressionAssignment(this.assignee, Token operator, this.expression) {
    tokens.add(operator);
  }

  Token get op => tokens.first;

  final AstExpression assignee;
  final AstExpression expression;

  @override
  Iterable<Ast> getChildren() sync* {
    yield assignee;
    yield op;
    yield expression;
  }
}

class AstExpressionUnary extends AstExpression {
  AstExpressionUnary(Token operator, this.expression) {
    tokens.add(operator);
  }

  final AstExpression expression;

  @override
  Iterable<Ast> getChildren() sync* {
    yield tokens.first;
    yield expression;
  }
}

class AstExpressionBinary extends AstExpression {
  AstExpressionBinary(this.leftOperand, Token operator, this.rightOperand) {
    tokens.add(operator);
  }

  final AstExpression leftOperand;
  final AstExpression rightOperand;

  @override
  Iterable<Ast> getChildren() sync* {
    yield leftOperand;
    yield tokens.first;
    yield rightOperand;
  }
}

class AstExpressionSets extends AstExpressionList {
  @override
  Iterable<Ast> getChildren() sync* {
    yield _children[0];
    for (var i = 1; i < _children.length; i++) {
      yield tokens[i - 1];
      yield _children[i];
    }
  }
}

@internal
extension AstExpressionMeasureCallImpl on AstExpressionMeasureCall {
  void setAssignee(AstExpression assignee) => _assignee = assignee;
}

@internal
extension AstExpressionNumberImpl on AstExpressionNumber {
  void setNumber(Token number) => tokens[0] = number;
}
