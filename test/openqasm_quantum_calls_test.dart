import 'package:qartvm/qartvm.dart';
import 'package:qartvm/src/openqasm/_token.dart';
import 'package:qartvm/src/openqasm/ast/ast_node.dart';
import 'package:qartvm/src/openqasm/parser/openqasm_parser.dart';
import 'package:test/test.dart';

void main() {
  group('OpenQAsm Parser - Quantum Calls -', () {
    test('reset', () {
      final p = parse('reset \$0;');
      expect(p, hasLength(1));
      expect(p.first, isA<AstStatementExpression>());
      expect((p.first as AstStatementExpression).expression,
          isA<AstExpressionGateCall>());
      final gateCall = (p.first as AstStatementExpression).expression
          as AstExpressionGateCall;
      expect(gateCall.gate.asText(), equals(['reset']));
      expect(gateCall.arguments, isNull);
      expect(gateCall.qubits, hasLength(1));
      expect(gateCall.qubits.first.asText(), equals(['\$0']));
      expect(
          gateCall.getDebugInfo(),
          equals([
            [AstIdentifier, 'reset'],
            [AstExpressionPhysicalQubit, '\$0']
          ]));
    });

    test('measure', () {
      final p = parse('measure \$0;');
      expect(p, hasLength(1));
      expect(p.first, isA<AstStatementExpression>());
      expect((p.first as AstStatementExpression).expression,
          isA<AstExpressionMeasureCall>());
      final measureCall = (p.first as AstStatementExpression).expression
          as AstExpressionMeasureCall;
      expect(measureCall.assignee, isNull);
      expect(measureCall.qubit.asText(), equals(['\$0']));
      expect(
          measureCall.getDebugInfo(),
          equals([
            [AstIdentifier, 'measure'],
            [AstExpressionPhysicalQubit, '\$0']
          ]));
    });

    test('measure arrow assignment', () {
      final p = parse('measure \$12 -> register[i];');
      expect(p, hasLength(1));
      expect(p.first, isA<AstStatementExpression>());
      expect((p.first as AstStatementExpression).expression,
          isA<AstExpressionMeasureCall>());
      final measureCall = (p.first as AstStatementExpression).expression
          as AstExpressionMeasureCall;
      expect(measureCall.assignee, isNotNull);
      expect(
          measureCall.assignee!.asText(), equals(['register', '[', 'i', ']']));
      expect(measureCall.qubit.asText(), equals(['\$12']));
      expect(
          measureCall.getDebugInfo(),
          equals([
            [AstIdentifier, 'measure'],
            [AstExpressionPhysicalQubit, '\$12'],
            [Token, '->'],
            [AstExpressionArrayAccess, 'register', '[', 'i', ']'],
          ]));
    });

    test('measure assignment', () {
      final p = parse('x = measure \$12;');
      expect(p, hasLength(1));
      expect(p.first, isA<AstStatementExpression>());
      expect((p.first as AstStatementExpression).expression,
          isA<AstExpressionAssignment>());
      final assignment = (p.first as AstStatementExpression).expression
          as AstExpressionAssignment;
      expect(assignment.assignee.asText(), equals(['x']));
      expect(assignment.expression.asText(), equals(['measure', '\$12']));
      expect(
          assignment.getDebugInfo(),
          equals([
            [AstIdentifier, 'x'],
            [Token, '='],
            [AstExpressionMeasureCall, 'measure', '\$12']
          ]));
    });

    test('Hadamard', () {
      final p = parse('h qb[2];');
      expect(p, hasLength(1));
      expect(p.first, isA<AstStatementExpression>());
      expect((p.first as AstStatementExpression).expression,
          isA<AstExpressionGateCall>());
      final gateCall = (p.first as AstStatementExpression).expression
          as AstExpressionGateCall;
      expect(gateCall.gate.asText(), equals(['h']));
      expect(gateCall.arguments, isNull);
      expect(gateCall.modifiers, isEmpty);
      expect(gateCall.designator, isNull);
      expect(gateCall.qubits, hasLength(1));
      expect(gateCall.qubits.first.asText(), equals(['qb', '[', '2', ']']));
      expect(
          gateCall.getDebugInfo(),
          equals([
            [AstIdentifier, 'h'],
            [AstExpressionArrayAccess, 'qb', '[', '2', ']']
          ]));
    });

    test('Box', () {
      final p = parse('''
        rx(2*π/12) q;
        box {
            delay[ddt] q;
            x q;
            delay[ddt] q;
            x q;
            delay[ddt] q;
        }
        rx(3*π/12) q;
      ''');
      expect(p, hasLength(3));
    });

    test('Control', () {
      var p = parse('ctrl (\$0) @ h \$1;');
      expect(p, hasLength(1));

      p = parse('negctrl (\$0) @ h \$1;');
      expect(p, hasLength(1));
    });

    test('Power', () {
      final p = parse('pow(4) @ h \$1;');
      expect(p, hasLength(1));
    });

    test('Inverse', () {
      final p = parse('inv @ h \$1;');
      expect(p, hasLength(1));
    });

    test('Inverse + control', () {
      final p = parse('inv @ ctrl (\$0) @ h \$1;');
      expect(p, hasLength(1));
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
