import 'dart:math' as math;

import 'package:qartvm/qartvm.dart';

import '../exceptions.dart';
import '../extensions.dart';

/// Class representing a complex value
class Complex {
  /// Builds a new complex value with real part [re] and imaginary part [im]
  const Complex({this.re = 0, this.im = 0});

  /// Builds a new complex value from polar coordinates, with radius [radius] and angle [angle]
  Complex.polar({double radius = 0, double angle = 0})
      : this(re: radius * math.cos(angle), im: radius * math.sin(angle));

  /// Builds a new random complex value so that [modulus] < [radius]
  /// If [re] is `false`, the real part will be forced to 0
  /// If [im] is `true`, the imaginary part will be forced to 0
  factory Complex.random(
      {double radius = 1.0, bool re = true, bool im = true}) {
    var complex = Complex(
        re: re ? _rnd.nextDouble() * 2 - 1 : 0,
        im: im ? _rnd.nextDouble() * 2 - 1 : 0);
    if (complex != Complex.zero) {
      complex = complex * ((radius * _rnd.nextDouble()) / complex.modulus);
    }
    return complex;
  }

  /// Returns the real part of this instance
  final double re;

  /// Returns the imaginary part of this instance
  final double im;

  /// Complex zero = 0 + 0 i
  static const zero = Complex(re: 0);

  /// Complex one = 1 + 0 i
  static const one = Complex(re: 1);

  /// Opposite of complex one = -1 + 0 i
  static const minusOne = Complex(re: -1);

  /// Complex i = 0 + 1 i
  static const i = Complex(im: 1);

  static final _rnd = math.Random.secure();

  /// Returns a new [Complex] value which is the opposite of this instance
  Complex operator -() => Complex(re: -re, im: -im);

  /// Returns a new [Complex] value obtained by adding [other] to this instance
  /// [other] may be a [num] or a [Complex]
  /// If [other] is 0 or [Complex.zero], the current instance is returned
  Complex operator +(Object other) {
    if (other is num) {
      return (other == 0) ? this : Complex(re: re + other, im: im);
    } else if (other is Complex) {
      return (other == Complex.zero)
          ? this
          : Complex(re: re + other.re, im: im + other.im);
    } else {
      throw InvalidOperationException(
          'Cannot add ${other.runtimeType} to $this');
    }
  }

  /// Returns a new [Complex] value obtained by subtracting [other] from this instance
  /// [other] may be a [num] or a [Complex]
  /// If [other] is 0 or [Complex.zero], the current instance is returned
  Complex operator -(Object other) {
    if (other is num) {
      return (other == 0) ? this : Complex(re: re - other, im: im);
    } else if (other is Complex) {
      return (other == Complex.zero)
          ? this
          : Complex(re: re - other.re, im: im - other.im);
    } else {
      throw InvalidOperationException(
          'Cannot subtract ${other.runtimeType} from $this');
    }
  }

  /// Returns a new [Complex] value obtained by multiplying this instance by [other]
  /// [other] may be a [num] or a [Complex]
  /// If [other] is 0 or [Complex.zero], [Complex.zero] is returned
  /// If [other] is 1 or [Complex.one], the current instance is returned
  Complex operator *(Object other) {
    if (other is num) {
      if (other == 0) {
        return Complex.zero;
      } else if (other == 1) {
        return this;
      } else {
        return Complex(re: re * other, im: im * other);
      }
    } else if (other is Complex) {
      if (other == Complex.zero) {
        return Complex.zero;
      } else if (other == Complex.one) {
        return this;
      } else {
        return Complex(
            re: re * other.re - im * other.im,
            im: re * other.im + im * other.re);
      }
    } else {
      throw InvalidOperationException(
          'Cannot multiply ${other.runtimeType} by $this');
    }
  }

  /// Returns a new [Complex] value obtained by dividing this instance by [other]
  /// [other] may be a [num] or a [Complex]
  /// If [other] is 1 or [Complex.one], the current instance is returned
  Complex operator /(Object other) {
    if (other is num) {
      if (other == 1) {
        return this;
      } else {
        return Complex(re: re / other, im: im / other);
      }
    } else if (other is Complex) {
      if (other == Complex.one) {
        return this;
      } else {
        final d = other.det;
        return Complex(
            re: (re * other.re + im * other.im) / d,
            im: (im * other.re - re * other.im) / d);
      }
    } else {
      throw InvalidOperationException(
          'Cannot divide ${other.runtimeType} by $this');
    }
  }

  @override
  bool operator ==(dynamic other) {
    if (other is num) {
      return re == other && im == 0;
    } else if (other is Complex) {
      return re == other.re && im == other.im;
    } else {
      return false;
    }
  }

  /// Returns true if [other] is equal to this instance down to a precision of [precision]
  /// [other] may be a [num] or a [Complex]
  bool equals(Object other, {double precision = 0}) {
    if (other is num) {
      return (re - other).abs() <= precision;
    } else if (other is Complex) {
      final complex = this - other;
      return complex.modulus <= precision;
    } else {
      throw InvalidOperationException(
          'Cannot compare ${other.runtimeType} with $this');
    }
  }

  @override
  int get hashCode => re.hashCode + im.hashCode * 17;

  /// Returns a new [Complex] value which is the inverse of this instance
  Complex get inverse {
    final d = det;
    return Complex(re: re / d, im: -im / d);
  }

  /// Returns a new [Complex] value which is the conjugate of this instance
  Complex get conjugate => Complex(re: re, im: -im);

  /// Returns the determinant of this instance (i.e. [re] * [re] + [im] * [im])
  double get det => re * re + im * im;

  /// Returns the modulus of this instance (i.e. the square root of [det])
  double get modulus => math.sqrt(det);

  @override
  String toString() {
    num r = re.normalize();
    num i = im.normalize();

    if (i == 0) return '$r';
    if (r == 0) return '$i i';
    if (i > 0) {
      return '$r + $i i';
    } else {
      return '$r - ${-i} i';
    }
  }

  /// Returns a String representation of this instance with [re] and [im] formatted via [num.toStringAsFixed]
  String toStringAsFixed(int fractionDigits) {
    num r = num.parse(re.toStringAsFixed(fractionDigits)).normalize();
    num i = num.parse(im.toStringAsFixed(fractionDigits)).normalize();

    if (i == 0) return r.toStringAsFixed(fractionDigits);
    if (r == 0) return '${i.toStringAsFixed(fractionDigits)} i';
    if (i > 0) {
      return '${r.toStringAsFixed(fractionDigits)} + ${i.toStringAsFixed(fractionDigits)} i';
    } else {
      return '${r.toStringAsFixed(fractionDigits)} - ${(-i).toStringAsFixed(fractionDigits)} i';
    }
  }
}
