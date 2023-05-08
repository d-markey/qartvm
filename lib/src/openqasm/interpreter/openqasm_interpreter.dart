import 'dart:math' as math;
import 'package:qartvm/src/openqasm/_tokenizer.dart';
import 'package:qartvm/src/openqasm/ast/ast_node.dart';

import '../program.dart';
import 'status_codes.dart';
import 'value.dart';

part 'openqasm_interpreter.statements.dart';
part 'openqasm_interpreter.expressions.dart';

class OpenQAsmInterpreter {
  StatusCode execute(Program p, Map<String, dynamic> io) {
    final context = _OpenQAsmInterpreterContext(io);
    StatusCode result;
    context.enterScope();
    try {
      result = context.run(p.children);
    } finally {
      context.leaveScope();
    }
    for (var entry in context._rootScope.entries) {
      if (entry.value.decl is AstVariable &&
          (entry.value.decl as AstVariable).output) {
        io[entry.key] = entry.value.value?.value;
      }
    }
    return result;
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
    _scopes.removeLast();
    _currentScope = _scopes.last;
  }

  Variable? find(String name) {
    for (var i = _scopes.length - 1; i >= 0; i--) {
      final scope = _scopes[i];
      final v = scope[name];
      if (v != null) {
        return v;
      } else {
        // print('$name not in scope $scope');
      }
    }
    return null;
  }

  StatusCode run(Iterable<AstStatement> statements) {
    for (var stmt in statements) {
      final s = execute(stmt);
      if (s is Return || s is Break || s is Continue) {
        return s;
      }
    }
    return Done();
  }

  StatusCode execute(AstStatement statement) {
    final executor = _executors[statement.runtimeType];
    if (executor == null) {
      throw UnsupportedError('No executor for ${statement.runtimeType}');
    }
    // print('[${statement.runtimeType}] $statement');
    return executor(statement);
  }

  late final _executors = <Type, StatusCode Function(AstStatement)>{
    AstStatementDeclaration: _stmt_declare,
    AstStatementExpression: _stmt_expression,
    AstStatementReturn: _stmt_return,
    AstStatementContinue: _stmt_continue,
    AstStatementBreak: _stmt_break,
    AstBlock: _stmt_block,
    AstStatementIf: _stmt_if,
    AstStatementFor: _stmt_for,
    AstStatementWhile: _stmt_while,
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
    // print('registered ${v.name} = ${v.value} in $scope');
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

  late final _evaluators = <Type, Value Function(AstExpression)>{
    AstExpressionAssignment: _expr_assign,
    AstExpressionParenthesis: _expr_parenthesis,
    AstExpressionInteger: _expr_number,
    AstExpressionImaginary: _expr_number,
    AstExpressionReal: _expr_number,
    AstExpressionString: _expr_string,
    AstExpressionConstant: _expr_constant,
    AstIdentifier: _expr_identifier,
    AstExpressionUnary: _expr_unary,
    AstExpressionBinary: _expr_binary,
    AstExpressionCast: _expr_cast,
    AstExpressionFunctionCall: _expr_call,
    AstExpressionArray: _expr_array,
    AstExpressionRange: _expr_range,
  };

  Value evaluate(AstExpression expr) {
    final evaluator = _evaluators[expr.runtimeType];
    if (evaluator == null) {
      throw UnsupportedError('No evaluator for ${expr.runtimeType}');
    }
    // print('[${expr.runtimeType}] $expr');
    return evaluator(expr);
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
