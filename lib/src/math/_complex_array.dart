import 'dart:math';
import 'dart:typed_data';

import '../exceptions.dart';
import '../extensions.dart';
import 'complex.dart';

/// Class holding a list of [Complex] values
class ComplexArray {
  /// Builds a list from [values]
  ComplexArray._clone(Float64List values)
      : _values = Float64List.fromList(values);

  /// Builds a list of [length] elements initialized to [Complex.zero]
  ComplexArray.zero(int length) : _values = Float64List(2 * length);

  /// Number of elements in the list
  int get length => _values.length ~/ 2;

  /// Obtains the value stored at index [idx]
  Complex operator [](int idx) =>
      Complex(re: _values[2 * idx], im: _values[2 * idx + 1]);

  final Float64List _values;

  /// Obtains the real part of the value stored at index [idx]
  double re(int idx) => _values[2 * idx];

  /// Obtains the imaginary part of the value stored at index [idx]
  double im(int idx) => _values[2 * idx + 1];

  /// Obtains the squared modulus of the value at index [idx]
  /// this is equal to [re]([idx]) * [re]([idx]) + [im]([idx]) * [im]([idx])
  double modulus2(int idx) {
    idx *= 2;
    final r = _values[idx];
    final i = _values[idx + 1];
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
    _values.setRange(0, _values.length, other._values);
    return this;
  }

  /// Creates a clone of this instance
  ComplexArray clone() => ComplexArray._clone(_values);

  /// Resets all values to [Complex.zero]
  void _zero() {
    _values.fillRange(0, _values.length, 0);
  }

  void _swap(Float64List values, int i1, int i2) {
    final v = values[i1];
    values[i1] = values[i2];
    values[i2] = v;
  }

  /// Exchanges values stored at indices [idx1] and [idx2]
  void swap(int idx1, int idx2) {
    idx1 *= 2;
    idx2 *= 2;
    _swap(_values, idx1, idx2);
    _swap(_values, idx1 + 1, idx2 + 1);
  }

  /// Negates the value stored at index [idx]
  void neg(int idx) {
    idx *= 2;
    _values[idx] = -_values[idx];
    _values[idx + 1] = -_values[idx + 1];
  }

  /// Conjugates the value stored at index [idx]
  void conj(int idx) {
    idx = 2 * idx + 1;
    _values[idx] = -_values[idx];
  }

  /// Inverts the value stored at index [idx]
  void inv(int idx) {
    idx *= 2;
    final re = _values[idx];
    final im = _values[idx + 1];
    final d = re * re + im * im;
    _values[idx] = re / d;
    _values[idx + 1] = -im / d;
  }

  /// Adds values from [a] at index [ai] and [b] at index [bi] and stores the result in this instance at index [idx]
  void add(int idx, ComplexArray a, int ai, ComplexArray b, int bi) {
    idx *= 2;
    ai *= 2;
    bi *= 2;
    _values[idx] = a._values[ai] + b._values[bi];
    _values[idx + 1] = a._values[ai + 1] + b._values[bi + 1];
  }

  /// Subtracts value in [b] at index [bi] from [a] at index [ai] and and stores the result in this instance at index [idx]
  void sub(int idx, ComplexArray a, int ai, ComplexArray b, int bi) {
    idx *= 2;
    ai *= 2;
    bi *= 2;
    _values[idx] = a._values[ai] - b._values[bi];
    _values[idx + 1] = a._values[ai + 1] - b._values[bi + 1];
  }

  /// Multiplies values from [a] at index [ai] and [b] at index [bi] and stores the result in this instance at index [idx]
  void mul(int idx, ComplexArray a, int ai, ComplexArray b, int bi) {
    idx *= 2;
    ai *= 2;
    bi *= 2;
    final are = a._values[ai];
    final aim = a._values[ai + 1];
    final bre = b._values[bi];
    final bim = b._values[bi + 1];
    _values[idx] = are * bre - aim * bim;
    _values[idx + 1] = are * bim + aim * bre;
  }

