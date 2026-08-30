import 'package:qartvm/qartvm.dart';
import 'package:test/test.dart';

void main() {
  group('OpenQASM Interpreter - Basic Tests', () {
    late OpenQASMInterpreter interpreter;

    setUp(() {
      interpreter = OpenQASMInterpreter();
    });

    test('should execute qubit declaration', () async {
      final source = '''
OPENQASM 3.0;
qubit[2] q;
''';
      final program = OpenQASMParser.parse(source);
      final result = await interpreter.execute(program);

      expect(result.quantumMemory, isNotNull);
      expect(result.quantumMemory!.size, equals(2));
    });

    test('should execute classical variable declaration', () async {
      final source = '''
OPENQASM 3.0;
int x = 5;
float y = 3.14;
bool flag = true;
''';
      final program = OpenQASMParser.parse(source);
      final result = await interpreter.execute(program);

      expect(result.classicalVariables['x'], equals(5));
      expect(result.classicalVariables['y'], equals(3.14));
      expect(result.classicalVariables['flag'], equals(true));
    });

    test('should evaluate expressions with literals', () async {
      final source = '''
OPENQASM 3.0;
int a = 10 + 5;
int b = 20 - 3;
int c = 4 * 3;
float d = 10 / 2;
''';
      final program = OpenQASMParser.parse(source);
      final result = await interpreter.execute(program);

      expect(result.classicalVariables['a'], equals(15));
      expect(result.classicalVariables['b'], equals(17));
      expect(result.classicalVariables['c'], equals(12));
      expect(result.classicalVariables['d'], equals(5.0));
    });

    test('should handle variable assignment', () async {
      final source = '''
OPENQASM 3.0;
int x = 10;
x = 20;
x += 5;
''';
      final program = OpenQASMParser.parse(source);
      final result = await interpreter.execute(program);

      expect(result.classicalVariables['x'], equals(25));
    });

    test('should evaluate binary expressions', () async {
      final source = '''
OPENQASM 3.0;
int a = 5;
int b = 3;
int sum = a + b;
int product = a * b;
bool comparison = a > b;
''';
      final program = OpenQASMParser.parse(source);
      final result = await interpreter.execute(program);

      expect(result.classicalVariables['sum'], equals(8));
      expect(result.classicalVariables['product'], equals(15));
      expect(result.classicalVariables['comparison'], equals(true));
    });

    test('should evaluate mathematical constants', () async {
      final source = '''
OPENQASM 3.0;
float pi_val = pi;
float tau_val = tau;
''';
      final program = OpenQASMParser.parse(source);
      final result = await interpreter.execute(program);

      expect(result.classicalVariables['pi_val'], closeTo(3.14159, 0.0001));
      expect(result.classicalVariables['tau_val'], closeTo(6.28318, 0.0001));
    });

    test('should declare constants', () async {
      final source = '''
OPENQASM 3.0;
const int N = 5;
int doubled = N * 2;
''';
      final program = OpenQASMParser.parse(source);
      final result = await interpreter.execute(program);

      expect(result.classicalVariables['doubled'], equals(10));
    });

    test(
      'should resolve runtime-provided variables without const declarations',
      () async {
        final source = '''
OPENQASM 3.0;
int N;
int a;
int result = N * a;
''';
        final program = OpenQASMParser.parse(source);
        final result = await interpreter.execute(
          program,
          initialVariables: {'N': 5, 'a': 7},
        );

        expect(result.classicalVariables['N'], equals(5));
        expect(result.classicalVariables['a'], equals(7));
        expect(result.classicalVariables['result'], equals(35));
      },
    );

    test('should handle bitwise operations', () async {
      final source = '''
OPENQASM 3.0;
int a = 12;
int b = 5;
int and_result = a & b;
int or_result = a | b;
int xor_result = a ^ b;
int shift_left = a << 1;
int shift_right = a >> 1;
''';
      final program = OpenQASMParser.parse(source);
      final result = await interpreter.execute(program);

      expect(result.classicalVariables['and_result'], equals(12 & 5));
      expect(result.classicalVariables['or_result'], equals(12 | 5));
      expect(result.classicalVariables['xor_result'], equals(12 ^ 5));
      expect(result.classicalVariables['shift_left'], equals(12 << 1));
      expect(result.classicalVariables['shift_right'], equals(12 >> 1));
    });
  });
}
