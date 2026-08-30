import '../exceptions.dart';
import '_complex_array.dart';
import 'complex.dart';
import 'complex_dense_matrix.dart';
import 'complex_matrix.dart';
import 'complex_vector.dart';

/// A complex matrix stored in compressed sparse row (CSR) form.
class ComplexSparseMatrix extends ComplexMatrix {
  factory ComplexSparseMatrix(List<List<Complex>> values) {
    if (values.isEmpty ||
        values.first.isEmpty ||
        values.any((row) => row.length != values.first.length)) {
      throw InvalidDimensionsException();
    }
    return ComplexSparseMatrix.generate(
      values.length,
      values.first.length,
      (row, column) => values[row][column],
    );
  }

  ComplexSparseMatrix.generate(
    int rows,
    int columns,
    Complex Function(int row, int column) generator,
  ) : rows = rows,
      columns = columns,
      _rowOffsets = List<int>.filled(rows + 1, 0),
      _columnIndices = <int>[],
      _values = <Complex>[],
      super.base() {
    _validateDimensions();
    for (var row = 0; row < rows; row++) {
      for (var column = 0; column < columns; column++) {
        set(row, column, generator(row, column));
      }
    }
  }

  ComplexSparseMatrix.zero(this.rows, this.columns)
    : _rowOffsets = List<int>.filled(rows + 1, 0),
      _columnIndices = <int>[],
      _values = <Complex>[],
      super.base() {
    _validateDimensions();
  }

  ComplexSparseMatrix.filled(int rows, int columns, Complex value)
    : this.generate(rows, columns, (_, _) => value);

  ComplexSparseMatrix.identity(int rows)
    : rows = rows,
      columns = rows,
      _rowOffsets = List<int>.filled(rows + 1, 0),
      _columnIndices = <int>[],
      _values = <Complex>[],
      super.base() {
    _validateDimensions();
    for (var i = 0; i < rows; i++) {
      set(i, i, Complex.one);
    }
  }

  void _validateDimensions() {
    if (rows <= 0 || columns <= 0) {
      throw InvalidDimensionsException();
    }
  }

  @override
  final int rows;

  @override
  final int columns;

  final List<int> _rowOffsets;
  final List<int> _columnIndices;
  final List<Complex> _values;

  @override
  int get memoryFootprint =>
      _rowOffsets.length * 8 +
      _columnIndices.length * 8 +
      _values.length * 8 * 2;

  /// Number of stored non-zero values.
  int get nonZeroCount => _values.length;

  /// Iterates over each stored non-zero entry in row-major order.
  Iterable<(int row, int column, Complex value)> get nonZeroEntries sync* {
    for (var row = 0; row < rows; row++) {
      final end = _rowOffsets[row + 1];
      for (var index = _rowOffsets[row]; index < end; index++) {
        yield (row, _columnIndices[index], _values[index]);
      }
    }
  }

  bool get isIdentity {
    if (!isSquare || nonZeroCount != rows) return false;
    for (var row = 0; row < rows; row++) {
      if (get(row, row) != Complex.one ||
          _rowOffsets[row + 1] - _rowOffsets[row] != 1) {
        return false;
      }
    }
    return true;
  }

  int _find(int row, int column) {
    var low = _rowOffsets[row];
    var high = _rowOffsets[row + 1];
    while (low < high) {
      final middle = (low + high) ~/ 2;
      if (_columnIndices[middle] < column) {
        low = middle + 1;
      } else {
        high = middle;
      }
    }
    return low;
  }

  @override
  Complex get(int row, int column) {
    final index = _find(row, column);
    return (index < _rowOffsets[row + 1] && _columnIndices[index] == column)
        ? _values[index]
        : Complex.zero;
  }

  @override
  void set(int row, int column, Complex value) {
    final index = _find(row, column);
    final exists =
        index < _rowOffsets[row + 1] && _columnIndices[index] == column;
    if (value == Complex.zero) {
      if (!exists) return;
      _columnIndices.removeAt(index);
      _values.removeAt(index);
      for (var i = row + 1; i < _rowOffsets.length; i++) {
        _rowOffsets[i]--;
      }
    } else if (exists) {
      _values[index] = value;
    } else {
      _columnIndices.insert(index, column);
      _values.insert(index, value);
      for (var i = row + 1; i < _rowOffsets.length; i++) {
        _rowOffsets[i]++;
      }
    }
  }

  @override
  ComplexSparseMatrix clone() => ComplexSparseMatrix.fromMatrix(this);

