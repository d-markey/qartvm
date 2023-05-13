import 'package:antlr4/antlr4.dart';

import '../../../exceptions.dart';
import '../../interpreter/status_codes.dart';
import '../../interpreter/value.dart';
import '../parser/OpenQASM3Parser.dart';
import '../parser/OpenQASM3ParserBaseVisitor.dart';
import 'qasm_context.dart';
import 'qasm_operators.dart';

class QasmInterpreter extends OpenQASM3ParserBaseVisitor<StatusCode> {
  QasmInterpreter(Map<String, dynamic> io) : _context = QasmContext(io);

  final QasmContext _context;

  void _trace(RuleNode node) {
    print('Visiting [${node.runtimeType}] ${node.text}');
  }

  @override
  StatusCode? aggregateResult(StatusCode? aggregate, StatusCode? nextResult) =>
      nextResult ?? aggregate;

  @override
  StatusCode? visitChildren(RuleNode node) {
    _trace(node);
    return super.visitChildren(node);
  }

  // program & scope

  @override
  StatusCode visitProgram(ProgramContext ctx) {
    _trace(ctx);
    _context.enterScope();
    try {
      for (var stmt in ctx.statements()) {
        final status = visitStatement(stmt);
        if (status is Return) {
          return status;
        }
        if (status is Break || status is Continue) {
          print('Ignoring unexpected status: $status');
        }
      }
    } finally {
      _context.leaveScope();
    }
    return Value.$void;
  }

  @override
  StatusCode visitScope(ScopeContext ctx) {
    _trace(ctx);
    _context.enterScope();
    try {
      for (var stmt in ctx.statements()) {
        final status = visitStatement(stmt);
        if (status is Return || status is Break || status is Continue) {
          return status!;
        }
      }
    } finally {
      _context.leaveScope();
    }
    return Done();
  }

  @override
  StatusCode visitStatement(StatementContext ctx) =>
      super.visitStatement(ctx) as StatusCode;

  @override
  StatusCode visitExpressionStatement(ExpressionStatementContext ctx) =>
      super.visitExpressionStatement(ctx) as StatusCode;

  // declaration

  @override
  StatusCode visitIoDeclarationStatement(IoDeclarationStatementContext ctx) {
    _trace(ctx);
    _context.register(
      ctx.Identifier()!.text!,
      ctx.scalarType() ?? ctx.arrayType()!,
      input: ctx.INPUT() != null,
      output: ctx.OUTPUT() != null,
    );
    return Done();
  }

  @override
  StatusCode visitClassicalDeclarationStatement(
      ClassicalDeclarationStatementContext ctx) {
    _trace(ctx);
    final variable = _context.register(
      ctx.Identifier()!.text!,
      ctx.scalarType() ?? ctx.arrayType()!,
    );
    final value =
        visitDeclarationExpression(ctx.declarationExpression()!) as Value?;
    if (value != null) {
      variable.set(value);
    }
    return Done();
  }

  // statement

  @override
  Break visitBreakStatement(BreakStatementContext ctx) {
    _trace(ctx);
    return Break();
  }

  @override
  Continue visitContinueStatement(ContinueStatementContext ctx) {
    _trace(ctx);
    return Continue();
  }

  @override
  StatusCode visitForStatement(ForStatementContext ctx) {
    _trace(ctx);
    _context.enterScope();
    try {
      final name = ctx.Identifier()!.text!;
      final loopVariable = _context.register(name, ctx.scalarType()!);
      IterableValue items;
      final set = ctx.setExpression();
      if (set != null) {
        items = visitSetExpression(set);
      } else {
        final range = ctx.rangeExpression();
        if (range != null) {
          items = visitRangeExpression(range);
        } else {
          items = _getExpressionValue(ctx.expression()!) as IterableValue;
        }
      }
      final body = ctx.body!;
      for (var v in items.value) {
        loopVariable.set(v);
        final res = visitStatementOrScope(body);
        if (res is Return) {
          return res;
        }
        if (res is Break) {
          break;
        }
      }
      return Done();
    } finally {
      _context.leaveScope();
    }
  }

