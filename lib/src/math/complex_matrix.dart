import '_complex_array.dart';
import 'complex.dart';
import 'complex_dense_matrix.dart';
import 'complex_sparse_matrix.dart';

enum ComplexMatrixType { dense, sparse }

abstract class ComplexMatrix {
  ComplexMatrix.base();

  int get memoryFootprint;

  int get rows;

  int get columns;

  bool get isSquare => rows == columns;

  Complex get(int row, int column);

  void set(int row, int column, Complex value);

  ComplexMatrix clone();

  ComplexMatrix copy(covariant ComplexMatrix other);

  void copyFrom(ComplexArray source);

  void copyTo(ComplexArray destination);

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

  String toStringIndent({
    int indent,
    int? fractionDigits,
    bool hideZeroes,
    double precision,
  });

  static ComplexMatrix tensor(ComplexMatrix a, ComplexMatrix b) {
    final ComplexMatrix result;
    final rows = a.rows * b.rows;
    final columns = a.columns * b.columns;
    final sparseA = a is ComplexSparseMatrix ? a : null;
    final sparseB = b is ComplexSparseMatrix ? b : null;
    if (sparseA != null && sparseB != null) {
      // full sparse
      result = ComplexSparseMatrix.zero(rows, columns);
      for (final (ar, ac, av) in sparseA.nonZeroEntries) {
        for (final (br, bc, bv) in sparseB.nonZeroEntries) {
          final r = ar * b.rows + br;
          final c = ac * b.columns + bc;
          result.set(r, c, result.get(r, c) + av * bv);
        }
      }
    } else if (sparseA != null) {
      // sparseB == null
      result = ComplexSparseMatrix.zero(rows, columns);
      for (final (ar, ac, av) in sparseA.nonZeroEntries) {
        for (var br = 0; br < b.rows; br++) {
          for (var bc = 0; bc < b.columns; bc++) {
            final bv = b.get(br, bc);
            if (bv == Complex.zero) continue;
            final r = ar * b.rows + br;
            final c = ac * b.columns + bc;
            result.set(r, c, result.get(r, c) + av * bv);
          }
        }
      }
    } else if (sparseB != null) {
      // sparseA == null
      result = ComplexSparseMatrix.zero(rows, columns);
      for (var ar = 0; ar < a.rows; ar++) {
        for (var ac = 0; ac < a.columns; ac++) {
          final av = a.get(ar, ac);
          if (av == Complex.zero) continue;
          for (final (br, bc, bv) in sparseB.nonZeroEntries) {
            final r = ar * b.rows + br;
            final c = ac * b.columns + bc;
            result.set(r, c, result.get(r, c) + av * bv);
          }
        }
      }
    } else {
      // full dense
      result = ComplexDenseMatrix.zero(rows, columns);
      for (var ar = 0; ar < a.rows; ar++) {
        for (var ac = 0; ac < a.columns; ac++) {
          final av = a.get(ar, ac);
          if (av == Complex.zero) continue;
          for (var br = 0; br < b.rows; br++) {
            for (var bc = 0; bc < b.columns; bc++) {
              final bv = b.get(br, bc);
              if (bv == Complex.zero) continue;
              final r = ar * b.rows + br;
              final c = ac * b.columns + bc;
              result.set(r, c, result.get(r, c) + av * bv);
            }
          }
        }
      }
    }

    return result;
  }

  Complex get det;

  ComplexMatrix inverse();

  bool equals(ComplexMatrix other, {double precision = 0});

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
