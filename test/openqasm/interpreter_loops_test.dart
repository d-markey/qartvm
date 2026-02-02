import 'package:test/test.dart';
import 'package:qartvm/qartvm.dart';

void main() {
  group('OpenQASM Interpreter - Loops', () {
    late OpenQASMInterpreter interpreter;

    setUp(() {
      interpreter = OpenQASMInterpreter();
    });

    test('For Loop (Range)', () {
      final source = '''
        OPENQASM 3.0;
        int result = 0;
        for int i in [1:5] {
          result += i;
        }
      ''';
      final program = OpenQASMParser.parse(source);
      final result = interpreter.execute(program);

      // 1 + 2 + 3 + 4 = 10
      expect(result.classicalVariables['result'], equals(10));
    });

    test('For Loop (Nested)', () {
      final source = '''
        OPENQASM 3.0;
        int result = 0;
        for int i in [1:3] {
          for int j in [1:4] {
            result += 1;
          }
        }
      ''';
      final program = OpenQASMParser.parse(source);
      final result = interpreter.execute(program);

      // 2 * 3 = 6
      expect(result.classicalVariables['result'], equals(6));
    });

    test('While Loop', () {
      final source = '''
        OPENQASM 3.0;
        int i = 0;
        int result = 0;
        while (i < 5) {
          result += i;
          i += 1;
        }
      ''';
      final program = OpenQASMParser.parse(source);
      final result = interpreter.execute(program);

      // 0 + 1 + 2 + 3 + 4 = 10
      expect(result.classicalVariables['result'], equals(10));
      expect(result.classicalVariables['i'], equals(5));
    });

    test('Loop with Break', () {
      final source = '''
        OPENQASM 3.0;
        int result = 0;
        for int i in [1:10] {
          if (i == 5) {
            break;
          }
          result += i;
        }
      ''';
      final program = OpenQASMParser.parse(source);
      final result = interpreter.execute(program);

      // 1 + 2 + 3 + 4 = 10
      expect(result.classicalVariables['result'], equals(10));
    });

    test('Loop with Continue', () {
      final source = '''
        OPENQASM 3.0;
        int result = 0;
        for int i in [1:6] {
          if (i == 3) {
            continue;
          }
          result += i;
        }
      ''';
      final program = OpenQASMParser.parse(source);
      final result = interpreter.execute(program);

      // 1 + 2 + 4 + 5 = 12
      expect(result.classicalVariables['result'], equals(12));
    });

    test('Quantum Operations in Loop', () {
      final source = '''
        OPENQASM 3.0;
        qubit[5] q;
        for int i in [0:5] {
          h q[i];
        }
      ''';
      final program = OpenQASMParser.parse(source);
      final result = interpreter.execute(program);

      expect(result.quantumMemory, isNotNull);
      expect(result.quantumMemory!.size, equals(5));
      // Each qubit should be in |+> state
      for (int i = 0; i < 5; i++) {
        expect(
          result.quantumMemory!.getPropability(
            List.generate(5, (j) => j == i ? '0' : '.').join(),
          ),
          closeTo(0.5, 0.01),
        );
      }
    });

    test('Pre-scan with nested blocks', () {
      // Test that pre-scan correctly finds qubits declared inside blocks
      final source = '''
        OPENQASM 3.0;
        int cond = 1;
        if (cond == 0) {
          qubit q1;
        }
        qubit[2] q2;
        for int i in [0:10] {
          // pre-scan should NOT multiply this by 10 (it only visits the AST nodes)
          x q2[0];
        }
      ''';
      // Total qubits: 1 (q1) + 2 (q2) = 3
      final program = OpenQASMParser.parse(source);
      final result = interpreter.execute(program);

      expect(result.quantumMemory, isNotNull);
      expect(result.quantumMemory!.size, equals(3));
    });
  });
}
