import 'dart:math';

import 'package:test/test.dart';

import 'package:qartvm/src/math/complex.dart';
import 'package:qartvm/src/qbit.dart';

import 'complex_matcher.dart';

void main() {
  group('Qubit', () {
    test('Zero |0>', () {
      final zero = Qbit.zero;
      expect(zero.ket0, complexEquals(Complex.one));
      expect(zero.ket1, complexEquals(Complex.zero));
      expect(zero.ket0.det + zero.ket1.det, closeTo(1, 1e-9));
    });

    test('One |1>', () {
      final one = Qbit.one;
      expect(one.ket0, complexEquals(Complex.zero));
      expect(one.ket1, complexEquals(Complex.one));
      expect(one.ket0.det + one.ket1.det, closeTo(1, 1e-9));
    });

    test('Plus |+>', () {
      final plus = Qbit.plus;
      expect(plus.ket0, complexEquals(Complex.one / sqrt2, precision: 1e-9));
      expect(plus.ket1, complexEquals(Complex.one / sqrt2, precision: 1e-9));
      expect(plus.ket0.det + plus.ket1.det, closeTo(1, 1e-9));
    });

    test('Minus |->', () {
      final minus = Qbit.minus;
      expect(minus.ket0, complexEquals(Complex.one / sqrt2, precision: 1e-9));
      expect(
          minus.ket1, complexEquals(Complex.minusOne / sqrt2, precision: 1e-9));
      expect(minus.ket0.det + minus.ket1.det, closeTo(1, 1e-9));
    });

    test('Random', () {
      final rnd = Qbit.random();
      expect(rnd.ket0.det + rnd.ket1.det, closeTo(1, 1e-9));
    });
  });
}
