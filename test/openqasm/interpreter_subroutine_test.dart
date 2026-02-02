import 'package:test/test.dart';
import 'package:qartvm/src/openqasm/openqasm_interpreter.dart';
import 'package:qartvm/src/openqasm/openqasm_parser.dart';

void main() {
  group('Subroutine Execution', () {
    late OpenQASMInterpreter interpreter;

    setUp(() {
      interpreter = OpenQASMInterpreter();
    });

    test('Void subroutine side effects', () {
      final source = '''
      OPENQASM 3.0;
      int[32] g = 0;
      def set_g() {
        g = 1;
      }
      set_g();
      ''';
      final result = interpreter.execute(OpenQASMParser.parse(source));
      expect(result.classicalVariables['g'], 1);
    });

    test('Subroutine with return value', () {
      final source = '''
      OPENQASM 3.0;
      def get_val() -> int[32] {
        return 42;
      }
      int[32] x = get_val();
      ''';
      final result = interpreter.execute(OpenQASMParser.parse(source));
      expect(result.classicalVariables['x'], 42);
    });

    test('Subroutine with arguments', () {
      final source = '''
      OPENQASM 3.0;
      def add(int[32] a, int[32] b) -> int[32] {
        return a + b;
      }
      int[32] result = add(10, 20);
      ''';
      final result = interpreter.execute(OpenQASMParser.parse(source));
      expect(result.classicalVariables['result'], 30);
    });

    test('Variable shadowing', () {
      final source = '''
      OPENQASM 3.0;
      int[32] x = 10;
      def modify_local() {
        int[32] x = 20;
      }
      modify_local();
      ''';
      final result = interpreter.execute(OpenQASMParser.parse(source));
      expect(result.classicalVariables['x'], 10);
    });

    test('Early return', () {
      final source = '''
      OPENQASM 3.0;
      def my_abs(int[32] n) -> int[32] {
        if (n < 0) {
           return -n;
        }
        return n;
      }
      int[32] a = my_abs(-5);
      int[32] b = my_abs(5);
      ''';
      final result = interpreter.execute(OpenQASMParser.parse(source));
      expect(result.classicalVariables['a'], 5);
      expect(result.classicalVariables['b'], 5);
    });
    test('Return in for loop inside subroutine', () {
      final source = '''
      OPENQASM 3.0;
      def loop_return() -> int[32] {
        int[32] i;
        for i in [0:5] {
          return 42;
        }
        return 0;
      }
      int[32] x = loop_return();
      ''';
      final result = interpreter.execute(OpenQASMParser.parse(source));
      expect(result.classicalVariables['x'], 42);
    });

    test('Return in while loop inside subroutine', () {
      final source = '''
      OPENQASM 3.0;
      def loop_return() -> int[32] {
        int[32] i = 0;
        while (i < 5) {
          return 99;
        }
        return 0;
      }
      int[32] x = loop_return();
      ''';
      final result = interpreter.execute(OpenQASMParser.parse(source));
      expect(result.classicalVariables['x'], 99);
    });
  });
}
