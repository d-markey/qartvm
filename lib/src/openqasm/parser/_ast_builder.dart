import '../antlr4/parser/OpenQASM3Parser.dart';
import '../antlr4/parser/OpenQASM3ParserBaseVisitor.dart';
import 'ast_nodes.dart';

class AstBuilder extends OpenQASM3ParserBaseVisitor<OpenQASMNode> {
  @override
  OpenQASMNode? visitProgram(ProgramContext ctx) {
    final version = ctx.version() != null
        ? visitVersion(ctx.version()!) as Version
        : null;
    final statements = ctx
        .statements()
        .map((s) => visitStatement(s) as Statement)
        .toList();
    return Program(Source.fromContext(ctx), version, statements);
  }

  @override
  OpenQASMNode? visitVersion(VersionContext ctx) {
    return Version(Source.fromContext(ctx), ctx.VersionSpecifier()?.text ?? '');
  }

  @override
  OpenQASMNode? visitStatement(StatementContext ctx) {
    if (ctx.includeStatement() != null) {
      return visitIncludeStatement(ctx.includeStatement()!);
    } else if (ctx.quantumDeclarationStatement() != null) {
      return visitQuantumDeclarationStatement(
        ctx.quantumDeclarationStatement()!,
      );
    } else if (ctx.classicalDeclarationStatement() != null) {
      return visitClassicalDeclarationStatement(
        ctx.classicalDeclarationStatement()!,
      );
    } else if (ctx.gateStatement() != null) {
      return visitGateStatement(ctx.gateStatement()!);
    } else if (ctx.gateCallStatement() != null) {
      return visitGateCallStatement(ctx.gateCallStatement()!);
    } else if (ctx.measureArrowAssignmentStatement() != null) {
      return visitMeasureArrowAssignmentStatement(
        ctx.measureArrowAssignmentStatement()!,
      );
    } else if (ctx.resetStatement() != null) {
      return visitResetStatement(ctx.resetStatement()!);
    } else if (ctx.barrierStatement() != null) {
      return visitBarrierStatement(ctx.barrierStatement()!);
    } else if (ctx.assignmentStatement() != null) {
      return visitAssignmentStatement(ctx.assignmentStatement()!);
    } else if (ctx.expressionStatement() != null) {
      return visitExpressionStatement(ctx.expressionStatement()!);
    } else if (ctx.ifStatement() != null) {
      return visitIfStatement(ctx.ifStatement()!);
    } else if (ctx.forStatement() != null) {
      return visitForStatement(ctx.forStatement()!);
    } else if (ctx.whileStatement() != null) {
      return visitWhileStatement(ctx.whileStatement()!);
    } else if (ctx.breakStatement() != null) {
      return visitBreakStatement(ctx.breakStatement()!);
    } else if (ctx.continueStatement() != null) {
      return visitContinueStatement(ctx.continueStatement()!);
    } else if (ctx.returnStatement() != null) {
      return visitReturnStatement(ctx.returnStatement()!);
    } else if (ctx.defStatement() != null) {
      return visitDefStatement(ctx.defStatement()!);
    } else if (ctx.externStatement() != null) {
      return visitExternStatement(ctx.externStatement()!);
    } else if (ctx.aliasDeclarationStatement() != null) {
      return visitAliasDeclarationStatement(ctx.aliasDeclarationStatement()!);
    } else if (ctx.constDeclarationStatement() != null) {
      return visitConstDeclarationStatement(ctx.constDeclarationStatement()!);
    } else if (ctx.ioDeclarationStatement() != null) {
      return visitIoDeclarationStatement(ctx.ioDeclarationStatement()!);
    }
    return null;
  }

  @override
  OpenQASMNode? visitIncludeStatement(IncludeStatementContext ctx) {
    final filename = ctx.StringLiteral()?.text?.replaceAll('"', '') ?? '';
    return IncludeStatement(Source.fromContext(ctx), filename);
  }

