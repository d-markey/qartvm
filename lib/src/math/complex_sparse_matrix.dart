import '../utils/exceptions.dart';
import 'complex.dart';
import 'complex_dense_matrix.dart';
import 'complex_matrix.dart';
import 'complex_vector.dart';

/// A complex matrix stored in compressed sparse row (CSR) form.
class ComplexSparseMatrix extends ComplexMatrix {
  ComplexSparseMatrix._fromCsr(
    this.rows,
    this.columns,
    List<int> rowOffsets,
    List<int> columnIndices,
    List<Complex> values,
  ) : _rowOffsets = List<int>.filled(rows + 1, 0),
      _columnIndices = <int>[],
      _values = <Complex>[],
      super.base() {
    _rowOffsets.setRange(0, _rowOffsets.length, rowOffsets);
    _columnIndices.addAll(columnIndices);
    _values.addAll(values);
  }

  ComplexSparseMatrix.zero(this.rows, this.columns)
    : _rowOffsets = List<int>.filled(rows + 1, 0),
      _columnIndices = <int>[],
      _values = <Complex>[],
      super.base();

  factory ComplexSparseMatrix(List<List<Complex>> values) {
    final first = values.firstOrNull ?? const [];
    if (first.isEmpty || values.any((row) => row.length != first.length)) {
      throw InvalidDimensionsException();
    }
    return ComplexSparseMatrix.generate(
      values.length,
      first.length,
      (row, column) => values[row][column],
    );
  }

  factory ComplexSparseMatrix.fromMatrix(ComplexMatrix source) =>
      ComplexSparseMatrix.generate(source.rows, source.columns, source.get);

