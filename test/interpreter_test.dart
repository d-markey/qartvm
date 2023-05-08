import 'dart:math' as math;
import 'package:qartvm/qartvm.dart';
import 'package:qartvm/src/openqasm/interpreter/openqasm_interpreter.dart';
import 'package:qartvm/src/openqasm/parser/openqasm_parser.dart';

void main() {
  final p = Program.parse('''
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
  print("   pow(y, 2) = ", pow(y, 2));
  print("   pow(sqrt(z), 2) = ", pow(sqrt(z), 2));
  print("   sqrt(pow(z, 2)) = ", sqrt(pow(z, 2)));
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
''', OpenQAsmParser());
  final interpreter = OpenQAsmInterpreter();
  final io = <String, dynamic>{
    'label': "Hop là",
    'n': 12,
    'x': {'deg': 45},
    'y': {'re': -3, 'im': 0},
    'z': {'re': 0, 'im': -3},
  };
  final status = interpreter.execute(p, io);
  print('DONE: $status');
  for (var entry in io.entries) {
    print('   ${entry.key} = ${entry.value}');
  }
}