  ComplexSparseMatrix.fromMatrix(ComplexMatrix source)
    : rows = source.rows,
      columns = source.columns,
      _rowOffsets = List<int>.filled(source.rows + 1, 0),
      _columnIndices = <int>[],
      _values = <Complex>[],
      super.base() {
    _validateDimensions();
    for (var row = 0; row < rows; row++) {
      for (var column = 0; column < columns; column++) {
        set(row, column, source.get(row, column));
      }
    }
  }

  @override
  ComplexSparseMatrix copy(ComplexMatrix other) {
    if (rows != other.rows || columns != other.columns) {
      throw InvalidOperationException();
    }
    _rowOffsets.fillRange(0, _rowOffsets.length, 0);
    _columnIndices.clear();
    _values.clear();
    for (var row = 0; row < rows; row++) {
      for (var column = 0; column < columns; column++) {
        set(row, column, other.get(row, column));
      }
    }
    return this;
  }

  @override
  void copyFrom(ComplexArray source) {
    if (source.length != rows * columns) {
      throw InvalidOperationException();
    }
    _rowOffsets.fillRange(0, _rowOffsets.length, 0);
    _columnIndices.clear();
    _values.clear();
    for (var row = 0; row < rows; row++) {
      for (var column = 0; column < columns; column++) {
        set(row, column, source[row * columns + column]);
      }
    }
  }

  @override
  void copyTo(ComplexArray destination) {
    if (destination.length != rows * columns) {
      throw InvalidOperationException();
    }
    for (var row = 0; row < rows; row++) {
      for (var column = 0; column < columns; column++) {
        destination.set(row * columns + column, get(row, column));
      }
    }
  }

  @override
  ComplexSparseMatrix neg() {
    for (var i = 0; i < _values.length; i++) {
      _values[i] = -_values[i];
    }
    return this;
  }

  @override
  ComplexSparseMatrix operator -() => clone().neg();

  @override
  ComplexSparseMatrix add(ComplexMatrix other) => _combine(other, false);

  @override
  ComplexSparseMatrix sub(ComplexMatrix other) => _combine(other, true);

  ComplexSparseMatrix _combine(ComplexMatrix other, bool subtract) {
    if (rows != other.rows || columns != other.columns) {
      throw InvalidOperationException(
        'Cannot combine a ${rows}x$columns matrix and a ${other.rows}x${other.columns} matrix',
      );
    }
    final result = ComplexSparseMatrix.zero(rows, columns);
    for (var row = 0; row < rows; row++) {
      for (var column = 0; column < columns; column++) {
        final value =
            get(row, column) +
            (subtract ? -other.get(row, column) : other.get(row, column));
        if (value != Complex.zero) result.set(row, column, value);
      }
    }
    return result;
  }

  @override
  ComplexSparseMatrix operator +(ComplexMatrix other) => clone().add(other);

  @override
  ComplexSparseMatrix operator -(ComplexMatrix other) => clone().sub(other);

  @override
  ComplexMatrix operator *(Object other) {
    if (other is num || other is Complex) return clone().._scale(other);
    if (other is! ComplexMatrix || columns != other.rows) {
      throw InvalidOperationException(
        'Cannot multiply ${rows}x$columns with ${other.runtimeType}',
      );
    }
    if (other.columns == 1) {
      final result = ComplexVector.zero(rows);
      for (var row = 0; row < rows; row++) {
        var sum = Complex.zero;
        for (
          var index = _rowOffsets[row];
          index < _rowOffsets[row + 1];
          index++
        ) {
          sum = sum + _values[index] * other.get(_columnIndices[index], 0);
        }
        result.set(row, 0, sum);
      }
      return result;
    }
    final result = ComplexSparseMatrix.zero(rows, other.columns);
    for (var row = 0; row < rows; row++) {
      final end = _rowOffsets[row + 1];
      for (var index = _rowOffsets[row]; index < end; index++) {
        final column = _columnIndices[index];
        final value = _values[index];
        for (var target = 0; target < other.columns; target++) {
          final product = value * other.get(column, target);
          result.set(row, target, result.get(row, target) + product);
        }
      }
    }
    return result;
  }

  @override
  ComplexSparseMatrix mul(Object other) {
    if (other is num || other is Complex) {
      _scale(other);
      return this;
    }
    if (other is! ComplexMatrix ||
        !isSquare ||
        !other.isSquare ||
        rows != other.rows) {
      throw InvalidDimensionsException(
        'Matrices must be square and have matching dimensions for in-place multiplication',
      );
    }
    return copy(this * other);
  }

