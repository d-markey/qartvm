import 'dart:math' as math;
import 'package:antlr4/antlr4.dart';
import 'package:qartvm/src/openqasm/antlr4/interpreter/qasm_interpreter.dart';
import 'package:qartvm/src/openqasm/antlr4/parser/OpenQASM3Lexer.dart';
import 'package:qartvm/src/openqasm/antlr4/parser/OpenQASM3Parser.dart';

void main() {
  OpenQASM3Lexer.checkVersion();
  OpenQASM3Parser.checkVersion();
  final input = InputStream.fromString('''
  input string label;
  input int n;
  input angle x;
  input complex y;
  input complex z;
  output angle out;
  print(label);
  print();
  print("n = ", n);
  print("x = ", x);
  print("y = ", y);
  print("z = ", z);
  print();
  print("   x * y = ", x * y);
  print("   y * x = ", y * x);
  print("   x * n = ", x * n);
  print("   n * x = ", n * x);
  print();
  print("   y + z = ", y + z);
  print("   y - z = ", y - z);
  print("   y * z = ", y * z);
  print("   y / z = ", y / z);
  print("   y ** z = ", y ** z);
  print();
  print("   exp(y) = ", exp(y));
  print("   log(y) = ", log(y));
  print("   exp(log(y)) = ", exp(log(y)));
  print("   log(exp(y)) = ", log(exp(y)));
  print("   exp(z) = ", exp(z));
  print("   log(z) = ", log(z));
  print("   exp(log(z)) = ", exp(log(z)));
  print("   log(exp(z)) = ", log(exp(z)));
  print();
  print("   sqrt(y) = ", sqrt(y));
  //print("   pow(y, 2) = ", pow(y, 2));
  //print("   pow(sqrt(z), 2) = ", pow(sqrt(z), 2));
  //print("   sqrt(pow(z, 2)) = ", sqrt(pow(z, 2)));
  print();
  out = angle(y);
  z=y;
  print("y = ", y);
  print("z = ", z);
  while (n > 0) {
    print("n = ", n);
    if (n == 3) { break; }
    n -= 1;
  }
  for int i in {2, 3, 5, 7, 11, 13, 17} {
    print("i = ", i);
  }
  for int i in [0:2:8] {
    print("i = ", i);
  }
  for int i in [0:8] {
    int a = 0;
    print("i = ", i);
    print("a = ", a);
  }

  array[int, 6] test = { 1, {2, 3}, 4, 5, {6, 7} };

  array[float[64], 4] my_floats = {1.2, -3.4, 0.5, 9.8};
  for float[64] f in my_floats {
    print("f = ", f);
  }
  bit[4] flags = "0110";
  print("flags = ", flags);
''');
  final lexer = OpenQASM3Lexer(input);
  final tokens = CommonTokenStream(lexer);
  final parser = OpenQASM3Parser(tokens);
  parser.addErrorListener(DiagnosticErrorListener());
  final p = parser.program();
  print('parsed program --> ${p.statements().length} statements');

  final io = <String, dynamic>{
    'label': "Hop là",
    'n': 12,
    'x': {'deg': 45},
    'y': {'re': -3, 'im': 0},
    'z': {'re': 0, 'im': -3},
  };
  final interpreter = QasmInterpreter(io);
  final status = interpreter.visitProgram(p);

  print('DONE: $status');
  for (var entry in io.entries) {
    print('   ${entry.key} = ${entry.value}');
  }
}
