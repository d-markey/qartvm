import 'package:qartvm/qartvm.dart';
import 'package:test/test.dart';

void main() {
  group('OpenQASM Interpreter - Assignment Operations', () {
    late OpenQASMInterpreter interpreter;

    setUp(() {
      interpreter = OpenQASMInterpreter();
    });

    test('should perform simple variable assignment', () async {
      final source = '''
OPENQASM 3.0;
int x = 5;
x = 10;
''';
      final program = OpenQASMParser.parse(source);
      final result = await interpreter.execute(program);

      expect(result.classicalVariables['x'], equals(10));
    });

    test('should initialize arrays properly', () async {
      final source = '''
OPENQASM 3.0;
int[3] arr;
int x = 1;
''';
      final program = OpenQASMParser.parse(source);
      final result = await interpreter.execute(program);

      // Check that arr is actually a list
      final arr = result.classicalVariables['arr'];
      expect(arr, isA<List>());
      expect(arr, isNotEmpty);
    });

    test('should perform compound operator assignment +=', () async {
      final source = '''
OPENQASM 3.0;
int x = 5;
x += 3;
''';
      final program = OpenQASMParser.parse(source);
      final result = await interpreter.execute(program);

      expect(result.classicalVariables['x'], equals(8));
    });

    test('should perform compound operator assignment -=', () async {
      final source = '''
OPENQASM 3.0;
int x = 10;
x -= 3;
''';
      final program = OpenQASMParser.parse(source);
      final result = await interpreter.execute(program);

      expect(result.classicalVariables['x'], equals(7));
    });

    test('should perform compound operator assignment *=', () async {
      final source = '''
OPENQASM 3.0;
int x = 5;
x *= 2;
''';
      final program = OpenQASMParser.parse(source);
      final result = await interpreter.execute(program);

      expect(result.classicalVariables['x'], equals(10));
    });

    test('should perform indexed array assignment', () async {
      final source = '''
OPENQASM 3.0;
int[3] arr;
arr[0] = 10;
arr[1] = 20;
arr[2] = 30;
''';
      final program = OpenQASMParser.parse(source);
      final result = await interpreter.execute(program);

      final arr = result.classicalVariables['arr'] as List<dynamic>;
      expect(arr[0], equals(10));
      expect(arr[1], equals(20));
      expect(arr[2], equals(30));
    });

    test('should perform indexed array compound assignment +=', () async {
      final source = '''
OPENQASM 3.0;
int[3] arr;
arr[0] = 5;
arr[1] = 10;
arr[2] = 15;
arr[1] += 5;
''';
      final program = OpenQASMParser.parse(source);
      final result = await interpreter.execute(program);

      final arr = result.classicalVariables['arr'] as List<dynamic>;
      expect(arr[0], equals(5));
      expect(arr[1], equals(15));
      expect(arr[2], equals(15));
    });

    test('should perform indexed array compound assignment -=', () async {
      final source = '''
OPENQASM 3.0;
int[3] arr;
arr[0] = 10;
arr[1] = 20;
arr[2] = 30;
arr[1] -= 5;
''';
      final program = OpenQASMParser.parse(source);
      final result = await interpreter.execute(program);

      final arr = result.classicalVariables['arr'] as List<dynamic>;
      expect(arr[1], equals(15));
    });

    test('should perform indexed array compound assignment *=', () async {
      final source = '''
OPENQASM 3.0;
int[3] arr;
arr[0] = 2;
arr[1] = 3;
arr[2] = 4;
arr[1] *= 5;
''';
      final program = OpenQASMParser.parse(source);
      final result = await interpreter.execute(program);

      final arr = result.classicalVariables['arr'] as List<dynamic>;
      expect(arr[1], equals(15));
    });

    test('should perform indexed assignment with variable index', () async {
      final source = '''
OPENQASM 3.0;
int[3] arr;
int idx = 1;
arr[0] = 10;
arr[1] = 20;
arr[2] = 30;
arr[idx] = 99;
''';
      final program = OpenQASMParser.parse(source);
      final result = await interpreter.execute(program);

      final arr = result.classicalVariables['arr'] as List<dynamic>;
      expect(arr[0], equals(10));
      expect(arr[1], equals(99));
      expect(arr[2], equals(30));
    });

    test('should perform indexed assignment in for loop', () async {
      final source = '''
OPENQASM 3.0;
int[4] arr;
for int i in [0:4] {
  arr[i] = i * 10;
}
''';
      final program = OpenQASMParser.parse(source);
      final result = await interpreter.execute(program);

      final arr = result.classicalVariables['arr'] as List<dynamic>;
      expect(arr[0], equals(0));
      expect(arr[1], equals(10));
      expect(arr[2], equals(20));
      expect(arr[3], equals(30));
    });

    test('should perform multiple indexed array assignments', () async {
      final source = '''
OPENQASM 3.0;
int[4] arr;
arr[0] = 10;
arr[1] = 20;
arr[2] = 30;
arr[3] = 40;
arr[0] = 100;
arr[2] -= 5;
arr[3] *= 2;
''';
      final program = OpenQASMParser.parse(source);
      final result = await interpreter.execute(program);

      final arr = result.classicalVariables['arr'] as List<dynamic>;
      expect(arr[0], equals(100));
      expect(arr[1], equals(20));
      expect(arr[2], equals(25));
      expect(arr[3], equals(80));
    });
  });
}
