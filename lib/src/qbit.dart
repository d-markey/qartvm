import 'dart:math' as math;

import 'math/complex.dart';
import 'exceptions.dart';
import 'extensions.dart';

class Qbit {
  Qbit({required this.ket0, required this.ket1}) {
    if (!(ket0.det + ket1.det).equals(1, precision: 1e-9)) {
      throw InvalidQubitException();
    }
  }

  static Qbit random() {
    var k0 = Complex.random();
    var k1 = Complex.random();
    final adjust = math.sqrt(k0.det + k1.det);
    k0 /= adjust;
    k1 /= adjust;
    return Qbit(ket0: k0, ket1: k1);
  }

  Qbit withError({double errorLevel = 0.01}) {
    Complex k0;
    do {
      var error = Complex.random(radius: errorLevel);
      k0 = ket0 + error;
    } while (k0.det > 1);

    Complex k1;
    do {
      var error = Complex.random(radius: errorLevel);
      k1 = ket1 + error;
    } while (k1.det > 1);

    final adjust = math.sqrt(k0.det + k1.det);
    k0 /= adjust;
    k1 /= adjust;

    return Qbit(ket0: k0, ket1: k1);
  }

  final Complex ket0;
  final Complex ket1;

  static Qbit get zero => Qbit(ket0: Complex.one, ket1: Complex.zero);
  static Qbit get one => Qbit(ket0: Complex.zero, ket1: Complex.one);
  static Qbit get plus =>
      Qbit(ket0: Complex(re: math.sqrt1_2), ket1: Complex(re: math.sqrt1_2));
  static Qbit get minus =>
      Qbit(ket0: Complex(re: math.sqrt1_2), ket1: Complex(re: -math.sqrt1_2));

  String _component(Complex c) {
    if (c.im == 0 || c.re == 0) {
      return c.toString();
    } else {
      return '($c)';
    }
  }

  @override
  String toString() {
    if (ket0 == Complex.zero) {
      if (ket1 == Complex.one) {
        return '|1>';
      } else {
        final k1 = _component(ket1);
        return '$k1 |1>';
      }
    } else if (ket1 == Complex.zero) {
      if (ket0 == Complex.one) {
        return '|0>';
      } else {
        final k0 = _component(ket0);
        return '$k0 |0>';
      }
    } else {
      final k0 = _component(ket0);
      var k1 = _component(ket1);
      if (k1.startsWith('-')) {
        k1 = k1.substring(1);
        return '$k0 |0> - $k1 |1>';
      } else {
        return '$k0 |0> + $k1 |1>';
      }
    }
  }
}
