// ignore_for_file: non_constant_identifier_names

part of 'openqasm_interpreter.dart';

extension _OpenQAsmInterpreterContextExprExt on _OpenQAsmInterpreterContext {
  Value _expr_assign(AstExpression expr) {
    expr = expr as AstExpressionAssignment;
    final v = evaluate(expr.expression);
    assign(expr.assignee, expr.op.text, v);
    return v;
  }

  Value _expr_parenthesis(AstExpression expr) {
    expr = expr as AstExpressionParenthesis;
    return evaluate(expr.expression);
  }

  Value _expr_number(AstExpression expr) {
    expr = expr as AstExpressionNumber;
    final val = expr.literal.text;
    if (expr is AstExpressionReal) {
      return FloatValue(double.parse(val));
    } else if (expr is AstExpressionImaginary) {
      return ComplexValue(0, double.parse(val.substring(0, val.length - 2)));
    } else if (expr is AstExpressionInteger) {
      if (val.length > 2) {
        final p = val.substring(0, 2).toLowerCase();
        if (p == '0x') {
          return IntValue(int.parse(val.substring(2), radix: 16));
        } else if (p == '0o') {
          return IntValue(int.parse(val.substring(2), radix: 8));
        } else if (p == '0b') {
          return IntValue(int.parse(val.substring(2), radix: 2));
        }
      }
      return IntValue(int.parse(val));
    }
    throw Exception('Unexpected literal ${expr.literal.text}');
  }

  Value _expr_set(AstExpression expr) {
    expr = expr as AstExpressionSets;
    return SetValue(expr.children.map(evaluate));
  }

  Value _expr_range(AstExpression expr) {
    expr = expr as AstExpressionRange;
    final start = evaluate(expr.slice.start);
    final end = evaluate(expr.slice.end);
    final step = expr.slice.incr;
    final incr = (step == null) ? IntValue(1) : evaluate(step);
    return RangeValue(start, end, incr);
  }

  static const _specialChars = {
    '\\n': '\n',
    '\\r': '\r',
    '\\t': '\t',
    '\\\\': '\\'
  };

  Value _expr_string(AstExpression expr) {
    expr = expr as AstExpressionString;
    var v = expr.literal.text;
    final quote = v.substring(0, 1);
    v = v.substring(1, v.length - 1);
    v = v.replaceAll('\\$quote', quote);
    for (var entry in _specialChars.entries) {
      v = v.replaceAll(entry.key, entry.value);
    }
    // TODO: replace escaped unicode code points "\\u0000"
    return StringValue(v);
  }

  static final _constants = <String, Value>{
    Constants.$pi: FloatValue.$pi,
    Constants.$$pi: FloatValue.$pi,
    Constants.$tau: FloatValue.$tau,
    Constants.$$tau: FloatValue.$tau,
    Constants.$euler: FloatValue.$euler,
    Constants.$$euler: FloatValue.$euler,
    Constants.$true: BoolValue.$true,
    Constants.$false: BoolValue.$false,
  };

  Value _expr_constant(AstExpression expr) {
    expr = expr as AstExpressionConstant;
    return _constants[expr.name.text]!;
  }

  Value _expr_identifier(AstExpression expr) {
    expr = expr as AstIdentifier;
    final v = find(expr.name.text);
    if (v == null) {
      throw Exception('Unknown variable "${expr.name.text}".');
    }
    final value = v.value;
    if (value == null) {
      throw Exception('Uninitialized variable "${expr.name.text}".');
    }
    return value;
  }

  static final _unaryOps = <String, Value Function(Value)>{
    '+': (v) => v,
    '-': (v) => v.neg(),
    '!': (v) => v.not(),
    '~': (v) => v.twoCompl(),
  };

  Value _expr_unary(AstExpression expr) {
    expr = expr as AstExpressionUnary;
    final v = evaluate(expr.expression);
    return _unaryOps[expr.tokens.first.text]!(v);
  }

  static final _binaryOps = <String, Value Function(Value, Value)>{
    '+': (a, b) => a.add(b),
    '-': (a, b) => a.sub(b),
    '*': (a, b) => a.mul(b),
    '/': (a, b) => a.div(b),
    '%': (a, b) => a.mod(b),
    '**': (a, b) => a.pow(b),
    '|': (a, b) => a.bitOr(b),
    '&': (a, b) => a.bitAnd(b),
    '^': (a, b) => a.bitXor(b),
    '<<': (a, b) => a.shiftl(b),
    '>>': (a, b) => a.shiftr(b),
    '||': (a, b) => a.or(b),
    '&&': (a, b) => a.and(b),
    '^^': (a, b) => a.xor(b),
    '==': (a, b) => a.eq(b),
    '!=': (a, b) => a.neq(b),
    '<': (a, b) => a.lt(b),
    '<=': (a, b) => a.lte(b),
    '>': (a, b) => a.gt(b),
    '>=': (a, b) => a.gte(b),
  };

  Value _expr_binary(AstExpression expr) {
    expr = expr as AstExpressionBinary;
    final left = evaluate(expr.leftOperand);
    final right = evaluate(expr.rightOperand);
    return _binaryOps[expr.tokens.first.text]!(left, right);
  }

  Value _expr_cast(AstExpression expr) {
    expr = expr as AstExpressionCast;
    final v = evaluate(expr.expression);
    return v.cast(expr.type);
  }

  static double _float(Value value) => value.toFloat().value;
  static ComplexValue _complex(Value value) => value.toComplex();

  static final _builtInFunctions = <String, Value Function(Iterable<Value>)>{
    'print': (values) {
      final str = values.map((v) => v is StringValue ? v.value : v.toString());
      print('[${DateTime.now().toIso8601String()}] ${str.join(' ')}');
      return Value.$void;
    },
    'real': (values) => FloatValue(_complex(values.single).re),
    'imag': (values) => FloatValue(_complex(values.single).im),
    'abs': (values) => FloatValue(_float(values.single).abs()),
    'arccos': (values) => FloatValue(math.acos(_float(values.single))),
    'arcsin': (values) => FloatValue(math.asin(_float(values.single))),
    'arctan': (values) => FloatValue(math.atan(_float(values.single))),
    'ceiling': (values) => FloatValue(_float(values.single).ceilToDouble()),
    'cos': (values) => FloatValue(math.cos(_float(values.single))),
    'exp': (values) => values.single.exp(),
    'floor': (values) => FloatValue(_float(values.single).floorToDouble()),
    'log': (values) => values.single.log(),
    'mod': (values) => values.first.mod(values.skip(1).single),
    'popcount': (values) => values.single.toBit().popCount(),
    'pow': (values) => values.first.pow(values.skip(1).single),
    'rotl': (values) => values.first.rotl(values.skip(1).single),
    'rotr': (values) => values.first.rotr(values.skip(1).single),
    'sin': (values) => FloatValue(math.sin(_float(values.single))),
    'sqrt': (values) => values.single.sqrt(),
    'tan': (values) => FloatValue(math.tan(_float(values.single))),
  };

  Value _expr_call(AstExpression expr) {
    expr = expr as AstExpressionFunctionCall;
    final funcName = expr.function.name.text;
    final f = _builtInFunctions[funcName];
    if (f != null) {
      return f(expr.arguments.map((a) => evaluate(a)));
    } else {
      throw Exception('Unknown function name "$funcName".');
    }
  }
}
