import 'dart:math' as math;
import 'package:qartvm/src/openqasm/_tokenizer.dart';
import 'package:qartvm/src/openqasm/ast/ast_node.dart';

import '../program.dart';
import 'status_codes.dart';
import 'value.dart';

part 'openqasm_interpreter.statements.dart';

class OpenQAsmInterpreter {
  StatusCode execute(Program p, Map<String, dynamic> io) {
    final context = _OpenQAsmInterpreterContext(io);
    context.enterScope();
    final status = context.run(p);
    context.leaveScope();
    for (var entry in context._rootScope.entries) {
      if (entry.value.decl is AstVariable &&
          (entry.value.decl as AstVariable).output) {
        io[entry.key] = entry.value.value?.value;
      }
    }
    return status;
  }
}

class _OpenQAsmInterpreterContext {
  _OpenQAsmInterpreterContext(this.io);

  final Map<String, dynamic> io;

  final _scopes = <Map<String, Variable>>[{}];
  late var _currentScope = _scopes.first;
  Map<String, Variable> get _rootScope => _scopes.first;

  void enterScope() {
    _currentScope = {};
    _scopes.add(_currentScope);
  }

  void leaveScope() {
    _currentScope = _scopes.removeLast();
  }

  Variable? find(String name) {
    for (var i = _scopes.length - 1; i >= 0; i--) {
      var v = _scopes[i][name];
      if (v != null) {
        return v;
      }
    }
    return null;
  }

  StatusCode run(Iterable<AstStatement> statements) {
    for (var statement in statements) {
      final executor = _executors[statement.runtimeType];
      if (executor == null) {
        throw UnsupportedError('No executor for ${statement.runtimeType}');
      }
      final res = executor(statement);
      if (res is Return || res is Break || res is Continue) {
        return res;
      }
    }
    return Done();
  }

  late final _executors = <Type, StatusCode Function(AstStatement)>{
    AstStatementDeclaration: _declare,
    AstStatementExpression: _expression,
    AstStatementReturn: _return,
    AstStatementContinue: _continue,
    AstStatementBreak: _break,
    AstBlock: _block,
    AstStatementIf: _if,
    AstStatementFor: _for,
    AstStatementWhile: _while,
  };

  Variable register(AstDeclaration decl) {
    Variable? v;
    Map<String, Variable> scope = _currentScope;
    if (decl is AstVariable) {
      final name = decl.identifier.name.text;
      if (decl.input || decl.output) {
        scope = _rootScope;
        if (scope.containsKey(name)) {
          throw Exception('I/O variable "$name" already declared.');
        }
        v = Variable(name, decl);
        final val = io[name];
        if (val is bool) {
          v.value = BoolValue(val);
        } else if (val is int) {
          v.value = IntValue(val);
        } else if (val is double) {
          v.value = FloatValue(val);
        } else if (val is String) {
          v.value = StringValue(val);
        } else if (val is Map) {
          if (val['re'] is num && val['im'] is num) {
            v.value = ComplexValue(val['re'].toDouble(), val['im'].toDouble());
          } else if (val['rad'] is num) {
            v.value = AngleValue(val['rad'].toDouble());
          } else if (val['deg'] is num) {
            v.value = AngleValue(val['deg'].toDouble() * math.pi / 180);
          }
        }
      } else {
        if (scope.containsKey(name)) {
          throw Exception('Variable "$name" already declared.');
        }
        v = Variable(name, decl);
        final expr = decl.expression;
        if (expr != null) {
          v.value = evaluate(expr);
        }
      }
    } else if (decl is AstQubit) {
      final name = decl.identifier.name.text;
      if (scope.containsKey(name)) {
        throw Exception('Variable "$name" already declared.');
      }
      v = Qubit(name, decl);
    } else if (decl is AstRegister) {
      final name = decl.identifier.name.text;
      if (scope.containsKey(name)) {
        throw Exception('Variable "$name" already declared.');
      }
      v = Register(name, decl);
    } else {
      throw Exception('Unexpected variable type "${decl.runtimeType}".');
    }
    scope[v.name] = v;
    return v;
  }

