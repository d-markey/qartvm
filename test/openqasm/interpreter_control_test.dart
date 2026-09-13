import 'package:qartvm/qartvm.dart';
import 'package:test/test.dart';

void main() {
  group('OpenQASM Interpreter - Control Flow & Measurement', () {
    late OpenQASMInterpreter interpreter;

    setUp(() {
      interpreter = OpenQASMInterpreter();
    });

    test('Measurement Statement (measure q -> c)', () async {
      final source = '''
        OPENQASM 3.0;
        include "stdgates.inc";
        qubit q;
        bit c;
        x q;
        measure q -> c;
      ''';
      final program = OpenQASMParser.parse(source);
      final result = (await interpreter.execute(program))[0];

      expect(result.quantumMemory, isNotNull);
      expect(result.classicalVariables['c'], equals(1));
    });

    test('Measurement Assignment (c = measure q)', () async {
      final source = '''
        OPENQASM 3.0;
        include "stdgates.inc";
        qubit q;
        bit c;
        x q;
        c = measure q;
      ''';
      final program = OpenQASMParser.parse(source);
      final result = (await interpreter.execute(program))[0];

      expect(result.classicalVariables['c'], equals(1));
    });

    test('Reset Statement', () async {
      final source = '''
        OPENQASM 3.0;
        include "stdgates.inc";
        qubit q;
        x q;
        reset q;
      ''';
      final program = OpenQASMParser.parse(source);
      final result = (await interpreter.execute(program))[0];

      // After reset, measuring should give 0
      final qmem = result.quantumMemory!;
      expect(qmem.read(qbits: [0]), equals(0));
    });

    test('If Statement (True Condition)', () async {
      final source = '''
        OPENQASM 3.0;
        include "stdgates.inc";
        qubit q;
        bit c = 1;
        if (c == 1) {
          x q;
        }
      ''';
      final program = OpenQASMParser.parse(source);
      final result = (await interpreter.execute(program))[0];

      final qmem = result.quantumMemory!;
      expect(qmem.read(qbits: [0]), equals(1));
    });

    test('If Statement (False Condition)', () async {
      final source = '''
        OPENQASM 3.0;
        include "stdgates.inc";
        qubit q;
        bit c = 0;
        if (c == 1) {
          x q;
        }
      ''';
      final program = OpenQASMParser.parse(source);
      final result = (await interpreter.execute(program))[0];

      final qmem = result.quantumMemory!;
      expect(qmem.read(qbits: [0]), equals(0));
    });

    test('If-Else Statement', () async {
      final source = '''
        OPENQASM 3.0;
        int c = 0;
        int result = 0;
        if (c == 1) {
          result = 1;
        } else {
          result = 2;
        }
      ''';
      final result = (await interpreter.execute(
        OpenQASMParser.parse(source),
      ))[0];
      expect(result.classicalVariables['result'], equals(2));

      final source2 = '''
        OPENQASM 3.0;
        int c = 0;
        int result = 0;
        if (c == 0) {
          result = 1;
        } else {
          result = 2;
        }
      ''';
      final result2 = (await interpreter.execute(
        OpenQASMParser.parse(source2),
      ))[0];
      expect(result2.classicalVariables['result'], equals(1));
    });

    test('Complex Control Flow: Conditional Gate after Measurement', () async {
      final source = '''
        OPENQASM 3.0;
        include "stdgates.inc";
        qubit q0;
        qubit q1;
        bit b;
        
        h q0;
        b = measure q0;
        
        if (b == 1) {
          x q1;
        }
      ''';
      final program = OpenQASMParser.parse(source);
      final result = (await interpreter.execute(program))[0];

      final qmem = result.quantumMemory!;
      final b = result.classicalVariables['b'];
      final q1 = qmem.read(qbits: [1]);

      expect(q1, equals(b));
    });
  });
}
