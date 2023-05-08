import 'package:qartvm/qartvm.dart';
import 'package:qartvm/src/openqasm/_token.dart';
import 'package:qartvm/src/openqasm/ast/ast_node.dart';
import 'package:qartvm/src/openqasm/parser/openqasm_parser.dart';
import 'package:test/test.dart';

void main() {
  group('OpenQAsm Parser - Declarations -', () {
    group('Classical -', () {
      void verify<T extends AstType>(
          String code, Iterable<String> type, String name,
          {Iterable? initializer, bool constant = false, bool trace = false}) {
        var p = parse(code, trace: trace);
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementDeclaration>());
        final decl =
            (p.first as AstStatementDeclaration).declaration as AstVariable;
        expect(
            decl.getDebugInfo(),
            equals([
              if (constant) [Token, 'const'],
              [T, ...type],
              [AstIdentifier, name],
              if (initializer != null) ...[
                [Token, '='],
                initializer
              ]
            ]));
      }

      void verifyArray<T extends AstType>(String code,
          Iterable<String> itemType, Iterable<String> dimensions, String name,
          {bool trace = false}) {
        var p = parse(code, trace: trace);
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementDeclaration>());
        final decl =
            (p.first as AstStatementDeclaration).declaration as AstVariable;
        expect(
            decl.getDebugInfo(),
            equals([
              [
                AstArrayType,
                'array',
                '[',
                ...itemType,
                ',',
                ...dimensions,
                ']'
              ],
              [AstIdentifier, name],
            ]));
        final arrayType = decl.type as AstArrayType;
        expect(arrayType.itemType, isA<T>());
        expect(arrayType.itemType.asText(), equals(itemType));
      }

      test('Integer', () {
        verify<AstSimpleType>('int a;', ['int'], 'a');
        verify<AstSimpleType>('int a=12;', ['int'], 'a',
            initializer: [AstExpressionInteger, '12']);
        verify<AstSimpleType>('int[32] a;', ['int', '[', '32', ']'], 'a');
        verify<AstSimpleType>('int[64] a;', ['int', '[', '64', ']'], 'a');

        verify<AstSimpleType>('uint a;', ['uint'], 'a');
        verify<AstSimpleType>('uint[32] a;', ['uint', '[', '32', ']'], 'a');
        verify<AstSimpleType>('uint[64] a;', ['uint', '[', '64', ']'], 'a');

        verify<AstSimpleType>('const int a=12;', ['int'], 'a',
            initializer: [AstExpressionInteger, '12'], constant: true);
      });

      test('Boolean', () {
        verify<AstSimpleType>('bool flag;', ['bool'], 'flag');
        verify<AstSimpleType>('bool flag=true;', ['bool'], 'flag',
            initializer: [AstExpressionConstant, 'true']);
        verify<AstSimpleType>('bool flag=!false;', ['bool'], 'flag',
            initializer: [AstExpressionUnary, '!', 'false']);
        verify<AstSimpleType>('const bool flag=true;', ['bool'], 'flag',
            initializer: [AstExpressionConstant, 'true'], constant: true);
      });

      test('Bit', () {
        verify<AstSimpleType>('bit b;', ['bit'], 'b');
        verify<AstSimpleType>('bit[8] b;', ['bit', '[', '8', ']'], 'b');
        verify<AstSimpleType>(
            'const bit[8] b="11001111";', ['bit', '[', '8', ']'], 'b',
            initializer: [AstExpressionString, '"11001111"'], constant: true);
      });

      test('Real', () {
        verify<AstSimpleType>('float x;', ['float'], 'x');
        verify<AstSimpleType>('float[32] x;', ['float', '[', '32', ']'], 'x');
        verify<AstSimpleType>(
            'const float[32] x=pi;', ['float', '[', '32', ']'], 'x',
            initializer: [AstExpressionConstant, 'pi'], constant: true);
      });

      test('Angle', () {
        verify<AstSimpleType>('angle x;', ['angle'], 'x');
        verify<AstSimpleType>('angle[12] x;', ['angle', '[', '12', ']'], 'x');
      });

      test('Duration', () {
        verify<AstSimpleType>('duration t;', ['duration'], 't');
        verify<AstSimpleType>(
            'const duration one_hour = 3600 s;', ['duration'], 'one_hour',
            initializer: [AstExpressionDuration, '3600 s'], constant: true);
      });

      test('Stretch', () {
        verify<AstSimpleType>('stretch t;', ['stretch'], 't');
      });

      test('Complex', () {
        verify<AstComplexType>('complex c;', ['complex'], 'c');
        verify<AstComplexType>('complex[float[16]] c;',
            ['complex', '[', 'float', '[', '16', ']', ']'], 'c');
        verify<AstComplexType>('const complex[float[16]] c = 0.5 + 0.5 im;',
            ['complex', '[', 'float', '[', '16', ']', ']'], 'c',
            initializer: [AstExpressionBinary, '0.5', '+', '0.5 im'],
            constant: true);
      });

      test('Array', () {
        verifyArray<AstSimpleType>('array[int, 5] a;', ['int'], ['5'], 'a');
        verifyArray<AstSimpleType>(
            'array[float, 5,2] a;', ['float'], ['5', ',', '2'], 'a');
        verifyArray<AstSimpleType>(
            'array[int[32], 5] a;', ['int', '[', '32', ']'], ['5'], 'a');
        verifyArray<AstSimpleType>('array[int[32], 5,2] a;',
            ['int', '[', '32', ']'], ['5', ',', '2'], 'a');
        verifyArray<AstComplexType>(
            'array[complex[float[32]], 5,2] a;',
            ['complex', '[', 'float', '[', '32', ']', ']'],
            ['5', ',', '2'],
            'a');
      });

      test('Alias', () {
        var p = parse('let numbers = { 1, 3, 5, 7} ++ {0, 2, 4, 6};');
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementDeclaration>());
        var decl = (p.first as AstStatementDeclaration).declaration;
        expect(decl, isA<AstAlias>());
        expect(
            decl.getDebugInfo(),
            equals([
              [Token, 'let'],
              [AstIdentifier, 'numbers'],
              [Token, '='],
              [
                AstExpressionSets,
                ...t('{¤1¤,¤3¤,¤5¤,¤7¤}'),
                '++',
                ...t('{¤0¤,¤2¤,¤4¤,¤6¤}')
              ]
            ]));
        var expr = (decl as AstAlias).sets;
        expect(
            expr.getDebugInfo(),
            equals([
              [AstExpressionArray, '{', '1', ',', '3', ',', '5', ',', '7', '}'],
              [AstExpressionArray, '{', '0', ',', '2', ',', '4', ',', '6', '}'],
            ]));

        p = parse('let numbers = {0}++{ 1, 3, 5, 7} ++ { 2, 4, 6};');
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementDeclaration>());
        decl = (p.first as AstStatementDeclaration).declaration;
        expect(decl, isA<AstAlias>());
        expect(
            decl.getDebugInfo(),
            equals([
              [Token, 'let'],
              [AstIdentifier, 'numbers'],
              [Token, '='],
              [
                AstExpressionSets,
                ...t('{¤0¤}'),
                '++',
                ...t('{¤1¤,¤3¤,¤5¤,¤7¤}'),
                '++',
                ...t('{¤2¤,¤4¤,¤6¤}')
              ]
            ]));
        expr = (decl as AstAlias).sets;
        expect(
            expr.getDebugInfo(),
            equals([
              [AstExpressionArray, '{', '0', '}'],
              [AstExpressionArray, '{', '1', ',', '3', ',', '5', ',', '7', '}'],
              [AstExpressionArray, '{', '2', ',', '4', ',', '6', '}'],
            ]));

        p = parse('let numbers = {0}++[1:2:99] ++ [2:2:100];');
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementDeclaration>());
        decl = (p.first as AstStatementDeclaration).declaration;
        expect(decl, isA<AstAlias>());
        expect(
            decl.getDebugInfo(),
            equals([
              [Token, 'let'],
              [AstIdentifier, 'numbers'],
              [Token, '='],
              [
                AstExpressionSets,
                ...t('{¤0¤}'),
                '++',
                ...t('[¤1¤:¤2¤:¤99¤]'),
                '++',
                ...t('[¤2¤:¤2¤:¤100¤]')
              ]
            ]));
        expr = (decl as AstAlias).sets;
        expect(
            expr.getDebugInfo(),
            equals([
              [AstExpressionArray, '{', '0', '}'],
              [AstExpressionRange, '[', '1', ':', '2', ':', '99', ']'],
              [AstExpressionRange, '[', '2', ':', '2', ':', '100', ']'],
            ]));
        final odds = expr[1] as AstExpressionRange;
        expect(odds.slice.start.asText(), equals(['1']));
        expect(odds.slice.end.asText(), equals(['99']));
        expect(odds.slice.incr?.asText(), equals(['2']));

        p = parse('let numbers = {0}++odd ++ even;');
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementDeclaration>());
        decl = (p.first as AstStatementDeclaration).declaration;
        expect(decl, isA<AstAlias>());
        expect(
            decl.getDebugInfo(),
            equals([
              [Token, 'let'],
              [AstIdentifier, 'numbers'],
              [Token, '='],
              [AstExpressionSets, '{', '0', '}', '++', 'odd', '++', 'even']
            ]));
        expr = (decl as AstAlias).sets;
        expect(
            expr.getDebugInfo(),
            equals([
              [AstExpressionArray, '{', '0', '}'],
              [AstIdentifier, 'odd'],
              [AstIdentifier, 'even'],
            ]));

        p = parse('let primes = [0:15][{2, 3, 5, 7, 11, 13}];');
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementDeclaration>());
        decl = (p.first as AstStatementDeclaration).declaration;
        expect(decl, isA<AstAlias>());
        expect(
            decl.getDebugInfo(),
            equals([
              [Token, 'let'],
              [AstIdentifier, 'primes'],
              [Token, '='],
              [
                AstExpressionSets,
                ...t('[¤0¤:¤15¤]¤[¤{¤2¤,¤3¤,¤5¤,¤7¤,¤11¤,¤13¤}¤]')
              ]
            ]));
        expr = (decl as AstAlias).sets;
        expect(
            expr.getDebugInfo(),
            equals([
              [
                AstExpressionArrayAccess,
                ...t('[¤0¤:¤15¤]¤[¤{¤2¤,¤3¤,¤5¤,¤7¤,¤11¤,¤13¤}¤]')
              ]
            ]));

        p = parse('let last = list[-1];');
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementDeclaration>());
        decl = (p.first as AstStatementDeclaration).declaration;
        expect(decl, isA<AstAlias>());
        expect(
            decl.getDebugInfo(),
            equals([
              [Token, 'let'],
              [AstIdentifier, 'last'],
              [Token, '='],
              [AstExpressionSets, 'list', '[', '-', '1', ']']
            ]));
        expr = (decl as AstAlias).sets;
        expect(
            expr.getDebugInfo(),
            equals([
              [AstExpressionArrayAccess, 'list', '[', '-', '1', ']']
            ]));

        p = parse('let first_two = list[0:1];');
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementDeclaration>());
        decl = (p.first as AstStatementDeclaration).declaration;
        expect(decl, isA<AstAlias>());
        expect(
            decl.getDebugInfo(),
            equals([
              [Token, 'let'],
              [AstIdentifier, 'first_two'],
              [Token, '='],
              [AstExpressionSets, 'list', '[', '0', ':', '1', ']']
            ]));
        expr = (decl as AstAlias).sets;
        expect(
            expr.getDebugInfo(),
            equals([
              [AstExpressionArrayAccess, 'list', '[', '0', ':', '1', ']']
            ]));

        p = parse('let last_three = list[-4:-1];');
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementDeclaration>());
        decl = (p.first as AstStatementDeclaration).declaration;
        expect(decl, isA<AstAlias>());
        expect(
            decl.getDebugInfo(),
            equals([
              [Token, 'let'],
              [AstIdentifier, 'last_three'],
              [Token, '='],
              [AstExpressionSets, 'list', '[', '-', '4', ':', '-', '1', ']']
            ]));
        expr = (decl as AstAlias).sets;
        expect(
            expr.getDebugInfo(),
            equals([
              [AstExpressionArrayAccess, ...t('list¤[¤-¤4¤:¤-¤1¤]')]
            ]));
      });

      test('Register', () {
        var p = parse('creg data[8];');
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementDeclaration>());
        var decl =
            (p.first as AstStatementDeclaration).declaration as AstRegister;
        expect(
            decl.getDebugInfo(),
            equals([
              [Token, 'creg'],
              [AstIdentifier, 'data'],
              [AstDesignator, '[', '8', ']']
            ]));

        p = parse('creg data;');
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementDeclaration>());
        decl = (p.first as AstStatementDeclaration).declaration as AstRegister;
        expect(
            decl.getDebugInfo(),
            equals([
              [Token, 'creg'],
              [AstIdentifier, 'data']
            ]));
      });
    });

    group('Quantum -', () {
      void verify(String code, Iterable<String> type, String name,
          {bool trace = false}) {
        var p = parse(code, trace: trace);
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementDeclaration>());
        final decl =
            (p.first as AstStatementDeclaration).declaration as AstQubit;
        expect(
            decl.getDebugInfo(),
            equals([
              [AstQuantumType, ...type],
              [AstIdentifier, name],
            ]));
      }

      test('Qubit', () {
        verify('qubit q;', ['qubit'], 'q');
        verify('qubit[7] q;', ['qubit', '[', '7', ']'], 'q');
      });

      test('Register', () {
        var p = parse('qreg qb[8];');
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementDeclaration>());
        var decl =
            (p.first as AstStatementDeclaration).declaration as AstRegister;
        expect(
            decl.getDebugInfo(),
            equals([
              [Token, 'qreg'],
              [AstIdentifier, 'qb'],
              [AstDesignator, '[', '8', ']']
            ]));

        p = parse('qreg qb;');
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementDeclaration>());
        decl = (p.first as AstStatementDeclaration).declaration as AstRegister;
        expect(
            decl.getDebugInfo(),
            equals([
              [Token, 'qreg'],
              [AstIdentifier, 'qb']
            ]));
      });
    });

    group('Function -', () {
      test('No argument, without type', () {
        final p = parse('def zero() { return;}');
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementDefinition>());
        expect(
            (p.first as AstStatementDefinition).definition, isA<AstFunction>());
        final fn =
            (p.first as AstStatementDefinition).definition as AstFunction;
        expect(fn.identifier.asText(), equals(['zero']));
        expect(fn.parameters, isEmpty);
        expect(fn.type, isNull);
        expect(
            fn.getDebugInfo(),
            equals([
              [Token, 'def'],
              [AstIdentifier, 'zero'],
              [Token, '('],
              [Token, ')'],
              [AstBlock, '{', 'return', ';', '}']
            ]));
      });

      test('No argument, with type', () {
        var p = parse('def zero() -> int { return 0;}');
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementDefinition>());
        expect(
            (p.first as AstStatementDefinition).definition, isA<AstFunction>());
        var fn = (p.first as AstStatementDefinition).definition as AstFunction;
        expect(fn.identifier.asText(), equals(['zero']));
        expect(fn.parameters, isEmpty);
        expect(fn.type, isNotNull);
        expect(fn.type!.asText(), ['int']);
        expect(
            fn.getDebugInfo(),
            equals([
              [Token, 'def'],
              [AstIdentifier, 'zero'],
              [Token, '('],
              [Token, ')'],
              [Token, '->'],
              [AstSimpleType, 'int'],
              [AstBlock, '{', 'return', '0', ';', '}']
            ]));

        p = parse('def zero() -> uint[8] { return 0;}');
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementDefinition>());
        expect(
            (p.first as AstStatementDefinition).definition, isA<AstFunction>());
        fn = (p.first as AstStatementDefinition).definition as AstFunction;
        expect(fn.identifier.asText(), equals(['zero']));
        expect(fn.parameters, isEmpty);
        expect(fn.type, isNotNull);
        expect(fn.type!.asText(), ['uint', '[', '8', ']']);
        expect(
            fn.getDebugInfo(),
            equals([
              [Token, 'def'],
              [AstIdentifier, 'zero'],
              [Token, '('],
              [Token, ')'],
              [Token, '->'],
              [AstSimpleType, 'uint', '[', '8', ']'],
              [AstBlock, '{', 'return', '0', ';', '}']
            ]));
      });

      test('2 arguments, with type', () {
        var p = parse('def add(int a,int b) -> int { return a+b;}');
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementDefinition>());
        expect(
            (p.first as AstStatementDefinition).definition, isA<AstFunction>());
        var fn = (p.first as AstStatementDefinition).definition as AstFunction;
        expect(fn.identifier.asText(), equals(['add']));
        expect(fn.parameters, hasLength(2));
        expect(
            fn.parameters[0].getDebugInfo(),
            equals([
              [AstSimpleType, 'int'],
              [AstIdentifier, 'a']
            ]));
        expect(
            fn.parameters[1].getDebugInfo(),
            equals([
              [AstSimpleType, 'int'],
              [AstIdentifier, 'b']
            ]));
        expect(fn.type, isNotNull);
        expect(fn.type!.asText(), ['int']);
        expect(
            fn.getDebugInfo(),
            equals([
              [Token, 'def'],
              [AstIdentifier, 'add'],
              [Token, '('],
              [AstVariable, 'int', 'a'],
              [Token, ','],
              [AstVariable, 'int', 'b'],
              [Token, ')'],
              [Token, '->'],
              [AstSimpleType, 'int'],
              [AstBlock, '{', 'return', 'a', '+', 'b', ';', '}']
            ]));

        p = parse('def add(uint[8] a,uint[8] b) -> uint[9] { return a+b;}');
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementDefinition>());
        expect(
            (p.first as AstStatementDefinition).definition, isA<AstFunction>());
        fn = (p.first as AstStatementDefinition).definition as AstFunction;
        expect(fn.identifier.asText(), equals(['add']));
        expect(fn.parameters, hasLength(2));
        expect(
            fn.parameters[0].getDebugInfo(),
            equals([
              [AstSimpleType, 'uint', '[', '8', ']'],
              [AstIdentifier, 'a']
            ]));
        expect(
            fn.parameters[1].getDebugInfo(),
            equals([
              [AstSimpleType, 'uint', '[', '8', ']'],
              [AstIdentifier, 'b']
            ]));
        expect(fn.type, isNotNull);
        expect(fn.type!.asText(), ['uint', '[', '9', ']']);
        expect(
            fn.getDebugInfo(),
            equals([
              [Token, 'def'],
              [AstIdentifier, 'add'],
              [Token, '('],
              [AstVariable, 'uint', '[', '8', ']', 'a'],
              [Token, ','],
              [AstVariable, 'uint', '[', '8', ']', 'b'],
              [Token, ')'],
              [Token, '->'],
              [AstSimpleType, 'uint', '[', '9', ']'],
              [AstBlock, '{', 'return', 'a', '+', 'b', ';', '}']
            ]));
      });
    });

    group('Gate -', () {
      test('Bell', () {
        final p = parse('gate bell q1, q2 { h q1; ctrl (q1) @ x q2; }');
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementDefinition>());
        expect((p.first as AstStatementDefinition).definition, isA<AstGate>());
        final gate = (p.first as AstStatementDefinition).definition as AstGate;
        expect(gate.identifier.asText(), equals(['bell']));
        expect(gate.parameters, isEmpty);
        expect(gate.qubits, hasLength(2));
        expect(gate.qubits.getDebugInfo(), [
          [AstIdentifier, 'q1'],
          [AstIdentifier, 'q2']
        ]);
        expect(
            gate.getDebugInfo(),
            equals([
              [Token, 'gate'],
              [AstIdentifier, 'bell'],
              [AstIdentifier, 'q1'],
              [Token, ','],
              [AstIdentifier, 'q2'],
              [AstBlock, ...t('{¤h¤q1¤;¤ctrl¤(¤q1¤)¤@¤x¤q2¤;¤}')]
            ]));
      });

      test('Unitary definition', () {
        final p = parse('''
          gate CX a, b {
            ctrl @ U(π, 0, π) a, b;
          }''');
        expect(p, hasLength(1));
        expect(p.first, isA<AstStatementDefinition>());
        expect((p.first as AstStatementDefinition).definition, isA<AstGate>());
        final gate = (p.first as AstStatementDefinition).definition as AstGate;
        expect(gate.identifier.asText(), equals(['CX']));
        expect(gate.parameters, isEmpty);
        expect(gate.qubits, hasLength(2));
        expect(gate.qubits.getDebugInfo(), [
          [AstIdentifier, 'a'],
          [AstIdentifier, 'b']
        ]);
        expect(gate.body.first, isA<AstStatementExpression>());
        final expr = (gate.body.first as AstStatementExpression).expression;
        expect(
            expr.getDebugInfo(),
            equals([
              [AstModifier, 'ctrl', '@'],
              [AstIdentifier, 'U'],
              [AstExpressionArguments, '(', 'π', ',', '0', ',', 'π', ')'],
              [AstIdentifier, 'a'],
              [Token, ','],
              [AstIdentifier, 'b']
            ]));
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

extension AstDebugExt on dynamic {
  Iterable<List> getDebugInfo() => (this is Iterable<Ast>)
      ? (this as Iterable<Ast>).map((c) => [c.runtimeType, ...c.asText()])
      : (this is Ast)
          ? (this as Ast)
              .getChildren()
              .map((c) => [c.runtimeType, ...c.asText()])
          : [];
}

// extension AstListDebugExt on Iterable<Ast> {
//   Iterable<List> getDebugInfo() => map((c) => [c.runtimeType, ...c.asText()]);
// }

Iterable<String> t(String code) => code.split('¤');