  static final _assignOps = <String, void Function(Variable, Value)>{
    '=': (variable, value) => variable.value = value,
    '+=': (variable, value) => variable.value = variable.value!.add(value),
    '-=': (variable, value) => variable.value = variable.value!.sub(value),
    '*=': (variable, value) => variable.value = variable.value!.mul(value),
    '/=': (variable, value) => variable.value = variable.value!.div(value),
    '%=': (variable, value) => variable.value = variable.value!.mod(value),
    '**=': (variable, value) => variable.value = variable.value!.pow(value),
    '|=': (variable, value) => variable.value = variable.value!.or(value),
    '&=': (variable, value) => variable.value = variable.value!.and(value),
    '^=': (variable, value) => variable.value = variable.value!.xor(value),
    '~=': (variable, value) => throw Exception('Not supported.'),
    '<<=': (variable, value) => variable.value = variable.value!.shiftr(value),
    '>>=': (variable, value) => variable.value = variable.value!.shiftl(value),
  };

  void assign(AstExpression assignee, String op, Value v) {
    if (assignee is AstIdentifier) {
      final variable = find(assignee.name.text)!;
      _assignOps[op]!(variable, v);
    } else if (assignee is AstExpressionArrayAccess) {
      throw Exception('Not supported');
    }
  }

  Value evaluate(AstExpression expr) {
    Value v;
    if (expr is AstExpressionAssignment) {
      v = evaluate(expr.expression);
      assign(expr.assignee, expr.op.text, v);
    } else if (expr is AstExpressionParenthesis) {
      v = evaluate(expr.expression);
    } else if (expr is AstExpressionNumber) {
      v = _evaluateNumber(expr);
    } else if (expr is AstExpressionString) {
      v = _evaluateString(expr);
    } else if (expr is AstExpressionConstant) {
      v = _evaluateConstant(expr);
    } else if (expr is AstExpressionSets) {
      v = SetValue(expr.children.map(evaluate));
    } else if (expr is AstExpressionRange) {
      final start = evaluate(expr.slice.start);
      final end = evaluate(expr.slice.end);
      final step = expr.slice.incr;
      final incr = (step == null) ? IntValue(1) : evaluate(step);
      v = RangeValue(start, end, incr);
    } else if (expr is AstIdentifier) {
      v = _evaluateIdentifier(expr);
    } else if (expr is AstExpressionUnary) {
      v = _evaluateUnary(expr);
    } else if (expr is AstExpressionBinary) {
      v = _evaluateBinary(expr);
    } else if (expr is AstExpressionCast) {
      v = _evaluateCast(expr);
    } else if (expr is AstExpressionFunctionCall) {
      v = _evaluateFunctionCall(expr);
    } else {
      throw Exception('Unexpected expression type "${expr.runtimeType}".');
    }
    return v;
  }

  Value _evaluateNumber(AstExpressionNumber expr) {
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

  static const _specialChars = {
    '\\n': '\n',
    '\\r': '\r',
    '\\t': '\t',
    '\\\\': '\\'
  };

  Value _evaluateString(AstExpressionString expr) {
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

  Value _evaluateConstant(AstExpressionConstant expr) =>
      _constants[expr.name.text]!;

  Value _evaluateIdentifier(AstIdentifier expr) {
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

  Value _evaluateUnary(AstExpressionUnary expr) {
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

  Value _evaluateBinary(AstExpressionBinary expr) {
    final left = evaluate(expr.leftOperand);
    final right = evaluate(expr.rightOperand);
    return _binaryOps[expr.tokens.first.text]!(left, right);
  }

  Value _evaluateCast(AstExpressionCast expr) {
    final v = evaluate(expr.expression);
    return v.cast(expr.type);
  }

  static double _float(Value value) => value.toFloat().value;
  static ComplexValue _complex(Value value) => value.toComplex();

  static final _buintInFunctions = <String, Value Function(Iterable<Value>)>{
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

  Value _evaluateFunctionCall(AstExpressionFunctionCall expr) {
    final funcName = expr.function.name.text;
    final f = _buintInFunctions[funcName];
    if (f != null) {
      return f(expr.arguments.map((a) => evaluate(a)));
    } else {
      throw Exception('Unknown function name "$funcName".');
    }
  }
}

class Variable {
  Variable(this.name, this.decl);

  final String name;
  final AstDeclaration decl;
  Value? value;
}

class Qubit extends Variable {
  Qubit(String name, AstDeclaration decl) : super(name, decl);
}

class Register extends Variable {
  Register(String name, AstDeclaration decl) : super(name, decl);
}