  @override
  StatusCode visitWhileStatement(WhileStatementContext ctx) {
    _trace(ctx);
    while (true) {
      final val = _getExpressionValue(ctx.expression()!);
      if (!val.toBool().value) {
        break;
      }
      final res = visitStatementOrScope(ctx.statementOrScope()!);
      if (res is Return) {
        return res;
      }
      if (res is Break) {
        break;
      }
    }
    return Done();
  }

  @override
  StatusCode visitIfStatement(IfStatementContext ctx) {
    _trace(ctx);
    final condition = _getExpressionValue(ctx.expression()!);
    final branch = condition.toBool().value
        ? ctx.statementOrScope(0)
        : ctx.statementOrScope(1);
    return (branch != null) ? visitStatementOrScope(branch)! : Done();
  }

  @override
  Return visitReturnStatement(ReturnStatementContext ctx) {
    _trace(ctx);
    Value value;
    final expr = ctx.expression();
    if (expr != null) {
      value = _getExpressionValue(expr);
    } else {
      value = visitMeasureExpression(ctx.measureExpression()!) as Value;
    }
    return Return(value);
  }

  // types

  @override
  BaseType visitScalarType(ScalarTypeContext ctx) {
    _trace(ctx);
    final baseType = (ctx.BIT() ??
            ctx.INT() ??
            ctx.UINT() ??
            ctx.FLOAT() ??
            ctx.ANGLE() ??
            ctx.BOOL() ??
            ctx.DURATION() ??
            ctx.STRETCH() ??
            ctx.COMPLEX() ??
            ctx.STRING())
        ?.text;
    Value? designator;
    final d = ctx.designator();
    if (d != null) {
      designator = visitDesignator(d) as Value;
    }
    switch (baseType) {
      case 'bit':
        return BitType(designator);
      case 'int':
        return IntType(designator);
      case 'uint':
        return UintType(designator);
      case 'float':
        return FloatType(designator);
      case 'angle':
        return AngleType(designator);
      case 'bool':
        return BoolType();
      case 'duration':
        return DurationType();
      case 'stretch':
        return StretchType();
      case 'complex':
        BaseType? type;
        final scalarType = ctx.scalarType();
        if (scalarType != null) {
          type = visitScalarType(scalarType);
        }
        return ComplexType(type);
      case 'string':
        return StringType();
      default:
        throw UnsupportedError('Unsupported scalar type $baseType');
    }
  }

  @override
  BaseType visitArrayType(ArrayTypeContext ctx) {
    _trace(ctx);
    final baseType = visitScalarType(ctx.scalarType()!);
    return ArrayType(baseType, null);
  }

  // expression

  Value _getExpressionValue(ExpressionContext ctx) {
    var result = ctx.accept(this) as Value;
    if (result is Target) {
      final variable = _context.find(result.name);
      if (variable == null) {
        throw UnsupportedError('Unknown identifier ${result.name}');
      } else if (variable.value == null) {
        throw UnsupportedError('Unset identifier ${result.name}');
      }
      result = variable.value!;
    }
    print('   returning value $result');
    return result;
  }

  @override
  Value visitAssignmentStatement(AssignmentStatementContext ctx) {
    _trace(ctx);
    final target = visitIndexedIdentifier(ctx.indexedIdentifier()!);
    final op = (ctx.EQUALS() ?? ctx.CompoundAssignmentOperator())!.text!;
    Value val;
    final expr = ctx.expression() ?? ctx.measureExpression();
    if (expr is ExpressionContext) {
      val = _getExpressionValue(expr);
    } else if (expr is MeasureExpressionContext) {
      val = visitMeasureExpression(expr) as Value;
    } else {
      throw UnsupportedError('Unsupported expression $expr');
    }
    final variable = _context.find(target.name)!;
    ValueOperations.assign(variable, op, val);
    print('   set $target to ${variable.value}');
    return variable.value!;
  }