  @override
  OpenQASMNode? visitQuantumDeclarationStatement(
    QuantumDeclarationStatementContext ctx,
  ) {
    final name = ctx.Identifier()?.text ?? '';
    final qubitType = visitQubitType(ctx.qubitType()!) as QubitTypeNode;
    return QubitDeclaration(Source.fromContext(ctx), name, qubitType);
  }

  @override
  OpenQASMNode? visitClassicalDeclarationStatement(
    ClassicalDeclarationStatementContext ctx,
  ) {
    final name = ctx.Identifier()?.text ?? '';
    final TypeNode type;
    if (ctx.scalarType() != null) {
      type = visitScalarType(ctx.scalarType()!) as TypeNode;
    } else {
      type = visitArrayType(ctx.arrayType()!) as TypeNode;
    }

    final initializerCtx = ctx.declarationExpression();
    final initializer = initializerCtx != null
        ? visitDeclarationExpression(initializerCtx) as Expression
        : null;
    return ClassicalDeclaration(
      Source.fromContext(ctx),
      type,
      name,
      initializer: initializer,
    );
  }

  @override
  OpenQASMNode? visitGateStatement(GateStatementContext ctx) {
    final name = ctx.Identifier()?.text ?? '';
    final params = ctx.params?.Identifiers().map((i) => i.text ?? '').toList();
    final qubits = ctx.qubits!.Identifiers().map((i) => i.text ?? '').toList();
    final body = ctx
        .scope()!
        .statements()
        .map((s) => visitStatement(s) as Statement)
        .toList();
    return GateStatement(Source.fromContext(ctx), name, params, qubits, body);
  }

  @override
  OpenQASMNode? visitGateCallStatement(GateCallStatementContext ctx) {
    final name = ctx.Identifier()?.text ?? ctx.GPHASE()?.text ?? '';
    final arguments = ctx
        .expressionList()
        ?.expressions()
        .map((e) => visit(e) as Expression)
        .toList();
    final qubits =
        ctx
            .gateOperandList()
            ?.gateOperands()
            .map((o) => visitGateOperand(o) as Expression)
            .toList() ??
        [];
    final modifiers = ctx
        .gateModifiers()
        .map((m) => visitGateModifier(m) as GateModifier)
        .toList();
    return GateCallStatement(
      Source.fromContext(ctx),
      name,
      arguments,
      qubits,
      modifiers: modifiers.isEmpty ? null : modifiers,
    );
  }

  @override
  OpenQASMNode? visitGateModifier(GateModifierContext ctx) {
    String type = '';
    if (ctx.INV() != null) {
      type = 'inv';
    }
    if (ctx.POW() != null) {
      type = 'pow';
    }
    if (ctx.CTRL() != null) {
      type = 'ctrl';
    }
    if (ctx.NEGCTRL() != null) {
      type = 'negctrl';
    }
    final expression = ctx.expression() != null
        ? visit(ctx.expression()!) as Expression
        : null;
    return GateModifier(Source.fromContext(ctx), type, expression);
  }

  @override
  OpenQASMNode? visitMeasureArrowAssignmentStatement(
    MeasureArrowAssignmentStatementContext ctx,
  ) {
    final measureExpr =
        visitMeasureExpression(ctx.measureExpression()!) as Expression;
    final target = ctx.indexedIdentifier()?.Identifier()?.text;
    return MeasurementStatement(Source.fromContext(ctx), measureExpr, target);
  }

  @override
  OpenQASMNode? visitMeasureExpression(MeasureExpressionContext ctx) {
    final qubit = visitGateOperand(ctx.gateOperand()!) as Expression;
    return MeasureExpression(Source.fromContext(ctx), qubit);
  }

  @override
  OpenQASMNode? visitResetStatement(ResetStatementContext ctx) {
    final qubit = visitGateOperand(ctx.gateOperand()!) as Expression;
    return ResetStatement(Source.fromContext(ctx), qubit);
  }

