import '../exceptions.dart';
import '_complex_array.dart';
import 'complex.dart';

/// Class representing a matrix of [Complex] values in [ComplexMatrix.rows] rows and [ComplexMatrix.columns] columns
class ComplexMatrix {
  ComplexMatrix._clone(this.rows, this.columns, ComplexArray values)
      : _values = values.clone();

  /// Builds a matrix of [rows] rows and [columns] columns initialized with values obtained from the [generator] function
  ComplexMatrix.generate(
      this.rows, this.columns, Complex Function(int row, int column) generator)
      : _values = ComplexArray.zero(rows * columns) {
    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < columns; c++) {
        _values.set(_idx(r, c), generator(r, c));
      }
    }
  }

  /// Builds a matrix of [rows] rows and [columns] columns initialized with values obtained from [values]
  factory ComplexMatrix(List<List<Complex>> values) {
    final rows = values.length;
    if (rows == 0) {
      throw InvalidDimensionsException();
    }
    final columns = values.first.length;
    if (columns == 0) {
      throw InvalidDimensionsException();
    }
    if (values.any((v) => v.length != columns)) {
      throw InvalidDimensionsException();
    }
    return ComplexMatrix.generate(rows, columns, (r, c) => values[r][c]);
  }

  /// Builds a matrix of [rows] rows and [columns] columns initialized with [Complex.zero]
  ComplexMatrix.zero(this.rows, this.columns)
      : _values = ComplexArray.zero(rows * columns);

  /// Builds a matrix of [rows] rows and [columns] columns initialized with [value]
  ComplexMatrix.filled(int rows, int columns, Complex value)
      : this.generate(rows, columns, (row, column) => value);

  /// Builds the identity matrix of [rows] rows and [columns] columns
  ComplexMatrix.identity(int rows)
      : this.generate(rows, rows,
            (row, column) => (row == column) ? Complex.one : Complex.zero);

  /// Builds a clone of this instance
  ComplexMatrix clone() => ComplexMatrix._clone(rows, columns, _values);

  final ComplexArray _values;

  /// Copies values from [source] into this instance
  /// The size of [source] must match the size of this matrix (i.e. [source].[ComplexArray.length] == [rows] * [columns])
  void copyFrom(ComplexArray source) {
    if (source.length != _values.length) {
      throw InvalidOperationException();
    }
    _values.copy(source);
  }

  /// Copies values from this instance to [destination]
  /// The size of [destination] must match the size of this matrix (i.e. [destination].[ComplexArray.length] == [rows] * [columns])
  void copyTo(ComplexArray destination) {
    if (destination.length != _values.length) {
      throw InvalidOperationException();
    }
    destination.copy(_values);
  }

  /// Number of rows in this matrix
  final int rows;

  /// Number of columns in this matrix
  final int columns;

  /// Returns the [Complex] value at row [row] and [column] column
  Complex get(int row, int column) => _values[_idx(row, column)];

  @override
  late final int hashCode = rows * columns;

  /// Returns true is this instance is a square matrix (i.e. [rows] == [columns])
  bool get square => rows == columns;

  /// Returns true is this instance is the identity matrix (i.e. values at row r and column c == 1 is r == c, 0 otherwise)
  bool get isIdentity {
    if (!square) return false;
    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < columns; c++) {
        if (r != c && !_values.isZero(_idx(r, c))) {
          return false;
        }
        if (r == c && !_values.isOne(_idx(r, c))) {
          return false;
        }
      }
    }
    return true;
  }

  int _idx(int row, int column) => row * columns + column;

  /// Copies values from matrix [other] into this instance
  /// [other].[rows] and [columns] must match the [rows] and [columns] in this instance
  ComplexMatrix copy(ComplexMatrix other) {
    if (rows != other.rows || columns != other.columns) {
      throw InvalidOperationException();
    }
    _values.copy(other._values);
    return this;
  }

  /// Returns a new matrix containing the opposite values from this instance
  ComplexMatrix operator -() => clone().neg();

  /// Negates all values in this instance
  ComplexMatrix neg() {
    final len = _values.length;
    for (var i = 0; i < len; i++) {
      _values.neg(i);
    }
    return this;
  }

  /// Returns a new matrix containing the results of adding this instance with [other]
  ComplexMatrix operator +(ComplexMatrix other) => clone().add(other);

  /// Adds values of [other] to the values in this instance
  ComplexMatrix add(ComplexMatrix other) {
    if (rows != other.rows || columns != other.columns) {
      throw InvalidOperationException(
          'Cannot add a ${rows}x$columns matrix and a ${other.rows}x${other.columns} matrix ');
    }
    final ov = other._values;
    final len = _values.length;
    for (var i = 0; i < len; i++) {
      _values.add(i, _values, i, ov, i);
    }
    return this;
  }

  /// Returns a new matrix containing the results of subtracting [other] from this instance
  ComplexMatrix operator -(ComplexMatrix other) => clone().sub(other);

  /// Subtracts values of [other] from the values in this instance
  ComplexMatrix sub(ComplexMatrix other) {
    if (rows != other.rows || columns != other.columns) {
      throw InvalidOperationException();
    }
    final ov = other._values;
    final len = _values.length;
    for (var i = 0; i < len; i++) {
      _values.sub(i, _values, i, ov, i);
    }
    return this;
  }

  /// Returns a new matrix containing the results of multiplying this instance by [other]
  /// [other] may be a [num], a [Complex] or another [ComplexMatrix]
  /// if [other] is a [num] or [Complex], the resulting matrix will have the same size
  /// if [other] is a [ComplexMatrix]:
  /// * its [rows] must equal this instance's [columns]
  /// * the size of the resulting matrix will be [rows] = [rows] and [columns] = [other].[columns]
  ComplexMatrix operator *(Object other) {
    if (other is num || other is Complex) {
      return clone().._values.scale(other);
    } else if (other is ComplexMatrix) {
      if (columns != other.rows) {
        throw InvalidOperationException(
            'Cannot multiply ${rows}x$columns by ${other.rows}x${other.columns}');
      }
      final res = ComplexMatrix.zero(rows, other.columns);
      final rrows = res.rows, rcolumns = res.columns;
      final rv = res._values, ridx = res._idx;
      final ov = other._values, oidx = other._idx;
      for (var r = 0; r < rrows; r++) {
        for (var c = 0; c < rcolumns; c++) {
          final ri = ridx(r, c);
          for (var joinIdx = 0; joinIdx < columns; joinIdx++) {
            rv.addmul(ri, _values, _idx(r, joinIdx), ov, oidx(joinIdx, c));
          }
        }
      }
      return res;
    } else {
      throw InvalidOperationException(
          'Cannot multiply ${rows}x$columns with ${other.runtimeType}');
    }
  }

  /// Multipies this instance by [other] and stores the result in this instance
  /// [other] may be a [num], a [Complex] or another [ComplexMatrix]
  /// if [other] is a [ComplexMatrix], this instance and [other] must be square matrices of the same size
  ComplexMatrix mul(Object other) {
    if (other is num || other is Complex) {
      _values.scale(other);
    } else if (other is ComplexMatrix) {
      if (!square || !other.square) {
        throw InvalidDimensionsException(
            'Matrices must be square for in-place multiplication');
      }
      final res = this * other;
      _values.copy(res._values);
    } else {
      throw InvalidOperationException(
          'Cannot multiply ${rows}x$columns with ${other.runtimeType}');
    }
    return this;
  }

  /// Returns a new matrix containing the results of dividing this instance by [other]
  /// [other] may be a [num], a [Complex] or another [ComplexMatrix]
  /// if [other] is a [num] or [Complex], the resulting matrix will have the same size
  /// if [other] is a [ComplexMatrix], [other] must be invertible and the resuting matrix is obtained by multipltying this instance by the [inverse] of [other]
  ComplexMatrix operator /(Object other) {
    if (other is num || other is Complex) {
      return clone().._values.unscale(other);
    } else if (other is ComplexMatrix) {
      return this * other.inverse();
    } else {
      throw InvalidOperationException();
    }
  }

  /// Divides this instance by [other] and stores the result in this instance
  /// [other] may be a [num], a [Complex] or another [ComplexMatrix]
  /// if [other] is a [ComplexMatrix], the result is obtained by calling [mul] with the [inverse] of [other]
  ComplexMatrix div(Object other) {
    if (other is num || other is Complex) {
      _values.unscale(other);
    } else if (other is ComplexMatrix) {
      return mul(other.inverse());
    } else {
      throw InvalidOperationException();
    }
    return this;
  }

  /// Builds a new matrix which is the result of the tensor product of [a] by [b]
  /// The size of the resulting matrix is [rows] = [a].[rows] * [b].[rows] and [columns] = [a].[columns] * [b].[columns]
  static ComplexMatrix tensor(ComplexMatrix a, ComplexMatrix b) {
    final arows = a.rows, acolumns = a.columns;
    final brows = b.rows, bcolumns = b.columns;

    final rows = arows * brows, columns = acolumns * bcolumns;
    final c = ComplexMatrix.zero(rows, columns);

    final av = a._values, aidx = a._idx;
    final bv = b._values, bidx = b._idx;
    final cv = c._values, cidx = c._idx;
    for (var ar = 0; ar < arows; ar++) {
      for (var ac = 0; ac < acolumns; ac++) {
        for (var br = 0; br < brows; br++) {
          final cr = (ar * brows) + br;
          for (var bc = 0; bc < bcolumns; bc++) {
            final cc = (ac * bcolumns) + bc;
            cv.mul(cidx(cr, cc), av, aidx(ar, ac), bv, bidx(br, bc));
          }
        }
      }
    }

    return c;
  }

  @override
  bool operator ==(Object other) =>
      (other is ComplexMatrix) &&
      (rows == other.rows) &&
      (columns == other.columns) &&
      (_values == other._values);

  /// Returns true if [other] is a [ComplexMatrix] of the same size, and all of their values are equal down to a precision of [precision]
  bool equals(ComplexMatrix other, {double precision = 0}) {
    if (rows != other.rows || columns != other.columns) return false;
    return _values.equals(other._values, precision: precision);
  }

  /// Obtains the determinant of this matrix
  /// This instance must be a square matrix
  /// if [rows] == [columns] == 1, returns [Complex.zero] if the matrix' single value is [Complex.zero] and [Complex.one] otherwise
  /// if [rows] == [columns] == 2, the determinant is obtained directly from the cross product of the matrix' values
  /// if [rows] == [columns] > 2, the determinant is obtained by Gaussian elimination
  Complex get det {
    if (!square) {
      throw InvalidDimensionsException();
    }

    switch (rows) {
      case 1:
        return _values.isZero(0) ? Complex.zero : Complex.one;

      case 2:
        // a b
        // c d
        final d = ComplexArray.zero(2);
        d.mul(0, _values, _idx(0, 0), _values, _idx(1, 1)); // ad
        d.mul(1, _values, _idx(0, 1), _values, _idx(1, 0)); // bc
        d.sub(0, d, 0, d, 1); // ad - bc
        return d[0];

      default:
        final copy = clone();
        return copy._gaussianElimination(full: false);
    }
  }

  /// Returns a new matrix obtained by transposing this matrix and conjugating its values
  /// The resulting matrix will have [columns] rows and [rows] columns
  ComplexMatrix dagger() {
    final d = transpose();
    final val = d._values, len = val.length;
    for (var i = 0; i < len; i++) {
      val.conj(i);
    }
    return d;
  }

  /// Returns a new matrix obtained by transposing this matrix
  /// The resulting matrix will have [columns] rows and [rows] columns
  ComplexMatrix transpose() {
    final t = ComplexMatrix.zero(columns, rows);
    final tv = t._values;
    final tidx = t._idx;
    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < columns; c++) {
        tv.assign(tidx(c, r), _values, _idx(r, c));
      }
    }
    return t;
  }

  /// Returns a new matrix obtained by taking the [Complex] conjugate of all values in this instance
  /// The resulting matrix will have the same size
  ComplexMatrix conjugate() {
    final c = clone();
    final val = c._values, len = val.length;
    for (var i = 0; i < len; i++) {
      val.conj(i);
    }
    return c;
  }

  /// Returns the inverse of this matrix
  /// This instance must be a square matrix
  /// if [rows] == [columns] == 1, returns a [ComplexMatrix] holding a single value which is the inverse of the value in this instance
  /// if [rows] == [columns] > 1, the inverse is obtained by Gaussian elimination
  ComplexMatrix inverse() {
    if (!square) {
      throw InvalidDimensionsException();
    }

    if (rows == 1) {
      final inv = clone();
      inv._values.inv(0);
      return inv;
    } else {
      final copy = ComplexMatrix.zero(rows, rows * 2);
      final identity = ComplexMatrix.identity(rows);
      final iv = identity._values, iidx = identity._idx;
      final cv = copy._values, cidx = copy._idx;
      for (var r = 0; r < rows; r++) {
        for (var c = 0; c < columns; c++) {
          cv.assign(cidx(r, c), _values, _idx(r, c));
          cv.assign(cidx(r, rows + c), iv, iidx(r, c));
        }
      }
      if (copy._gaussianElimination(full: true) == Complex.zero) {
        throw InvalidOperationException();
      }
      final inv = ComplexMatrix.zero(rows, rows);
      final invv = inv._values, invidx = inv._idx;
      for (var r = 0; r < rows; r++) {
        for (var c = 0; c < columns; c++) {
          invv.assign(invidx(r, c), cv, cidx(r, rows + c));
        }
      }
      return inv;
    }
  }

  /// Swaps row [r1] with [r2]
  void _swapRows(int r1, int r2) {
    for (var c = 0; c < columns; c++) {
      _values.swap(_idx(r1, c), _idx(r2, c));
    }
  }

  /// Finds a row under [row] so that the value in column [row] has a [Complex.modulus] as close to 1 as possible.
  /// If such a row exists, it is swapped with [row].
  /// The function returns 0 is the pivot value is 0, -1 is rows have been swapped, and 1 if no swap occurred.
  int _ensurePivot(int row) {
    var best = row;
    var bestDiff = double.maxFinite;
    for (var r = row; r < rows; r++) {
      final m = _values.modulus2(_idx(r, row));
      if (m == 0) continue;
      final diff = (m - 1).abs();
      if (diff < bestDiff) {
        bestDiff = diff;
        best = r;
      }
    }
    if (best == row) {
      return _values.isZero(_idx(row, row)) ? 0 : 1;
    } else {
      _swapRows(row, best);
      return _values.isZero(_idx(row, row)) ? 0 : -1;
    }
  }

  /// Gaussian elimination algorithm.
  /// * If [full] is `true`, a full elimination is performed so that the original matrix is transformed
  /// to an identity matrix and the function returns [Complex.one] if the original matrix is invertible,
  /// [Complex.zero] otherwise (used by [inverse]).
  /// * If [full] is `false`, only lower elimination is performed so that the original matrix is
  /// transformed into a triangular matrix and the function returns the determinant of the original matrix
  /// (used by [det]).
  /// The algorithm can operate on a square matrix of size N rows x N columns (e.g. if full elimination is
  /// not required) or on a matrix of size N rows x 2*N columns (e.g. if full elimination is required, in
  /// which case the first part contains the original NxN matrix to be inverted and the second part
  /// contains the NxN identity matrix; at the end of the algorithm, the first NxN matrix will have been
  /// transformed to the identity matrix and the second NxN matrix will contain the inverse of the original
  /// matrix).
  Complex _gaussianElimination({bool full = true}) {
    final ratios = ComplexArray.zero(rows);
    final factor = ComplexArray.zero(1);
    var sign = 1;
    for (var row = 0; row < rows; row++) {
      sign *= _ensurePivot(row);
      if (sign == 0) {
        // cannot perform row elimination
        return Complex.zero;
      }
      ratios.assign(row, _values, _idx(row, row));
      _values.set(_idx(row, row), Complex.one);
      for (var c = row + 1; c < columns; c++) {
        _values.div(_idx(row, c), _values, _idx(row, c), ratios, row);
      }
      final start = full ? 0 : row + 1;
      for (var r = start; r < rows; r++) {
        if (r == row) continue;
        factor.assign(0, _values, _idx(r, row));
        factor.neg(0);
        _values.set(_idx(r, row), Complex.zero);
        for (var c = row + 1; c < columns; c++) {
          _values.addmul(_idx(r, c), _values, _idx(row, c), factor, 0);
        }
      }
    }
    if (!full) {
      for (var i = 1; i < rows; i++) {
        ratios.mul(0, ratios, 0, ratios, i);
      }
      if (sign < 0) {
        ratios.neg(0);
      }
      return ratios[0];
    } else {
      return Complex.one;
    }
  }

  @override
  String toString() => toStringIndent();

  /// Returns a String representation of this matrix with indentation at level [indent]
  /// If [hideZeroes] is `true`, values equal to [Complex.zero] down to a precision of [precision] will not be displayed
  /// The optional [fractionDigits] is used to format [Complex] values
  String toStringIndent(
      {int indent = 0,
      int? fractionDigits,
      bool hideZeroes = false,
      double precision = 0}) {
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
        final v = _values[_idx(r, c)];
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
          sb.write((fractionDigits == null)
              ? v.toString()
              : v.toStringAsFixed(fractionDigits));
        }
      }
      sb.write(']');
    }
    sb.write('\n$tabs]');
    return sb.toString();
  }

  List serialize() => [
        rows,
        columns,
        _values.serialize(),
      ];

  static ComplexMatrix deserialize(List json) =>
      ComplexMatrix._clone(json[0], json[1], ComplexArray.deserialize(json[2]));
}