  @override
  Target visitIndexedIdentifier(IndexedIdentifierContext ctx) {
    _trace(ctx);
    final name = ctx.Identifier()!.text!;
    final indexes = ctx.indexOperators();
    if (indexes.isEmpty) {
      return Target(name);
    } else {
      return IndexedTarget(name, indexes.map(visitIndexOperator).toList());
    }
  }

  @override
  IterableValue visitIndexOperator(IndexOperatorContext ctx) =>
      super.visitIndexOperator(ctx) as IterableValue;

  @override
  SetValue visitSetExpression(SetExpressionContext ctx) {
    _trace(ctx);
    return SetValue(ctx.expressions().map(_getExpressionValue));
  }

  @override
  RangeValue visitRangeExpression(RangeExpressionContext ctx) {
    _trace(ctx);
    final start = _getExpressionValue(ctx.startExpr!);
    var step = _getExpressionValue(ctx.stepExpr!);
    Value? stop;
    final stopExpr = ctx.stopExpr;
    if (stopExpr != null) {
      stop = _getExpressionValue(stopExpr);
    } else {
      stop = step;
      step = IntValue.$one;
    }
    return RangeValue(start, step, stop);
  }

  @override
  Value visitPowerExpression(PowerExpressionContext ctx) {
    _trace(ctx);
    final left = _getExpressionValue(ctx.expression(0)!);
    final right = _getExpressionValue(ctx.expression(1)!);
    return ValueOperations.computeBinary(left, ctx.op!.text!, right);
  }

  @override
  Value visitLogicalOrExpression(LogicalOrExpressionContext ctx) {
    _trace(ctx);
    final left = _getExpressionValue(ctx.expression(0)!);
    final right = _getExpressionValue(ctx.expression(1)!);
    return ValueOperations.computeBinary(left, ctx.op!.text!, right);
  }

  @override
  Value visitLogicalAndExpression(LogicalAndExpressionContext ctx) {
    _trace(ctx);
    final left = _getExpressionValue(ctx.expression(0)!);
    final right = _getExpressionValue(ctx.expression(1)!);
    return ValueOperations.computeBinary(left, ctx.op!.text!, right);
  }

  @override
  Value visitBitwiseOrExpression(BitwiseOrExpressionContext ctx) {
    _trace(ctx);
    final left = _getExpressionValue(ctx.expression(0)!);
    final right = _getExpressionValue(ctx.expression(1)!);
    return ValueOperations.computeBinary(left, ctx.op!.text!, right);
  }

  @override
  Value visitBitwiseAndExpression(BitwiseAndExpressionContext ctx) {
    _trace(ctx);
    final left = _getExpressionValue(ctx.expression(0)!);
    final right = _getExpressionValue(ctx.expression(1)!);
    return ValueOperations.computeBinary(left, ctx.op!.text!, right);
  }

  @override
  Value visitBitshiftExpression(BitshiftExpressionContext ctx) {
    _trace(ctx);
    final left = _getExpressionValue(ctx.expression(0)!);
    final right = _getExpressionValue(ctx.expression(1)!);
    return ValueOperations.computeBinary(left, ctx.op!.text!, right);
  }

  @override
  Value visitEqualityExpression(EqualityExpressionContext ctx) {
    _trace(ctx);
    final left = _getExpressionValue(ctx.expression(0)!);
    final right = _getExpressionValue(ctx.expression(1)!);
    return ValueOperations.computeBinary(left, ctx.op!.text!, right);
  }

  @override
  Value visitComparisonExpression(ComparisonExpressionContext ctx) {
    _trace(ctx);
    final left = _getExpressionValue(ctx.expression(0)!);
    final right = _getExpressionValue(ctx.expression(1)!);
    return ValueOperations.computeBinary(left, ctx.op!.text!, right);
  }

