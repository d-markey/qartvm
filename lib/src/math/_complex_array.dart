import 'dart:math';
import 'dart:typed_data';

import '../exceptions.dart';
import '../extensions.dart';
import 'complex.dart';

/// Class holding a list of [Complex] values
class ComplexArray {
  /// Builds a list from [values]
  ComplexArray._clone(Float64List re, Float64List im)
      : _re = Float64List.fromList(re),
        _im = Float64List.fromList(im);

  /// Builds a list of [length] elements initialized to [Complex.zero]
  ComplexArray.zero(int length)
      : _re = Float64List(length),
        _im = Float64List(length);

  /// Number of elements in the list
  int get length => _re.length;

  /// Obtains the value stored at index [idx]
  Complex operator [](int idx) => Complex(re: _re[idx], im: _im[idx]);

  /// Obtains the real part of the value stored at index [idx]
  double re(int idx) => _re[idx];
  final Float64List _re;

  /// Obtains the imaginary part of the value stored at index [idx]
  double im(int idx) => _im[idx];
  final Float64List _im;

  /// Obtains the squared modulus of the value at index [idx]
  /// this is equal to [re]([idx]) * [re]([idx]) + [im]([idx]) * [im]([idx])
  double modulus2(int idx) {
    final r = _re[idx];
    final i = _im[idx];
    return r * r + i * i;
  }

  /// Obtains the modulus of the value at index [idx]
  /// this is equal to sqrt([modulus2]))
  double modulus(int idx) => sqrt(modulus2(idx));

  /// Copies values from [other] into this instance
  /// [other].[length] must match the [length] of this instance
  ComplexArray copy(ComplexArray other) {
    if (length != other.length) {
      throw InvalidOperationException();
    }
    _re.setRange(0, length, other._re);
    _im.setRange(0, length, other._im);
    return this;
  }

  /// Creates a clone of this instance
  ComplexArray clone() => ComplexArray._clone(_re, _im);

  /// Resets all values to [Complex.zero]
  void _zero() {
    _re.fillRange(0, length, 0);
    _im.fillRange(0, length, 0);
  }

  void _swap(Float64List values, int i1, int i2) {
    final v = values[i1];
    values[i1] = values[i2];
    values[i2] = v;
  }

  /// Exchanges values stored at indices [idx1] and [idx2]
  void swap(int idx1, int idx2) {
    _swap(_re, idx1, idx2);
    _swap(_im, idx1, idx2);
  }

  /// Negates the value stored at index [idx]
  void neg(int idx) {
    _re[idx] = -_re[idx];
    _im[idx] = -_im[idx];
  }

  /// Conjugates the value stored at index [idx]
  void conj(int idx) {
    _im[idx] = -_im[idx];
  }

  /// Inverts the value stored at index [idx]
  void inv(int idx) {
    final re = _re[idx];
    final im = _im[idx];
    final d = re * re + im * im;
    _re[idx] = re / d;
    _im[idx] = -im / d;
  }

  /// Adds values from [a] at index [ai] and [b] at index [bi] and stores the result in this instance at index [idx]
  void add(int idx, ComplexArray a, int ai, ComplexArray b, int bi) {
    _re[idx] = a._re[ai] + b._re[bi];
    _im[idx] = a._im[ai] + b._im[bi];
  }

  /// Subtracts value in [b] at index [bi] from [a] at index [ai] and and stores the result in this instance at index [idx]
  void sub(int idx, ComplexArray a, int ai, ComplexArray b, int bi) {
    _re[idx] = a._re[ai] - b._re[bi];
    _im[idx] = a._im[ai] - b._im[bi];
  }

  /// Multiplies values from [a] at index [ai] and [b] at index [bi] and stores the result in this instance at index [idx]
  void mul(int idx, ComplexArray a, int ai, ComplexArray b, int bi) {
    final are = a._re[ai];
    final aim = a._im[ai];
    final bre = b._re[bi];
    final bim = b._im[bi];
    _re[idx] = are * bre - aim * bim;
    _im[idx] = are * bim + aim * bre;
  }