  @override
  OpenQASMNode? visitBarrierStatement(BarrierStatementContext ctx) {
    final qubits = ctx
        .gateOperandList()
        ?.gateOperands()
        .map((o) => visitGateOperand(o) as Expression)
        .toList();
    return BarrierStatement(Source.fromContext(ctx), qubits);
  }

  @override
  OpenQASMNode? visitGateOperand(GateOperandContext ctx) {
    if (ctx.indexedIdentifier() != null) {
      return visitIndexedIdentifier(ctx.indexedIdentifier()!);
    }
    if (ctx.HardwareQubit() != null) {
      final text = ctx.HardwareQubit()!.text!;
      return HardwareQubitExpression(
        Source.fromContext(ctx),
        int.parse(text.substring(1)),
      );
    }
    return IdentifierExpression(Source.fromContext(ctx), ctx.text);
  }

  @override
  OpenQASMNode? visitIndexedIdentifier(IndexedIdentifierContext ctx) {
    Expression expr = IdentifierExpression(
      Source.fromContext(ctx),
      ctx.Identifier()!.text!,
    );
    final operators = ctx.indexOperators();
    for (final op in operators) {
      final indices = _visitIndexOperator(op);
      expr = IndexExpression(Source.fromContext(ctx), expr, indices);
    }
    return expr;
  }

  List<Expression> _visitIndexOperator(IndexOperatorContext op) {
    final List<Expression> indices = [];
    if (op.setExpression() != null) {
      indices.add(visit(op.setExpression()!) as Expression);
    } else if (op.rangeExpressions().isNotEmpty) {
      indices.addAll(
        op.rangeExpressions().map((r) => visit(r) as Expression).toList(),
      );
    } else if (op.expressions().isNotEmpty) {
      indices.addAll(
        op.expressions().map((e) => visit(e) as Expression).toList(),
      );
    }
    return indices;
  }

  @override
  OpenQASMNode? visitDesignator(DesignatorContext ctx) {
    return visit(ctx.expression()!);
  }

  @override
  OpenQASMNode? visitDeclarationExpression(DeclarationExpressionContext ctx) {
    if (ctx.expression() != null) {
      return visit(ctx.expression()!);
    }
    if (ctx.measureExpression() != null) {
      return visitMeasureExpression(ctx.measureExpression()!) as Expression;
    }
    if (ctx.arrayLiteral() != null) {
      return visitArrayLiteral(ctx.arrayLiteral()!) as Expression;
    }
    return null;
  }

  // Expressions
  @override
  OpenQASMNode? visitParenthesisExpression(ParenthesisExpressionContext ctx) {
    return visit(ctx.expression()!);
  }

