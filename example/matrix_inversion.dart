import 'package:qartvm/qartvm.dart';

void main() {
  final m = ComplexMatrix.generate(64, 64, (r, c) => Complex.random(radius: 2));

  final d = m.det;
  print('m.det = ${m.det}');
  print('');

  if (d == Complex.zero) {
    print('non invertible');
  } else {
    final p = m * m.inverse();
    print(p.toStringIndent(fractionDigits: 0));
    if (!p.equals(ComplexMatrix.identity(64), precision: 1e-9)) {
      throw Exception('Expected the identity matrix');
    }
  }

  print('');
}
