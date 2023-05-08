import 'dart:math';
import 'dart:typed_data';

import '../exceptions.dart';
import '../extensions.dart';
import 'complex.dart';

/// Class holding a list of [Complex] values
class ComplexArray {
  /// Builds a list from [values]
  ComplexArray._clone(List<Float64x2> values)
      : _values = Float64x2List.fromList(values);

  /// Builds a list of [length] elements initialized to [Complex.zero]
  ComplexArray.zero(int length) : _values = Float64x2List(length);

  /// Number of elements in the list
  int get length => _values.length;

  /// Obtains the value stored at index [idx]
  Complex operator [](int idx) =>
      Complex(re: _values[idx].x, im: _values[idx].y);

  final Float64x2List _values;

  /// Obtains the real part of the value stored at index [idx]
  double re(int idx) => _values[idx].x;

  /// Obtains the imaginary part of the value stored at index [idx]
  double im(int idx) => _values[idx].y;

  /// Obtains the squared modulus of the value at index [idx]
  /// this is equal to [re]([idx]) * [re]([idx]) + [im]([idx]) * [im]([idx])
  double modulus2(int idx) {
    final v = _values[idx] * _values[idx];
    return v.x + v.y;
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
  void _zero() => _values.fillRange(0, _values.length, Float64x2.zero());

  /// Exchanges values stored at indices [idx1] and [idx2]
  void swap(int idx1, int idx2) {
    final v = _values[idx1];
    _values[idx1] = _values[idx2];
    _values[idx2] = v;
  }

  /// Negates the value stored at index [idx]
  void neg(int idx) {
    _values[idx] = -_values[idx];
  }

  /// Conjugates the value stored at index [idx]
  void conj(int idx) {
    _values[idx] = Float64x2(_values[idx].x, -_values[idx].y);
  }

  /// Inverts the value stored at index [idx]
  void inv(int idx) {
    final v = _values[idx];
    final v2 = v * v;
    final d = v2.x + v2.y;
    _values[idx] = Float64x2(v.x / d, -v.y / d);
  }

  /// Adds values from [a] at index [ai] and [b] at index [bi] and stores the result in this instance at index [idx]
  void add(int idx, ComplexArray a, int ai, ComplexArray b, int bi) {
    _values[idx] = a._values[ai] + b._values[bi];
  }

  /// Subtracts value in [b] at index [bi] from [a] at index [ai] and and stores the result in this instance at index [idx]
  void sub(int idx, ComplexArray a, int ai, ComplexArray b, int bi) {
    _values[idx] = a._values[ai] - b._values[bi];
  }

  /// Multiplies values from [a] at index [ai] and [b] at index [bi] and stores the result in this instance at index [idx]
  void mul(int idx, ComplexArray a, int ai, ComplexArray b, int bi) {
    final av = a._values[ai];
    final bv = b._values[bi];
    _values[idx] =
        Float64x2(av.x * bv.x - av.y * bv.y, av.x * bv.y + av.y * bv.x);
  }

  /// Divides values in [a] at index [ai] by [b] at index [bi] and stores the result in this instance at index [idx]
  void div(int idx, ComplexArray a, int ai, ComplexArray b, int bi) {
    final av = a._values[ai];
    final bv = b._values[bi];
    final bv2 = bv * bv;
    final d = bv2.x + bv2.y;
    _values[idx] = Float64x2(
        (av.x * bv.x + av.y * bv.y) / d, (av.y * bv.x - av.x * bv.y) / d);
  }

  /// Multiplies values from [a] at index [ai] and [b] at index [bi] and adds the result to the value at index [idx] in this instance
  void addmul(int idx, ComplexArray a, int ai, ComplexArray b, int bi) {
    final av = a._values[ai];
    final bv = b._values[bi];
    _values[idx] +=
        Float64x2(av.x * bv.x - av.y * bv.y, av.x * bv.y + av.y * bv.x);
  }

  /// Returns `true` if the value at index [idx] is [Complex.zero]
  bool isZero(int idx) {
    return _values[idx].x == 0 && _values[idx].y == 0;
  }

  /// Returns `true` if the value at index [idx] is [Complex.one]
  bool isOne(int idx) {
    return _values[idx].x == 1 && _values[idx].y == 0;
  }

  /// Sets value at index [idx] with [value]
  void set(int idx, Complex value) {
    _values[idx] = Float64x2(value.re, value.im);
  }

  /// Sets value at index [idx] with the value from [a] at index [ai]
  void assign(int idx, ComplexArray a, int ai) {
    _values[idx] = a._values[ai];
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
        final fac = factor.toDouble();
        for (var i = 0; i < len; i++) {
          _values[i] = _values[i].scale(fac);
        }
      }
    } else if (factor is Complex) {
      if (factor == Complex.zero) {
        _zero();
      } else if (factor == Complex.one) {
        // nothing to do
      } else {
        final fre = factor.re;
        final fim = factor.im;
        final len = _values.length;
        for (var i = 0; i < len; i++) {
          final v = _values[i];
          _values[i] = Float64x2(v.x * fre - v.y * fim, v.x * fim + v.y * fre);
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
        scale(1 / factor);
      }
    } else if (factor is Complex) {
      if (factor == Complex.one) {
        // nothing to do
      } else {
        scale(Complex.one / factor);
      }
    } else {
      throw InvalidOperationException();
    }
  }

  /// Returns true if [other] is a [ComplexArray] of same [length] with same values
  @override
  bool operator ==(Object other) => other is ComplexArray && equals(other);

  /// Returns true if [other] is a [ComplexArray] of same [length] with same values
  /// down to a precision of [precision]
  bool equals(ComplexArray other, {double precision = 0}) {
    final len = _values.length;
    if (len != other._values.length) {
      return false;
    }
    for (var i = 0; i < len; i++) {
      final d = (_values[i] - other._values[i]).abs();
      if (d.x > precision || d.y > precision) {
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
                  '${_values[i].x.normalize()} + ${_values[i].y.normalize()} i')
          .join(', ') +
      ']';

  List serialize() => _values.expand((f) => [f.x, f.y]).toList();

  static ComplexArray deserialize(List json) {
    final len = json.length;
    final list = <Float64x2>[];
    for (var i = 0; i < len; i += 2) {
      list.add(Float64x2(json[i], json[i + 1]));
    }
    return ComplexArray._clone(list);
  }
}