  @override
  OpenQASMNode? visitLiteralExpression(LiteralExpressionContext ctx) {
    if (ctx.Identifier() != null) {
      return IdentifierExpression(
        Source.fromContext(ctx),
        ctx.Identifier()!.text ?? '',
      );
    }
    if (ctx.DecimalIntegerLiteral() != null) {
      return LiteralExpression(
        Source.fromContext(ctx),
        int.parse(ctx.DecimalIntegerLiteral()!.text!.replaceAll('_', '')),
        'int',
      );
    }
    if (ctx.BinaryIntegerLiteral() != null) {
      final text = ctx.BinaryIntegerLiteral()!.text!;
      return LiteralExpression(
        Source.fromContext(ctx),
        int.parse(text.substring(2).replaceAll('_', ''), radix: 2),
        'int',
      );
    }
    if (ctx.OctalIntegerLiteral() != null) {
      final text = ctx.OctalIntegerLiteral()!.text!;
      return LiteralExpression(
        Source.fromContext(ctx),
        int.parse(text.substring(2).replaceAll('_', ''), radix: 8),
        'int',
      );
    }
    if (ctx.HexIntegerLiteral() != null) {
      final text = ctx.HexIntegerLiteral()!.text!;
      return LiteralExpression(
        Source.fromContext(ctx),
        int.parse(text.substring(2).replaceAll('_', ''), radix: 16),
        'int',
      );
    }
    if (ctx.FloatLiteral() != null) {
      return LiteralExpression(
        Source.fromContext(ctx),
        double.parse(ctx.FloatLiteral()!.text!.replaceAll('_', '')),
        'float',
      );
    }
    if (ctx.BooleanLiteral() != null) {
      return LiteralExpression(
        Source.fromContext(ctx),
        ctx.BooleanLiteral()!.text == 'true',
        'bool',
      );
    }
    if (ctx.StringLiteral() != null) {
      return LiteralExpression(
        Source.fromContext(ctx),
        ctx.StringLiteral()!.text!.replaceAll('"', '').replaceAll('\'', ''),
        'string',
      );
    }
    if (ctx.ImaginaryLiteral() != null) {
      final text = ctx.ImaginaryLiteral()!.text!.trim();
      final val = double.parse(text.substring(0, text.length - 2).trim());
      return LiteralExpression(Source.fromContext(ctx), val, 'imaginary');
    }
    if (ctx.TimingLiteral() != null) {
      return LiteralExpression(
        Source.fromContext(ctx),
        ctx.TimingLiteral()!.text,
        'timing',
      );
    }
    if (ctx.BitstringLiteral() != null) {
      final text = ctx.BitstringLiteral()!.text!;
      return LiteralExpression(
        Source.fromContext(ctx),
        text.replaceAll('"', ''),
        'bitstring',
      );
    }
    if (ctx.HardwareQubit() != null) {
      final text = ctx.HardwareQubit()!.text!;
      return HardwareQubitExpression(
        Source.fromContext(ctx),
        int.parse(text.substring(1)),
      );
    }
    return LiteralExpression(Source.fromContext(ctx), ctx.text, 'literal');
  }

  @override
  OpenQASMNode? visitAdditiveExpression(AdditiveExpressionContext ctx) {
    return BinaryExpression(
      Source.fromContext(ctx),
      visit(ctx.expression(0)!) as Expression,
      ctx.op!.text!,
      visit(ctx.expression(1)!) as Expression,
    );
  }

  @override
  OpenQASMNode? visitMultiplicativeExpression(
    MultiplicativeExpressionContext ctx,
  ) {
    return BinaryExpression(
      Source.fromContext(ctx),
      visit(ctx.expression(0)!) as Expression,
      ctx.op!.text!,
      visit(ctx.expression(1)!) as Expression,
    );
  }

  @override
  OpenQASMNode? visitUnaryExpression(UnaryExpressionContext ctx) {
    return UnaryExpression(
      Source.fromContext(ctx),
      ctx.op!.text!,
      visit(ctx.expression()!) as Expression,
    );
  }

  @override
  OpenQASMNode? visitCallExpression(CallExpressionContext ctx) {
    final name = ctx.Identifier()?.text ?? '';
    final args =
        ctx
            .expressionList()
            ?.expressions()
            .map((e) => visit(e) as Expression)
            .toList() ??
        [];
    return CallExpression(Source.fromContext(ctx), name, args);
  }

  @override
  OpenQASMNode? visitAssignmentStatement(AssignmentStatementContext ctx) {
    final target =
        visitIndexedIdentifier(ctx.indexedIdentifier()!) as Expression;
    final value = ctx.expression() != null
        ? visit(ctx.expression()!) as Expression
        : visitMeasureExpression(ctx.measureExpression()!) as Expression;

    final opText = ctx.EQUALS()?.text ?? ctx.CompoundAssignmentOperator()?.text;

    return AssignmentStatement(
      Source.fromContext(ctx),
      target,
      value,
      operator: opText ?? '=',
    );
  }

