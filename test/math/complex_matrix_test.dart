import 'dart:math';

import 'package:qartvm/qartvm.dart';
import 'package:test/test.dart';

import 'complex_matcher.dart';

ComplexMatrix _complexMatrix(List<List<num>> matrix) => ComplexDenseMatrix(
  matrix
      .map((row) => row.map((v) => Complex(re: v.toDouble())).toList())
      .toList(),
);

void main() {
  group('Sparse representation -', () {
    test('stores zero and identity without zero entries', () {
      final zero = ComplexSparseMatrix.zero(4, 4);
      final identity = ComplexSparseMatrix.identity(4);

      expect(zero.nonZeroCount, 0);
      expect(identity.nonZeroCount, 4);
      expect(identity.isIdentity, isTrue);
    });

    test('stores, mutates, compares, and serializes non-zero values', () {
      final sparse = ComplexSparseMatrix.zero(2, 2);
      sparse.set(0, 1, Complex.i);
      expect(sparse.nonZeroCount, 1);
      expect(sparse.get(0, 1), Complex.i);
      sparse.set(0, 1, Complex.zero);
      expect(sparse.nonZeroCount, 0);

      final original = ComplexSparseMatrix([
        [Complex.one, Complex.zero],
        [Complex.zero, Complex.i],
      ]);
      final restored = ComplexMatrix.deserialize(original.serialize());
      expect(restored, isA<ComplexSparseMatrix>());
      expect(restored, complexMatrixEquals(original));
    });

    test('matches dense results for complex operations', () {
      final dense = ComplexDenseMatrix([
        [Complex.one, Complex.i, Complex.zero],
        [Complex.zero, Complex(re: 2, im: -1), Complex.one],
        [Complex.i, Complex.zero, Complex.one],
      ]);
      final sparse = ComplexSparseMatrix.fromMatrix(dense);

      expect(sparse, complexMatrixEquals(dense));
      expect(sparse.nonZeroCount, 6);
      expect(
        sparse + (-sparse),
        complexMatrixEquals(ComplexSparseMatrix.zero(3, 3)),
      );
      expect(sparse.transpose(), complexMatrixEquals(dense.transpose()));
      expect(sparse.conjugate(), complexMatrixEquals(dense.conjugate()));
      expect(sparse.dagger(), complexMatrixEquals(dense.dagger()));
      expect(sparse * dense, complexMatrixEquals(dense * dense));
    });

    test('keeps sparse tensor products sparse and numerically correct', () {
      final a = ComplexSparseMatrix([
        [Complex.one, Complex.zero],
        [Complex.zero, Complex(re: 2)],
      ]);
      final b = ComplexSparseMatrix([
        [Complex.zero, Complex.one],
        [Complex.one, Complex.zero],
      ]);

      final tensor = ComplexMatrix.tensor(a, b);

      expect(tensor, isA<ComplexSparseMatrix>());
      expect(
        tensor,
        complexMatrixEquals(
          ComplexDenseMatrix([
            [Complex.zero, Complex.one, Complex.zero, Complex.zero],
            [Complex.one, Complex.zero, Complex.zero, Complex.zero],
            [Complex.zero, Complex.zero, Complex.zero, Complex(re: 2)],
            [Complex.zero, Complex.zero, Complex(re: 2), Complex.zero],
          ]),
          precision: 1e-9,
        ),
      );
    });

    test('uses dense conversion for determinant and inverse', () {
      final sparse = ComplexSparseMatrix([
        [Complex.one, Complex.one],
        [Complex.one, Complex.zero],
      ]);

      expect(sparse.det, complexEquals(Complex.minusOne));
      expect(
        sparse * sparse.inverse(),
        complexMatrixEquals(ComplexDenseMatrix.identity(2), precision: 1e-9),
      );
    });
  });

  group('1x1 -', () {
    group('Operators -', () {
      test('Addition', () {
        final a = ComplexDenseMatrix([
          [Complex(re: 1, im: 1)],
        ]);
        final b = ComplexDenseMatrix([
          [Complex(re: 2, im: -0.5)],
        ]);
        final c = a + b;

        expect(
          a,
          complexMatrixEquals(
            ComplexDenseMatrix([
              [Complex(re: 1, im: 1)],
            ]),
          ),
        );
        expect(
          b,
          complexMatrixEquals(
            ComplexDenseMatrix([
              [Complex(re: 2, im: -0.5)],
            ]),
          ),
        );
        expect(
          c,
          complexMatrixEquals(
            ComplexDenseMatrix([
              [Complex(re: 3, im: 0.5)],
            ]),
          ),
        );
      });

      test('Substraction', () {
        final a = ComplexDenseMatrix([
          [Complex(re: 1, im: 1)],
        ]);
        final b = ComplexDenseMatrix([
          [Complex(re: 2, im: -0.5)],
        ]);
        final c = a - b;

        expect(
          a,
          complexMatrixEquals(
            ComplexDenseMatrix([
              [Complex(re: 1, im: 1)],
            ]),
          ),
        );
        expect(
          b,
          complexMatrixEquals(
            ComplexDenseMatrix([
              [Complex(re: 2, im: -0.5)],
            ]),
          ),
        );
        expect(
          c,
          complexMatrixEquals(
            ComplexDenseMatrix([
              [Complex(re: -1, im: 1.5)],
            ]),
          ),
        );
      });
    });

    group('In-memory operations -', () {
      test('Addition', () {
        final a = ComplexDenseMatrix([
          [Complex(re: 1, im: 1)],
        ]);
        final b = ComplexDenseMatrix([
          [Complex(re: 2, im: -0.5)],
        ]);
        final c = a.add(b);

        expect(
          a,
          complexMatrixEquals(
            ComplexDenseMatrix([
              [Complex(re: 3, im: 0.5)],
            ]),
          ),
        );
        expect(
          b,
          complexMatrixEquals(
            ComplexDenseMatrix([
              [Complex(re: 2, im: -0.5)],
            ]),
          ),
        );
        expect(
          c,
          complexMatrixEquals(
            ComplexDenseMatrix([
              [Complex(re: 3, im: 0.5)],
            ]),
          ),
        );
        expect(identical(a, c), isTrue);
      });

      test('Substraction', () {
        final a = ComplexDenseMatrix([
          [Complex(re: 1, im: 1)],
        ]);
        final b = ComplexDenseMatrix([
          [Complex(re: 2, im: -0.5)],
        ]);
        final c = a.sub(b);

        expect(
          a,
          complexMatrixEquals(
            ComplexDenseMatrix([
              [Complex(re: -1, im: 1.5)],
            ]),
          ),
        );
        expect(
          b,
          complexMatrixEquals(
            ComplexDenseMatrix([
              [Complex(re: 2, im: -0.5)],
            ]),
          ),
        );
        expect(
          c,
          complexMatrixEquals(
            ComplexDenseMatrix([
              [Complex(re: -1, im: 1.5)],
            ]),
          ),
        );
        expect(identical(a, c), isTrue);
      });
    });

    group('Determinant -', () {
      test('Zero', () {
        final a = ComplexDenseMatrix([
          [Complex.zero],
        ]);
        expect(a.det, isZero);
      });

      test('Non-zero', () {
        final a = ComplexDenseMatrix([
          [Complex(re: 0.5, im: -1)],
        ]);
        expect(a.det, complexEquals(Complex.one));
      });
    });
  });

  group('4x4 -', () {
    group('Determinant -', () {
      test('Invertible', () {
        final a = _complexMatrix([
          [1, 1, 1, 1],
          [1, 0, 0, 0],
          [1, 0, 2, 3],
          [1, 0, 4, 5],
        ]);
        expect(a.det, complexEquals(Complex(re: 2)));
      });

      test('Non-invertible', () {
        final a = _complexMatrix([
          [1, 2, 3, 4],
          [5, 6, 7, 8],
          [9, 10, 11, 12],
          [13, 14, 15, 16],
        ]);
        expect(a.det, complexEquals(Complex.zero));
        expect(() => a.inverse(), throwsA(isA<InvalidOperationException>()));
      });
    });

    group('Inverse -', () {
      test('Invertible', () {
        final a = _complexMatrix([
          [1, 1, 1, 1],
          [1, 0, 0, 0],
          [1, 0, 2, 3],
          [1, 0, 4, 5],
        ]);
        final b = a.inverse();

        expect(
          a * b,
          complexMatrixEquals(ComplexDenseMatrix.identity(4), precision: 1e-9),
        );
        expect(
          b * a,
          complexMatrixEquals(ComplexDenseMatrix.identity(4), precision: 1e-9),
        );

        expect(
          b,
          complexMatrixEquals(
            _complexMatrix([
              [0, 1, 0, 0],
              [1, -1, 0.5, -0.5],
              [0, 1, -2.5, 1.5],
              [0, -1, 2, -1],
            ]),
            precision: 1e-9,
          ),
        );
      });

      test('Non-invertible', () {
        final a = _complexMatrix([
          [1, 2, 3, 4],
          [5, 6, 7, 8],
          [9, 10, 11, 12],
          [13, 14, 15, 16],
        ]);
        expect(a.det, complexEquals(Complex.zero));
        expect(() => a.inverse(), throwsA(isA<InvalidOperationException>()));
      });
    });
  });

  group('Random -', () {
    test('Inverse', () {
      final rnd = Random.secure();
      for (var i = 0; i < 100; i++) {
        final size = 2 + rnd.nextInt(30 + 1); // 2-32
        final matrix = ComplexDenseMatrix.generate(
          size,
          size,
          (r, c) => Complex.random(),
        );
        final d = matrix.det.modulus;
        if (d == 0) {
          expect(matrix.inverse, throwsA(isA<InvalidOperationException>()));
        } else {
          final inv = matrix.inverse();
          final prod = matrix * inv;
          expect(
            prod,
            complexMatrixEquals(
              ComplexDenseMatrix.identity(size),
              precision: 1e-9,
            ),
          );
        }
      }
    });
  });
}
