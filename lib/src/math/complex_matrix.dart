import '_complex_array.dart';
import 'complex.dart';
import 'complex_dense_matrix.dart';
import 'complex_sparse_matrix.dart';

abstract class ComplexMatrix {
  ComplexMatrix.base([String warning = '']) {
    if (warning.isNotEmpty) {
      print('!!! $runtimeType: $warning');
    }
  }

  int get memoryFootprint;

  int get rows;

  int get columns;

  bool get isSquare => rows == columns;

  bool get isIdentity;

  bool get isDiagonal;

  Complex get(int row, int column);

  void set(int row, int column, Complex value);

  ComplexMatrix clone();

  ComplexMatrix copy(covariant ComplexMatrix other);

  ComplexMatrix neg();

  ComplexMatrix add(covariant ComplexMatrix other);

  ComplexMatrix sub(covariant ComplexMatrix other);

  ComplexMatrix operator +(covariant ComplexMatrix other);

  ComplexMatrix operator -();

  ComplexMatrix operator -(covariant ComplexMatrix other);

  ComplexMatrix operator *(Object other);

  ComplexMatrix mul(Object other);

  ComplexMatrix operator /(Object other);

  ComplexMatrix div(Object other);

  ComplexMatrix transpose();

  ComplexMatrix dagger();

  ComplexMatrix conjugate();

  Complex get det;

  ComplexMatrix inverse();

  bool equals(ComplexMatrix other, {double precision = 0});

  @override
  String toString() => toStringIndent();

  /// Returns a String representation of this matrix with indentation at level [indent]
  /// If [hideZeroes] is `true`, values equal to [Complex.zero] down to a precision of [precision] will not be displayed
  /// The optional [fractionDigits] is used to format [Complex] values
  String toStringIndent({
    int indent = 0,
    int? fractionDigits,
    bool hideZeroes = false,
    double precision = 0,
  }) {
    final spaces = '   ';
    final tabs = spaces * indent;
    final sb = StringBuffer();
    sb.write('$tabs[\n');
    for (var r = 0; r < rows; r++) {
      if (r > 0) {
        sb.write(',\n');
      }
      sb.write('$tabs$spaces[');
      var isZero = false;
      for (var c = 0; c < columns; c++) {
        final v = get(r, c);
        if (c > 0) {
          if (isZero && hideZeroes) {
            sb.write('  ');
          } else {
            sb.write(', ');
          }
        }
        if (hideZeroes && v.equals(Complex.zero, precision: precision)) {
          isZero |= true;
          sb.write(' ');
        } else {
          isZero &= false;
          sb.write(
            (fractionDigits == null)
                ? v.toString()
                : v.toStringAsFixed(fractionDigits),
          );
        }
      }
      sb.write(']');
    }
    sb.write('\n$tabs]');
    return sb.toString();
  }

  List serialize();

  static ComplexMatrix deserialize(List json) => json.length == 3
      ? ComplexDenseMatrix.fromComplexArray(
          json[0],
          json[1],
          ComplexArray.deserialize(json[2]),
        )
      : (json[1] == 'sparse'
            ? ComplexSparseMatrix.deserialize(json[2], json[3], json[4])
            : ComplexDenseMatrix.deserialize(json[2], json[3], json[4]));
}
