import 'dart:math' as math;

import 'package:qartvm/qartvm.dart';

import '../utils/exceptions.dart';
import '../utils/extensions.dart';

/// Extension type representing a complex value
class Complex {
  /// Builds a new complex value with real part [re] and imaginary part [im]
  Complex({this.re = 0, this.im = 0});

  /// Builds a new complex value from polar coordinates, with radius [radius] and angle [angle]
  factory Complex.polar({double radius = 0, double angle = 0}) =>
      Complex(re: radius * math.cos(angle), im: radius * math.sin(angle));

  /// Builds a new random complex value so that [modulus] < [radius]
  factory Complex.random({double radius = 1.0}) {
    var complex = Complex(
      re: _rnd.nextDouble() * 2 - 1,
      im: _rnd.nextDouble() * 2 - 1,
    );
    final modulus = complex.modulus;
    if (modulus > radius) {
      complex *= (radius * _rnd.nextDouble()) / modulus;
    }
    return complex;
  }

  /// Returns the real part of this instance
  final double re;

  /// Returns the imaginary part of this instance
  final double im;

  bool get isZero => re == 0 && im == 0;
  bool get isMinusOne => re == -1 && im == 0;
  bool get isOne => re == 1 && im == 0;
  bool get isNonZero => !isZero;

  /// Complex zero = 0 + 0 i
  static final zero = Complex(re: 0, im: 0);

  /// Complex one = 1 + 0 i
  static final one = Complex(re: 1);

  /// Complex i = 0 + 1 i
  static final i = Complex(im: 1);

  static final _rnd = math.Random.secure();

  /// Returns a new [Complex] value which is the opposite of this instance
  Complex operator -() => Complex(re: -re, im: -im);

  /// Returns a new [Complex] value obtained by adding [other] to this instance
  /// [other] may be a [num] or a [Complex]
  /// If [other] is 0 or [Complex.zero], the current instance is returned
  Complex operator +(Object other) => switch (other) {
    num n when n == 0 => this,
    num n => Complex(re: re + n, im: im),
    Complex c when c.isZero => this,
    Complex c => Complex(re: re + c.re, im: im + c.im),
    _ => throw InvalidOperationException(
      'Cannot add ${other.runtimeType} to $this',
    ),
  };

  /// Returns a new [Complex] value obtained by subtracting [other] from this instance
  /// [other] may be a [num] or a [Complex]
  /// If [other] is 0 or [Complex.zero], the current instance is returned
  Complex operator -(Object other) => switch (other) {
    num n when n == 0 => this,
    num n => Complex(re: re - n, im: im),
    Complex c when c.isZero => this,
    Complex c => Complex(re: re - c.re, im: im - c.im),
    _ => throw InvalidOperationException(
      'Cannot subtract ${other.runtimeType} from $this',
    ),
  };

  /// Returns a new [Complex] value obtained by multiplying this instance by [other]
  /// [other] may be a [num] or a [Complex]
  /// If [other] is 0 or [Complex.zero], [Complex.zero] is returned
  /// If [other] is 1 or [Complex.one], the current instance is returned
  Complex operator *(Object other) => switch (other) {
    num n when n == 0 => Complex.zero,
    num n when n == 1 => this,
    num n => Complex(re: re * n, im: im * n),
    Complex c when c.isZero => Complex.zero,
    Complex c when c.isOne => this,
    Complex c => Complex(re: re * c.re - im * c.im, im: re * c.im + im * c.re),
    _ => throw InvalidOperationException(
      'Cannot multiply ${other.runtimeType} by $this',
    ),
  };

  static Complex _rdiv(double re, double im, double factor) {
    final inv = 1 / factor;
    return Complex(re: re * inv, im: im * inv);
  }

  static Complex _cdiv(double re, double im, Complex factor) {
    final fre = factor.re, fim = factor.im;
    final denom = fre * fre + fim * fim;
    return Complex(
      re: (re * fre + im * fim) / denom,
      im: (im * fre - re * fim) / denom,
    );
  }

  /// Returns a new [Complex] value obtained by dividing this instance by [other]
  /// [other] may be a [num] or a [Complex]
  /// If [other] is 1 or [Complex.one], the current instance is returned
  Complex operator /(Object other) => switch (other) {
    num n when n == 1 => this,
    num n => _rdiv(re, im, n.toDouble()),
    Complex c when c.isOne => this,
    Complex c => _cdiv(re, im, c),
    _ => throw InvalidOperationException(
      'Cannot divide $this by ${other.runtimeType}',
    ),
  };

  /// Returns true if [other] is equal to this instance down to a precision of [precision]
  /// [other] may be a [num] or a [Complex]
  bool equals(Object other, {double precision = 0}) =>
      (this - other).modulus <= precision;

  /// Returns a new [Complex] value which is the inverse of this instance
  Complex get inverse {
    final r = re, i = im;
    if (r.abs() >= i.abs()) {
      final ratio = i / r, denom = r + i * ratio;
      return Complex(re: 1 / denom, im: -ratio / denom);
    } else {
      final ratio = r / i, denom = i + r * ratio;
      return Complex(re: ratio / denom, im: -1 / denom);
    }
  }

  /// Returns a new [Complex] value which is the conjugate of this instance
  Complex get conjugate => Complex(re: re, im: -im);

  /// Returns the squared modulus of this instance (i.e [re] * [re] + [im] * [im])
  double get modulus2 => re * re + im * im;

  /// Returns the modulus of this instance (i.e. the square root of [re] * [re] + [im] * [im])
  double get modulus => math.sqrt(modulus2);

  @override
  int get hashCode => (im == 0) ? re.hashCode : Object.hash(re, im);

  @override
  bool operator ==(Object other) => switch (other) {
    num n => re == n && im == 0,
    Complex c => re == c.re && im == c.im,
    _ => false,
  };

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
