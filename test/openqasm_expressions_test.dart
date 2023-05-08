import 'package:qartvm/qartvm.dart';
import 'package:qartvm/src/openqasm/_token.dart';
import 'package:qartvm/src/openqasm/ast/ast_node.dart';
import 'package:qartvm/src/openqasm/parser/openqasm_parser.dart';
import 'package:test/test.dart';

void main() {
  group('OpenQAsm Parser - Expressions -', () {
    group('Identifiers and literals -', () {
      void verify<T extends AstExpression>(String code, String value,
          {bool trace = false}) {
        var p = parse(code, trace: trace);
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementExpression>());
        expect(
            p.first.getDebugInfo(),
            equals([
              [T, value],
              [Token, ';']
            ]));
      }

      test('Integer', () {
        verify<AstExpressionInteger>('1;', '1');
        verify<AstExpressionInteger>('0;', '0');
        verify<AstExpressionInteger>('456;', '456');
        verify<AstExpressionInteger>('78_456;', '78_456');
        verify<AstExpressionInteger>('0x1234CAFE;', '0x1234CAFE');
        verify<AstExpressionInteger>('0x1234_CAFE;', '0x1234_CAFE');
        verify<AstExpressionInteger>('0o1234567;', '0o1234567');
        verify<AstExpressionInteger>('0o1_23_45_67;', '0o1_23_45_67');
        verify<AstExpressionInteger>('0b01101001;', '0b01101001');
        verify<AstExpressionInteger>('0b0110_1001;', '0b0110_1001');
      });

      test('Real', () {
        verify<AstExpressionReal>('.1234;', '.1234');
        verify<AstExpressionReal>('.123_4;', '.123_4');
        verify<AstExpressionReal>('1.234;', '1.234');
        verify<AstExpressionReal>('1.234_5;', '1.234_5');
        verify<AstExpressionReal>('1234.;', '1234.');
        verify<AstExpressionReal>('1_234.;', '1_234.');
        verify<AstExpressionReal>('1234.56;', '1234.56');
        verify<AstExpressionReal>('1_234.56;', '1_234.56');
        verify<AstExpressionReal>('1e3;', '1e3');
        verify<AstExpressionReal>('1e+3;', '1e+3');
        verify<AstExpressionReal>('1e-3;', '1e-3');
        verify<AstExpressionReal>('1.2345e6;', '1.2345e6');
        verify<AstExpressionReal>('1.2345e+6;', '1.2345e+6');
        verify<AstExpressionReal>('1.234_5e+6;', '1.234_5e+6');
        verify<AstExpressionReal>('1.2345e-6;', '1.2345e-6');
        verify<AstExpressionReal>('1.234_5e-6;', '1.234_5e-6');
      });

      test('Imaginary', () {
        verify<AstExpressionImaginary>('.1234im;', '.1234im');
        verify<AstExpressionImaginary>('.123_4im;', '.123_4im');
        verify<AstExpressionImaginary>('1.234 im;', '1.234 im');
        verify<AstExpressionImaginary>('1.234_5 im;', '1.234_5 im');
        verify<AstExpressionImaginary>('1234.im;', '1234.im');
        verify<AstExpressionImaginary>('1_234. im;', '1_234. im');
        verify<AstExpressionImaginary>('1234.56im;', '1234.56im');
        verify<AstExpressionImaginary>('1_234.56 im;', '1_234.56 im');
        verify<AstExpressionImaginary>('1e3im;', '1e3im');
        verify<AstExpressionImaginary>('1e+3 im;', '1e+3 im');
        verify<AstExpressionImaginary>('1e-3 im;', '1e-3 im');
        verify<AstExpressionImaginary>('1.2345e6 im;', '1.2345e6 im');
        verify<AstExpressionImaginary>('1.2345e+6im;', '1.2345e+6im');
        verify<AstExpressionImaginary>('1.234_5e+6im;', '1.234_5e+6im');
        verify<AstExpressionImaginary>('1.2345e-6  im;', '1.2345e-6  im');
        verify<AstExpressionImaginary>('1.234_5e-6im;', '1.234_5e-6im');
      });

      test('Duration', () {
        verify<AstExpressionDuration>('10000000ns;', '10000000ns');
        verify<AstExpressionDuration>('10_000_000ns;', '10_000_000ns');
        verify<AstExpressionDuration>('10_000_000 ns;', '10_000_000 ns');
        verify<AstExpressionDuration>('10000us;', '10000us');
        verify<AstExpressionDuration>('10_000 us;', '10_000 us');
        verify<AstExpressionDuration>('10000 µs;', '10000 µs');
        verify<AstExpressionDuration>('10_000µs;', '10_000µs');
        verify<AstExpressionDuration>('10ms;', '10ms');
        verify<AstExpressionDuration>('10 ms;', '10 ms');
        verify<AstExpressionDuration>('3600s;', '3600s');
        verify<AstExpressionDuration>('3_600 s;', '3_600 s');
      });

      test('Boolean', () {
        verify<AstExpressionConstant>('true;', 'true');
        verify<AstExpressionConstant>('false;', 'false');
      });

      test('Predefined constants', () {
        verify<AstExpressionConstant>('pi;', 'pi');
        verify<AstExpressionConstant>('π;', 'π');
        verify<AstExpressionConstant>('tau;', 'tau');
        verify<AstExpressionConstant>('τ;', 'τ');
        verify<AstExpressionConstant>('euler;', 'euler');
        verify<AstExpressionConstant>('ℇ;', 'ℇ');
      });

      test('Strings', () {
        verify<AstExpressionString>(
            '"double-quoted string";', '"double-quoted string"');
        verify<AstExpressionString>(
            '"double-quoted string with \\"double quotes\\"";',
            '"double-quoted string with \\"double quotes\\""');
        verify<AstExpressionString>(
            '"double-quoted string with \'single quotes\'";',
            '"double-quoted string with \'single quotes\'"');

        verify<AstExpressionString>(
            '\'single-quoted string\';', '\'single-quoted string\'');
        verify<AstExpressionString>(
            '\'single-quoted string with "double quotes"\';',
            '\'single-quoted string with "double quotes"\'');
        verify<AstExpressionString>(
            '\'single-quoted string with \\\'single quotes\\\'\';',
            '\'single-quoted string with \\\'single quotes\\\'\'');
      });
    });

    group('Function calls -', () {
      void verify(String code, String funcName, List<List> arguments,
          {bool trace = false}) {
        var p = parse(code, trace: trace);
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementExpression>());
        expect((p.first as AstStatementExpression).expression,
            isA<AstExpressionFunctionCall>());
        final funcCall = (p.first as AstStatementExpression).expression
            as AstExpressionFunctionCall;
        expect(funcCall.function.name.text, equals(funcName));
        expect(funcCall.arguments.children.getDebugInfo(), equals(arguments));
      }

      test('No arguments', () {
        verify('fn();', 'fn', []);
      });

      test('1 argument - atomic', () {
        verify('fn(variable);', 'fn', [
          [AstIdentifier, 'variable']
        ]);
        verify('fn(pi);', 'fn', [
          [AstExpressionConstant, 'pi']
        ]);
        verify('fn(τ);', 'fn', [
          [AstExpressionConstant, 'τ']
        ]);
        verify('fn(1);', 'fn', [
          [AstExpressionInteger, '1']
        ]);
        verify('fn(2.34);', 'fn', [
          [AstExpressionReal, '2.34']
        ]);
        verify('fn(56.7 im);', 'fn', [
          [AstExpressionImaginary, '56.7 im']
        ]);
        verify('fn(true);', 'fn', [
          [AstExpressionConstant, 'true']
        ]);
        verify('fn(false);', 'fn', [
          [AstExpressionConstant, 'false']
        ]);
        verify('fn("test");', 'fn', [
          [AstExpressionString, '"test"']
        ]);
      });

      test('1 argument - expression', () {
        verify('fn(!false);', 'fn', [
          [AstExpressionUnary, '!', 'false']
        ]);
        verify('fn(2 * pi);', 'fn', [
          [AstExpressionBinary, '2', '*', 'pi']
        ]);
        verify('fn(L || R);', 'fn', [
          [AstExpressionBinary, 'L', '||', 'R']
        ]);
        verify('fn(1+0.5 im);', 'fn', [
          [AstExpressionBinary, '1', '+', '0.5 im']
        ]);
      });

      test('1 argument - nested', () {
        verify('f(g(x));', 'f', [
          [AstExpressionFunctionCall, 'g', '(', 'x', ')']
        ]);
        verify('f(L(x)/R(x));', 'f', [
          [AstExpressionBinary, 'L', '(', 'x', ')', '/', 'R', '(', 'x', ')']
        ]);
      });
    });

    group('Arrays & Ranges -', () {
      void verifyRange(
          String code, Iterable start, Iterable end, Iterable? incr,
          {bool trace = false}) {
        var p = parse(code, trace: trace);
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementExpression>());
        expect((p.first as AstStatementExpression).expression,
            isA<AstExpressionRange>());
        final range = (p.first as AstStatementExpression).expression
            as AstExpressionRange;
        expect(
            range.slice.getDebugInfo(),
            equals([
              start,
              [Token, ':'],
              end,
              if (incr != null) ...[
                [Token, ':'],
                incr
              ]
            ]));
      }

      void verifyArrayItems(String code, List<List> values,
          {bool trace = false}) {
        var p = parse(code, trace: trace);
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementExpression>());
        expect((p.first as AstStatementExpression).expression,
            isA<AstExpressionArray>());
        final array = (p.first as AstStatementExpression).expression
            as AstExpressionArray;
        expect(array.children.getDebugInfo(), equals(values));
      }

      void verifyArrayAccess(String code, List<List> values,
          {bool trace = false}) {
        var p = parse(code, trace: trace);
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementExpression>());
        expect((p.first as AstStatementExpression).expression,
            isA<AstExpressionArrayAccess>());
        final array = (p.first as AstStatementExpression).expression
            as AstExpressionArrayAccess;
        expect(array.getDebugInfo(), equals(values));
      }

      test('Ranges', () {
        verifyRange('[1:4];', [AstExpressionInteger, '1'],
            [AstExpressionInteger, '4'], null);
        verifyRange('[0:1000:100];', [AstExpressionInteger, '0'],
            [AstExpressionInteger, '1000'], [AstExpressionInteger, '100']);
      });

      test('Array items', () {
        verifyArrayItems('{ 1, 2, 3 };', [
          [AstExpressionInteger, '1'],
          [AstExpressionInteger, '2'],
          [AstExpressionInteger, '3']
        ]);

        verifyArrayItems('{ 1, .0, 0.5 im };', [
          [AstExpressionInteger, '1'],
          [AstExpressionReal, '.0'],
          [AstExpressionImaginary, '0.5 im']
        ]);

        verifyArrayItems('{ tau, τ, true };', [
          [AstExpressionConstant, 'tau'],
          [AstExpressionConstant, 'τ'],
          [AstExpressionConstant, 'true']
        ]);

        verifyArrayItems('{ "text", "text with closing }", "ok" };', [
          [AstExpressionString, '"text"'],
          [AstExpressionString, '"text with closing }"'],
          [AstExpressionString, '"ok"']
        ]);

        verifyArrayItems('{ 1+3, f(x), !B };', [
          [AstExpressionBinary, '1', '+', '3'],
          [AstExpressionFunctionCall, 'f', '(', 'x', ')'],
          [AstExpressionUnary, '!', 'B']
        ]);

        verifyArrayItems('{ {1}, {1,2}, {1,2,3} };', [
          [AstExpressionArray, '{', '1', '}'],
          [AstExpressionArray, '{', '1', ',', '2', '}'],
          [AstExpressionArray, '{', '1', ',', '2', ',', '3', '}']
        ]);

        verifyArrayItems('{ {1}, [1:2], [1:3] };', [
          [AstExpressionArray, '{', '1', '}'],
          [AstExpressionRange, '[', '1', ':', '2', ']'],
          [AstExpressionRange, '[', '1', ':', '3', ']']
        ]);
      });

      test('Access', () {
        verifyArrayAccess('list[0];', [
          [AstIdentifier, 'list'],
          [AstExpressionIndex, '[', '0', ']']
        ]);

        verifyArrayAccess('list[i + j];', [
          [AstIdentifier, 'list'],
          [AstExpressionIndex, '[', 'i', '+', 'j', ']']
        ]);

        verifyArrayAccess('list[index];', [
          [AstIdentifier, 'list'],
          [AstExpressionIndex, '[', 'index', ']']
        ]);

        verifyArrayAccess('list[idx1, idx2];', [
          [AstIdentifier, 'list'],
          [AstExpressionIndex, '[', 'idx1', ',', 'idx2', ']']
        ]);

        verifyArrayAccess('list[idx1][idx2];', [
          [AstExpressionArrayAccess, 'list', '[', 'idx1', ']'],
          [AstExpressionIndex, '[', 'idx2', ']']
        ]);

        verifyArrayAccess('{1, 2, 3, 5, 7, 11}[2];', [
          [AstExpressionArray, ...t('{¤1¤,¤2¤,¤3¤,¤5¤,¤7¤,¤11¤}')],
          [AstExpressionIndex, '[', '2', ']']
        ]);

        verifyArrayAccess('{1, 2, 3, 5, 7, 11}[1:3];', [
          [AstExpressionArray, ...t('{¤1¤,¤2¤,¤3¤,¤5¤,¤7¤,¤11¤}')],
          [AstExpressionRange, '[', '1', ':', '3', ']']
        ]);

        verifyArrayAccess('arr[i:j, k];', [
          [AstIdentifier, 'arr'],
          [AstExpressionIndex, '[', 'i', ':', 'j', ',', 'k', ']']
        ]);
      });

      test('Slice', () {
        verifyArrayAccess('{1, 2, 3, 5, 7, 11}[0:3];', [
          [AstExpressionArray, ...t('{¤1¤,¤2¤,¤3¤,¤5¤,¤7¤,¤11¤}')],
          [AstExpressionRange, '[', '0', ':', '3', ']']
        ]);
        verifyArrayAccess('{1, 2, 3, 5, 7, 11}[{1, 3}];', [
          [AstExpressionArray, ...t('{¤1¤,¤2¤,¤3¤,¤5¤,¤7¤,¤11¤}')],
          [AstExpressionIndex, '[', '{', '1', ',', '3', '}', ']']
        ]);
      });
    });

    group('Cast -', () {
      void verify(String code, Iterable type, Iterable expression,
          {bool trace = false}) {
        var p = parse(code, trace: trace);
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementExpression>());
        expect((p.first as AstStatementExpression).expression,
            isA<AstExpressionCast>());
        final cast =
            (p.first as AstStatementExpression).expression as AstExpressionCast;
        expect(
            cast.getDebugInfo(),
            equals([
              type,
              [Token, '('],
              expression,
              [Token, ')']
            ]));
      }

      test('Literals', () {
        verify(
            'bool(1);', [AstSimpleType, 'bool'], [AstExpressionInteger, '1']);
        verify('int[32](0xCAFE);', [AstSimpleType, 'int', '[', '32', ']'],
            [AstExpressionInteger, '0xCAFE']);
        verify('bit[1](true);', [AstSimpleType, 'bit', '[', '1', ']'],
            [AstExpressionConstant, 'true']);
      });

      test('Expressions', () {
        verify('bool(1 == 2);', [AstSimpleType, 'bool'],
            [AstExpressionBinary, '1', '==', '2']);
        verify('int[32](2 << 16);', [AstSimpleType, 'int', '[', '32', ']'],
            [AstExpressionBinary, '2', '<<', '16']);
        verify('bit[1](L && !R);', [AstSimpleType, 'bit', '[', '1', ']'],
            [AstExpressionBinary, 'L', '&&', '!', 'R']);
        verify('int[32](uint[32](x));', [AstSimpleType, 'int', '[', '32', ']'],
            [AstExpressionCast, 'uint', '[', '32', ']', '(', 'x', ')']);
      });
    });

    group('Unary operators -', () {
      void verify(String code, String op, Iterable<String> tokens,
          {bool trace = false}) {
        var p = parse(code, trace: trace);
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementExpression>());
        expect(
            p.first.getDebugInfo(),
            equals([
              [AstExpressionUnary, op, ...tokens],
              [Token, ';']
            ]));
      }

      test('Arithmetic', () {
        verify('-L;', '-', ['L']);
        verify('--L;', '-', ['-', 'L']);
        verify('-+L;', '-', ['+', 'L']);
        verify('+L;', '+', ['L']);
      });

      test('Logical', () {
        verify('!true;', '!', ['true']);
        verify('!!false;', '!', ['!', 'false']);
      });

      test('Bitwise', () {
        verify('~0B1000_0101;', '~', ['0B1000_0101']);
      });

      test('Precedence', () {
        verify('-{1, 2, 3, 5}[0];', '-', t('{¤1¤,¤2¤,¤3¤,¤5¤}¤[¤0¤]'));
        verify('-list[idx];', '-', ['list', '[', 'idx', ']']);
      });
    });

    group('Binary operators -', () {
      void verify(String code, Iterable<String> leftTokens, String op,
          Iterable<String> rightTokens,
          {bool trace = false}) {
        var p = parse(code, trace: trace);
        expect(p.asText(), equals([...leftTokens, op, ...rightTokens, ';']));
        var expr = (p.first as AstStatementExpression).expression
            as AstExpressionBinary;
        expect(expr.leftOperand.asText(), equals(leftTokens));
        expect(expr.tokens.first.text, equals(op));
        expect(expr.rightOperand.asText(), equals(rightTokens));
      }

      test('Arithmetic', () {
        verify('L + R;', ['L'], '+', ['R']);
        verify('L - R;', ['L'], '-', ['R']);
        verify('L * R;', ['L'], '*', ['R']);
        verify('L / R;', ['L'], '/', ['R']);
        verify('L % R;', ['L'], '%', ['R']);
        verify('L ** R;', ['L'], '**', ['R']);
      });

      test('Logical', () {
        verify('L || R;', ['L'], '||', ['R']);
        verify('L && R;', ['L'], '&&', ['R']);
      });

      test('Bitwise', () {
        verify('L | R;', ['L'], '|', ['R']);
        verify('L & R;', ['L'], '&', ['R']);
        verify('L ^ R;', ['L'], '^', ['R']);
        verify('L >> R;', ['L'], '>>', ['R']);
        verify('L << R;', ['L'], '<<', ['R']);
      });

      test('Comparisons', () {
        verify('L == R;', ['L'], '==', ['R']);
        verify('L != R;', ['L'], '!=', ['R']);
        verify('L < R;', ['L'], '<', ['R']);
        verify('L <= R;', ['L'], '<=', ['R']);
        verify('L > R;', ['L'], '>', ['R']);
        verify('L >= R;', ['L'], '>=', ['R']);
      });

      test('Precedence - arithmetic', () {
        verify('L + M + R;', ['L'], '+', ['M', '+', 'R']);
        verify('L + M * R;', ['L'], '+', ['M', '*', 'R']);
        verify('L * M + R;', ['L', '*', 'M'], '+', ['R']);
        verify('L * M ** R;', ['L'], '*', ['M', '**', 'R']);
        verify('L ** M * R;', ['L', '**', 'M'], '*', ['R']);
        verify('-L ** R;', ['-', 'L'], '**', ['R']);
        verify('L[i] ** R[j];', t('L¤[¤i¤]'), '**', t('R¤[¤j¤]'));
        verify('-L[i] ** +R[j];', t('-¤L¤[¤i¤]'), '**', t('+¤R¤[¤j¤]'));
      });

      test('Precedence - logical', () {
        verify('L || M && R;', ['L'], '||', ['M', '&&', 'R']);
        verify('!L || M && R;', ['!', 'L'], '||', ['M', '&&', 'R']);
        verify('L || !M && R;', ['L'], '||', ['!', 'M', '&&', 'R']);
        verify('L && M || R;', ['L', '&&', 'M'], '||', ['R']);
        verify('!L && M || R;', ['!', 'L', '&&', 'M'], '||', ['R']);
        verify('L && !M || R;', ['L', '&&', '!', 'M'], '||', ['R']);
      });

      test('Precedence - bitwise', () {
        verify('L | M & R;', ['L'], '|', ['M', '&', 'R']);
        verify('~L | M & R;', ['~', 'L'], '|', ['M', '&', 'R']);
        verify('L | ~M & R;', ['L'], '|', ['~', 'M', '&', 'R']);
        verify('L & ~M | R;', ['L', '&', '~', 'M'], '|', ['R']);
        verify('L | M ^ R;', ['L'], '|', ['M', '^', 'R']);
        verify('L ^ M | R;', ['L', '^', 'M'], '|', ['R']);
        verify('L & M ^ R;', ['L', '&', 'M'], '^', ['R']);
        verify('L ^ M & R;', ['L'], '^', ['M', '&', 'R']);
      });

      test('Precedence - comparison', () {
        verify('L < M || R;', ['L', '<', 'M'], '||', ['R']);
        verify('L && M < R;', ['L'], '&&', ['M', '<', 'R']);
      });
    });

    group('Assignment -', () {
      void verify(
          String code, Iterable assignee, String op, Iterable expression,
          {bool trace = false}) {
        final p = parse(code, trace: trace);
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementExpression>());
        final expr = (p.first as AstStatementExpression).expression;
        expect(expr, isA<AstExpressionAssignment>());
        expect(
            expr.getDebugInfo(),
            equals([
              assignee,
              [Token, op],
              expression
            ]));
      }

      test('Simple variable assignment', () {
        verify('var = value;', [AstIdentifier, 'var'], '=',
            [AstIdentifier, 'value']);
        verify('var = L + R;', [AstIdentifier, 'var'], '=',
            [AstExpressionBinary, 'L', '+', 'R']);
        verify('var = 123;', [AstIdentifier, 'var'], '=',
            [AstExpressionInteger, '123']);
        verify('var = 123.4;', [AstIdentifier, 'var'], '=',
            [AstExpressionReal, '123.4']);
        verify('var = 123 im;', [AstIdentifier, 'var'], '=',
            [AstExpressionImaginary, '123 im']);
        verify('var = 123.4im;', [AstIdentifier, 'var'], '=',
            [AstExpressionImaginary, '123.4im']);
        verify('var = 3600 s;', [AstIdentifier, 'var'], '=',
            [AstExpressionDuration, '3600 s']);
        verify('var = f(x);', [AstIdentifier, 'var'], '=',
            [AstExpressionFunctionCall, 'f', '(', 'x', ')']);
        verify('var = {1,2,3};', [AstIdentifier, 'var'], '=',
            [AstExpressionArray, '{', '1', ',', '2', ',', '3', '}']);
        verify('var = {1,2,3}[0];', [AstIdentifier, 'var'], '=',
            [AstExpressionArrayAccess, ...t('{¤1¤,¤2¤,¤3¤}¤[¤0¤]')]);
        verify('var = list[i];', [AstIdentifier, 'var'], '=',
            [AstExpressionArrayAccess, 'list', '[', 'i', ']']);
      });

      test('Array item assignment', () {
        verify(
            'arr[i] = value;',
            [AstExpressionArrayAccess, 'arr', '[', 'i', ']'],
            '=',
            [AstIdentifier, 'value']);
        verify(
            'arr[i] = L + R;',
            [AstExpressionArrayAccess, 'arr', '[', 'i', ']'],
            '=',
            [AstExpressionBinary, 'L', '+', 'R']);
        verify(
            'arr[i,j] = 123;',
            [AstExpressionArrayAccess, 'arr', '[', 'i', ',', 'j', ']'],
            '=',
            [AstExpressionInteger, '123']);
        verify(
            'arr[i][j] = 123.4;',
            [AstExpressionArrayAccess, 'arr', '[', 'i', ']', '[', 'j', ']'],
            '=',
            [AstExpressionReal, '123.4']);
      });

      test('Self-assignment', () {
        verify('var += value;', [AstIdentifier, 'var'], '+=',
            [AstIdentifier, 'value']);
        verify(
            'arr[i] *= arr[j];',
            [AstExpressionArrayAccess, 'arr', '[', 'i', ']'],
            '*=',
            [AstExpressionArrayAccess, 'arr', '[', 'j', ']']);
        verify('flag |= L || R;', [AstIdentifier, 'flag'], '|=',
            [AstExpressionBinary, 'L', '||', 'R']);
      });

      group('Cast -', () {
        test('Simple', () {
          var p = parse('value = bool(1);');
          var cast = ((p.first as AstStatementExpression).expression
                  as AstExpressionAssignment)
              .expression;
          expect(cast, isA<AstExpressionCast>());
          expect(
              cast.getDebugInfo(),
              equals([
                [AstSimpleType, 'bool'],
                [Token, '('],
                [AstExpressionInteger, '1'],
                [Token, ')']
              ]));

          p = parse('value = int[32](test);');
          cast = ((p.first as AstStatementExpression).expression
                  as AstExpressionAssignment)
              .expression;
          expect(cast, isA<AstExpressionCast>());
          expect(
              cast.getDebugInfo(),
              equals([
                [AstSimpleType, 'int', '[', '32', ']'],
                [Token, '('],
                [AstIdentifier, 'test'],
                [Token, ')']
              ]));
        });

        test('Array', () {
          var p = parse('value = bool(list[index]);');
          var cast = ((p.first as AstStatementExpression).expression
                  as AstExpressionAssignment)
              .expression;
          expect(cast, isA<AstExpressionCast>());
          expect(
              cast.getDebugInfo(),
              equals([
                [AstSimpleType, 'bool'],
                [Token, '('],
                [AstExpressionArrayAccess, 'list', '[', 'index', ']'],
                [Token, ')']
              ]));
        });

        test('Function call ', () {
          var p = parse('value = bool(func(arg1, arg2));');
          var cast = ((p.first as AstStatementExpression).expression
                  as AstExpressionAssignment)
              .expression;
          expect(cast, isA<AstExpressionCast>());
          expect(
              cast.getDebugInfo(),
              equals([
                [AstSimpleType, 'bool'],
                [Token, '('],
                [
                  AstExpressionFunctionCall,
                  'func',
                  '(',
                  'arg1',
                  ',',
                  'arg2',
                  ')'
                ],
                [Token, ')']
              ]));
        });
      });

      group('Array -', () {
        test('Value - One dimension', () {
          final p = parse('var={ 1, 3.14, euler};');
          expect(p, hasLength(1));
          expect(p.first, isA<AstStatementExpression>());
          expect(
              (p.first as AstStatementExpression).expression.getDebugInfo(),
              equals([
                [AstIdentifier, 'var'],
                [Token, '='],
                [AstExpressionArray, ...t('{¤1¤,¤3.14¤,¤euler¤}')],
              ]));
        });

        test('Value - Nested', () {
          final p = parse('var={ { 1, π }, {0,ℇ}};');
          expect(p, hasLength(1));
          expect(p.first, isA<AstStatementExpression>());
          expect(
              (p.first as AstStatementExpression).expression.getDebugInfo(),
              equals([
                [AstIdentifier, 'var'],
                [Token, '='],
                [AstExpressionArray, ...t('{¤{¤1¤,¤π¤}¤,¤{¤0¤,¤ℇ¤}¤}')],
              ]));
        });

        test('Item access', () {
          var p = parse('value = list[index];');
          expect(p, hasLength(1));
          expect(p.first, isA<AstStatementExpression>());
          expect(
              (p.first as AstStatementExpression).expression.getDebugInfo(),
              equals([
                [AstIdentifier, 'value'],
                [Token, '='],
                [AstExpressionArrayAccess, 'list', '[', 'index', ']']
              ]));
        });

        test('Target - One dimensional', () {
          final p = parse('list[index]=value;');
          expect(p, hasLength(1));
          expect(p.first, isA<AstStatementExpression>());
          expect(
              (p.first as AstStatementExpression).expression.getDebugInfo(),
              equals([
                [AstExpressionArrayAccess, 'list', '[', 'index', ']'],
                [Token, '='],
                [AstIdentifier, 'value']
              ]));
        });

        test('Target - Multi dimensional', () {
          final p = parse('list[dim1, dim2] = value;');
          expect(p, hasLength(1));
          expect(p.first, isA<AstStatementExpression>());
          expect(
              (p.first as AstStatementExpression).expression.getDebugInfo(),
              equals([
                [AstExpressionArrayAccess, ...t('list¤[¤dim1¤,¤dim2¤]')],
                [Token, '='],
                [AstIdentifier, 'value']
              ]));
        });

        test('Target - Nested', () {
          final p = parse('list[idx1][idx2] = value ;');
          expect(p, hasLength(1));
          expect(p.first, isA<AstStatementExpression>());
          expect(
              (p.first as AstStatementExpression).expression.getDebugInfo(),
              equals([
                [AstExpressionArrayAccess, ...t('list¤[¤idx1¤]¤[¤idx2¤]')],
                [Token, '='],
                [AstIdentifier, 'value']
              ]));
        });
      });

      group('Unary operators -', () {
        test('Plus', () {
          var p = parse('value = +A;');
          expect(p.asText(), equals(['value', '=', '+', 'A', ';']));

          p = parse('value = +1.2345;');
          expect(p.asText(), equals(['value', '=', '+', '1.2345', ';']));
        });

        test('Minus', () {
          var p = parse('value = -A;');
          expect(p.asText(), equals(['value', '=', '-', 'A', ';']));

          p = parse('value = -1.2345;');
          expect(p.asText(), equals(['value', '=', '-', '1.2345', ';']));
        });

        test('Not', () {
          var p = parse('value = !true;');
          expect(p.asText(), equals(['value', '=', '!', 'true', ';']));
        });

        test('Two-complement', () {
          var p = parse('value = ~0b_0010_0011;');
          expect(p.asText(), equals(['value', '=', '~', '0b_0010_0011', ';']));
        });

        test('Multiple', () {
          var p = parse('value = -+~0b_0010_0011;');
          expect(p.asText(),
              equals(['value', '=', '-', '+', '~', '0b_0010_0011', ';']));
          expect(p.first, isA<AstStatementExpression>());
          var expr = ((p.first as AstStatementExpression).expression
                  as AstExpressionAssignment)
              .expression;
          expect(expr, isA<AstExpressionUnary>());
          expect(expr.asText(), equals(['-', '+', '~', '0b_0010_0011']));
          expr = (expr as AstExpressionUnary).expression;
          expect(expr, isA<AstExpressionUnary>());
          expect(expr.asText(), equals(['+', '~', '0b_0010_0011']));
          expr = (expr as AstExpressionUnary).expression;
          expect(expr, isA<AstExpressionUnary>());
          expect(expr.asText(), equals(['~', '0b_0010_0011']));
        });
      });

      group('Parenthesis expressions -', () {
        test('Change precedence', () {
          var p = parse('value = L * (R1 + R2);');
          expect(p, hasLength(1));
          expect(p.first, isA<AstStatementExpression>());
          expect((p.first as AstStatementExpression).expression,
              isA<AstExpressionAssignment>());
          final assignment = (p.first as AstStatementExpression).expression
              as AstExpressionAssignment;
          expect(
              assignment.getDebugInfo(),
              equals([
                [AstIdentifier, 'value'],
                [Token, '='],
                [AstExpressionBinary, 'L', '*', '(', 'R1', '+', 'R2', ')']
              ]));
          expect(
              assignment.expression.getDebugInfo(),
              equals([
                [AstIdentifier, 'L'],
                [Token, '*'],
                [AstExpressionParenthesis, '(', 'R1', '+', 'R2', ')']
              ]));
        });

        test('Nested', () {
          var p = parse('value = (L * (M1 + M2)) * (R1 ^ R2);');
          expect(p, hasLength(1));
          expect(p.first, isA<AstStatementExpression>());
          expect((p.first as AstStatementExpression).expression,
              isA<AstExpressionAssignment>());
          final assignment = (p.first as AstStatementExpression).expression
              as AstExpressionAssignment;
          expect(
              assignment.getDebugInfo(),
              equals([
                [AstIdentifier, 'value'],
                [Token, '='],
                [AstExpressionBinary, ...t('(¤L¤*¤(¤M1¤+¤M2¤)¤)¤*¤(¤R1¤^¤R2¤)')]
              ]));
          expect(
              assignment.expression.getDebugInfo(),
              equals([
                [AstExpressionParenthesis, ...t('(¤L¤*¤(¤M1¤+¤M2¤)¤)')],
                [Token, '*'],
                [AstExpressionParenthesis, '(', 'R1', '^', 'R2', ')']
              ]));
        });
      });
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

extension AstListDebugExt on Iterable<Ast> {
  Iterable<List> getDebugInfo() => map((c) => [c.runtimeType, ...c.asText()]);
}

Iterable<String> t(String code) => code.split('¤');
