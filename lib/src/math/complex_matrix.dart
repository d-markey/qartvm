import '../exceptions.dart';
import 'complex_array.dart';
import 'complex.dart';

class ComplexMatrix {
  ComplexMatrix._(this.rows, this.columns, List<Complex> values)
      : _values = ComplexArray(values);

  ComplexMatrix.generate(
      int rows, int columns, Complex Function(int row, int column) generator)
      : this._(
            rows,
            columns,
            Iterable.generate(
              rows,
              (row) => Iterable.generate(
                columns,
                (column) => generator(row, column),
              ),
            ).expand((v) => v).toList());

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

  ComplexMatrix.zero(this.rows, this.columns)
      : _values = ComplexArray.zero(rows * columns);

  ComplexMatrix.filled(int rows, int columns, Complex value)
      : this.generate(rows, columns, (row, column) => value);

  ComplexMatrix.identity(int rows)
      : this.generate(rows, rows,
            (row, column) => (row == column) ? Complex.one : Complex.zero);

  ComplexMatrix clone() =>
      ComplexMatrix.zero(rows, columns).._values.copy(_values);

  final ComplexArray _values;

  Complex get(int r, int c) => _values[_idx(r, c)];

  void copyTo(ComplexArray dest) {
    if (dest.length != _values.length) {
      throw InvalidOperationException();
    }
    dest.copy(_values);
  }

  late final int rows;
  late final int columns;

  @override
  late final int hashCode = rows * columns;

  bool get square => rows == columns;

  int _idx(int row, int column) => row * columns + column;

  ComplexMatrix copy(ComplexMatrix other) {
    if (rows != other.rows || columns != other.columns) {
      throw InvalidOperationException();
    }
    _values.copy(other._values);
    return this;
  }

  ComplexMatrix operator -() => clone().neg();

  ComplexMatrix neg() {
    for (var i = 0; i < _values.length; i++) {
      _values.neg(i);
    }
    return this;
  }

  ComplexMatrix operator +(ComplexMatrix other) => clone().add(other);

  ComplexMatrix add(ComplexMatrix other) {
    if (rows != other.rows || columns != other.columns) {
      throw InvalidOperationException(
          'Cannot add a ${rows}x$columns matrix and a ${other.rows}x${other.columns} matrix ');
    }
    for (var i = 0; i < _values.length; i++) {
      _values.add(i, _values, i, other._values, i);
    }
    return this;
  }

  ComplexMatrix operator -(ComplexMatrix other) => clone().sub(other);

  ComplexMatrix sub(ComplexMatrix other) {
    if (rows != other.rows || columns != other.columns) {
      throw InvalidOperationException();
    }
    for (var i = 0; i < _values.length; i++) {
      _values.sub(i, _values, i, other._values, i);
    }
    return this;
  }

  ComplexMatrix operator *(Object other) {
    if (other is num || other is Complex) {
      return clone().._values.scale(other);
    } else if (other is ComplexMatrix) {
      if (columns != other.rows) {
        throw InvalidOperationException(
            'Cannot multiply ${rows}x$columns by ${other.rows}x${other.columns}');
      }
      final res = ComplexMatrix.zero(rows, other.columns);
      final rv = res._values, ridx = res._idx;
      final ov = other._values, oidx = other._idx;
      for (var r = 0; r < res.rows; r++) {
        for (var c = 0; c < res.columns; c++) {
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

  ComplexMatrix operator /(Object other) {
    if (other is num || other is Complex) {
      return clone().._values.unscale(other);
    } else if (other is ComplexMatrix) {
      return this * other.inverse;
    } else {
      throw InvalidOperationException();
    }
  }

  ComplexMatrix div(Object other) {
    if (other is num || other is Complex) {
      _values.unscale(other);
    } else if (other is ComplexMatrix) {
      return mul(other.inverse);
    } else {
      throw InvalidOperationException();
    }
    return this;
  }

  static ComplexMatrix tensor(ComplexMatrix a, ComplexMatrix b,
      {ComplexMatrix? res}) {
    final arows = a.rows, acolumns = a.columns;
    final brows = b.rows, bcolumns = b.columns;

    final rows = arows * brows, columns = acolumns * bcolumns;
    final c = (res == null || res.rows != rows || res.columns != columns)
        ? ComplexMatrix.zero(rows, columns)
        : res;

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
        return copy._gaussianElimination(det: true, partial: true);
    }
  }

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

  ComplexMatrix conjugate() {
    final t = clone();
    for (var i = 0; i < t._values.length; i++) {
      t._values.conj(i);
    }
    return t;
  }

  ComplexMatrix normalize() {
    if (!square) {
      throw InvalidDimensionsException();
    }
    final norm = ComplexArray([det]);
    for (var i = 0; i < _values.length; i++) {
      _values.div(i, _values, i, norm, 0);
    }
    return this;
  }

  ComplexMatrix inverse() {
    if (rows == 1) {
      final inv = clone();
      inv._values.inv(0);
      return inv;
    } else {
      final copy = ComplexMatrix.zero(rows, rows * 2);
      final identity = ComplexMatrix.identity(rows);
      for (var r = 0; r < rows; r++) {
        for (var c = 0; c < columns; c++) {
          copy._values.assign(copy._idx(r, c), _values, _idx(r, c));
        }
        for (var c = 0; c < columns; c++) {
          copy._values.assign(
              copy._idx(r, rows + c), identity._values, identity._idx(r, c));
        }
      }
      if (copy._gaussianElimination() == Complex.zero) {
        throw InvalidOperationException();
      }
      final inv = ComplexMatrix.zero(rows, rows);
      for (var r = 0; r < rows; r++) {
        for (var c = 0; c < columns; c++) {
          inv._values
              .assign(inv._idx(r, c), copy._values, copy._idx(r, rows + c));
        }
      }
      return inv;
    }
  }

  void _swapRows(int r1, int r2) {
    for (var c = 0; c < columns; c++) {
      _values.swap(_idx(r1, c), _idx(r2, c));
    }
  }

  int _ensurePivot(int row) {
    var best = row;
    var bestDiff = double.maxFinite;
    for (var r = row; r < rows; r++) {
      final m = _values[_idx(r, row)].modulus;
      if (m == 0) continue;
      final diff = (m - 1).abs().toDouble();
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

  Complex _gaussianElimination({bool det = false, bool partial = false}) {
    final ratios = ComplexArray(List.generate(rows, (index) => Complex.zero));
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
      final start = partial ? row + 1 : 0;
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
    if (det) {
      for (var i = 1; i < rows; i++) {
        ratios.mul(0, ratios, 0, ratios, i);
      }
      if (sign < 0) {
        ratios.neg(0);
      }
    }
    return ratios[0];
  }

  @override
  String toString() => toStringIndent(0);

  String toStringIndent(int indent, {int? fractionDigits}) {
    final spaces = '   ';
    final tabs = spaces * indent;
    final sb = StringBuffer();
    sb.write('$tabs[\n');
    for (var r = 0; r < rows; r++) {
      if (r > 0) {
        sb.write(',\n');
      }
      sb.write('$tabs$spaces[');
      for (var c = 0; c < columns; c++) {
        final v = _values[_idx(r, c)];
        if (c > 0) {
          sb.write(', ');
        }
        sb.write(fractionDigits == null
            ? v.toString()
            : v.toStringAsFixed(fractionDigits));
      }
      sb.write(']');
    }
    sb.write('\n$tabs]');
    return sb.toString();
  }
}
