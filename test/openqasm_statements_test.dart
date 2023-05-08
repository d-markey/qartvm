import 'package:qartvm/qartvm.dart';
import 'package:qartvm/src/openqasm/_token.dart';
import 'package:qartvm/src/openqasm/ast/ast_node.dart';
import 'package:qartvm/src/openqasm/parser/openqasm_parser.dart';
import 'package:test/test.dart';

void main() {
  group('OpenQAsm Parser - Statements -', () {
    test('Comments only', () {
      final p = parse('''
    // single line
    // comments
    /* multiline comment on a single line */
    /* real
    multiline
    comment */
    /**/
''');
      expect(p.comments, hasLength(5));
      expect(p.comments[0].text, equals('// single line'));
      expect(p.comments[1].text, equals('// comments'));
      expect(p.comments[2].text,
          equals('/* multiline comment on a single line */'));
      expect(p.comments[3].text, equals('''/* real
    multiline
    comment */'''));
      expect(p.comments[4].text, equals('/**/'));
    });

    test('Empty statements', () {
      var p = parse(';;;');
      expect(p, hasLength(3));
      expect(
          p.getDebugInfo(),
          equals([
            [AstStatement, ';'],
            [AstStatement, ';'],
            [AstStatement, ';']
          ]));

      p = parse(''';
;
      
;
''');
      expect(p, hasLength(3));
      expect(
          p.getDebugInfo(),
          equals([
            [AstStatement, ';'],
            [AstStatement, ';'],
            [AstStatement, ';']
          ]));
    });

    test('if (...) ...;', () {
      var p = parse('if(L ==R)  res = 1;');
      expect(p, hasLength(1));
      expect(
          p.first.getDebugInfo(),
          equals([
            [Token, 'if'],
            [Token, '('],
            [AstExpressionBinary, 'L', '==', 'R'],
            [Token, ')'],
            [AstStatementExpression, 'res', '=', '1', ';']
          ]));
    });

    test('if (...) {...}', () {
      var p = parse('if(L ==R) { res = 1;}');
      expect(p, hasLength(1));
      expect(
          p.first.getDebugInfo(),
          equals([
            [Token, 'if'],
            [Token, '('],
            [AstExpressionBinary, 'L', '==', 'R'],
            [Token, ')'],
            [AstBlock, '{', 'res', '=', '1', ';', '}']
          ]));
    });

    test('if (...) {...} else ...;', () {
      var p = parse('if(!ko) { res = 1;} else res = 0;');
      expect(p, hasLength(1));
      expect(
          p.first.getDebugInfo(),
          equals([
            [Token, 'if'],
            [Token, '('],
            [AstExpressionUnary, '!', 'ko'],
            [Token, ')'],
            [AstBlock, '{', 'res', '=', '1', ';', '}'],
            [Token, 'else'],
            [AstStatementExpression, 'res', '=', '0', ';']
          ]));
    });

    test('while (...) ...,', () {
      var p = parse('while(!L && R) fn(x, y);');
      expect(p, hasLength(1));
      expect(
          p.first.getDebugInfo(),
          equals([
            [Token, 'while'],
            [Token, '('],
            [AstExpressionBinary, '!', 'L', '&&', 'R'],
            [Token, ')'],
            [AstStatementExpression, 'fn', '(', 'x', ',', 'y', ')', ';']
          ]));
    });

    test('for ... in { ... } { ... }', () {
      var p = parse('for int[32] var in {1, 2, 4, 8, 16} sum += var;');
      expect(
          p.asText(),
          equals([
            'for',
            ...['int', '[', '32', ']', 'var'],
            'in',
            ...['{', '1', ',', '2', ',', '4', ',', '8', ',', '16', '}'],
            ...['sum', '+=', 'var', ';']
          ]));
      expect(p.first, isA<AstStatementFor>());
      final variable = (p.first as AstStatementFor).variable;
      expect(variable.type.asText(), equals(['int', '[', '32', ']']));
      expect(variable.identifier.name.asText(), equals(['var']));
      final set = (p.first as AstStatementFor).set;
      expect(set.asText(),
          equals(['{', '1', ',', '2', ',', '4', ',', '8', ',', '16', '}']));
      final body = (p.first as AstStatementFor).body;
      expect(body.asText(), equals(['sum', '+=', 'var', ';']));
    });

    test('for ... in [ ... ] { ... }', () {
      var p = parse('for int[32] var in [0:100:2] sum += var;');
      expect(
          p.asText(),
          equals([
            'for',
            ...['int', '[', '32', ']', 'var'],
            'in',
            ...['[', '0', ':', '100', ':', '2', ']'],
            ...['sum', '+=', 'var', ';']
          ]));
      expect(p.first, isA<AstStatementFor>());
      var variable = (p.first as AstStatementFor).variable;
      expect(variable.type.asText(), equals(['int', '[', '32', ']']));
      expect(variable.identifier.name.asText(), equals(['var']));
      var set = (p.first as AstStatementFor).set;
      expect(set.asText(), equals(['[', '0', ':', '100', ':', '2', ']']));
      var body = (p.first as AstStatementFor).body;
      expect(body.asText(), equals(['sum', '+=', 'var', ';']));

      p = parse('for int[32] var in [0:100] sum += var;');
      expect(
          p.asText(),
          equals([
            'for',
            ...['int', '[', '32', ']', 'var'],
            'in',
            ...['[', '0', ':', '100', ']'],
            ...['sum', '+=', 'var', ';']
          ]));
      expect(p.first, isA<AstStatementFor>());
      variable = (p.first as AstStatementFor).variable;
      expect(variable.type.asText(), equals(['int', '[', '32', ']']));
      expect(variable.identifier.name.asText(), equals(['var']));
      set = (p.first as AstStatementFor).set;
      expect(set.asText(), equals(['[', '0', ':', '100', ']']));
      body = (p.first as AstStatementFor).body;
      expect(body.asText(), equals(['sum', '+=', 'var', ';']));
    });

    test('multiple statements', () {
      var p = parse('''
          bool L;
          bool R;
          while(!L || R) {
            if (L) {
              continue;
            }
            R = fn(x, y);
            if (L && R) break;
          }''');
      expect(
          p.asText(),
          equals([
            ...['bool', 'L', ';'],
            ...['bool', 'R', ';'],
            'while',
            ...['(', '!', 'L', '||', 'R', ')'],
            '{',
            ...['if', '(', 'L', ')', '{', 'continue', ';', '}'],
            ...['R', '=', 'fn', '(', 'x', ',', 'y', ')', ';'],
            ...['if', '(', 'L', '&&', 'R', ')', 'break', ';'],
            '}'
          ]));
      expect(p, hasLength(3));
      expect(p[0], isA<AstStatementDeclaration>());
      expect(p[1], isA<AstStatementDeclaration>());
      expect(p[2], isA<AstStatementWhile>());
      expect((p[2] as AstStatementWhile).body, isA<AstBlock>());
      final body = (p[2] as AstStatementWhile).body as AstBlock;
      expect(body, hasLength(3));
      expect(
          body[0].getDebugInfo(),
          equals([
            [Token, 'if'],
            [Token, '('],
            [AstIdentifier, 'L'],
            [Token, ')'],
            [AstBlock, '{', 'continue', ';', '}']
          ]));
      expect(
          body[1].getDebugInfo(),
          equals([
            [AstExpressionAssignment, ...t('R¤=¤fn¤(¤x¤,¤y¤)')],
            [Token, ';']
          ]));
      expect(
          body[2].getDebugInfo(),
          equals([
            [Token, 'if'],
            [Token, '('],
            [AstExpressionBinary, 'L', '&&', 'R'],
            [Token, ')'],
            [AstStatementBreak, 'break', ';']
          ]));
    });

    test('annotation', () {
      var p = parse('''
          @bind env %L%
          @default true
          bool L;
          @bind env %R% default true
          bool R;
          while(!L || R) {
            if (L) {
              continue;
            }
            R = fn(x, y);
            if (L && R) break;
          }''');
      expect(
          p.asText(),
          equals([
            ...['bool', 'L', ';'],
            ...['bool', 'R', ';'],
            'while',
            ...['(', '!', 'L', '||', 'R', ')'],
            '{',
            ...['if', '(', 'L', ')', '{', 'continue', ';', '}'],
            ...['R', '=', 'fn', '(', 'x', ',', 'y', ')', ';'],
            ...['if', '(', 'L', '&&', 'R', ')', 'break', ';'],
            '}'
          ]));
      expect(p, hasLength(3));

      expect(p[0], isA<AstStatementDeclaration>());
      expect(p[0].annotations, hasLength(2));
      expect(
          p[0].annotations.asText(),
          equals(
            ['@bind env %L%', '@default true'],
          ));

      expect(p[1], isA<AstStatementDeclaration>());
      expect(p[1].annotations, hasLength(1));
      expect(
          p[1].annotations.asText(),
          equals(
            ['@bind env %R% default true'],
          ));

      expect(p[2], isA<AstStatementWhile>());
      expect((p[2] as AstStatementWhile).body, isA<AstBlock>());
      final body = (p[2] as AstStatementWhile).body as AstBlock;
      expect(body, hasLength(3));

      expect(
          body[0].getDebugInfo(),
          equals([
            [Token, 'if'],
            [Token, '('],
            [AstIdentifier, 'L'],
            [Token, ')'],
            [AstBlock, '{', 'continue', ';', '}']
          ]));

      expect(
          body[1].getDebugInfo(),
          equals([
            [AstExpressionAssignment, ...t('R¤=¤fn¤(¤x¤,¤y¤)')],
            [Token, ';']
          ]));

      expect(
          body[2].getDebugInfo(),
          equals([
            [Token, 'if'],
            [Token, '('],
            [AstExpressionBinary, 'L', '&&', 'R'],
            [Token, ')'],
            [AstStatementBreak, 'break', ';']
          ]));
    });

    test('pragma', () {
      var p = parse('''
          #pragma no_optimization
          input bool L;
          input int x;
          bool R = true;
          while(!L || R) {
            L = R;
            R = f(x);
            x += 1;
          }''');
      expect(
          p.asText(),
          equals([
            '#pragma no_optimization',
            ...['input', 'bool', 'L', ';'],
            ...['input', 'int', 'x', ';'],
            ...['bool', 'R', '=', 'true', ';'],
            'while',
            ...['(', '!', 'L', '||', 'R', ')'],
            '{',
            ...['L', '=', 'R', ';'],
            ...['R', '=', 'f', '(', 'x', ')', ';'],
            ...['x', '+=', '1', ';'],
            '}'
          ]));
      expect(p, hasLength(5));
      expect(p[0], isA<AstPragma>());
      expect(p[1], isA<AstStatementDeclaration>());
      expect(p[2], isA<AstStatementDeclaration>());
      expect(p[3], isA<AstStatementDeclaration>());
      expect(p[4], isA<AstStatementWhile>());
      expect((p[4] as AstStatementWhile).body, isA<AstBlock>());
      var body = (p[4] as AstStatementWhile).body as AstBlock;
      expect(body, hasLength(3));
      expect(
          body[0].getDebugInfo(),
          equals([
            [AstExpressionAssignment, 'L', '=', 'R'],
            [Token, ';']
          ]));
      expect(
          body[1].getDebugInfo(),
          equals([
            [AstExpressionAssignment, 'R', '=', 'f', '(', 'x', ')'],
            [Token, ';']
          ]));
      expect(
          body[2].getDebugInfo(),
          equals([
            [AstExpressionAssignment, 'x', '+=', '1'],
            [Token, ';']
          ]));

      p = parse('''
          pragma no_optimization
          input bool L;
          input int x;
          bool R = true;
          while(!L || R) {
            L = R;
            R = f(x);
            x += 1;
          }''');
      expect(
          p.asText(),
          equals([
            'pragma no_optimization',
            ...['input', 'bool', 'L', ';'],
            ...['input', 'int', 'x', ';'],
            ...['bool', 'R', '=', 'true', ';'],
            'while',
            ...['(', '!', 'L', '||', 'R', ')'],
            '{',
            ...['L', '=', 'R', ';'],
            ...['R', '=', 'f', '(', 'x', ')', ';'],
            ...['x', '+=', '1', ';'],
            '}'
          ]));
      expect(p, hasLength(5));
      expect(p[0], isA<AstPragma>());
      expect(p[1], isA<AstStatementDeclaration>());
      expect(p[2], isA<AstStatementDeclaration>());
      expect(p[3], isA<AstStatementDeclaration>());
      expect(p[4], isA<AstStatementWhile>());
      expect((p[4] as AstStatementWhile).body, isA<AstBlock>());
      body = (p[4] as AstStatementWhile).body as AstBlock;
      expect(body, hasLength(3));
      expect(
          body[0].getDebugInfo(),
          equals([
            [AstExpressionAssignment, 'L', '=', 'R'],
            [Token, ';']
          ]));
      expect(
          body[1].getDebugInfo(),
          equals([
            [AstExpressionAssignment, 'R', '=', 'f', '(', 'x', ')'],
            [Token, ';']
          ]));
      expect(
          body[2].getDebugInfo(),
          equals([
            [AstExpressionAssignment, 'x', '+=', '1'],
            [Token, ';']
          ]));
    });
  });
}

final openQAsmParser = OpenQAsmParser();

Program parse(String code, {bool trace = false}) {
  openQAsmParser.trace = trace;
  if (trace) {
    print('''Parsing code:
   --------------------------------------------------
${code.split('\n').map((l) => '      $l').join('\n')}
   --------------------------------------------------''');
  }
  final p = Program.parse(code, openQAsmParser);
  if (trace) {
    print('>> ${p.asText()}');
  }
  return p;
}

extension AstDebugExt on Ast {
  Iterable<List> getDebugInfo() =>
      getChildren().map((c) => [c.runtimeType, ...c.asText()]);
}

Iterable<String> t(String code) => code.split('¤');
