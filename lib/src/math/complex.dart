import 'dart:math' as math;

import 'package:qartvm/qartvm.dart';

import '../exceptions.dart';
import '../extensions.dart';

class Complex {
  const Complex({this.re = 0, this.im = 0});

  Complex.polar({double radius = 0, double angle = 0})
      : this(re: radius * math.cos(angle), im: radius * math.sin(angle));

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

  final double re;
  final double im;

  static const zero = Complex(re: 0);
  static const one = Complex(re: 1);
  static const minusOne = Complex(re: -1);
  static const i = Complex(im: 1);

  static final _rnd = math.Random.secure();

  Complex operator -() => Complex(re: -re, im: -im);

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

  bool equals(Object other, {double precision = 0}) {
    if (other is num || other is Complex) {
      final diff = (this - other).det;
      return diff == 0 || diff < precision;
    } else {
      throw InvalidOperationException(
          'Cannot compare ${other.runtimeType} with $this');
    }
  }

  @override
  bool operator ==(Object other) {
    if (other is num) {
      return re == other && im == 0;
    } else if (other is Complex) {
      return re == other.re && im == other.im;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => re.hashCode * 17 + im.hashCode;

  Complex get inverse => Complex(re: re / det, im: -im / det);

  Complex get conjugate => Complex(re: re, im: -im);

  double get det => re * re + im * im;

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
