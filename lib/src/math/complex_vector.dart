import '../utils/exceptions.dart';
import 'complex.dart';
import 'complex_dense_matrix.dart';
import 'complex_matrix.dart';
import 'complex_sparse_matrix.dart';

/// Class representing a vector holding [length] [Complex] values
class ComplexVector extends ComplexDenseMatrix {
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
    final bt = b.transpose, m = a * bt;
    return ComplexVector.zero(a.length * b.length)..copy(m);
  }

  /// Multiplies the matrix [m] by this instance and stores results in this instance
  /// [m] must be a square matrix of size [length]x[length]
  ComplexVector transform(ComplexMatrix m) {
    if (!m.isSquare || m.rows != length) {
      throw InvalidOperationException(
        'Cannot transform a vector($length) with a matrix(${m.rows}x${m.columns})',
      );
    }
    if (m is! ComplexSparseMatrix) {
      final sm = ComplexSparseMatrix.fromMatrix(m);
      if (sm.memoryFootprint < m.memoryFootprint) {
        print(
          '!!! m is a ${m.runtimeType} ${m.rows} x ${m.columns} - dense: ${m.memoryFootprint} / ${m.rows * m.columns} vs. sparse: ${sm.memoryFootprint} / ${sm.nonZeroCount}',
        );
      }
    }
    copy(m * this);
    return this;
  }
}
