import 'package:qartvm/qartvm.dart';
import 'package:test/test.dart';

void main() {
  group('OpenQASM Interpreter - Measurement Extraction', () {
    late OpenQASMInterpreter interpreter;

    setUp(() {
      interpreter = OpenQASMInterpreter();
    });

    test('should extract single qubit measurement', () async {
      final source = '''
OPENQASM 3.0;
qubit[2] q;
bit[2] c;
c[0] = measure q[0];
''';
      final program = OpenQASMParser.parse(source);
      final result = await interpreter.execute(program);

      expect(result.measurements, isNotEmpty);
      expect(result.measurements.containsKey('q[0]'), isTrue);
      // Value is 0 because initial state is |0>
      expect(result.measurements['q[0]'], equals(0));
    });

    test('should extract register measurement', () async {
      final source = '''
OPENQASM 3.0;
qubit[2] q;
bit[2] c;
c = measure q;
''';
      final program = OpenQASMParser.parse(source);
      final result = await interpreter.execute(program);

      // When measuring a register 'q' of size 2, we might expect entries for q[0] and q[1],
      // OR a single entry 'q' with integer value.
      // Based on typical QASM behavior, we probably want individual qubit results if possible,
      // or the register value.
      // The current implementation plan suggests using the expression text as key.
      // "measure q" -> key "q", value integer.

      expect(result.measurements.containsKey('q'), isTrue);
      expect(result.measurements['q'], equals(0));
    });

    test('should extract measurement with gates applied', () async {
      final source = '''
OPENQASM 3.0;
include "stdgates.inc";
qubit q;
bit c;
x q;
c = measure q;
''';
      final program = OpenQASMParser.parse(source);
      final result = await interpreter.execute(program);

      expect(result.measurements['q'], equals(1));
    });
  });
}