  @override
  Value visitAdditiveExpression(AdditiveExpressionContext ctx) {
    _trace(ctx);
    final left = _getExpressionValue(ctx.expression(0)!);
    final right = _getExpressionValue(ctx.expression(1)!);
    return ValueOperations.computeBinary(left, ctx.op!.text!, right);
  }

  @override
  Value visitUnaryExpression(UnaryExpressionContext ctx) {
    final value = _getExpressionValue(ctx.expression()!);
    return ValueOperations.computeUnary(ctx.op!.text!, value);
  }

  @override
  Value visitMultiplicativeExpression(MultiplicativeExpressionContext ctx) {
    _trace(ctx);
    final left = _getExpressionValue(ctx.expression(0)!);
    final right = _getExpressionValue(ctx.expression(1)!);
    return ValueOperations.computeBinary(left, ctx.op!.text!, right);
  }

  @override
  Value visitLiteralExpression(LiteralExpressionContext ctx) {
    _trace(ctx);
    final value = ctx.Identifier()?.asTarget() ??
        ctx.BinaryIntegerLiteral()?.asInt(2) ??
        ctx.OctalIntegerLiteral()?.asInt(8) ??
        ctx.DecimalIntegerLiteral()?.asInt(10) ??
        ctx.HexIntegerLiteral()?.asInt(16) ??
        ctx.FloatLiteral()?.asFloat() ??
        ctx.ImaginaryLiteral()?.asImaginary() ??
        ctx.BooleanLiteral()?.asBool() ??
        ctx.BitstringLiteral()?.asBit() ??
        ctx.StringLiteral()?.asString() ??
        ctx.TimingLiteral()?.asTiming() ??
        ctx.HardwareQubit()?.asQubit();
    print('   returning $value');
    return value;
  }

  @override
  ArrayValue visitArrayLiteral(ArrayLiteralContext ctx) {
    final values = <Value>[];
    final children = ctx.children!
        .where((c) => c is ExpressionContext || c is ArrayLiteralContext)
        .toList();
    for (var c in children) {
      if (c is ExpressionContext) {
        values.add(_getExpressionValue(c));
      } else if (c is ArrayLiteralContext) {
        values.add(visitArrayLiteral(c));
      } else {
        throw UnsupportedError('Unsupported array value ${c.runtimeType}');
      }
    }
    return ArrayValue.from(values);
  }

  @override
  Value visitCastExpression(CastExpressionContext ctx) {
    _trace(ctx);
    var res = _getExpressionValue(ctx.expression()!);
    BaseType type;
    final scalarType = ctx.scalarType();
    if (scalarType != null) {
      type = visitScalarType(scalarType);
    } else {
      type = visitArrayType(ctx.arrayType()!);
    }
    if (type is ScalarType) {
      res = res.cast(type);
    } else if (type is ArrayType) {
      res = res.cast(type);
    }
    return res;
  }

  @override
  Value visitCallExpression(CallExpressionContext ctx) {
    _trace(ctx);
    final func = ValueOperations.getBuiltinFunction(ctx.Identifier()!.text!);
    if (func != null) {
      final args = ctx.expressionList()?.expressions() ?? [];
      return func(args.map(_getExpressionValue));
    } else {
      throw UnsupportedError('   function $func not supported');
    }
  }
}

extension _LiteralExt on TerminalNode {
  Target asTarget() => Target(text!);

  IntValue asInt(int radix) => IntValue(int.parse(text!, radix: radix));

  FloatValue asFloat() => FloatValue(double.parse(text!));

  ComplexValue asImaginary() => ComplexValue(0, double.parse(text!));

  BoolValue asBool() => (text == 'true')
      ? BoolValue(true)
      : (text == 'false')
          ? BoolValue(false)
          : throw InvalidOperationException('Invalid boolean literal $text');

  BitValue asBit() =>
      BitValue(int.parse(text!.substring(1, text!.length - 1), radix: 2));

  StringValue asString() => StringValue(text!);

  dynamic asTiming() => null;

  dynamic asQubit() => null;
}
