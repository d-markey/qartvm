import '../exceptions.dart';
import 'complex.dart';
import 'complex_matrix.dart';

class ComplexVector extends ComplexMatrix {
  ComplexVector(List<Complex> values)
      : super.generate(values.length, 1, (row, column) => values[row]);

  ComplexVector.zero(int length) : super.zero(length, 1);

  ComplexVector.filled(int length, Complex value)
      : super.filled(length, 1, value);

  ComplexVector.generate(int length, Complex Function(int i) generator)
      : super.generate(length, 1, (i, j) => generator(i));

  int get length => rows;

  static ComplexVector tensor(ComplexVector a, ComplexVector b) {
    final bt = b.transpose;
    final m = a * bt;
    final c = ComplexVector.zero(a.length * b.length);
    c.copy(m);
    return c;
  }

  void transform(ComplexMatrix m) {
    if (!m.square || m.rows != length) {
      throw InvalidOperationException(
          'Cannot transform a vector($length) with a matrix(${m.rows}x${m.columns})');
    }
    copy(m * this);
  }
}
