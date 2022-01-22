import 'package:qartvm/qartvm.dart';

void main() {
  final m = ComplexMatrix.generate(
      64, 64, (r, c) => Complex.random(radius: 5, im: true));

  final d = m.det;
  print('m.det = ${m.det}');
  print('');

  if (d == Complex.zero) {
    print('non invertible');
  } else {
    final p = m * m.inverse();
    print(p.toStringIndent(0, fractionDigits: 0));
  }

  print('');
}