  void _scale(Object factor) {
    if (factor is num) {
      if (factor == 0) {
        _rowOffsets.fillRange(0, _rowOffsets.length, 0);
        _columnIndices.clear();
        _values.clear();
      } else if (factor != 1) {
        final value = factor.toDouble();
        for (var i = 0; i < _values.length; i++) {
          _values[i] = _values[i] * value;
        }
      }
    } else if (factor is Complex) {
      if (factor == Complex.zero) {
        _rowOffsets.fillRange(0, _rowOffsets.length, 0);
        _columnIndices.clear();
        _values.clear();
      } else if (factor != Complex.one) {
        for (var i = 0; i < _values.length; i++) {
          _values[i] = _values[i] * factor;
        }
      }
    } else {
      throw InvalidOperationException();
    }
  }

  @override
  ComplexMatrix operator /(Object other) {
    if (other is num || other is Complex) return clone().._unscale(other);
    if (other is ComplexMatrix) return this * other.inverse();
    throw InvalidOperationException();
  }

  @override
  ComplexMatrix div(Object other) {
    if (other is num || other is Complex) {
      _unscale(other);
      return this;
    }
    if (other is ComplexMatrix) return mul(other.inverse());
    throw InvalidOperationException();
  }

  void _unscale(Object factor) =>
      _scale(factor is num ? 1 / factor : Complex.one / (factor as Complex));

  @override
  ComplexSparseMatrix transpose() {
    final result = ComplexSparseMatrix.zero(columns, rows);
    for (var row = 0; row < rows; row++) {
      final end = _rowOffsets[row + 1];
      for (var index = _rowOffsets[row]; index < end; index++) {
        result.set(_columnIndices[index], row, _values[index]);
      }
    }
    return result;
  }

  @override
  ComplexSparseMatrix conjugate() {
    final result = clone();
    for (var i = 0; i < result._values.length; i++) {
      result._values[i] = Complex(
        re: result._values[i].re,
        im: -result._values[i].im,
      );
    }
    return result;
  }

  @override
  ComplexSparseMatrix dagger() => transpose().conjugate();

  @override
  Complex get det => _toDense().det;

  @override
  ComplexMatrix inverse() => _toDense().inverse();

  ComplexDenseMatrix _toDense() =>
      ComplexDenseMatrix.generate(rows, columns, get);

  @override
  bool equals(ComplexMatrix other, {double precision = 0}) {
    if (rows != other.rows || columns != other.columns) return false;
    for (var row = 0; row < rows; row++) {
      for (var column = 0; column < columns; column++) {
        if (!get(
          row,
          column,
        ).equals(other.get(row, column), precision: precision)) {
          return false;
        }
      }
    }
    return true;
  }

  @override
  bool operator ==(Object other) =>
      other is ComplexMatrix &&
      rows == other.rows &&
      columns == other.columns &&
      equals(other);

  @override
  int get hashCode => rows * columns;

  @override
  String toString() => toStringIndent();

  @override
  String toStringIndent({
    int indent = 0,
    int? fractionDigits,
    bool hideZeroes = false,
    double precision = 0,
  }) {
    final spaces = '   ';
    final tabs = spaces * indent;
    final buffer = StringBuffer('$tabs[\n');
    for (var row = 0; row < rows; row++) {
      if (row > 0) buffer.write(',\n');
      buffer.write('$tabs$spaces[');
      for (var column = 0; column < columns; column++) {
        if (column > 0) buffer.write(', ');
        final value = get(row, column);
        buffer.write(
          hideZeroes && value.equals(Complex.zero, precision: precision)
              ? ' '
              : fractionDigits == null
              ? value.toString()
              : value.toStringAsFixed(fractionDigits),
        );
      }
      buffer.write(']');
    }
    buffer.write('\n$tabs]');
    return buffer.toString();
  }

  @override
  List serialize() => [
    1,
    'sparse',
    rows,
    columns,
    [
      for (var row = 0; row < rows; row++)
        [
          for (
            var index = _rowOffsets[row];
            index < _rowOffsets[row + 1];
            index++
          )
            [_columnIndices[index], _values[index].re, _values[index].im],
        ],
    ],
  ];

  static ComplexSparseMatrix deserialize(int rows, int columns, List payload) {
    final matrix = ComplexSparseMatrix.zero(rows, columns);
    for (var row = 0; row < rows; row++) {
      for (final entry in payload[row]) {
        matrix.set(row, entry[0], Complex(re: entry[1], im: entry[2]));
      }
    }
    return matrix;
  }
}