  /// Divides values in [a] at index [ai] by [b] at index [bi] and stores the result in this instance at index [idx]
  void div(int idx, ComplexArray a, int ai, ComplexArray b, int bi) {
    idx *= 2;
    ai *= 2;
    bi *= 2;
    final are = a._values[ai];
    final aim = a._values[ai + 1];
    final bre = b._values[bi];
    final bim = b._values[bi + 1];
    final d = bre * bre + bim * bim;
    if (d != 0 && are == 0 && aim == 0) return;
    _values[idx] = (are * bre + aim * bim) / d;
    _values[idx + 1] = (aim * bre - are * bim) / d;
  }

  /// Multiplies values from [a] at index [ai] and [b] at index [bi] and adds the result to the value at index [idx] in this instance
  void addmul(int idx, ComplexArray a, int ai, ComplexArray b, int bi) {
    idx *= 2;
    ai *= 2;
    bi *= 2;
    final are = a._values[ai];
    final aim = a._values[ai + 1];
    if (are == 0 && aim == 0) return;
    final bre = b._values[bi];
    final bim = b._values[bi + 1];
    if (bre == 0 && bim == 0) return;
    _values[idx] += are * bre - aim * bim;
    _values[idx + 1] += are * bim + aim * bre;
  }

  /// Returns `true` if the value at index [idx] is [Complex.zero]
  bool isZero(int idx) {
    idx *= 2;
    return _values[idx] == 0 && _values[idx + 1] == 0;
  }

  /// Returns `true` if the value at index [idx] is [Complex.one]
  bool isOne(int idx) {
    idx *= 2;
    return _values[idx] == 1 && _values[idx + 1] == 0;
  }

  /// Sets value at index [idx] with [value]
  void set(int idx, Complex value) {
    idx *= 2;
    _values[idx] = value.re;
    _values[idx + 1] = value.im;
  }

  /// Sets value at index [idx] with the value from [a] at index [ai]
  void assign(int idx, ComplexArray a, int ai) {
    idx *= 2;
    ai *= 2;
    _values[idx] = a._values[ai];
    _values[idx + 1] = a._values[ai + 1];
  }

  /// Multiplies all values in this instance by [factor] ([num] or [Complex] value)
  void scale(Object factor) {
    if (factor is num) {
      if (factor == 0) {
        _zero();
      } else if (factor == 1) {
        // nothing to do
      } else {
        final len = _values.length;
        for (var i = 0; i < len; i++) {
          _values[i] *= factor;
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
        final len = _values.length;
        for (var i = 0; i < len; i += 2) {
          final re = _values[i];
          final im = _values[i + 1];
          _values[i] = re * fre - im * fim;
          _values[i + 1] = re * fim + im * fre;
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
        final len = _values.length;
        for (var i = 0; i < len; i++) {
          _values[i] /= factor;
        }
      }
    } else if (factor is Complex) {
      if (factor == Complex.one) {
        // nothing to do
      } else {
        final fre = factor.re;
        final fim = factor.im;
        final d = fre * fre + fim * fim;
        final len = _values.length;
        for (var i = 0; i < len; i += 2) {
          final re = _values[i];
          final im = _values[i + 1];
          _values[i] = (re * fre + im * fim) / d;
          _values[i + 1] = (im * fre - re * fim) / d;
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
    final len = _values.length;
    for (var i = 0; i < len; i++) {
      if (_values[i] != other._values[i]) {
        return false;
      }
    }
    return true;
  }

  /// Returns true if [other] is a [ComplexArray] of same [length] with same values down to a precision of [precision]
  bool equals(ComplexArray other, {double precision = 0}) {
    if (length != other.length) return false;
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
              length,
              (i) =>
                  '${_values[2 * i].normalize()} + ${_values[2 * i + 1].normalize()} i')
          .join(', ') +
      ']';

  List serialize() => _values;

  static ComplexArray deserialize(List json) =>
      ComplexArray._clone(Float64List.fromList(json.cast<double>()));
}