  /// Divides values in [a] at index [ai] by [b] at index [bi] and stores the result in this instance at index [idx]
  void div(int idx, ComplexArray a, int ai, ComplexArray b, int bi) {
    final are = a._re[ai];
    final aim = a._im[ai];
    if (are == 0 && aim == 0) return;
    final bre = b._re[bi];
    final bim = b._im[bi];
    final d = bre * bre + bim * bim;
    _re[idx] = (are * bre + aim * bim) / d;
    _im[idx] = (aim * bre - are * bim) / d;
  }

  /// Multiplies values from [a] at index [ai] and [b] at index [bi] and adds the result to the value at index [idx] in this instance
  void addmul(int idx, ComplexArray a, int ai, ComplexArray b, int bi) {
    final are = a._re[ai];
    final aim = a._im[ai];
    if (are == 0 && aim == 0) return;
    final bre = b._re[bi];
    final bim = b._im[bi];
    if (bre == 0 && bim == 0) return;
    _re[idx] += are * bre - aim * bim;
    _im[idx] += are * bim + aim * bre;
  }

  /// Returns `true` if the value at index [idx] is [Complex.zero]
  bool isZero(int idx) => _re[idx] == 0 && _im[idx] == 0;

  /// Returns `true` if the value at index [idx] is [Complex.one]
  bool isOne(int idx) => _re[idx] == 1 && _im[idx] == 0;

  /// Sets value at index [idx] with [value]
  void set(int idx, Complex value) {
    _re[idx] = value.re;
    _im[idx] = value.im;
  }

  /// Sets value at index [idx] with the value from [a] at index [ai]
  void assign(int idx, ComplexArray a, int ai) {
    _re[idx] = a._re[ai];
    _im[idx] = a._im[ai];
  }

  /// Multiplies all values in this instance by [factor] ([num] or [Complex] value)
  void scale(Object factor) {
    if (factor is num) {
      if (factor == 0) {
        _zero();
      } else if (factor == 1) {
        // nothing to do
      } else {
        for (var i = 0; i < length; i++) {
          _re[i] *= factor;
          _im[i] *= factor;
        }
      }
    } else if (factor is Complex) {
      if (factor == Complex.one) {
        _zero();
      } else if (factor == Complex.one) {
        // nothing to do
      } else {
        final fre = factor.re;
        final fim = factor.im;
        for (var i = 0; i < length; i++) {
          final re = _re[i];
          final im = _im[i];
          _re[i] = re * fre - im * fim;
          _im[i] = re * fim + im * fre;
        }
      }
    } else {
      throw InvalidOperationException();
    }
  }

  /// Divides all values in this instance by [factor] ([num] or [Complex] value)
  void unscale(Object factor) {
    if (factor is num) {
      if (factor == 1) {
        // nothing to do
      } else {
        for (var i = 0; i < length; i++) {
          _re[i] /= factor;
          _im[i] /= factor;
        }
      }
    } else if (factor is Complex) {
      if (factor == Complex.one) {
        // nothing to do
      } else {
        final fre = factor.re;
        final fim = factor.im;
        final d = fre * fre + fim * fim;
        for (var i = 0; i < length; i++) {
          final re = _re[i];
          final im = _im[i];
          _re[i] = (re * fre + im * fim) / d;
          _im[i] = (im * fre - re * fim) / d;
        }
      }
    } else {
      throw InvalidOperationException();
    }
  }

  /// Returns true if [other] is a [ComplexArray] of same [length] with same values
  @override
  bool operator ==(Object other) {
    if (other is! ComplexArray || length != other.length) {
      return false;
    }
    for (var i = 0; i < length; i++) {
      if (_re[i] != other._re[i] || _im[i] != other._im[i]) {
        return false;
      }
    }
    return true;
  }

  /// Returns true if [other] is a [ComplexArray] of same [length] with same values down to a precision of [precision]
  bool equals(ComplexArray other, {double precision = 0}) {
    if (length != other.length) return false;
    // precision *= precision;
    for (var i = 0; i < length; i++) {
      if ((modulus(i) - other.modulus(i)).abs() > precision) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode => length.hashCode;

  @override
  String toString() =>
      '[' +
      Iterable.generate(
              length, (i) => '${_re[i].normalize()} + ${_im[i].normalize()} i')
          .join(', ') +
      ']';

  List serialize() => [
        _re,
        _im,
      ];

  static ComplexArray deserialize(List json) => ComplexArray._clone(
      Float64List.fromList(json[0]), Float64List.fromList(json[1]));
}
