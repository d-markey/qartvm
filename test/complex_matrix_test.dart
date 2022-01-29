import 'dart:math';

import 'package:test/test.dart';

import 'package:qartvm/src/exceptions.dart';
import 'package:qartvm/src/math/complex_matrix.dart';
import 'package:qartvm/src/math/complex.dart';

import 'complex_matcher.dart';

ComplexMatrix _complexMatrix(List<List<num>> matrix) => ComplexMatrix(matrix
    .map((row) => row.map((v) => Complex(re: v.toDouble())).toList())
    .toList());

void main() {
  group('1x1', () {
    group('Operators', () {
      test('Addition', () {
        final a = ComplexMatrix([
          [Complex(re: 1, im: 1)]
        ]);
        final b = ComplexMatrix([
          [Complex(re: 2, im: -0.5)]
        ]);
        final c = a + b;

        expect(
            a,
            complexMatrixEquals(ComplexMatrix([
              [Complex(re: 1, im: 1)]
            ])));
        expect(
            b,
            complexMatrixEquals(ComplexMatrix([
              [Complex(re: 2, im: -0.5)]
            ])));
        expect(
            c,
            complexMatrixEquals(ComplexMatrix([
              [Complex(re: 3, im: 0.5)]
            ])));
      });

      test('Substraction', () {
        final a = ComplexMatrix([
          [Complex(re: 1, im: 1)]
        ]);
        final b = ComplexMatrix([
          [Complex(re: 2, im: -0.5)]
        ]);
        final c = a - b;

        expect(
            a,
            complexMatrixEquals(ComplexMatrix([
              [Complex(re: 1, im: 1)]
            ])));
        expect(
            b,
            complexMatrixEquals(ComplexMatrix([
              [Complex(re: 2, im: -0.5)]
            ])));
        expect(
            c,
            complexMatrixEquals(ComplexMatrix([
              [Complex(re: -1, im: 1.5)]
            ])));
      });
    });

    group('In-memory operations', () {
      test('Addition', () {
        final a = ComplexMatrix([
          [Complex(re: 1, im: 1)]
        ]);
        final b = ComplexMatrix([
          [Complex(re: 2, im: -0.5)]
        ]);
        final c = a.add(b);

        expect(
            a,
            complexMatrixEquals(ComplexMatrix([
              [Complex(re: 3, im: 0.5)]
            ])));
        expect(
            b,
            complexMatrixEquals(ComplexMatrix([
              [Complex(re: 2, im: -0.5)]
            ])));
        expect(
            c,
            complexMatrixEquals(ComplexMatrix([
              [Complex(re: 3, im: 0.5)]
            ])));
        expect(identical(a, c), isTrue);
      });

      test('Substraction', () {
        final a = ComplexMatrix([
          [Complex(re: 1, im: 1)]
        ]);
        final b = ComplexMatrix([
          [Complex(re: 2, im: -0.5)]
        ]);
        final c = a.sub(b);

        expect(
            a,
            complexMatrixEquals(ComplexMatrix([
              [Complex(re: -1, im: 1.5)]
            ])));
        expect(
            b,
            complexMatrixEquals(ComplexMatrix([
              [Complex(re: 2, im: -0.5)]
            ])));
        expect(
            c,
            complexMatrixEquals(ComplexMatrix([
              [Complex(re: -1, im: 1.5)]
            ])));
        expect(identical(a, c), isTrue);
      });
    });

    group('Determinant', () {
      test('Zero', () {
        final a = ComplexMatrix([
          [Complex.zero]
        ]);
        expect(a.det, isZero);
      });

      test('Non-zero', () {
        final a = ComplexMatrix([
          [Complex(re: 0.5, im: -1)]
        ]);
        expect(a.det, complexEquals(Complex.one));
      });
    });
  });

  group('4x4', () {
    group('Determinant', () {
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

    group('Inverse', () {
      test('Invertible', () {
        final a = _complexMatrix([
          [1, 1, 1, 1],
          [1, 0, 0, 0],
          [1, 0, 2, 3],
          [1, 0, 4, 5],
        ]);
        final b = a.inverse();

        expect(a * b,
            complexMatrixEquals(ComplexMatrix.identity(4), precision: 1e-9));
        expect(b * a,
            complexMatrixEquals(ComplexMatrix.identity(4), precision: 1e-9));

        expect(
            b,
            complexMatrixEquals(
                _complexMatrix([
                  [0, 1, 0, 0],
                  [1, -1, 0.5, -0.5],
                  [0, 1, -2.5, 1.5],
                  [0, -1, 2, -1],
                ]),
                precision: 1e-9));
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

  group('Random', () {
    test('Inverse', () {
      final rnd = Random.secure();
      for (var i = 0; i < 100; i++) {
        final size = 2 + rnd.nextInt(30 + 1); // 2-32
        final matrix =
            ComplexMatrix.generate(size, size, (r, c) => Complex.random());
        final d = matrix.det.modulus;
        if (d == 0) {
          expect(() => matrix.inverse(),
              throwsA(isA<InvalidOperationException>()));
        } else {
          final inv = matrix.inverse();
          final prod = matrix * inv;
          expect(
              prod,
              complexMatrixEquals(ComplexMatrix.identity(size),
                  precision: 1e-9));
        }
      }
    });
  });
}