  @override
  OpenQASMNode? visitExpressionStatement(ExpressionStatementContext ctx) {
    final expr = visit(ctx.expression()!) as Expression;
    return ExpressionStatement(Source.fromContext(ctx), expr);
  }

  @override
  OpenQASMNode? visitIfStatement(IfStatementContext ctx) {
    final condition = visit(ctx.expression()!) as Expression;
    final ifBody = _visitStatementOrScope(ctx.if_body!);
    final elseBody = ctx.else_body != null
        ? _visitStatementOrScope(ctx.else_body!)
        : null;
    return IfStatement(
      Source.fromContext(ctx),
      condition,
      ifBody,
      elseBody: elseBody,
    );
  }

  @override
  OpenQASMNode? visitForStatement(ForStatementContext ctx) {
    final loopVar = ctx.Identifier()?.text ?? '';
    final scalarType = ctx.scalarType();
    final varType = (scalarType == null)
        ? null
        : visitScalarType(scalarType) as ScalarTypeNode;
    Expression range;
    if (ctx.setExpression() != null) {
      range = visitSetExpression(ctx.setExpression()!) as SetExpression;
    } else if (ctx.rangeExpression() != null) {
      range = visitRangeExpression(ctx.rangeExpression()!) as RangeExpression;
    } else {
      range = visit(ctx.expression()!) as Expression;
    }
    final body = _visitStatementOrScope(ctx.body!);
    return ForStatement(Source.fromContext(ctx), loopVar, varType, range, body);
  }

  @override
  OpenQASMNode? visitWhileStatement(WhileStatementContext ctx) {
    final condition = visit(ctx.expression()!) as Expression;
    final body = _visitStatementOrScope(ctx.body!);
    return WhileStatement(Source.fromContext(ctx), condition, body);
  }

  @override
  OpenQASMNode? visitBreakStatement(BreakStatementContext ctx) {
    return BreakStatement(Source.fromContext(ctx));
  }

  @override
  OpenQASMNode? visitContinueStatement(ContinueStatementContext ctx) {
    return ContinueStatement(Source.fromContext(ctx));
  }

  @override
  OpenQASMNode? visitReturnStatement(ReturnStatementContext ctx) {
    Expression? expr;
    if (ctx.expression() != null) {
      expr = visit(ctx.expression()!) as Expression;
    } else if (ctx.measureExpression() != null) {
      expr = visitMeasureExpression(ctx.measureExpression()!) as Expression;
    }
    return ReturnStatement(Source.fromContext(ctx), expr);
  }

  @override
  OpenQASMNode? visitRangeExpression(RangeExpressionContext ctx) {
    final start = ctx.startExpr != null
        ? visit(ctx.startExpr!) as Expression
        : null;
    final step = ctx.stepExpr != null
        ? visit(ctx.stepExpr!) as Expression
        : null;
    final stop = ctx.stopExpr != null
        ? visit(ctx.stopExpr!) as Expression
        : null;
    return RangeExpression(
      Source.fromContext(ctx),
      start: start,
      step: step,
      stop: stop,
    );
  }

  @override
  OpenQASMNode? visitSetExpression(SetExpressionContext ctx) {
    final expressions = ctx
        .expressions()
        .map((e) => visit(e) as Expression)
        .toList();
    return SetExpression(Source.fromContext(ctx), expressions);
  }

  List<Statement> _visitStatementOrScope(StatementOrScopeContext ctx) {
    if (ctx.scope() != null) {
      return ctx
              .scope()
              ?.statements()
              .map((s) => visitStatement(s) as Statement)
              .toList() ??
          [];
    } else {
      return [visitStatement(ctx.statement()!) as Statement];
    }
  }

  @override
  OpenQASMNode? visitBitwiseXorExpression(BitwiseXorExpressionContext ctx) {
    return BinaryExpression(
      Source.fromContext(ctx),
      visit(ctx.expression(0)!) as Expression,
      ctx.op!.text!,
      visit(ctx.expression(1)!) as Expression,
    );
  }

