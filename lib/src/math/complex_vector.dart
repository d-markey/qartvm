import '../exceptions.dart';
import 'complex.dart';
import 'complex_matrix.dart';

/// Class representing a vector holding [length] [Complex] values
class ComplexVector extends ComplexMatrix {
  /// Builds a vector of [length] values obtained from [values]
  ComplexVector(List<Complex> values)
      : super.generate(values.length, 1, (row, column) => values[row]);

  /// Builds a vector of [length] values all initialized to [Complex.zero]
  ComplexVector.zero(int length) : super.zero(length, 1);

  /// Builds a vector of [length] values all initialized to [value]
  ComplexVector.filled(int length, Complex value)
      : super.filled(length, 1, value);

  /// Builds a vector of [length] values obtained from the [generator] function
  ComplexVector.generate(int length, Complex Function(int i) generator)
      : super.generate(length, 1, (i, j) => generator(i));

  /// Returns the [length] of this vector
  int get length => rows;

  /// Builds a new vector which is the result of the tensor product of [a] by [b]
  /// The length of the resulting vector  is [length] = [a].[length] * [b].[length]
  static ComplexVector tensor(ComplexVector a, ComplexVector b) {
    final bt = b.transpose;
    final m = a * bt;
    final c = ComplexVector.zero(a.length * b.length);
    c.copy(m);
    return c;
  }

  /// Multiplies the matrix [m] by this instance and stores results in this instance
  /// [m] must be a square matrix of size [length]x[length]
  ComplexVector transform(ComplexMatrix m) {
    if (!m.square || m.rows != length) {
      throw InvalidOperationException(
          'Cannot transform a vector($length) with a matrix(${m.rows}x${m.columns})');
    }
    copy(m * this);
    return this;
  }
}
