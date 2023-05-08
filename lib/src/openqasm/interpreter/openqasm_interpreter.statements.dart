// ignore_for_file: non_constant_identifier_names

part of 'openqasm_interpreter.dart';

extension _OpenQAsmInterpreterContextStmtExt on _OpenQAsmInterpreterContext {
  StatusCode _stmt_declare(AstStatement decl) {
    decl = decl as AstStatementDeclaration;
    register(decl.declaration);
    return Done();
  }

  StatusCode _stmt_expression(AstStatement expr) {
    expr = expr as AstStatementExpression;
    evaluate(expr.expression);
    return Done();
  }

  StatusCode _stmt_return(AstStatement ret) {
    ret = ret as AstStatementReturn;
    final expr = ret.expression;
    final value = (expr == null) ? Value.$void : evaluate(expr);
    return Return(value);
  }

  StatusCode _stmt_continue(AstStatement cont) => Continue();

  StatusCode _stmt_break(AstStatement brk) => Break();

  StatusCode _stmt_block(AstStatement block) {
    block = block as AstBlock;
    enterScope();
    try {
      return run(block.children);
    } finally {
      leaveScope();
    }
  }

  StatusCode _stmt_if(AstStatement alt) {
    alt = alt as AstStatementIf;
    final condition = alt.condition;
    final flag = evaluate(condition).toBool();
    final body = flag.value ? alt.trueBody : alt.falseBody;
    return (body == null) ? Done() : execute(body);
  }

  StatusCode _stmt_while(AstStatement loop) {
    loop = loop as AstStatementWhile;
    final condition = loop.condition;
    final body = loop.body;
    var flag = evaluate(condition).toBool();
    while (flag.value) {
      final result = execute(body);
      if (result is Break) {
        break;
      } else if (result is Return) {
        return result;
      }
      flag = evaluate(condition).toBool();
    }
    return Done();
  }

  StatusCode _stmt_for(AstStatement loop) {
    loop = loop as AstStatementFor;
    enterScope();
    try {
      register(loop.variable);
      final body = loop.body;
      final set = evaluate(loop.set) as IterableValue;
      for (var item in set.value) {
        assign(loop.variable.identifier, '=', item);
        final result = execute(body);
        if (result is Break) {
          break;
        } else if (result is Return) {
          return result;
        }
      }
    } finally {
      leaveScope();
    }
    return Done();
  }
}