  @override
  OpenQASMNode? visitBitwiseOrExpression(BitwiseOrExpressionContext ctx) {
    return BinaryExpression(
      Source.fromContext(ctx),
      visit(ctx.expression(0)!) as Expression,
      ctx.op!.text!,
      visit(ctx.expression(1)!) as Expression,
    );
  }

  @override
  OpenQASMNode? visitBitwiseAndExpression(BitwiseAndExpressionContext ctx) {
    return BinaryExpression(
      Source.fromContext(ctx),
      visit(ctx.expression(0)!) as Expression,
      ctx.op!.text!,
      visit(ctx.expression(1)!) as Expression,
    );
  }

  @override
  OpenQASMNode? visitLogicalOrExpression(LogicalOrExpressionContext ctx) {
    return BinaryExpression(
      Source.fromContext(ctx),
      visit(ctx.expression(0)!) as Expression,
      ctx.op!.text!,
      visit(ctx.expression(1)!) as Expression,
    );
  }

  @override
  OpenQASMNode? visitLogicalAndExpression(LogicalAndExpressionContext ctx) {
    return BinaryExpression(
      Source.fromContext(ctx),
      visit(ctx.expression(0)!) as Expression,
      ctx.op!.text!,
      visit(ctx.expression(1)!) as Expression,
    );
  }

  @override
  OpenQASMNode? visitEqualityExpression(EqualityExpressionContext ctx) {
    return BinaryExpression(
      Source.fromContext(ctx),
      visit(ctx.expression(0)!) as Expression,
      ctx.op!.text!,
      visit(ctx.expression(1)!) as Expression,
    );
  }

  @override
  OpenQASMNode? visitComparisonExpression(ComparisonExpressionContext ctx) {
    return BinaryExpression(
      Source.fromContext(ctx),
      visit(ctx.expression(0)!) as Expression,
      ctx.op!.text!,
      visit(ctx.expression(1)!) as Expression,
    );
  }

  @override
  OpenQASMNode? visitBitshiftExpression(BitshiftExpressionContext ctx) {
    return BinaryExpression(
      Source.fromContext(ctx),
      visit(ctx.expression(0)!) as Expression,
      ctx.op!.text!,
      visit(ctx.expression(1)!) as Expression,
    );
  }

  @override
  OpenQASMNode? visitPowerExpression(PowerExpressionContext ctx) {
    return BinaryExpression(
      Source.fromContext(ctx),
      visit(ctx.expression(0)!) as Expression,
      ctx.op!.text!,
      visit(ctx.expression(1)!) as Expression,
    );
  }

  @override
  OpenQASMNode? visitCastExpression(CastExpressionContext ctx) {
    final type = ctx.scalarType() != null
        ? visitScalarType(ctx.scalarType()!) as TypeNode
        : visitArrayType(ctx.arrayType()!) as TypeNode;
    final expr = visit(ctx.expression()!) as Expression;
    return CastExpression(Source.fromContext(ctx), type, expr);
  }

  @override
  OpenQASMNode? visitDurationofExpression(DurationofExpressionContext ctx) {
    final body =
        ctx
            .scope()
            ?.statements()
            .map((s) => visitStatement(s) as Statement)
            .toList() ??
        [];
    return DurationOfExpression(Source.fromContext(ctx), body);
  }

  @override
  OpenQASMNode? visitIndexExpression(IndexExpressionContext ctx) {
    final expr = visit(ctx.expression()!) as Expression;
    final op = ctx.indexOperator();
    if (op == null) return IndexExpression(Source.fromContext(ctx), expr, []);

    return IndexExpression(
      Source.fromContext(ctx),
      expr,
      _visitIndexOperator(op),
    );
  }

