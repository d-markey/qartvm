part of 'openqasm_interpreter.dart';

extension _OpenQAsmInterpreterContextExt on _OpenQAsmInterpreterContext {
  StatusCode _declare(AstStatement decl) {
    decl = decl as AstStatementDeclaration;
    register(decl.declaration);
    return Done();
  }

  StatusCode _expression(AstStatement expr) {
    expr = expr as AstStatementExpression;
    evaluate(expr.expression);
    return Done();
  }

  StatusCode _return(AstStatement ret) {
    ret = ret as AstStatementReturn;
    final expr = ret.expression;
    final value = (expr == null) ? Value.$void : evaluate(expr);
    return Return(value);
  }

  StatusCode _continue(AstStatement cont) => Continue();

  StatusCode _break(AstStatement brk) => Break();

  StatusCode _block(AstStatement block) {
    block = block as AstBlock;
    enterScope();
    final res = run(block.children);
    leaveScope();
    return res;
  }

  StatusCode _if(AstStatement alt) {
    alt = alt as AstStatementIf;
    final condition = alt.condition;
    final flag = evaluate(condition).toBool();
    final body = flag.value ? alt.trueBody : alt.falseBody;
    if (body != null) {
      final result = run([body]);
      print('statement = $alt --> ${flag.value}: $result');
      if (result is Break || result is Continue || result is Return) {
        return result;
      }
    } else {
      print('statement = $alt --> ${flag.value}: nothing to do');
    }
    return Done();
  }

  StatusCode _while(AstStatement loop) {
    loop = loop as AstStatementWhile;
    final condition = loop.condition;
    final body = [loop.body];
    var flag = evaluate(condition).toBool();
    while (flag.value) {
      final result = run(body);
      if (result is Break) {
        break;
      } else if (result is Return) {
        return result;
      }
      flag = evaluate(condition).toBool();
    }
    return Done();
  }

  StatusCode _for(AstStatement loop) {
    loop = loop as AstStatementFor;
    enterScope();
    register(loop.variable);
    final body = [loop.body];
    final set = evaluate(loop.set) as SetValue;
    for (var item in set.value) {
      assign(loop.variable.identifier, '=', item);
      final result = run(body);
      if (result is Break || result is Return) {
        leaveScope();
        return result;
      }
    }
    leaveScope();
    return Done();
  }
}