  factory ComplexSparseMatrix.generate(
    int rows,
    int columns,
    Complex Function(int row, int column) generator,
  ) {
    final builder = ComplexSparseMatrixBuilder(rows, columns);
    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < columns; c++) {
        builder.append(r, c, generator(r, c));
      }
    }
    return builder.build();
  }

  factory ComplexSparseMatrix.diagonal(
    int dim,
    Complex Function(int idx) generator,
  ) {
    final builder = ComplexSparseMatrixBuilder(dim, dim);
    for (var idx = 0; idx < dim; idx++) {
      builder.append(idx, idx, generator(idx));
    }
    return builder.build();
  }

  factory ComplexSparseMatrix.identity(int dim) =>
      ComplexSparseMatrix.diagonal(dim, (_) => Complex.one);

  @override
  final int rows;

  @override
  final int columns;

  @override
  int get hashCode => rows * columns;

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
  Iterable<({int row, int column, Complex value})> get nonZeroEntries sync* {
    for (var r = 0; r < rows; r++) {
      final end = _rowOffsets[r + 1];
      for (var index = _rowOffsets[r]; index < end; index++) {
        yield (row: r, column: _columnIndices[index], value: _values[index]);
      }
    }
  }

  List<({int column, Complex value})> nonZeroEntriesInRow(int row) => [
    for (var i = _rowOffsets[row]; i < _rowOffsets[row + 1]; i++)
      (column: _columnIndices[i], value: _values[i]),
  ];

  @override
  bool get isIdentity {
    if (!isSquare || nonZeroCount != rows) return false;
    for (var row = 0; row < rows; row++) {
      if (!get(row, row).isOne ||
          _rowOffsets[row + 1] - _rowOffsets[row] != 1) {
        return false;
      }
    }
    return true;
  }

  @override
  bool get isDiagonal {
    if (!isSquare) return false;
    for (var row = 0; row < rows; row++) {
      final end = _rowOffsets[row + 1];
      for (var i = _rowOffsets[row]; i < end; i++) {
        // column index must equal the row index
        if (_columnIndices[i] != row) {
          return false;
        }
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
    if (value.isZero) {
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
  ComplexSparseMatrix clone() {
    final copy = ComplexSparseMatrix.zero(rows, columns);
    copy._rowOffsets.setRange(0, copy._rowOffsets.length, _rowOffsets);
    copy._columnIndices.addAll(_columnIndices);
    copy._values.addAll(_values);
    return copy;
  }

  @override
  ComplexSparseMatrix copy(ComplexMatrix other) {
    if (rows != other.rows || columns != other.columns) {
      throw InvalidOperationException();
    }

    if (other is ComplexSparseMatrix) {
      _rowOffsets.setRange(0, _rowOffsets.length, other._rowOffsets);
      _columnIndices.clear();
      _columnIndices.addAll(other._columnIndices);
      _values.clear();
      _values.addAll(other._values);
    } else {
      _rowOffsets.fillRange(0, _rowOffsets.length, 0);
      _columnIndices.clear();
      _values.clear();
      for (var r = 0; r < rows; r++) {
        for (var c = 0; c < columns; c++) {
          set(r, c, other.get(r, c));
        }
      }
    }
    return this;
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
  ComplexSparseMatrix add(ComplexMatrix other) {
    if (rows != other.rows || columns != other.columns) {
      throw InvalidOperationException(
        'Cannot add a ${rows}x$columns matrix and a ${other.rows}x${other.columns} matrix',
      );
    }

    final builder = ComplexSparseMatrixBuilder(rows, columns);

    if (other case final ComplexSparseMatrix sparseOther) {
      // Two-pointer merge of already-sorted rows -- O(nnz(this) + nnz(other))
      // total, no per-entry set() / O(dim) sweep.
      for (var r = 0; r < rows; r++) {
        final thisRow = nonZeroEntriesInRow(r);
        final otherRow = sparseOther.nonZeroEntriesInRow(r);
        var i = 0, j = 0;
        while (i < thisRow.length && j < otherRow.length) {
          final a = thisRow[i], b = otherRow[j];
          if (a.column < b.column) {
            builder.append(r, a.column, a.value);
            i++;
          } else if (b.column < a.column) {
            builder.append(r, b.column, b.value);
            j++;
          } else {
            builder.append(r, a.column, a.value + b.value);
            i++;
            j++;
          }
        }
        for (; i < thisRow.length; i++) {
          builder.append(r, thisRow[i].column, thisRow[i].value);
        }
        for (; j < otherRow.length; j++) {
          builder.append(r, otherRow[j].column, otherRow[j].value);
        }
      }
    } else {
      for (var r = 0; r < rows; r++) {
        final thisRow = nonZeroEntriesInRow(r);
        var i = 0;
        for (var c = 0; c < columns; c++) {
          final otherVal = other.get(r, c);
          var thisVal = Complex.zero;
          if (i < thisRow.length && thisRow[i].column == c) {
            thisVal = thisRow[i].value;
            i++;
          }
          builder.append(r, c, thisVal + otherVal);
        }
      }
    }

    final built = builder.build();
    _rowOffsets.setRange(0, _rowOffsets.length, built._rowOffsets);
    _columnIndices
      ..clear()
      ..addAll(built._columnIndices);
    _values
      ..clear()
      ..addAll(built._values);
    return this;
  }

  @override
  ComplexSparseMatrix sub(ComplexMatrix other) {
    if (rows != other.rows || columns != other.columns) {
      throw InvalidOperationException(
        'Cannot subtract a ${other.rows}x${other.columns} matrix from a ${rows}x$columns matrix',
      );
    }

    final builder = ComplexSparseMatrixBuilder(rows, columns);

    if (other case final ComplexSparseMatrix sparseOther) {
      // Two-pointer merge of already-sorted rows -- O(nnz(this) + nnz(other))
      // total, no per-entry set() / O(dim) sweep.
      for (var r = 0; r < rows; r++) {
        final thisRow = nonZeroEntriesInRow(r);
        final otherRow = sparseOther.nonZeroEntriesInRow(r);
        var i = 0, j = 0;
        while (i < thisRow.length && j < otherRow.length) {
          final a = thisRow[i], b = otherRow[j];
          if (a.column < b.column) {
            builder.append(r, a.column, a.value);
            i++;
          } else if (b.column < a.column) {
            builder.append(r, b.column, -b.value);
            j++;
          } else {
            builder.append(r, a.column, a.value - b.value);
            i++;
            j++;
          }
        }
        for (; i < thisRow.length; i++) {
          builder.append(r, thisRow[i].column, thisRow[i].value);
        }
        for (; j < otherRow.length; j++) {
          builder.append(r, otherRow[j].column, -otherRow[j].value);
        }
      }
    } else {
      for (var r = 0; r < rows; r++) {
        final thisRow = nonZeroEntriesInRow(r);
        var i = 0;
        for (var c = 0; c < columns; c++) {
          final otherVal = other.get(r, c);
          var thisVal = Complex.zero;
          if (i < thisRow.length && thisRow[i].column == c) {
            thisVal = thisRow[i].value;
            i++;
          }
          builder.append(r, c, thisVal - otherVal);
        }
      }
    }

    final built = builder.build();
    _rowOffsets.setRange(0, _rowOffsets.length, built._rowOffsets);
    _columnIndices
      ..clear()
      ..addAll(built._columnIndices);
    _values
      ..clear()
      ..addAll(built._values);
    return this;
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

    final ocols = other.columns;
    if (ocols == 1) {
      // ComplexVector derives from ComplexDenseMatrix with 1 column -- already efficient, unchanged
      final result = ComplexVector.zero(rows);
      for (var row = 0; row < rows; row++) {
        var sum = Complex.zero;
        final end = _rowOffsets[row + 1];
        for (var index = _rowOffsets[row]; index < end; index++) {
          sum += _values[index] * other.get(_columnIndices[index], 0);
        }
        result.set(row, 0, sum);
      }
      return result;
    }

    // Gustavson's algorithm: for each row of `this`, only visit `other`'s
    // ACTUAL nonzero entries in the relevant rows (not all `ocols` columns),
    // accumulate per output column, flush sorted into the builder.
    // O(nnz(this) * avg row-nnz of other), not O(nnz(this) * ocols).
    final builder = ComplexSparseMatrixBuilder(rows, ocols);
    final sparseOther = other is ComplexSparseMatrix ? other : null;

    for (var row = 0; row < rows; row++) {
      final start = _rowOffsets[row], end = _rowOffsets[row + 1];
      final rowNnz = end - start;
      if (rowNnz == 0) continue;

      if (rowNnz == 1) {
        // Fast path: a single contributor means no summing/accumulation is
        // needed at all -- just scale that one row of `other` and copy it
        // straight through, already in sorted column order. Avoids allocating
        // a Map for what is, for permutation-like gates (X/CX/CCX/SWAP), the
        // overwhelmingly common case.
        final aCol = _columnIndices[start];
        final aVal = _values[start];
        if (sparseOther != null) {
          for (final (:column, :value) in sparseOther.nonZeroEntriesInRow(
            aCol,
          )) {
            builder.append(row, column, aVal * value);
          }
        } else {
          for (var target = 0; target < ocols; target++) {
            final bVal = other.get(aCol, target);
            builder.append(row, target, aVal * bVal);
          }
        }
        continue;
      }

      // General case (multiple contributors per row): needs real accumulation.
      final accumulator = <int, Complex>{};
      for (var index = start; index < end; index++) {
        final aCol = _columnIndices[index];
        final aVal = _values[index];
        if (sparseOther != null) {
          for (final (:column, :value) in sparseOther.nonZeroEntriesInRow(
            aCol,
          )) {
            final product = aVal * value;
            accumulator[column] =
                (accumulator[column] ?? Complex.zero) + product;
          }
        } else {
          for (var target = 0; target < ocols; target++) {
            final bVal = other.get(aCol, target);
            if (bVal.isZero) continue;
            final product = aVal * bVal;
            accumulator[target] =
                (accumulator[target] ?? Complex.zero) + product;
          }
        }
      }
      if (accumulator.isEmpty) continue;
      final sortedCols = accumulator.keys.toList()..sort();
      for (final c in sortedCols) {
        final v = accumulator[c]!;
        builder.append(row, c, v);
      }
    }

    return builder.build();
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
    switch (factor) {
      case num f when f == 0:
      case Complex f when f.isZero:
        _rowOffsets.fillRange(0, _rowOffsets.length, 0);
        _columnIndices.clear();
        _values.clear();

      case num f when f == 1:
      case Complex f when f.isOne:
        // nothing to do
        break;

      case num f:
        final df = f.toDouble(), len = _values.length;
        for (var i = 0; i < len; i++) {
          _values[i] = _values[i] * df;
        }

      case Complex f:
        final len = _values.length;
        for (var i = 0; i < len; i++) {
          _values[i] = _values[i] * f;
        }

      default:
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
    final result = clone(), values = result._values;
    for (var i = 0; i < values.length; i++) {
      values[i] = values[i].conjugate;
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

  static ComplexSparseMatrix tensor(ComplexMatrix a, ComplexMatrix b) {
    final rows = a.rows * b.rows;
    final columns = a.columns * b.columns;
    final builder = ComplexSparseMatrixBuilder(rows, columns);

    // Returns this row's nonzero (column, value) pairs, in ascending column
    // order -- via a direct CSR slice if sparse, via a full row scan if not.
    List<({int column, Complex value})> rowOfDense(ComplexMatrix m, int row) {
      final out = <({int column, Complex value})>[];
      for (var c = 0; c < m.columns; c++) {
        final v = m.get(row, c);
        if (!v.isZero) out.add((column: c, value: v));
      }
      return out;
    }

    List<({int column, Complex value})> rowOfSparse(
      ComplexSparseMatrix m,
      int row,
    ) {
      return m.nonZeroEntriesInRow(row); // needs adding, see below
    }

    final rowOfA = (a is ComplexSparseMatrix)
        ? (int r) => rowOfSparse(a, r)
        : (int r) => rowOfDense(a, r);

    final rowOfB = (b is ComplexSparseMatrix)
        ? (int r) => rowOfSparse(b, r)
        : (int r) => rowOfDense(b, r);

    for (var ar = 0; ar < a.rows; ar++) {
      final aRowEntries = rowOfA(ar); // ascending a_col
      if (aRowEntries.isEmpty) continue;
      for (var br = 0; br < b.rows; br++) {
        final bRowEntries = rowOfB(br); // ascending b_col
        if (bRowEntries.isEmpty) continue;
        final r = ar * b.rows + br;
        // a_col is the "outer" digit of the output column (it's multiplied
        // by b.columns), so it must be the outer loop for c to come out
        // ascending; b_col is the inner digit.
        for (final aEntry in aRowEntries) {
          for (final bEntry in bRowEntries) {
            final c = aEntry.column * b.columns + bEntry.column;
            builder.append(r, c, aEntry.value * bEntry.value);
          }
        }
      }
    }

    return builder.build();
  }

  static ComplexSparseMatrix tensorIdentity2(ComplexMatrix a) {
    final builder = ComplexSparseMatrixBuilder(a.rows * 2, a.columns * 2);

    if (a is ComplexSparseMatrix) {
      // Buffer one source row's entries at a time, then emit the "even"
      // row (2r) fully before the "odd" row (2r+1) -- same content as the
      // original interleaved set() calls, but reordered into the
      // monotonic row-major sequence append() requires.
      final pending = <(int column, Complex value)>[];
      int? currentRow;

      void flush() {
        if (currentRow == null) return;
        for (final (column, value) in pending) {
          builder.append(2 * currentRow, 2 * column, value);
        }
        for (final (column, value) in pending) {
          builder.append(2 * currentRow + 1, 2 * column + 1, value);
        }
        pending.clear();
      }

      for (final (:row, :column, :value) in a.nonZeroEntries) {
        if (row != currentRow) {
          flush();
          currentRow = row;
        }
        pending.add((column, value));
      }
      flush();
    } else {
      final rowEntries = <(int column, Complex value)>[];
      for (var r = 0; r < a.rows; r++) {
        rowEntries.clear();
        for (var c = 0; c < a.columns; c++) {
          final v = a.get(r, c);
          if (!v.isZero) rowEntries.add((c, v));
        }
        for (final (c, v) in rowEntries) {
          builder.append(2 * r, 2 * c, v);
        }
        for (final (c, v) in rowEntries) {
          builder.append(2 * r + 1, 2 * c + 1, v);
        }
      }
    }

    return builder.build();
  }

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
    1, // version
    'sparse', // kind
    rows, // size
    columns,
    [
      // values
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

/// Bulk-builds a CSR matrix from entries supplied in row-major order
/// (non-decreasing row, strictly increasing column within each row).
/// O(nnz) total, versus O(nnz * dim) for repeated set() calls.
class ComplexSparseMatrixBuilder {
  final int rows;
  final int columns;
  final List<int> _rowOffsets;
  final List<int> _columnIndices = [];
  final List<Complex> _values = [];
  int _currentRow = 0;

  ComplexSparseMatrixBuilder(this.rows, this.columns)
    : _rowOffsets = List<int>.filled(rows + 1, 0);

  void append(int row, int column, Complex value) {
    if (value.isZero) return;
    assert(row >= _currentRow, 'append() requires non-decreasing rows');
    while (_currentRow < row) {
      _currentRow++;
      _rowOffsets[_currentRow] = _columnIndices.length;
    }
    _columnIndices.add(column);
    _values.add(value);
  }

  ComplexSparseMatrix build() {
    while (_currentRow < rows) {
      _currentRow++;
      _rowOffsets[_currentRow] = _columnIndices.length;
    }
    return ComplexSparseMatrix._fromCsr(
      rows,
      columns,
      _rowOffsets,
      _columnIndices,
      _values,
    );
  }
}