  @override
  OpenQASMNode? visitDefStatement(DefStatementContext ctx) {
    final name = ctx.Identifier()?.text ?? '';
    final args = ctx
        .argumentDefinitionList()
        ?.argumentDefinitions()
        .map((a) => visitArgumentDefinition(a) as Argument)
        .toList();
    final returnType = ctx.returnSignature() != null
        ? visitScalarType(ctx.returnSignature()!.scalarType()!) as TypeNode
        : null;
    final body =
        ctx
            .scope()
            ?.statements()
            .map((s) => visitStatement(s) as Statement)
            .toList() ??
        [];
    return SubroutineDefinition(
      Source.fromContext(ctx),
      name,
      args,
      returnType,
      body,
    );
  }

  @override
  OpenQASMNode? visitArgumentDefinition(ArgumentDefinitionContext ctx) {
    final TypeNode type;
    if (ctx.scalarType() != null) {
      type = visitScalarType(ctx.scalarType()!) as TypeNode;
    } else if (ctx.qubitType() != null) {
      type = visitQubitType(ctx.qubitType()!) as TypeNode;
    } else if (ctx.arrayReferenceType() != null) {
      type = visitArrayReferenceType(ctx.arrayReferenceType()!) as TypeNode;
    } else if (ctx.CREG() != null) {
      type = ScalarTypeNode(
        Source.fromContext(ctx),
        'creg',
        designator: ctx.designator() != null
            ? visitDesignator(ctx.designator()!) as Expression
            : null,
      );
    } else if (ctx.QREG() != null) {
      type = QubitTypeNode(
        Source.fromContext(ctx),
        designator: ctx.designator() != null
            ? visitDesignator(ctx.designator()!) as Expression
            : null,
      );
    } else {
      type = ScalarTypeNode(Source.fromContext(ctx), 'unknown');
    }
    final name = ctx.Identifier()?.text ?? '';
    return Argument(Source.fromContext(ctx), type, name);
  }

  @override
  OpenQASMNode? visitExternStatement(ExternStatementContext ctx) {
    final name = ctx.Identifier()?.text ?? '';
    final types =
        ctx.externArgumentList()?.externArguments().map((a) {
          if (a.scalarType() != null) {
            return visitScalarType(a.scalarType()!) as TypeNode;
          } else if (a.CREG() != null) {
            return ScalarTypeNode(
              Source.fromContext(ctx),
              'creg',
              designator: a.designator() != null
                  ? visitDesignator(a.designator()!) as Expression
                  : null,
            );
          }
          return ScalarTypeNode(
            Source.fromContext(ctx),
            'readonly',
          ); // TODO: handle arrayReferenceType
        }).toList() ??
        [];
    final returnType = ctx.returnSignature() != null
        ? visitScalarType(ctx.returnSignature()!.scalarType()!) as TypeNode
        : null;
    return ExternStatement(
      Source.fromContext(ctx),
      name,
      types,
      returnType: returnType,
    );
  }

  @override
  OpenQASMNode? visitAliasDeclarationStatement(
    AliasDeclarationStatementContext ctx,
  ) {
    final name = ctx.Identifier()?.text ?? '';
    final aliasCtx = ctx.aliasExpression();
    if (aliasCtx == null) return null;

    final exprs = aliasCtx
        .expressions()
        .map((e) => visit(e) as Expression)
        .toList();
    Expression value = exprs[0];
    for (int i = 1; i < exprs.length; i++) {
      value = BinaryExpression(Source.fromContext(ctx), value, '++', exprs[i]);
    }
    return AliasStatement(Source.fromContext(ctx), name, value);
  }

  @override
  OpenQASMNode? visitConstDeclarationStatement(
    ConstDeclarationStatementContext ctx,
  ) {
    final type = visitScalarType(ctx.scalarType()!) as TypeNode;
    final name = ctx.Identifier()?.text ?? '';
    final valueCtx = ctx.declarationExpression();
    final value = (valueCtx == null)
        ? null
        : visitDeclarationExpression(valueCtx) as Expression;
    return ConstantDeclaration(Source.fromContext(ctx), type, name, value);
  }

