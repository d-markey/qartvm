import 'dart:math' as math;

import 'math/complex.dart';
import 'exceptions.dart';
import 'extensions.dart';

/// Class representing a qubit
class Qbit {
  /// Builds a qubit in state [ket0] |0> + [ket1] |1>
  /// |[ket0]|² + |[ket1]|² must be equal to 1
  Qbit({required this.ket0, required this.ket1}) {
    if (!(ket0.det + ket1.det).equals(1, precision: 1e-9)) {
      throw InvalidQubitError();
    }
  }

  /// Builds a random qubit
  static Qbit random() {
    var k0 = Complex.random();
    var k1 = Complex.random();
    final adjust = math.sqrt(k0.det + k1.det);
    k0 /= adjust;
    k1 /= adjust;
    return Qbit(ket0: k0, ket1: k1);
  }

  /// Builds a new qubit with amplitudes within [errorLevel] from this instance's amplitudes
  Qbit withError({double errorLevel = 0.01}) {
    var error = Complex.random(radius: errorLevel);
    var k0 = ket0 + error;

    error = Complex.random(radius: errorLevel);
    var k1 = ket1 + error;

    final adjust = math.sqrt(k0.det + k1.det);
    k0 /= adjust;
    k1 /= adjust;

    return Qbit(ket0: k0, ket1: k1);
  }

  /// amplitude for |0>
  final Complex ket0;

  /// amplitude for |1>
  final Complex ket1;

  /// constant for state |0>
  static final Qbit zero = Qbit(ket0: Complex.one, ket1: Complex.zero);

  /// constant for state |1>
  static final Qbit one = Qbit(ket0: Complex.zero, ket1: Complex.one);

  /// constant for state |+> = (|0> + |1>) / sqrt(2)
  static final Qbit plus =
      Qbit(ket0: Complex(re: math.sqrt1_2), ket1: Complex(re: math.sqrt1_2));

  /// constant for state |-> = (|0> - |1>) / sqrt(2)
  static final Qbit minus =
      Qbit(ket0: Complex(re: math.sqrt1_2), ket1: Complex(re: -math.sqrt1_2));

  /// generates a sequence of [count] qubits derived from bits in [n]
  /// if [count] is not provided or <= 0, the sequence will contain just enough qubits to represent [n]
  static Iterable<Qbit> fromInt(int n, {int? count}) sync* {
    final value = n;
    var nb = count ?? 0;
    if (nb <= 0) {
      nb = 0;
      var m = n;
      while (m != 0) {
        nb++;
        m >>= 1;
      }
      if (nb == 0) {
        nb = 1;
      }
    }
    while (nb > 0) {
      yield ((n & 1) == 0) ? Qbit.zero : Qbit.one;
      n >>= 1;
      nb--;
    }
    if (n != 0) {
      throw InvalidOperationException(
          'Overflow for initialization value $value');
    }
  }

  String _component(Complex c) {
    if (c.im == 0 || c.re == 0) {
      return c.toString();
    } else {
      return '($c)';
    }
  }

  @override
  bool operator ==(dynamic other) =>
      (other is Qbit) && (ket0 == other.ket0) && (ket1 == other.ket1);

  bool equals(Object other, {double precision = 0}) =>
      (other is Qbit) &&
      ket0.equals(other.ket0, precision: precision) &&
      ket1.equals(other.ket1, precision: precision);

  @override
  int get hashCode => ket0.hashCode + 31 * ket1.hashCode;

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
    } else if (equals(Qbit.plus)) {
      return '|+>';
    } else if (equals(Qbit.minus)) {
      return '|->';
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
