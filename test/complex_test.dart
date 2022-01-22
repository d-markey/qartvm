import 'dart:math' as math;

import 'package:test/test.dart';

import 'package:qartvm/src/math/complex.dart';

import 'complex_matcher.dart';

void main() {
  group('Complex', () {
    group('Constants', () {
      test('zero', () {
        final a = Complex.zero;
        expect(a.det, equals(0));
        expect(a.modulus, equals(0));
        expect(a, complexEquals(Complex(re: 0)));
        expect(a, complexEquals(Complex.polar(radius: 0), precision: 1e-9));
      });

      test('one', () {
        final a = Complex.one;
        expect(a.det, equals(1));
        expect(a.modulus, equals(1));
        expect(a, complexEquals(Complex(re: 1)));
        expect(a,
            complexEquals(Complex.polar(radius: 1, angle: 0), precision: 1e-9));
      });

      test('i', () {
        final a = Complex.i;
        expect(a.det, equals(1));
        expect(a.modulus, equals(1));
        expect(a, complexEquals(Complex(im: 1)));
        expect(
            a,
            complexEquals(Complex.polar(radius: 1, angle: math.pi / 2),
                precision: 1e-9));
      });
    });

    group('Operators', () {
      test('Addition', () {
        final a = Complex.i;
        final b = Complex(re: 2, im: -2);
        expect(a + b, complexEquals(Complex(re: 2, im: -1), precision: 1e-9));
        final c = Complex.polar(radius: 3, angle: math.pi / 4);
        expect(
            a + c,
            complexEquals(
                Complex(re: 3 * math.sqrt1_2, im: 1 + 3 * math.sqrt1_2),
                precision: 1e-9));
      });

      test('Substraction', () {
        final a = Complex.i;
        final b = Complex(re: 2, im: -2);
        expect(a - b, complexEquals(Complex(re: -2, im: 3), precision: 1e-9));
        final c = Complex.polar(radius: 3, angle: math.pi / 4);
        expect(
            a - c,
            complexEquals(
                Complex(re: -3 * math.sqrt1_2, im: 1 - 3 * math.sqrt1_2),
                precision: 1e-9));
      });

      test('Multiplication', () {
        final a = Complex.i;
        expect(a * a, complexEquals(Complex.minusOne));
        final b = Complex.polar(radius: 3, angle: math.pi / 4);
        expect(
            a * b,
            complexEquals(Complex.polar(radius: 3, angle: 3 * math.pi / 4),
                precision: 1e-9));
      });

      test('Division', () {
        final a = Complex.i;
        expect(a / 2, complexEquals(Complex(im: 1 / 2)));
        final b = Complex(re: 0, im: 3);
        final c = Complex.polar(radius: 2, angle: math.pi / 4);
        expect(
            b / c,
            complexEquals(
                Complex(re: 3 * math.sqrt1_2 / 2, im: 3 * math.sqrt1_2 / 2),
                precision: 1e-9));
      });
    });
  });
}
