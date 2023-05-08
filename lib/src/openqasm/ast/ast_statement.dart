part of 'ast_node.dart';

class AstStatement extends AstNode {
  final annotations = <Token>[];

  @override
  Iterable<Ast> getChildren() => tokens;
}

class AstPragma extends AstStatement {}

class AstStatementExpression extends AstStatement {
  AstStatementExpression(this.expression);

  final AstExpression expression;

  @override
  Iterable<Ast> getChildren() sync* {
    yield expression;
    yield tokens.last;
  }
}

class AstStatementInclude extends AstStatement {}

class AstStatementVersion extends AstStatement {}

class AstStatementBox extends AstStatement {
  AstStatementBox(this.designator, this.statement);

  final AstDesignator? designator;
  final AstStatement statement;

  @override
  Iterable<Ast> getChildren() sync* {
    yield tokens.first;
    if (designator != null) {
      yield designator!;
    }
    yield statement;
  }
}

class AstStatementIf extends AstStatement {
  AstStatementIf(this.condition, this.trueBody);

  final AstExpression condition;
  final AstStatement trueBody;

  AstStatement? _falseBody;
  AstStatement? get falseBody => _falseBody;

  @override
  Iterable<Ast> getChildren() sync* {
    yield* tokens.take(2);
    yield condition;
    yield tokens.skip(2).first;
    yield trueBody;
    if (_falseBody != null) {
      yield tokens.last;
      yield _falseBody!;
    }
  }
}

class AstStatementWhile extends AstStatement {
  AstStatementWhile(this.condition, this.body);

  final AstExpression condition;
  final AstStatement body;

  @override
  Iterable<Ast> getChildren() sync* {
    yield* tokens.take(2);
    yield condition;
    yield tokens.last;
    yield body;
  }
}

class AstStatementFor extends AstStatement {
  AstStatementFor(this.variable, this.set, this.body);

  final AstVariable variable;
  final AstExpression set;
  final AstStatement body;

  @override
  Iterable<Ast> getChildren() sync* {
    yield tokens.first;
    yield variable;
    yield tokens.last;
    yield set;
    yield body;
  }
}

class AstStatementContinue extends AstStatement {}

class AstStatementBreak extends AstStatement {}

class AstStatementEnd extends AstStatement {}

class AstStatementReturn extends AstStatement {
  AstStatementReturn(this.expression);

  final AstExpression? expression;

  @override
  Iterable<Ast> getChildren() sync* {
    yield tokens.first;
    if (expression != null) {
      yield expression!;
    }
    yield tokens.last;
  }
}

class AstStatementDeclaration extends AstStatement {
  AstStatementDeclaration(this.declaration);

  final AstDeclaration declaration;

  @override
  Iterable<Ast> getChildren() sync* {
    yield declaration;
    if (tokens.isNotEmpty) {
      yield tokens.first;
    }
  }
}

class AstStatementDefinition extends AstStatement {
  AstStatementDefinition(this.definition);

  final AstDefinition definition;

  @override
  Iterable<Ast> getChildren() sync* {
    yield definition;
  }
}

@internal
extension AstStatementIfImpl on AstStatementIf {
  void setFalseBody(AstStatement falseBody) => _falseBody = falseBody;
}