  @override
  OpenQASMNode? visitIoDeclarationStatement(IoDeclarationStatementContext ctx) {
    final direction = ctx.INPUT() != null ? 'input' : 'output';
    final type = ctx.scalarType() != null
        ? visitScalarType(ctx.scalarType()!) as TypeNode
        : visitArrayType(ctx.arrayType()!) as TypeNode;
    final name = ctx.Identifier()?.text ?? '';
    return IOStatement(Source.fromContext(ctx), direction, type, name);
  }

  @override
  OpenQASMNode? visitScalarType(ScalarTypeContext ctx) {
    String name = '';
    if (ctx.BIT() != null) name = 'bit';
    if (ctx.INT() != null) name = 'int';
    if (ctx.UINT() != null) name = 'uint';
    if (ctx.FLOAT() != null) name = 'float';
    if (ctx.ANGLE() != null) name = 'angle';
    if (ctx.BOOL() != null) name = 'bool';
    if (ctx.DURATION() != null) name = 'duration';
    if (ctx.STRETCH() != null) name = 'stretch';
    if (ctx.STRING() != null) name = 'string';
    if (ctx.COMPLEX() != null) {
      final base = ctx.scalarType() != null
          ? visitScalarType(ctx.scalarType()!) as ScalarTypeNode
          : null;
      return ComplexTypeNode(Source.fromContext(ctx), base);
    }
    final designator = ctx.designator() != null
        ? visitDesignator(ctx.designator()!) as Expression
        : null;
    return ScalarTypeNode(
      Source.fromContext(ctx),
      name,
      designator: designator,
    );
  }

  @override
  OpenQASMNode? visitQubitType(QubitTypeContext ctx) {
    final designator = ctx.designator() != null
        ? visitDesignator(ctx.designator()!) as Expression
        : null;
    return QubitTypeNode(Source.fromContext(ctx), designator: designator);
  }

  @override
  OpenQASMNode? visitArrayType(ArrayTypeContext ctx) {
    final baseType = visitScalarType(ctx.scalarType()!) as TypeNode;
    final dims = ctx
        .expressionList()!
        .expressions()
        .map((e) => visit(e) as Expression)
        .toList();
    return ArrayTypeNode(Source.fromContext(ctx), baseType, dims);
  }

  @override
  OpenQASMNode? visitArrayLiteral(ArrayLiteralContext ctx) {
    final elements = <dynamic>[];

    // Parse each element - can be expression or nested arrayLiteral
    if (ctx.children != null) {
      for (final element in ctx.children!) {
        if (element is ExpressionContext) {
          elements.add(visit(element) as Expression);
        } else if (element is ArrayLiteralContext) {
          elements.add(visitArrayLiteral(element) as ArrayLiteralExpression);
        }
      }
    }

    return ArrayLiteralExpression(Source.fromContext(ctx), elements);
  }

  @override
  OpenQASMNode? visitArrayReferenceType(ArrayReferenceTypeContext ctx) {
    final modifier = ctx.READONLY() != null ? 'readonly' : 'mutable';
    final baseType = visitScalarType(ctx.scalarType()!) as ScalarTypeNode;

    final dimensions = <Expression>[];
    final Expression? dimEquals;

    if (ctx.DIM() != null) {
      // DIM = expression syntax
      dimEquals = ctx.expression() != null
          ? visit(ctx.expression()!) as Expression
          : null;
    } else {
      // expressionList syntax
      dimensions.addAll(
        ctx
            .expressionList()!
            .expressions()
            .map((e) => visit(e) as Expression)
            .toList(),
      );
      dimEquals = null;
    }

    return ArrayReferenceType(
      Source.fromContext(ctx),
      modifier,
      baseType,
      dimensions,
      dimEquals: dimEquals,
    );
  }
}
