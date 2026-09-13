import 'dart:math';

import 'package:qartvm/qartvm.dart';
import 'package:test/test.dart';

import 'math/complex_matcher.dart';

void main() {
  group('Qubit -', () {
    test('Zero |0>', () {
      final zero = Qbit.zero;
      expect(zero.ket0, complexEquals(Complex.one));
      expect(zero.ket1, complexEquals(Complex.zero));
      expect(zero.ket0.modulus2 + zero.ket1.modulus2, closeTo(1, 1e-9));
    });

    test('One |1>', () {
      final one = Qbit.one;
      expect(one.ket0, complexEquals(Complex.zero));
      expect(one.ket1, complexEquals(Complex.one));
      expect(one.ket0.modulus2 + one.ket1.modulus2, closeTo(1, 1e-9));
    });

    test('Plus |+>', () {
      final plus = Qbit.plus;
      expect(plus.ket0, complexEquals(Complex.one * sqrt1_2, precision: 1e-9));
      expect(plus.ket1, complexEquals(Complex.one * sqrt1_2, precision: 1e-9));
      expect(plus.ket0.modulus2 + plus.ket1.modulus2, closeTo(1, 1e-9));
    });

    test('Minus |->', () {
      final minus = Qbit.minus;
      expect(minus.ket0, complexEquals(Complex.one * sqrt1_2, precision: 1e-9));
      expect(
        minus.ket1,
        complexEquals(-Complex.one * sqrt1_2, precision: 1e-9),
      );
      expect(minus.ket0.modulus2 + minus.ket1.modulus2, closeTo(1, 1e-9));
    });

    test('Random', () {
      final rnd = Qbit.random();
      expect(rnd.ket0.modulus2 + rnd.ket1.modulus2, closeTo(1, 1e-9));
    });
  });
}
